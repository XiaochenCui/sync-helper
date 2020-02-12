#!/usr/bin/perl
use warnings;
use Term::ANSIColor;
# use autodie qw( system );

$verbose = $ARGV[0];
if (not defined $verbose) {
    $verbose = 0;
} else {
    $verbose = 1;
}

$home = $ENV{"HOME"};
$pwd = $ENV{"PWD"};

sub print_green{
    $s = shift or die "need a string";
    print color('green');
    print $s . "\n";
    print color('reset');
}

# create some file and directory if not exist
sub create{
    print_green("Init some files and directories");

    $local_config = $home . '/.localrc';
    unless (-e "$local_config"){
        system("touch $local_config");
    }

    $binary_dir = $home . '/bin';
    unless (-e "$binary_dir"){
        system("mkdir $binary_dir");
    }
}

sub sync{
    print_green("Start synchronizing...");

    # Check if there are uncommitted changes
    # https://stackoverflow.com/questions/3878624/how-do-i-programmatically-determine-if-there-are-uncommitted-changes
    system("git diff-index --quiet HEAD --");
    if ($? != 0) {
        print_green("Workspace unclean, commit staff...");
        system("git add --all");
        system('git commit -m "update"');
    }
    system("git pull");
    system("git push");
}

sub link_config(){
    print_green("Start linking...");
    $file = "sync-list.txt";
    open(FH, "<", $file) or die $!;
    while(<FH>){
        chomp;
        if ($_ =~ /(\S+)\s(.+)/) {
            $src = $pwd . "/config_files/" . $1;
            $dst = path("$2");
            # do_link($src, $dst);
        } else {
            $src = $pwd . "/config_files/" . $_;
            $dst = path("~/$_");
            do_link($src, $dst);
        }
    }
    close(FH);

    system('grep \.cxcrc ~/.zshrc 1>/dev/null || printf "\nsource ~/.cxcrc" >> ~/.zshrc');

    if ($verbose) {
        system("source ~/.zshrc");
    } else {
        system("source ~/.zshrc 2>&1 >/dev/null");
    }
}

sub do_link {
    $src = shift or die "need src";
    $dst = shift or die "need dst";

    $i = rindex($dst, "/");
    $dir = substr($dst, 0, $i);

    unless (-e "$dir") {
        print "$dir\n";
        system("mkdir $dir");
    }
    if ($verbose) {
        print "src: $src, dst: $dst\n";
    }
    system("ln -sfh $src $dst");
}

sub path{
    $origin = shift or die "need an argument";
    if (substr($origin, 0, 1) eq "~") {
        $origin = $home . substr($origin, 1);
    }
    return $origin;
}

create;

# sync;

link_config;

print_green("Done");
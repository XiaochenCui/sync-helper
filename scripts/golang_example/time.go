package main

import (
	"fmt"
	"time"
)

func main() {
	tm := time.Now()
	fmt.Printf("time: %v\n", tm)
	second := tm.Unix()
	fmt.Printf("second: %v\n", second)
	day := second / 86400
	fmt.Printf("day: %v\n", day)
	new_tm := time.Unix(day * 86400, 0)
	fmt.Printf("new time: %v\n", new_tm)
}
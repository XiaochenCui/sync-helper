package main

import (
	"context"
	"fmt"

	"github.com/tsuna/gohbase"
	"github.com/tsuna/gohbase/hrpc"
)

func main() {
	client := gohbase.NewClient("localhost")
	getRequest, err := hrpc.NewGetStr(context.Background(), "table", "row")
	if err != nil {
		fmt.Print(err)
	}
	getRsp, err := client.Get(getRequest)
	if err != nil {
		fmt.Print(err)
	}
	fmt.Print(getRsp)
}

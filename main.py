import argparse
import os
import sys


def make_export_statement(resource):
    return f"export * from './{os.path.splitext(resource)[0]}'"


if __name__ == "__main__":
    parser = argparse.ArgumentParser("barrel", "creates a barrel file for you")

    parser.add_argument("-d", "--directory")
    parser.add_argument("-o", "--output")

    args = parser.parse_args()
    if args.directory is None:
        print("missing -d / --directory parameter")
        sys.exit(1)
    if args.output is None:
        print("missing -o / --output parameter")
        sys.exit(1)

    statements = [make_export_statement(file) for file in os.listdir(args.directory)]

    with open(args.output, "w+") as f:
        f.write("\n".join(statements))

    print(f"[OK] exported {len(statements)} files from {args.output}")

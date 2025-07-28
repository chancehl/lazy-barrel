import argparse
import os
import sys


SUPPORTED_EXTENSIONS = ["js", "ts"]


def get_exports(root):
    exports = []
    for file in os.listdir(root):
        name = os.path.splitext(file)[0]
        if name != "index":
            exports.append(file)
    return exports


def make_export_statement(resource):
    return f"export * from './{os.path.splitext(resource)[0]}'"


if __name__ == "__main__":
    parser = argparse.ArgumentParser("barrel", "creates a barrel file for you")

    parser.add_argument("-d", "--directory")
    parser.add_argument("-o", "--output")
    parser.add_argument("-e", "--extension")

    args = parser.parse_args()

    if args.directory is None:
        print("missing -d / --directory parameter")
        sys.exit(1)
    if args.extension is not None and args.extension not in SUPPORTED_EXTENSIONS:
        print('invalid -e / --extension flag (only "js" and "ts" supported)')
        sys.exit(1)

    extension = args.extension if args.extension is not None else "ts"

    output = (
        args.output
        if args.output is not None
        else f"{args.directory}/index.{extension}"
    )

    statements = [make_export_statement(file) for file in get_exports(args.directory)]

    with open(output, "w+") as f:
        f.write("\n".join(statements))

    print(f"[OK] exported {len(statements)} files from {output}")

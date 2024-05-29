import json

def md_format_tutorial(item):
    title = item.get('title', '')
    link = item.get('link', '')
    completed = "[X]" if item.get('completed', False) else "[ ]"
    path = item.get('path')
    return f"- {completed} [{title}]({link}) : [{path}]({path})\n"

def md_format_lecture(item):
    title = item.get('title', '')
    link = item.get('link', '')
    completed = "[X]" if item.get('completed', False) else "[ ]"
    path = item.get('path')
    return f"- {completed} [{title}]({link}) : [{path}]({path})\n" if path else f"- {completed} [{title}]({link})"

def md_format_book(item):
    title = item.get('title', '')
    author = item.get('author', '')
    completed = "[X]" if item.get('completed', False) else "[ ]"
    path = item.get('path')
    return f"- {completed} _{title}_, by {author} : [{path}]({path})\n"

def json_to_markdown(data, level=1):
    md = ""
    
    if isinstance(data, dict):
        # print(data)
        for key, value in data.items():
            md += f"{'#' * level} {key}\n\n"
            md += json_to_markdown(value, level + 1)
    elif isinstance(data, list):
        for item in data:
            if isinstance(item, dict):
                if item.get('type') == "tutorial": 
                    md+= md_format_tutorial(item)
                elif item.get('type') == "lecture": 
                    md+= md_format_lecture(item)
                elif item.get('type') == "book": 
                    md+= md_format_book(item)
                else: 
                    md+= f"- {item}\n"
            else:
                md += f"- {item}\n"
        md += "\n"
    else:
        md += f"{data}\n\n"
    
    return md

# Load JSON data from a file
with open('structure.json', 'r') as file:
    data = json.load(file)

# Convert JSON to Markdown
markdown = json_to_markdown(data)

# Save Markdown to a file
with open('README_template.md') as template:
    md_intro = template.read()
    template.close()

with open('README.md', 'w') as file:
    file.write(md_intro)
    file.write(markdown)
    file.close()
    print("--> Markdown file has been generated as README.md")
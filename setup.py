import setuptools

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setuptools.setup(
    name="alphamonitor-cebernard22",
    version="0.0.12",
    author="Cedric Bernard",
    author_email="ce_bernard@yahoo.fr",
    description="Simple python package to interact with JIRA",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/cebernard22/alphatraining",
    project_urls={
        "Bug Tracker": "https://github.com/cebernard22/alphatraining/issues",
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    package_dir={"": "src"},
    packages=setuptools.find_packages(where="src"),
    python_requires=">=3.6",
)
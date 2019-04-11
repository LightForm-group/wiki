---
layout: post
title: How to use the LightForm Wiki
author: Adam Plowman
tags: []
toc: true
published: true
---
## How the site is organised

Content is currently organised into three *collections*:

- Experiments
- Software & Simulation
- Miscellaneous

We can always change how content is organised at a later date, if the need arises. To add a page to one of these collections, navigate to the collection home page by using the links in the navigation side-bar. Next, click `ADD PAGE` or `ADD EXPERIMENT`. This will take you to a new page on Prose.io, which is a Markdown editor for GitHub. 

## How to add content

### Adding content with Prose.io

> Note that whenever you add a new Markdown file, or edit an existing Markdown file, you'll need to wait a couple of minutes before the changes show up on the website. This is because GitHub needs to re-build the website.

Prose.io is a Markdown editor for GitHub content. It allows us to write/edit Markdown files and add them to the Wiki without necessarily understanding how `git` works. Whenever you click on the `EDIT` button of a page, or you click a button to add a new page, you will be taken to the Prose.io website.

> Note that the first time you visit Prose.io, and occasionally on subsequent occasions, you will need to *authorise* Prose.io to access your GitHub content. Make sure you grant Prose.io access to the LightForm organisation. On subsequent occasions, the authorise button may appear in the bottom-right corner of the Prose.io website, and looks like this: ![prose_authorise_button.png]({{site.baseurl}}/assets/images/posts/prose_authorise_button.png) If you don't authorise Prose.io, you will not be able to save any changes.

When you are adding a new page, the first thing you should do is **change the title of the page** (However, there is an exception to this: if you are adding a new experiment metadata YAML file, please **do not** change the title from what it is by default.). By default, the title of a new Markdown file is just set to the current date (something like: `2019-04-11 14:19 +0100`). You can change the title by editing the text at the top of the Prose.io page; it looks something like this:

![prose_io_title_guide_small.png]({{site.baseurl}}/assets/images/posts/prose_io_title_guide_small.png)

Prose.io has a Markdown editing toolbar that looks like this:

![prose_io_toolbar_guide_small.png]({{site.baseurl}}/assets/images/posts/prose_io_toolbar_guide_small.png)
*The Markdown editing toolbar of Prose.io allows you to format your content.*

And Prose.io has a sidebar on the right-hand side that looks like this:

![prose_io_sidebar_guide_small.png]({{site.baseurl}}/assets/images/posts/prose_io_sidebar_guide_small.png)
*The Prose.io sidebar allows you to save and preview the file, as well as edit the file's YAML metadata.*

## Adding images

Adding images with Markdown is easy; just type: `![image_description](image_url)`, where `image_description` is a short description of the image, and `image_url` is the URL that points to the image.

### Adding images with Prose.io

If you are using Prose.io to add and edit content (i.e. by clicking on the `EDIT` button in the top-right corner of the Wiki), you can easily upload and insert your own images, and Prose.io will insert the correct Markdown code for you. To use Prose.io to add an image to your Markdown, click on the `Insert Image` button on the Prose.io toolbar:

![prose_io_toolbar.png]({{site.baseurl}}/assets/images/posts/prose_io_toolbar.png)
*The Prose.io toolbar, with the Insert Image button highlighted*

Then you can either manually add the image URL and image description, or you can add an image that has already been added to the Wiki, or you can upload a new image to the wiki. In the latter cases, the image description and image URL are automatically added for you.

![prose_io_insert_image.png]({{site.baseurl}}/assets/images/posts/prose_io_insert_image.png)
*Inserting an image with Pose.io.*

### Adding images without Prose.io

If you are not using Prose.io, please commit your images to the correct images directory of the Wiki, which is `/assets/images/posts/`. This way, we keep all post media in one place, and people who *are* using Prose.io can also use your images.

### Examples

The following Markdown...

```markdown
![Aluminium]({{site.baseurl}}/assets/images/posts/aluminium_small.jpg)
```
...adds the following image:

![Aluminium]({{site.baseurl}}/assets/images/posts/aluminium_small.jpg)

You can even add a caption to your image; the following Markdown:

```markdown
![Aluminium]({{site.baseurl}}/assets/images/posts/aluminium_small.jpg)
*Here is some aluminium*
```

...results in:

![Aluminium]({{site.baseurl}}/assets/images/posts/aluminium_small.jpg)
*Here is some aluminium*

## Markdown front-matter (YAML metadata)

>Note this section discusses how we can add YAML data to the front of a Markdown file. This is called "front-matter" or "metadata". This is a distinct concept from our idea of a metadata file for experiments (although both are written in YAML!).

The LightForm Wiki makes extensive use of YAML front-matter to configure the Markdown pages correctly. When using Prose.io, this YAML block is extracted out from the Markdown editor and placed inside the metadata editor view, which you can access using the Prose.io side-bar on the right-hand side. However, if you're editing the Markdown files in a standard text editor, you'll see the front-matter at the top of the file, delineated by three dashes:

```markdown
---
# This is the YAML front-matter
toc: true
title: My new post
---

## Markdown Heading

Here is some Markdown content.
```

For example, the title of each Markdown page is stored in the YAML front-matter. When using Prose.io, the title is set from whatever you type in the title field at the top of the page. Additionally, an `author` field is also added to the front-matter, and this is, by default, populated according to your GitHub name.

## Experiments

The Experiments home page show a list of experiments and allows us to add/edit the associated metadata YAML file. If you want to add a new experiment, click the `ADD EXPERIMENT` button on the Experiments home page. This will take you to a new Markdown file in Prose.io. The first thing to do is **change the title** to something descriptive, as discussed above. You can then add information about the experiment using the Prose.io Markdown editor. If you'd like to associate the experiment with a GitHub repository that provides analysis code, you can add a URL to this GitHub repository, by clicking on the metadata viewer/editor within the Prose.io side-bar on the right hand side. Make sure you save the new file by clicking the save and then `commit` buttons.

If you want to add an experiment metadata YAML file to your new experiment page, firstly go to the Experiment home page (you might have to wait a couple of minutes for your new experiment to appear in the experiments table). Under the `Metadata template` column of the table, click on the `ADD` button for your new experiment. You will be taken to a new YAML file in Prose.io. This time, please **do not** change the title (actually the file name) of this file, since we rely on the automatically generated file name to associate the metadata template with the correct experiment. Delete the pre-existing Markdown content and add your own YAML code to this file. Make sure you save it!

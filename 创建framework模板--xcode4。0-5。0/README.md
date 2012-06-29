iOS Universal Framework Mk 7
============================

An XCode 4 project template to build universal (arm6, arm7, and simulator)
frameworks for iOS.

![screenshot](https://github.com/kstenerud/iOS-Universal-Framework/raw/master/screenshot.png)

By Karl Stenerud


News
----

#### 2012-05-26 - iOS Universal Framework Mk 8 in Beta!

##### Highlights:

- Complete rewrite. Build scripts are now written in Python, and read the project file directly.
- Real and Fake framework projects now build the exact same thing.
- Build script has configuration section to allow more fine-grained control over the build process.

To participate in the beta, switch over to the "beta" branch!



Why a Framework?
----------------

Distributing libraries in a developer-friendly manner is tricky. You need to
include not only the library itself, but also any public include files,
resources, scripts etc.

Apple's solution to this problem is frameworks, which are basically folders
that follow a standard structure to include everything required to use a
library. Unfortunately, in disallowing dynamically linked libraries in iOS,
Apple also removed static iOS framework creation functionality in XCode.

Xcode is still technically capable of building frameworks for iOS, and with a
little tweaking it can be re-enabled.

Static frameworks are perfectly acceptable for packaging code intended for the
app store. Despite appearances, it's just a static library at the core.



Kinds of Frameworks
-------------------

The most common kind of framework is the **dynamically linked framework**. Only
Apple can install these on an iOS device, so there's no point in building them.

A **statically linked framework** is almost the same, except it gets linked
to your binary at compile time, so there's no problem using them.

A **fake framework** is the result of a hack upon a bundle target in Xcode and
some scripting magic. It looks and behaves like a static framework, and a fake
framework project is functionally equivalent in most aspects to a real
framework project (but not all).

An **embedded framework** is a wrapper around a static framework, designed to
trick Xcode into seeing the framework's resources (images, plists, nibs, etc).

This distribution includes templates to build **static frameworks** and
**fake frameworks**, as well as **embedded framework** variants of each.



Choosing Which Template System to Use
-------------------------------------

In this distribution are two template systems, each with their strengths and
weaknesses. You should choose whichever one best suits your needs and
constraints (or just install both).

The biggest difference is that Xcode can't build real frameworks unless you
install the static framework xcspec file inside the Xcode app, which might be
a dealbreaker for some (this applies to the *PROJECT*, not the framework
itself).


### Short decision chart for the impatient ###

* I don't want to modify Xcode: **Fake framework**

* I'm just distributing the final framework binary (not the project):
  **Either kind will work**

* I'm distributing my framework **project** to other developers who may not
  want to modify Xcode: **Fake framework**

* I'm distributing my framework **project** to other developers who will also
  be modifying Xcode: **Real framework**

* I need to set up the framework project as a dependency of another project
  (in a workspace or as a child project): **Real framework**
  (or Fake framework, using the -framework trick - see below)

* I'm adding static libraries/frameworks to my framework project AND I want
  them linked into the produced framework so they don't need to be added
  separately to end-user projects: **Fake framework**


### Fake Framework ###

The fake framework is based on the well known "relocatable object file" bundle
hack, which tricks Xcode into building something that mostly resembles a
framework, but is really a bundle.

The fake framework template takes this a step further, using some scripting to
generate a real static framework (based on a static library rather than a
relocatable object file). However, the framework's **project** still defines
it to be of type 'wrapper.cfbundle', which makes it a second class citizen
according to Xcode.

So while it produces a proper static framework that works just as well as a
"real" static framework, things get tricky when you have dependencies.

#### The problem with dependencies ####

If you're just setting up a standalone project, then you're not using
dependencies, so there's no problem.

If, however, you use project dependencies (such as in workspaces), Xcode won't
be happy. The fake framework won't show up in the list when you click the '+'
button under "Link Binary With Libraries" in your main application project.
You can manually drag it from "Products" under your fake framework project,
but then when you build your main project, you'll get a warning like this:

    warning: skipping file '/somewhere/MyFramework.framework'
    (unexpected file type 'wrapper.cfbundle' in Frameworks & Libraries build phase)

This will be followed by linker errors for anything in your fake framework.

Fortunately, there is a workaround. You can manually tell the linker to link
in the framework by adding a "-framework" switch with your framework's name in
"Other Linker Flags" in the project that uses the framework:

    -framework MyFramework

It won't get rid of the warning, which is annoying, but it does link properly.

#### Adding other static libraries/frameworks ####

If you add other static (not dynamic) libraries or other static frameworks to
your fake framework project, they will be **LINKED INTO** your final framework
binary. In a real framework project they are merely referenced, not linked in.

You can avoid this behavior by only including the header files into your
project (so that it will compile), not the static libraries/frameworks
themselves.


### Real Framework ###

The real framework is real in every sense of the word. It is a true static
framework made by re-introducing specifications that Apple left out of Xcode.

In order to be able to build a real framework project, you must install an
xcspec file inside the Xcode installation.

If you are releasing a **project** (rather than the built product) that builds
a real framework, anyone who wishes to **build** that framework must also
install the xcspec file (using the install script in this distribution) so
that their Xcode can understand the target type.

Note: If all you're doing is distributing the fully built framework, and not
the framework's project, then the end user doesn't need to install anything.

I've submitted a report to Apple in the hopes that they'll update the
specification files in Xcode, but that could take awhile.
[OpenRadar link here](http://openradar.appspot.com/radar?id=1194402)

#### Adding other static libraries/frameworks ####

If you add other static (not dynamic) libraries or other static frameworks to
your real framework project, they will only be referenced, **NOT** linked into
the final framework binary like they would in a fake framework.



Upgrading from previous iOS-Universal-Framework versions
--------------------------------------------------------

If you are upgrading from iOS-Universal-Framework **Mk 6 or earlier** and were
using the **Real Static Framework**, and are still using **Xcode 4.2.1** or
earlier, please run **uninstall_legacy.sh** first to remove any patches that
were previously applied to Xcode, then run **install.sh** and restart Xcode.

If you are using **Xcode 4.3** or later, just run **install.sh** and restart
Xcode.



Installing the Template System
------------------------------

To install, run the **install.sh** script in either the "Real Framework" or
"Fake Framework" folder (or both).

Now restart Xcode and you'll see **Static iOS Framework** (or **Fake Static
iOS Framework**) under **Framework & Library** when creating a new project.

To uninstall, run the **uninstall.sh** script and restart Xcode.


Creating an iOS Framework Project
---------------------------------

1. Start a new project.

2. For the project type, choose **Static iOS Framework** (or **Fake Static
   iOS Framework**), which is under **Framework & Library**.

3. Optionally choose to include unit tests.

4. Add your classes, resources, etc with your framework as the target.

5. Any header files that need to be available to other projects must be
   declared public. To do so, go to **Build Phases** in your framework
   target, expand **Copy Headers**, then drag any header files you want to
   make public from the **Project** or **Private** section to the **Public**
   section.



Building your iOS Framework
---------------------------

1. Select your framework's scheme (any of its targets will do).

2. (optional) Set the "Run" configuration in the scheme editor.
   It's set to Debug by default but you'll probably want to change it to
   "Release" when you're ready to distribute your framework.

3. Build the framework (both "iOS device" and "Simulator" destinations will
   build the same universal binary, so it doesn't matter which you select).

4. Select your framework under "Products", then show in Finder.

There will be two folders in the build location: **(your framework).framework**
and **(your framework).embeddedframework**

If your framework has only code, and no resources (like images, scripts, xibs,
core data momd files, etc), you can distribute **(your framework).framework**
to your users and it will just work.

If you have included resources in your framework, you **MUST** distribute
**(your framework).embeddedframework**.

Why is an embedded framework necessary? Because XCode won't look inside static
frameworks to find resources, so if you distribute
(your framework).framework, none of its resources will be visible or usable.

An embedded framework is simply an extra wrapper around a framework,
containing symbolic links to the framework's resources. Doing this makes Xcode
happy-warm-and-fuzzy because it can finally see the resources.



Using an iOS Framework
----------------------

iOS frameworks are basically the same as regular dynamic Mac OS X frameworks,
except they are statically linked.

To add a framework to your project, simply drag it into your project.
When including headers from your framework, remember to use angle bracket
syntax rather than quotes.

For example, with framework "MyFramework":

    #import <MyFramework/MyClass.h>



Troubleshooting
---------------

### Headers Not Found ###

If Xcode can't find the header files from your framework, you've likely
forgotten to make them public. See step 5 in **Creating an iOS Framework Project**


### No Such Product Type ###

If someone who has not installed iOS Universal Framework in their development
environment attempts to build a universal framework project (for a real
framework, not a fake framework), they'll get the following error:

    target specifies product type 'com.apple.product-type.framework.static',
    but there's no such product type for the 'iphonesimulator' platform

Xcode requires some modification in order to be able to build true iOS static
frameworks (see the two diff files in the "Real Framework" folder of this
repository for the gory details), so please install it on all development
machines that will build your real static framework projects (this
isn't needed for users of your framework, only for builders of the framework).


### The selected run destination is not valid for this action ###

Sometimes Xcode gets confused and loads the wrong active settings. The first
thing to try is restarting Xcode. If it still fails, Xcode generated a bad
project (this can happen with any kind of project due to a bug in Xcode 4).
If this happens, you'll need to start over and create a new project.


### Linker Warnings ###

The first time you build your framework target, XCode may complain about
missing folders during the linking phase:

    ld: warning: directory not found for option
    '-L/Users/myself/Library/Developer/Xcode/DerivedData/MyFramework-ccahfoccjqiognaqraesrxdyqcne/Build/Products/Debug-iphoneos'

If this happens, simply clean and rebuild the target and the warnings should
go away.


### Core Data momd not found ###

Xcode builds managed object model files differently in a framework project than
it does in an application project. Instead of creating a .momd directory
containing VersionInfo.plist and the .mom file, it simply creates the .mom file
in the root directory.

This means that when initializing your NSManagedObjectModel from a model in an
embedded framework, you must specify your model URL with an extension of "mom"
rather than "momd":

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyModel" withExtension:@"mom"];


### Unknown class MyClass in Interface Builder file. ###

Since static frameworks are statically linked, the linker strips out any code
it thinks is not being used. Unfortunately, the linker does not check xib
files, and so if a class is referenced only in a xib, and not in objective-c
code, the linker will drop that class from the final executable. This is a
linker issue, not a framework issue (it also happens when you build a static
library).

Apple's built-in framworks don't suffer this problem because they are
dynamically loaded at runtime and the complete, unstripped dynamic library
exists in the iOS device's firmware.

There are two ways around this:

1. Have end users of your framework disable linker optimizations by adding
   "-ObjC" and "-all_load" to "Other Linker Flags" in their project.

2. Put a code reference to the class inside another class in your framework
   that always gets used. For example, suppose you have "MyTextField", which
   is getting stripped by the linker. Suppose you also have
   "MyViewController", which uses MyTextField in its xib file and doesn't get
   stripped. You could do the following:

In MyTextField:
   
    + (void) forceLinkerLoad_ {}

In MyViewController:
   
    + (void) initialize
    {
        [MyTextField forceLinkerLoad_];
    }

They will still need to add "-ObjC" to their linker settings, but won't need
to force all_load.

Option 2 is more work for you, but if done right it saves the end user from
having to disable linker optimizations (causing object file bloat) just to use
your framework.


### unexpected file type 'wrapper.cfbundle' in Frameworks & Libraries build phase ###

This happens when you use a fake framework project as a dependency in a
workspace, or as a child project (real framework projects don't have this
issue). Even though the framework project produces a proper static framework,
Xcode only looks at the project file, which says it's a bundle, and so it
issues a warning during the dependency check and then skips it during the
linker phase.

You can get it to link properly by manually adding a command to link
your framework during the linker phase. Add a command to link your framework
in "Other Linker Flags" in the project that depends on the framework:

    -framework MyFramework

You'll still get the warning, but it won't fail in the linker phase anymore.


### Libraries being linked or not being linked into the final framework ###

Unfortunately, due to the way Xcode works, the "Real Framework" and
"Fake Framework" templates handle included static libraries/frameworks
differently.

The "Real Framework" template follows correct static library procedure, NOT
linking other static libraries/frameworks into the final product.

The "Fake Framework" template tricks Xcode into thinking that it's building a
relocatable object file, and so the linking phase treats it as if it were
building an executable, linking all static code sources into the final binary
(although it doesn't check for missing object code). To get the
"Real Framework" behavior, you should include only the header files from the
library/framework in your framework project, not the static library or
framework itself.


### Unrecognized selector in (some class with a category method) ###

If your static library or static framework contains a module with ONLY
category code (no full class implementations), the linker will get confused,
and will leave the code out of the final binary. Since it's not present in the
final product, you'll get "unrecognized selector" exceptions when any call is
made to those category methods.

To get around this, put a dummy class into the module containing the category
code. The linker, seeing a full Objective-C class, will link the module in,
including the category code.

I've made a header file [LoadableCategory.h](https://github.com/kstenerud/Objective-Gems/blob/master/Objective-Gems/LoadableCategory.h)
to make this easier to do:

    #import "SomeConcreteClass+MyAdditions.h"
    #import "LoadableCategory.h"
    
    
    MAKE_CATEGORIES_LOADABLE(SomeConcreteClass_MyAdditions);

    
    @implementation SomeConcreteClass (MyAdditions)
    
    ...
    
    @end

You will also need to add "-ObjC" to the "Other Linker Flags" build setting in
any project that uses the framework.


### Unit tests crash before executing any code ###

If you make a new static framework (or static library) target with unit tests
in Xcode 4.3, it will crash when you try to run the unit tests:

    Thread 1: EXC_BAD_ACCESS (code=2, address=0x0)
    0 0x00000000
    ---
    15 dyldbootstrap:start(...)

This is due to a bug in lldb. You can run the unit tests using GDB instead by
editing your scheme, selecting "Test", and from the "Info" tab changing
Debugger from **LLDB** to **GDB**.



History
-------

### Mk 1

The first incarnation. It used a bunch of script hackery to cobble together a
fake framework. It exploited the "bundle" target, setting its type to a
relocatable object file.


### Mk 2

This version took advantage of the template system to do most of the work
that the script used to do. Everything (including the script) was embedded
in the template.


### Mk 3

This version does away with the "relocatable object" hackery and builds a true
static framework, with all the abilities of an OS X static framework.
This solves a number of linker, unit testing, and workspace inclusion issues
that plagued the previous hacky implementations.

It also includes the concept of the embeddedframework, which allows you to
include resources with your framework in a way that Xcode understands.

Josh Weinberg also added some tweaks to make it build in the proper build
directory with scheme-controlled configuration, and behave better as a
subproject dependency.

It now requires some small modifications to Xcode's specification files in
order to support true static frameworks, and thus comes with an install and
uninstall script.


### Mk 4

This version gives you the choice of installing the "real framework" template
or the "fake framework" template. Both come with an install script, but only
the "real framework" installer needs to modify Xcode.

This also fixes some issues that the fake framework had in Mk 2 (such as
the curious behavior of embedding the full path to the compiled files within
the files themselves, resulting in warnings when building with that framework).


### Mk 5

This version does away with the extra target and script. Everything is self
contained in the framework target, and the framework under the "Products"
group is actually the universal framework (no more Debug-univesal or
Release-universal folders).

You can build and clean like you would in any other project.

As well, the "Fake" framework template now builds a proper static library
instead of a relocatable object file (although Xcode still doesn't believe
that it's real).


### Mk 6

This version makes the Xcode modifications for real static frameworks safer
by simply adding an extra specification file instead of patching existing
ones.


### Mk 7

This version was *supposed* to be the one that no longer modified Xcode, but
alas, Xcode behaves differently depending on *WHERE* the xcspec file gets
installed. Take a guess at which location doesn't work...

@wtfxcode

So instead, this version basically handles the new install location of
Xcode4.3.

Templates now build armv6 + armv7 by default instead of just armv7.

Note: If you previously installed real framework supprt under the broken Mk 7
(i.e. if you installed it on Feb 16th, or Feb 17th before 9:00 am PST, 2012),
run uninstall_legacy.sh to uninstall the xcspec file from your home dir, then
reinstall.



License
-------

Copyright (c) 2011 Karl Stenerud

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
the documentation of any redistributions of the template files themselves
(but not in projects built using the templates).

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

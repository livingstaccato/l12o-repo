# l12o repo

## Introduction

```text
                ,.
               (\(\)
,_              ;  o >    _     _    __                                       
{`-.          /  (_)     (_ ) /' ) /'__`\                                     
`={\`-._____/`   |        | |(_, |(_)  ) )   _       _ __   __   _ _      _   
 `-{ /    -=`\   |        | |  | |   /' /  /'_`\    ( '__)/'__`\( '_`\  /'_`\ 
  `={  -= = _/   /        | |  | | /' /( )( (_) )   | |  (  ___/| (_) )( (_) )
     `\  .-'   /`        (___) (_)(_____/'`\___/'   (_)  `\____)| ,__/'`\___/'
      {`-,__.'===,_                                             | |           
      //`        `\\                                            (_)           
     //
    `\=
```

This is a WIP.

It's kinda tough to find packages for Amazon Linux 2023. So if they're not gonna
do it then I suppose it's up to me… or us. 🤷

My process for getting this setup has been:

* Roll my eyes, sigh, and say, "fucking shit damnit. ugh. fine."

* Find the primary RPM I want to build. In this case it's FreeIPA.

* Hunt down the freshest and latest RPM spec file. From trusted sources.
  * Usually Fedora.
  * Then CentOS.
  * Then vendor - if they provide it.

* Use `spectool` to download the source code.

* Attempt to build it using `rpmbuild`  

* if: it builds the first time:
  * Embrace the dopamine hit with the good fortune that this was a pain-free
    rebuild.

* else:
  * Sigh. Loudly. Then say, "fucking damnit."

  * It's likely a dependency issue. Almost always.
    * So I try to use `dnf install` to install the package… then…

    * if: the package installs
      * Smile. Maybe.

    * else:
      * Sigh. More loudly. Proceed to iterate through a process somewhat like
        this.

      * Hunting down stupid dependent packages.
        * Newest backward.

  * Repeat this process until I have the package I want working in the way that
    I want it to.

## Prerequisites

Basic Docker knowledge.

And everything else that you hopefully know if you found
this Git repo.

### Check out the source

Please.

Even though I have benign intentions, blindly installing packages on your
system — **especially if it's production** — is a very questionable at the
moment given the current lack of verification/attestation/signing systems in
place and knowing that you probably have no clue who I am yet. 😉

### RTF(read)M

Hey look, you're doing that. Nice job.

Better documentation will eventually be coming. If I maintain the thing.

Dunno.

ADHD makes keeping stuff like this maintained kind of a challenge.

So, dunno.

I really just want the FreeIPA client.

## Building the packages

1. Build the container using the `container-build` script.
2. Use the `run` script to get into the container.
3. Execute the `/scripts/fetch-sources.sh` script.
4. Execute the `/scripts/build-packages.sh` script.
5. Since you're probably here for FreeIPA packages, execute the
   `/build/bundle-ipa-client-pkgs.sh` script.

The output

## Installing the packages

Execute `dnf install /wherever-you-put-rpms/*.rpm`

## Non-comprehensive to do

* Make a not insane .rpmmacros directory.

* Makefile. Makefile. Makefile. Mmmakefile.

* Better documentation.

* Create meta packages that provide a list of all the packages required to
  support the target package. And notes about where I got the spec and what
  changes I made.

* Get my signing stuff all setup again.

* Get this working with CI/CD.

* Refactor things in manners that please me.

* Better caching logic. Probably taking md5sum of all the things. 

* Stick the patches into package-specific subdirectories. I hate having a bunch
  of patches in the src dir and them having them being so freaking ambiguously.

  * Maybe someone could fix this…

* Setup a Markdown Linter for this. Cuz why not?!

* Implement a Code of Conduct, or CoC.

* Split the package lists up into better units.

* Multistage.

* `${HOSTTYPE}` usage. To or to not?

* Figure out if groups help.

* Caching logic for index generation

* Set the stuff like reop_dir in the l12o profile

* OS check. No running on macOS, Tim. No.

---

## References

* [s it possible to map a user inside the docker container to an outside user?](https://stackoverflow.com/questions/57776452/is-it-possible-to-map-a-user-inside-the-docker-container-to-an-outside-user)

### Repo Management

* [Create an Apache-based YUM/DNF repository on Red Hat Enterprise Linux 8](https://www.redhat.com/sysadmin/apache-yum-dnf-repo)

## Credits

* All the people that have contributed to the spec files being used.

* [patorjk.com](https://patorjk.com/software/taag/#p=display&h=1&v=2&f=Puffy&t=l12o%20repo) for the font.
* [jgs for the rooster ascii art](https://ascii.co.uk/art/rooster) I have no clue who jgs is.

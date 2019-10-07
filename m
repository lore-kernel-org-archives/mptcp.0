Content-Type: multipart/mixed; boundary="===============0668769106485472827=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] move TCP-related commits to the beginning
Date: Mon, 07 Oct 2019 17:00:59 +0200
Message-ID: <20191007150059.GL13866@breakpoint.cc>
In-Reply-To: 7a9e06aa-4078-7d3d-9c64-ecf231dad17d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2033

--===============0668769106485472827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > ... this turns 'tcp: clean ext on tx recycle' into a one-line change.
> =

> Good idea! Just applied this diff and added your signed-off to the patch.

Thanks!

> > If we place this early in the series, then
> > =

> > > 966eb30045b9 mptcp: increment MIB counters in a few places
> > =

> > ... could be folded into the patches that add those code paths.
> > =

> > Perhaps right after 'mptcp: Add MPTCP socket stubs'?
> > =

> > Could also be squashed, I do not mind.  Just a suggestion.
> =

> For me it is clearer to have dedicated patches for the introduction of the
> MIBs: it might help reviewers to easily point out "strategic places" or
> because spending less time on that because it only modifies MPTCP code :)

Right, we can do this as a followup so it doesn't influence the initial
batch sizes in any way.

In light of this I agree its better to keep it as-is.

> It is just that I guess the reviewers will not like having too big patches
> neither. I understand that 40 patches is too big but as a reviewer, I wou=
ld
> prefer having a very few more patches and split per features / refactorin=
g.

Same here.

> I mean: if we send the same modifications in less patches, I don't know if
> it will help reviewers.

Right.  Lets keep it separate.
--===============0668769106485472827==--

Content-Type: multipart/mixed; boundary="===============0981650913978416778=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH MPTCP 0/2] mptcp: token api refactoring/cleanup
Date: Thu, 05 Sep 2019 10:25:04 -0700
Message-ID: <57ad65189bf7d171641e71e936815f128e6f8b48.camel@linux.intel.com>
In-Reply-To: 20190902110909.3724-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1793

--===============0981650913978416778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 2019-09-02 at 13:09 +0200, Florian Westphal wrote:
> I tried to fold the earlier 'RFC v2' in a way so that it allows
> easy squashing.
> =

> Patch #1 is the only one where this is painless.
> For all others, things are not easy because conflicts exist all
> over the place.
> =

> So I see two ways forward:
> 1. I rebase this myself and offer a pull request for the resulting series
> 2. Only squash the first patch and keep the rest as extra patch.
> =

> I suggest we go with #2.  The export tree already has a few patches
> that need to be squashed anyway before sending a formal series.
> =

This looks good and I'm fine with the extra patch for now, would just be too
hard to split this up and squash to all kinds of different places.

Peter.

> Also, the export branch is currently not bisectable, I get build
> errors mid-series.
> =

> I don't think this is a problem for now, I think it makes sense to
> not squash the larger patches for the time being.
> =

> Once another patch series is to be submitted to netdev, the export
> branch can be renamed/archived and a reorganisation can be done at that
> point (and the result diff'd versus the old export branch to make sure
> there is no difference in resulting code).
> =

> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============0981650913978416778==--

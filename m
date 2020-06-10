Content-Type: multipart/mixed; boundary="===============7700875591042586282=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/3] mptcp: more token follow-up
Date: Wed, 10 Jun 2020 11:20:49 +0200
Message-ID: <c20a5b3e8538f2fbd0a34ae61b87c30d2612b003.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2006091414220.26344@hlin4-mobl2.gar.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4630

--===============7700875591042586282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-09 at 14:26 -0700, Mat Martineau wrote:
> On Mon, 8 Jun 2020, Paolo Abeni wrote:
> =

> > The patch 1 addesses a race on close which may possibly fix
> > issues/36 && issues/29, the 2nd patch is resolve conflicts and the 3rd =
one
> > is a follow-up cleanup.
> > =

> > Patch 3 should be inserted just after "mptcp: refactor token container."
> > =

> > v1 -> v2:
> > - hopefully includes the correct patches
> > =

> > protocol.c |    9 ++++---
> > subflow.c  |   69 ++++++++++++++++++++++-------------------------------=
--------
> > 2 files changed, 30 insertions(+), 48 deletions(-)
> =

> Thanks Paolo, these fixes look good. From IRC and =

> https://github.com/multipath-tcp/mptcp_net-next/issues/36 it looks like =

> #36 is still happening, do you prefer to try more changes in a v3 or =

> squash these in the export branch and work from there?

I don't have anything more in my pocket, so I would opt for squashing
this changes as is, thanks!

/P

--===============7700875591042586282==--

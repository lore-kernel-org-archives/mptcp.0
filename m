Content-Type: multipart/mixed; boundary="===============1985494332206645420=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/3] mptcp: more token follow-up
Date: Tue, 09 Jun 2020 14:26:48 -0700
Message-ID: <alpine.OSX.2.22.394.2006091414220.26344@hlin4-mobl2.gar.corp.intel.com>
In-Reply-To: cover.1591652866.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4625

--===============1985494332206645420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 8 Jun 2020, Paolo Abeni wrote:

> The patch 1 addesses a race on close which may possibly fix
> issues/36 && issues/29, the 2nd patch is resolve conflicts and the 3rd one
> is a follow-up cleanup.
>
> Patch 3 should be inserted just after "mptcp: refactor token container."
>
> v1 -> v2:
> - hopefully includes the correct patches
>
> protocol.c |    9 ++++---
> subflow.c  |   69 ++++++++++++++++++++++---------------------------------=
------
> 2 files changed, 30 insertions(+), 48 deletions(-)

Thanks Paolo, these fixes look good. From IRC and =

https://github.com/multipath-tcp/mptcp_net-next/issues/36 it looks like =

#36 is still happening, do you prefer to try more changes in a v3 or =

squash these in the export branch and work from there?

--
Mat Martineau
Intel
--===============1985494332206645420==--

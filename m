Content-Type: multipart/mixed; boundary="===============4150015452458195540=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] Interim Path Manager
Date: Mon, 14 Oct 2019 13:29:11 +0200
Message-ID: <fa075b41d8c5ddc20037031633dc3396989c4cbe.camel@redhat.com>
In-Reply-To: 20190917183750.2693-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2106

--===============4150015452458195540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2019-09-17 at 11:37 -0700, Peter Krystad wrote:
> Patchset includes the interim path manager plus sysctl setting of
> the announce address and binding local address when creating subflows.
> I also split the path manager into a seperate file.
> =

> v2:
>   rename to 'basic' path manager
>   remove pm_init definition
>     =

> Peter Krystad (2):
>   mptcp: Minor changes to path manager interface
>   mptcp: Implement basic path manager
> =

>  net/mptcp/Makefile   |   2 +-
>  net/mptcp/basic.c    | 247 +++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/pm.c       |  38 +++++--
>  net/mptcp/protocol.c |   2 +-
>  net/mptcp/protocol.h |  14 ++-
>  5 files changed, 290 insertions(+), 13 deletions(-)
>  create mode 100644 net/mptcp/basic.c

I'm sorry for lagging behind so much.

I'm ok with the patches in the current status - even if I fear some
rebasing will be now need, perhaps good Matt can take that bourden, too
 - since he called me 'lawyer' I feel less guilty asking that ;)

I think we pm looking schema may need some follow-up/cleanup, but that
could eventually follow later.

Cheers,

Paolo

--===============4150015452458195540==--

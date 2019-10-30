Content-Type: multipart/mixed; boundary="===============1459801978844592598=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] Fix issues in prerequisite patches
Date: Wed, 30 Oct 2019 11:42:29 +0100
Message-ID: <0c770735b26da65189bcf16a1eb8c4cf4cbab67e.camel@redhat.com>
In-Reply-To: 20191029165557.7029-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2349

--===============1459801978844592598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-29 at 09:55 -0700, Peter Krystad wrote:
> Fix issues found by Mat in the "IPv6 prerequisite" patch series
> when running against the multipath.org implementation.
> =

> v2: Only announce address if same family as listener
>     Only bind local address if same family as remote
>     Patch 1 of v1 set already merged.
> =

> Peter Krystad (2):
>   mptcp: Save address family when creating socket
>   mptcp: Use correct address family when creating subflows
> =

>  net/mptcp/basic.c    | 36 ++++++++++++++++++++++--------------
>  net/mptcp/protocol.c |  1 +
>  net/mptcp/protocol.h |  1 +
>  3 files changed, 24 insertions(+), 14 deletions(-)
> =


The patches LGTM, thanks!

Note: patch 2/2 will allow mptcp clients to either ipv4 and ipv6
subflows, if the server allows/supports that - e.g. mptcp.org server

Paolo

--===============1459801978844592598==--

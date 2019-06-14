Content-Type: multipart/mixed; boundary="===============1141220168744538023=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/4] Move MPTCP #defines to internal header
Date: Fri, 14 Jun 2019 10:56:26 +0200
Message-ID: <7a3947b756a10fca743dbaeafe06e5a66477eafb.camel@redhat.com>
In-Reply-To: 20190613222454.10728-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1371

--===============1141220168744538023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2019-06-13 at 15:24 -0700, Peter Krystad wrote:
> Like it says...
> =

> Peter Krystad (4):
>   mptcp: Move TCPOLEN #defines to protocol.h
>   mptcp: Move TCPOLEN #defines to protocol.h
>   mptcp: Move TCPOLEN #defines to protocol.h
>   mptcp: make flag field naming consistent
> =

>  include/net/tcp.h    |  9 ---------
>  net/mptcp/options.c  |  4 ++--
>  net/mptcp/protocol.h | 16 +++++++++++++---
>  3 files changed, 15 insertions(+), 14 deletions(-)

Thank you for following-up so fastly! I like how you split the changes
to hopefully simplify the merge.

LGTM,

Thanks!

Paolo


--===============1141220168744538023==--

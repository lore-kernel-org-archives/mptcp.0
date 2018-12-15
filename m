Content-Type: multipart/mixed; boundary="===============1093146260633076689=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 00/12] Code-removal out of mptcp-net-next
Date: Fri, 14 Dec 2018 16:52:23 -0800
Message-ID: <alpine.OSX.2.21.1812141650260.47434@jaheilin-mobl.amr.corp.intel.com>
In-Reply-To: 20181206010023.18819-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 919

--===============1093146260633076689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 5 Dec 2018, Christoph Paasch wrote:

> Series removing a lot of code out of mptcp-net-next.
>
> Before:
> $ git diff --shortstat  1464193107da..mptcp-net-next/master
> 54 files changed, 14663 insertions(+), 375 deletions(-)
>
> $ git diff --shortstat  1464193107da..HEAD
> 50 files changed, 12286 insertions(+), 349 deletions(-)
>
>
> Christoph Paasch (12):
>  mptcp: Remove support for DSS-checksums
>  mptcp: Remove some left-over cruft
>  mptcp: Remove RPS-recording for flow-steering in MPTCP
>  mptcp: Remove support for subflow-priorities (aka backup)
>  mptcp: Remove support for sendpage()
>  mptcp: Remove reinjection of data across subflows
>  mptcp: Remove support for TCP SYN-cookies
>  mptcp: Remove support for TCP Fast Open
>  mptcp: Remove MPTCP-code out of do_ip_setsockopt
>  mptcp: Remove scheduler-selection support
>  mptcp: Remove ndiffports path manager
>  mptcp: Make path-management no more a module nor selectable through
>    socketops
>

Hi Christoph -

I went through the patch series and don't have changes to suggest. Also =

built with CONFIG_MPTCP enabled and ran some simple tests (DSS checksums =

off), and CONFIG_MPTCP=3Dn built fine too.

I'll take a look at v2 when that's ready.

--
Mat Martineau
Intel OTC

--===============1093146260633076689==--

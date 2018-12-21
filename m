Content-Type: multipart/mixed; boundary="===============8589940544276978022=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v4 mptcp-net-next 00/12] Code-removal out of
 mptcp-net-next
Date: Fri, 21 Dec 2018 10:19:33 -0800
Message-ID: <alpine.OSX.2.21.1812211018340.53308@samaxfie-mobl1.amr.corp.intel.com>
In-Reply-To: 20181221161338.72325-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 967

--===============8589940544276978022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 21 Dec 2018, Christoph Paasch wrote:

> Series removing a lot of code out of mptcp-net-next.
>
> Before:
> $ git diff --shortstat  1464193107da..mptcp-net-next/master
> 54 files changed, 14663 insertions(+), 375 deletions(-)
>
> After:
> $ git diff --shortstat  1464193107da..HEAD
> 50 files changed, 12213 insertions(+), 349 deletions(-)
>
>
> v4: Minor left-over removals that were missing - identified by Mat
> v3: Minor left-over removals that were missing - identified by Matthieu
> v2: Some minor fixes - see notes in the sub-patches 4/12 and 12/12
>

Thanks Christoph. I've applied the patches and will merge mptcp_net-next =

with net-next.

--
Mat Martineau
Intel OTC

--===============8589940544276978022==--

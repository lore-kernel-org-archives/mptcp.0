Content-Type: multipart/mixed; boundary="===============7635319176043622029=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 00/11] Multipath TCP: Prerequisites
Date: Mon, 16 Dec 2019 16:32:59 -0800
Message-ID: <alpine.OSX.2.21.1912161626510.6806@mjmartin-mac01.local>
In-Reply-To: 20191217002455.24849-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3108

--===============7635319176043622029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 16 Dec 2019, Mat Martineau wrote:

> v2 changes: sk_pacing_shift left as a regular struct member, and modified=
 SACK
> space check based on recent -net fix.

...

> Clone/fetch:
> https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-v2-part1)
>
> Browse:
> https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v2-part1
>

Matthieu -

I pushed tags for netdev-v2-full and netdev-v2-part1. I modified the =

commit message for patch 9 to reflect Paolo's modifications, so that will =

need to be folded in to topgit:

https://github.com/multipath-tcp/mptcp_net-next/commit/e4a1478a220fab82a06b=
45142cf3edc56c212960

I confirmed there were no code changes between netdev-v2-full and =

export/20191216T191349


--
Mat Martineau
Intel
--===============7635319176043622029==--

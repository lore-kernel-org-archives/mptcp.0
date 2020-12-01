Content-Type: multipart/mixed; boundary="===============5032326128613132476=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: let MPTCP create max size skbs
Date: Tue, 01 Dec 2020 12:19:11 -0800
Message-ID: <8fb7ab63-c6fb-f98c-6580-742bc2969bd9@linux.intel.com>
In-Reply-To: d5c7935a21f20d37900cd51fc0f1f88327a0dfdd.1606406237.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7000

--===============5032326128613132476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2020, Paolo Abeni wrote:

> Currently the xmit path of the MPTCP protocol creates smaller-
> than-max-size skbs, which is suboptimal for the performances.
>
> There are a few things to improve:
> - when coalescing to an existing skb, must clear the PUSH flag
> - tcp_build_frag() expect the available space as an argument.
>  When coalescing is enable MPTCP already subtracted the
>  to-be-coalesced skb len. We must increment said argument
>  accordingly.
>
> Before:
> ./use_mptcp.sh netperf -H 127.0.0.1 -t TCP_STREAM
> [...]
> 131072  16384  16384    30.00    24414.86
>
> After:
> ./use_mptcp.sh netperf -H 127.0.0.1 -t TCP_STREAM
> [...]
> 131072  16384  16384    30.05    28357.69
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> use_mptcp.sh forces exiting app to create MPTCP instead of TCP
> ones via LD_PRELOAD of crafter socket() implementation.
>
> https://github.com/pabeni/mptcp-tools/tree/master/use_mptcp
> ---
> v2 -> v3:
> - drop the tcp bits. They caused stream corruption which
>   could not be easily set, and dropping them does not affect
>   the performance in a visible way, since that code path is
>   hit only on corner cases
> v1 -> v2:
> - prevent splitting if from_ext is frozen: should never happen
>   but is cheap
> - provide dummy mptcp_skb_split() for non MPTCP build
> ---
> net/mptcp/protocol.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>

Thanks for the simplified version, looks good!

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============5032326128613132476==--

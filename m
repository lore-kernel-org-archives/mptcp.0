Content-Type: multipart/mixed; boundary="===============8575797208554248495=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] tcp: mptcp: use mptcp receive buffer space to
 select rcv window
Date: Fri, 13 Mar 2020 16:30:21 -0700
Message-ID: <alpine.OSX.2.22.394.2003131621310.69817@jsingh3-mobl.amr.corp.intel.com>
In-Reply-To: 20200312154901.540-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3945

--===============8575797208554248495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 12 Mar 2020, Florian Westphal wrote:

> In MPTCP, the receive windo is shared across all subflows, because it
> refers to the mptcp-level sequence space.
>
> This commit doesn't change choice of initial window for passive or active
> connections.
> While it would be possible to change those as well, this adds complexity
> (especially when handling MP_JOIN requests).
>
> However, the MPTCP RFC specifically says that a MPTCP sender
> 'MUST NOT use the RCV.WND field of a TCP segment at the connection level =
if
> it does not also carry a DSS option with a Data ACK field.'
>
> SYN/SYNACK packets do not carry a DSS option with a Data ACK field.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> Unless there are comments i will post this as RFC to netdev and will
> CC Eric Dumazet.
>

I think this looks ready for netdev RFC. Thanks.


--
Mat Martineau
Intel
--===============8575797208554248495==--

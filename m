Content-Type: multipart/mixed; boundary="===============3354270646917733216=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Use tcp_abort correctly for MPTCP
Date: Fri, 12 Oct 2018 08:53:24 -0700
Message-ID: <alpine.OSX.2.21.1810120853040.30756@barbab-mobl3.amr.corp.intel.com>
In-Reply-To: 20181010141214.29467-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 826

--===============3354270646917733216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 10 Oct 2018, Matthieu Baerts wrote:

> With MPTCP, we have a modified version of tcp_send_active_reset(). Let's
> use it if needed.
>
> Fixes: 10c57b6f07ac (Merge tag 'v4.5' into mptcp_trunk)
> Fixes: 07abdbda3bd6 (mptcp: Use tcp_abort correctly for MPTCP)
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> (cherry picked from commit f2632fa4ee58f2d375e38119633b5739b6d43b2e)
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> net/ipv4/tcp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 3fb5481e78b3..c4d14fbce16b 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4026,7 +4026,7 @@ int tcp_abort(struct sock *sk, int err)
> 		smp_wmb();
> 		sk->sk_error_report(sk);
> 		if (tcp_need_reset(sk->sk_state))
> -			tcp_send_active_reset(sk, GFP_ATOMIC);
> +			tcp_sk(sk)->ops->send_active_reset(sk, GFP_ATOMIC);
> 		tcp_done(sk);
> 	}
>
> -- =

> 2.17.1

Thanks Matthieu. Patch applied.

--
Mat Martineau
Intel OTC

--===============3354270646917733216==--

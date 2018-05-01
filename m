Content-Type: multipart/mixed; boundary="===============8667467081580638752=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp-net-next] tcp/mptcp: Purge write-queue of
 the sk not meta_sk in tcp_abort()
Date: Tue, 01 May 2018 14:17:12 -0700
Message-ID: <alpine.OSX.2.21.1805011416260.6259@blkatz-mobl.amr.corp.intel.com>
In-Reply-To: 20180501204409.96816-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 597

--===============8667467081580638752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 1 May 2018, Christoph Paasch wrote:

> tcp_abort terminates a specific subflow (e.g., when the interface goes
> down).
>
> However, in tcp_abort() we should not purge the write-queue of the
> meta-sk but of the sk that we are removing.
>
> Fixes: 16b5a42fd18e ("Merge branch 'net-next/master'")
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> net/ipv4/tcp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index eaa32600fe63..eeb98619b181 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3932,7 +3932,7 @@ int tcp_abort(struct sock *sk, int err)
>
> 	bh_unlock_sock(meta_sk);
> 	local_bh_enable();
> -	tcp_write_queue_purge(meta_sk);
> +	tcp_write_queue_purge(sk);
> 	release_sock(meta_sk);
> 	return 0;
> }
> -- =

> 2.16.2

Thanks for catching that, I've applied the patch.

--
Mat Martineau
Intel OTC

--===============8667467081580638752==--

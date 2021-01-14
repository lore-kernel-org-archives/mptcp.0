Content-Type: multipart/mixed; boundary="===============0126741180059803016=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix locking in mptcp_disconnect()
Date: Thu, 14 Jan 2021 20:21:48 +0100
Message-ID: <9cf07f1b-c013-adfc-15b4-58902095cf07@gmail.com>
In-Reply-To: f818e82b58a556feeb71dcccc8bf1c87aafc6175.1610638176.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7390

--===============0126741180059803016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 1/14/21 4:37 PM, Paolo Abeni wrote:
> tcp_disconnect() expects the caller acquires the sock lock,
> but mptcp_disconnect() is not doing that. Add the missing
> required lock.
> =

> Reported-by: Eric Dumazet <eric.dumazet(a)gmail.com>
> Fixes: 76e2a55d1625 ("mptcp: better msk-level shutdown.")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 81faeff8f3bb..f998a077c7dd 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2646,8 +2646,13 @@ static int mptcp_disconnect(struct sock *sk, int f=
lags)
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  =

>  	__mptcp_flush_join_list(msk);
> -	mptcp_for_each_subflow(msk, subflow)
> -		tcp_disconnect(mptcp_subflow_tcp_sock(subflow), flags);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		lock_sock(ssk);
> +		tcp_disconnect(ssk, flags);
> +		release_sock(ssk);
> +	}

Reviewed-by: Eric Dumazet <edumazet(a)google.com>

Note that for loops like this one, calling non blocking functions,
you could use lock_sock_fast()

(Probably does not matter in slow path)

--===============0126741180059803016==--

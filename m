Content-Type: multipart/mixed; boundary="===============6887941612471312528=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "mptcp: clean-up the rtx
 path"
Date: Fri, 12 Mar 2021 10:35:12 +0100
Message-ID: <ff57363a4812e030679ea4313a8994d2e6d96c07.camel@redhat.com>
In-Reply-To: 20210312083514.2725103-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8111

--===============6887941612471312528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-03-12 at 09:35 +0100, Matthieu Baerts wrote:
> The MPTCP_RETRANSMIT define is 9 and these tests should be testing if
> BIT(9) is set instead of taking the number 9.
> =

> This fix is similar to
> commit fe202ab685d5 ("mptcp: fix bit MPTCP_PUSH_PENDING tests") by Dan
> Carpenter.
> =

> Luckily everything was OK before because the only other flag that was
> set was "6", using different bits than "9". Note that BIT(6) is also
> using different bits than "9".
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     to be squashed in "mptcp: clean-up the rtx path"
> =

>  net/mptcp/protocol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2573551912fc..3cd83eb08f2d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2838,7 +2838,7 @@ static void mptcp_release_cb(struct sock *sk)
>  		if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
>  			flags |=3D BIT(MPTCP_PUSH_PENDING);
>  		if (test_and_clear_bit(MPTCP_RETRANSMIT, &mptcp_sk(sk)->flags))
> -			flags |=3D MPTCP_RETRANSMIT;
> +			flags |=3D BIT(MPTCP_RETRANSMIT);
>  		if (!flags)
>  			break;
>  =

> @@ -2853,7 +2853,7 @@ static void mptcp_release_cb(struct sock *sk)
>  		spin_unlock_bh(&sk->sk_lock.slock);
>  		if (flags & BIT(MPTCP_PUSH_PENDING))
>  			__mptcp_push_pending(sk, 0);
> -		if (flags & MPTCP_RETRANSMIT)
> +		if (flags & BIT(MPTCP_RETRANSMIT))
>  			__mptcp_retrans(sk);
>  =

>  		cond_resched();

LGTM, thanks for the quick turnaround!

/P

--===============6887941612471312528==--

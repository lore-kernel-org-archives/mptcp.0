Content-Type: multipart/mixed; boundary="===============7772956957188290400=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 8/8] mptcp: defer work schedule until
 mptcp lock is released
Date: Tue, 25 Feb 2020 13:50:37 +0100
Message-ID: <e570c24a581bd1ce734f7c5751ee3579d92069d1.camel@redhat.com>
In-Reply-To: 20200225120526.2866-9-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3782

--===============7772956957188290400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-25 at 13:05 +0100, Florian Westphal wrote:
> Don't schedule the work queue right away, instead defer this
> to the lock release callback.
> =

> This has the advantage that it will give recv path a chance to
> complete -- this might have moved all pending packets from the
> subflow to the mptcp receive queue, which allows to avoid another
> schedule_work().
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index de6bd9d28116..f7c0d205b047 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -240,8 +240,15 @@ void mptcp_data_ready(struct sock *sk, struct sock *=
ssk)
>  		return;
>  =

>  	/* mptcp socket is busy, schedule worker */
> -	if (schedule_work(&msk->work))
> -		sock_hold((struct sock *)msk);
> +	if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,
> +			      &sk->sk_tsq_flags)) {
> +		sock_hold(sk);

Here is the msk/sk socket lock always held by some other process?

I think the trylock in patch 6 from different subflows can collide with
each other, so a try lock can fail even with !sk->sk_lock.owned

Or the process owning the msk sock lock when the previous check has
been done can release it in the meanwhile.

In one of the above happens, can the TCP_DELACK_TIMER_DEFERRED delayed
for a long time? Do we need to address that scenario?

Thanks,

Paolo


--===============7772956957188290400==--

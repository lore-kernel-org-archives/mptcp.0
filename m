Content-Type: multipart/mixed; boundary="===============0754033631439313072=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 6/8] mptcp: avoid work queue scheduling
 if possible
Date: Tue, 25 Feb 2020 13:40:05 +0100
Message-ID: <e39273fde8de31e82c35048cd758c48268518bff.camel@redhat.com>
In-Reply-To: 20200225120526.2866-7-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3780

--===============0754033631439313072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-25 at 13:05 +0100, Florian Westphal wrote:
> We can't grab the mptcp socket lock from the subflow data_ready
> callback, it would result in ABBA deadlock.
> =

> But we can try to grab the mptcp lock.
> If we can't, we can defer to work queue.
> If the lock succeeds however we can avoid the schedule_work()
> call and move all in-sequence skbs to the mptcp receive queue.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 30 +++++++++++++++++++++++++++++-
>  net/mptcp/protocol.h |  2 +-
>  net/mptcp/subflow.c  |  4 ++--
>  3 files changed, 32 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c96489c5c875..c28c5cc49d65 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -201,17 +201,45 @@ static bool __mptcp_move_skbs_from_subflow(struct m=
ptcp_sock *msk,
>  	return done;
>  }
>  =

> -void mptcp_data_ready(struct sock *sk)
> +/* In most cases we will be able to lock the mptcp socket.  If its alrea=
dy
> + * owned, we need to defer to the work queue to avoid ABBA deadlock.
> + */
> +static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	unsigned int moved =3D 0;
> +
> +	if (sock_owned_by_user_nocheck(sk))
> +		return false;
> +
> +	if (unlikely(!spin_trylock_bh(&sk->sk_lock.slock)))
> +		return false;
> +
> +	/* must re-check after taking the lock */
> +	if (!sock_owned_by_user_nocheck(sk))

Don't we additionally need a READ_ONCE() here and above ?
Otherwise the compiler and/or CPU could merge the read?

AFAICS sock_owned_by_user_nocheck() does not include the additional
annotation.

I think we could simply drop the first check (and always do the
trylock)

Cheers,

Paolo

--===============0754033631439313072==--

Content-Type: multipart/mixed; boundary="===============2147088034412081913=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/6] mptcp: separate accouting for wmem forward
 alloc mem
Date: Mon, 16 Nov 2020 18:04:57 +0100
Message-ID: <e023afa8f4ad8536aaaab41584917775beec41ca.camel@redhat.com>
In-Reply-To: f258529e0cc92e23cda9129216a672ce10e850e7.1605283958.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6754

--===============2147088034412081913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-11-13 at 17:27 +0100, Paolo Abeni wrote:
> Account separatelly the memory forward allocated
> for write operation. When sendmsg() need more memory
> it looks at wforward_alloc first and if that is
> exaused, move more space from sk_forward_alloc.
> =

> This will simplify the next patch
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 52 +++++++++++++++++++++++++++++++++++++++-----
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 48 insertions(+), 5 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6397083476e3..87d8659b9bcc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -852,9 +852,48 @@ static bool mptcp_frag_can_collapse_to(const struct =
mptcp_sock *msk,
>  		df->data_seq + df->data_len =3D=3D msk->write_seq;
>  }
>  =

> +static bool mptcp_wmem_alloc(struct sock *sk, int size)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int amount;
> +
> +	if (msk->wforward_alloc >=3D size)
> +		goto account;
> +
> +	if (!sk_wmem_schedule(sk, size))
> +		return false;
> +
> +	/* try to keep half fwd alloc memory for each direction */
> +	amount =3D max(size, sk->sk_forward_alloc >> 1);
> +	sk->sk_forward_alloc -=3D amount;
> +	msk->wforward_alloc +=3D amount;
> +
> +account:
> +	msk->wforward_alloc -=3D size;
> +	return true;
> +}
> +
> +static void mptcp_wmem_uncharge(struct sock *sk, int size)
> +{
> +	mptcp_sk(sk)->wforward_alloc +=3D size;
> +}
> +
> +static void mptcp_mem_reclaim_partial(struct sock *sk)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	sk->sk_forward_alloc +=3D msk->wforward_alloc;
> +	msk->wforward_alloc =3D 0;
> +	sk_mem_reclaim_partial(sk);
> +
> +	/* split the remaining fwd allocated memory between rx and tx */
> +	msk->wforward_alloc =3D sk->sk_forward_alloc >> 1;
> +	sk->sk_forward_alloc -=3D msk->wforward_alloc;
> +}
> +
>  static void dfrag_uncharge(struct sock *sk, int len)
>  {
> -	sk_mem_uncharge(sk, len);
> +	mptcp_wmem_uncharge(sk, len);
>  	sk_wmem_queued_add(sk, -len);
>  }
>  =

> @@ -909,8 +948,8 @@ static void mptcp_clean_una(struct sock *sk)
>  	}
>  =

>  out:
> -	if (cleaned)
> -		sk_mem_reclaim_partial(sk);
> +	if (cleaned && tcp_under_memory_pressure(sk))
> +		mptcp_mem_reclaim_partial(sk);
>  }
>  =

>  static void mptcp_clean_una_wakeup(struct sock *sk)
> @@ -1334,11 +1373,12 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
>  		offset =3D dfrag->offset + dfrag->data_len;
>  		psize =3D pfrag->size - offset;
>  		psize =3D min_t(size_t, psize, msg_data_left(msg));
> -		if (!sk_wmem_schedule(sk, psize + frag_truesize))
> +		if (!mptcp_wmem_alloc(sk, psize + frag_truesize))
>  			goto wait_for_memory;

As mentioned before, one possible follow-up to this series is open-code =

a MPTCP-specific variant of lock_sock()/release_sock() which will allow
performing some additional/MPTCP specific actions under the msk level
spinlock.

Specifically:

- in recevmsg(), in lock_sock(), splice sk->sk_receive_queue in msk-
>receive_queue
- still in recvmsg(), in release_sock(), update the bulk freed rmem =


Overall this 2 will allow acquiring no additional spinlock at all in
the average case for recvmsg()

- in sendmsg(), in lock_sock(), move as much memory as needed from
sk_forward_memory to wforward_memory, eventually allocating it.
- in sendmsg(), in release_sock(), move again the unused
wforward_memory to sk_forward_memory.

Overall this 2 will allow acquiring no additional spinlock at all in
the average case for sendmsg() and will avoid artifacts due to the
sk_forward_memory/wforward_memory separation.

But they additionally will allow replacing the wforward_memory field
with a local variable. =


So I'm wondering if I should already code the above, to avoid
introducing this additional new msk field just to remove it in a few
patches !?!

Any opinion more than welcome!

Paolo

--===============2147088034412081913==--

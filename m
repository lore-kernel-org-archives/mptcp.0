Content-Type: multipart/mixed; boundary="===============0094881359136802555=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 2/3] mptcp: fix race in release_cb
Date: Tue, 09 Feb 2021 15:22:49 +0100
Message-ID: <25ae0379-e557-22ac-7a0c-0a6289d3d454@tessares.net>
In-Reply-To: 45298408838519faf5eb1ca8e39593c3a5d4bac9.1612869198.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7707

--===============0094881359136802555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for the patch!

On 09/02/2021 12:42, Paolo Abeni wrote:
> If we receive a MPTCP_PUSH_PENDING even from a subflow when
> mptcp_release_cb() is serving the previous one, the latter
> will be delayed up to the next release_sock(msk).
> =

> Address the issue implementing a test/serve loop for such
> event.
> =

> Additionally rename the push helper to __mptcp_push_pending()
> to be more consistent with the existing code.

(...)

> @@ -2942,13 +2942,14 @@ static void mptcp_release_cb(struct sock *sk)
>   {
>   	unsigned long flags, nflags;
>   =

> -	/* push_pending may touch wmem_reserved, do it before the later
> -	 * cleanup
> -	 */
> -	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
> -		__mptcp_clean_una(sk);
> -	if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags)) {
> -		/* mptcp_push_pending() acquires the subflow socket lock
> +	for (;;) {
> +		flags =3D 0;
> +		if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
> +			flags |=3D MPTCP_PUSH_PENDING;
> +		if (!flags)
> +			break;

This looks strange: "flags" is reset to 0 then set if the previous =

condition is valid and we check what was done at the previous =

instruction. Maybe clearer with "else" instead of "if (!flags)"?

> +
> +		/* the following actions acquire the subflow socket lock
>   		 *
>   		 * 1) can't be invoked in atomic scope
>   		 * 2) must avoid ABBA deadlock with msk socket spinlock: the RX
> @@ -2957,13 +2958,21 @@ static void mptcp_release_cb(struct sock *sk)
>   		 */
>   =

>   		spin_unlock_bh(&sk->sk_lock.slock);
> -		mptcp_push_pending(sk, 0);
> +		if (flags & MPTCP_PUSH_PENDING)
> +			__mptcp_push_pending(sk, 0);
> +
> +		cond_resched();
>   		spin_lock_bh(&sk->sk_lock.slock);
>   	}
> +
> +	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
> +		__mptcp_clean_una(sk);
>   	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
>   		__mptcp_error_report(sk);
>   =

> -	/* clear any wmem reservation and errors */
> +	/* push_pending may touch wmem_reserved, ensure we do the cleanup
> +	 * later

But we still need to update "rmem", right? :)
(oh yes but even before, we were only talking about "wmem", fine!)

> +	 */
>   	__mptcp_update_wmem(sk);
>   	__mptcp_update_rmem(sk);
>   =

> =


Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0094881359136802555==--

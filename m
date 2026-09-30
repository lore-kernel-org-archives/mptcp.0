Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE854973B8
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765586; cv=none; b=aWXAiSx5dyorbmADFiy4YeSTW4osUR3ui3LFFcgG2dnU577jmOCZyGFURI3308APeYDTkSLiX5ZpXQRvLK/jEHwbfU2AAUbX6aJT+5v9W8/xYg0fORfi9ekoQA68xX7IqHmDKTog8HopTvEINXoHW2wmAk3bPacEBZn4ZEBOZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765586; c=relaxed/simple;
	bh=5M+xaLekzYFvOS73N9Mz7dXNVp1h125/qCgt6Qj3KHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mlr2N5yDz0XtYitJemRoHimRHQLJUIb3XVccJUrbKnj4niz7ryrXngOYEvkIvewn9O0xcDMc9Y77n5LDdcxCC3Ij2TG/ZaWvPDfSpRe2sdHhjxsKfzVb83B9juIydalsU4MrknBOupb8xN4PTDLkD+oJjdQ+KDvL30fzhqaYe0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeNBwnWR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeNBwnWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CF31F00893;
	Wed, 30 Sep 2026 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790765566;
	bh=L3vEXA+EoHB2NTtBKRMXoqODZUREd08jZc3j+XmUgyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IeNBwnWRMOsHn7ImGTIKuM86aa4LMWuaNDzSr9dyWVOMl0mZK2XEerYA+TQmqxlQ+
	 4C/wXvIow8Xi5ZhXx/TCdkYBJ8WAFHhiryDt9CO9aeSSw5m4sh8yB/cgrePN5ufRSH
	 4Fu37+sV+7+3QMDwII6+BFBHvbA+uAN5fcvRvKXLNELjo3bEPuTu9XOsF19Ep0LhKN
	 DOepSYWJMUQa3wVpVPoz3xSY/LHtOxca5CCwjNnTlX1X1c9illrDD0PhW+xK2hvfLy
	 ElwT3khlnXorxQ0NDHf5VKoTOBeIxF69Av9S2GrQ5/C8WOKE7QImLeI8+4oOEnjqq6
	 M2F5EIMJA+Dhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7] mptcp: normalize seq numbers reported in
 mptcp_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com>
References: <20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:52:46 +0000
Message-Id: <20260930105246.80CF31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] mptcp: breaks UAPI backward compatibility for sequence numbers
- [Critical] mptcp: use-after-free in mptcp_diag_fill_info when accessing s=
ubflow context
--

commit d5f0de8b3b4a150c893d97d9c69889501c979b26
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

    mptcp: normalize seq numbers reported in mptcp_info

This commit normalizes the MPTCP sequence numbers reported via mptcp_info
by subtracting the local and remote initial sequence numbers. It updates
mptcpi_write_seq, mptcpi_snd_una, and mptcpi_rcv_nxt to provide relative
values instead of absolute on-the-wire 64-bit sequence numbers. The
normalization logic accesses the connection's first subflow context to fetch
these initial sequence numbers.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..918ec873fcb05 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1008,9 +1010,37 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, =
struct mptcp_info *info)
>  	info->mptcpi_flags =3D flags;
> =20
>  	slow =3D lock_sock_fast(sk);
> +	/* msk->first is only ever NULL once the whole msk is already in
> +	 * TCP_CLOSE (see __mptcp_close_ssk()); mptcp_close() holds the same
> +	 * sk lock this function acquires via lock_sock_fast(), so no caller
> +	 * can observe that transition mid-flight. If it does happen, write_seq
> +	 * and snd_una below are just left unnormalized, which is harmless
> +	 * since the socket is already gone.
> +	 *
> +	 * first is snapshotted once here, rather than re-read later, so
> +	 * local_idsn and remote_idsn below both come from the same subflow
> +	 * and stay consistent with each other even if msk->first changes
> +	 * between the two normalizations. __mptcp_close_ssk() can drop the
> +	 * last reference on this subflow (sock_put()) before it clears
> +	 * msk->first, so refcount_inc_not_zero() is used instead of
> +	 * sock_hold(): if the count has already reached zero, first is
> +	 * treated the same as NULL instead of resurrecting a dying socket.
> +	 * On success, the extra reference keeps the subflow context alive
> +	 * for the rest of this function; it is released with sock_put() at
> +	 * the end.
> +	 */
> +	rcu_read_lock();
> +	first =3D READ_ONCE(msk->first);
> +	if (first && !refcount_inc_not_zero(&first->sk_refcnt))
> +		first =3D NULL;
> +	rcu_read_unlock();
> +
> +	if (first)
> +		local_idsn =3D mptcp_subflow_ctx(first)->idsn;
> +
>  	info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token =3D msk->token;
> -	info->mptcpi_write_seq =3D msk->write_seq;
> +	info->mptcpi_write_seq =3D msk->write_seq - local_idsn;

[Severity: Critical]
Does this change introduce a UAPI regression?

Since this modifies UAPI fields (mptcpi_write_seq, mptcpi_snd_una, and
mptcpi_rcv_nxt) to use a relative offset instead of the absolute sequence
number, it might permanently break existing userspace tools (like tcpdump) =
that
rely on absolute on-the-wire values to correlate with packet captures.

>  	info->mptcpi_retransmits =3D inet_csk(sk)->icsk_retransmits;
>  	info->mptcpi_bytes_sent =3D msk->bytes_sent;
>  	info->mptcpi_bytes_received =3D msk->bytes_received;
> @@ -1023,11 +1053,28 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk,=
 struct mptcp_info *info)
>  	unlock_sock_fast(sk, slow);

[Severity: Critical]
Does taking a reference on the socket's sk_refcnt earlier actually protect =
the
subflow ULP context across this lock gap?

When we drop the socket lock here via unlock_sock_fast(), could a concurrent
mptcp_close() acquire the lock and call __tcp_close(), which unconditionally
executes tcp_cleanup_ulp()?

If tcp_cleanup_ulp() runs, it frees the ULP context via kfree_rcu() regardl=
ess
of the elevated sk_refcnt. Since unlock_sock_fast() can sleep and we are not
in an RCU read-side critical section, the RCU grace period might elapse bef=
ore
we re-acquire the lock below.

> =20
>  	mptcp_data_lock(sk);
> +	if (first) {
> +		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(first);
> +
> +		/* subflow->iasn is incremented once in subflow_set_remote_key(),
> +		 * which runs under this same mptcp_data_lock() (see
> +		 * mptcp_propagate_state()); compute remote_idsn here, under the
> +		 * same lock as the writer, and atomically with ack_seq below.
> +		 * first is the same held reference from earlier in this
> +		 * function, so it is guaranteed to still be valid here and to
> +		 * be the same subflow local_idsn was computed from above.
> +		 */
> +		remote_idsn =3D subflow->remote_key_valid ? subflow->iasn - 1 : 0;

Could this regression result in a use-after-free when reading subflow->iasn=
 if
the ULP context was freed during the lock gap?

> +	}
> +
>  	info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk->last_ack_rec=
v);
> -	info->mptcpi_snd_una =3D msk->snd_una;
> -	info->mptcpi_rcv_nxt =3D msk->ack_seq;
> +	info->mptcpi_snd_una =3D msk->snd_una - local_idsn;
> +	info->mptcpi_rcv_nxt =3D msk->ack_seq - remote_idsn;
>  	info->mptcpi_bytes_acked =3D msk->bytes_acked;
>  	mptcp_data_unlock(sk);
> +
> +	if (first)
> +		sock_put(first);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930102804.2796=
208-1-kalpan.jani@mpiricsoftware.com?part=3D1

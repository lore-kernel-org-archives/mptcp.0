Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596929ACC5
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415262; cv=none; b=rTMFoiz6BIlydg3RHSDQZdXdfueGTQf7kyzTy7DTAyHzNGnQrFAK2tCqv6H9v51eubp/xqaJotd+oSbQeNZHMqEVxaHL+cFTtbD6+fcdyEyU9dlhi+oSLVpNEFpLjr8KqmBsbmgNbkx7pih3ZG5IfZVoEzOcO68YXCv9MCbd5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415262; c=relaxed/simple;
	bh=ie0ewSyb7wgYpz1ElwEHQYJ29pIM4yK49K2pXU4MSHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JjW8QkPEAo5kQhWoXId1b2scxQl3HIzmFlmfkf1j6mr0SEa0KZczXGqPT3xHGYxpd4ipNXJmGq34BMEULTNRSLUsYPbBfqVaV/s2fbnnWy5vV6rrwfxpEZOtILvSoriip/NMgpn1vvFU3fMw2e1BrMesRKkBp2yGStjJ0Y8Y2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNGyy7iA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNGyy7iA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E361F000E9;
	Thu,  3 Sep 2026 06:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788415260;
	bh=bEbG0ZKx746sbPkxRb/zbM8PYEqfN6jSRNsk2FXJRqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNGyy7iAUL++ty85EKPpeDPn/44wLrhCFhCswOZL24CAuKD2HZI5DkT/NjFGUhapQ
	 W1M5qago30hLMw2xFeh9hGkwGhxS7ptbsrV9SaZpTMW4rdGKVYVHGGxd9z43r9dxv/
	 Ru3JrkxMy0SjRcqpquHiK5QeJX6k+rf2s69rtRd6I2NaFmA0r5l++EZwYS84pvoeMc
	 VtJfYZ3cfFWgbkRVQNWurxVJylG+v0n/3GDudJzLC8Dp9N89v/EhlVvZbhlqYN5SxM
	 mOvlv9XHW6nHnaw+fHLe7JgU838gUMmhPaFXGbpd1RITHeZ0/MVRrBx0b9kPa6XyW5
	 BzraLKsxmFNLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4] mptcp: normalize seq numbers reported in
 mptcp_info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260903054853.3400545-1-kalpan.jani@mpiricsoftware.com>
References: <20260903054853.3400545-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 06:01:00 +0000
Message-Id: <20260903060100.B2E361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Changing the semantics of UAPI fields `mptcpi_write_seq`, `mpt=
cpi_snd_una`, and `mptcpi_rcv_nxt` from absolute MPTCP sequence numbers to =
relative zero-based offsets breaks userspace tools.
- [Medium] Unsynchronized access to the 64-bit `subflow->iasn` and bitfield=
 `subflow->remote_key_valid` causes a data race, torn reads, and memory reo=
rdering bugs.
- [Medium] A cross-lock Time-of-Check to Time-of-Use (TOCTOU) race between =
reading `remote_key_valid` and `msk->ack_seq` causes the diagnostic tool to=
 leak the raw, unnormalized sequence number.
--

commit b74b908d7d9e7114635fdc56f70e62e97e495292
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: normalize seq numbers reported in mptcp_info

This commit attempts to normalize sequence numbers reported in mptcp_info by
subtracting the initial sequence numbers from the raw values. It calculates
these offsets using the local and remote IDSN from the subflow context.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..5bcad54e909d1 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
[ ... ]
> @@ -1008,9 +1009,29 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, =
struct mptcp_info *info)
>  	info->mptcpi_flags =3D flags;
> =20
>  	slow =3D lock_sock_fast(sk);
> +	/* msk->first is only ever NULL once the whole msk is already in
> +	 * TCP_CLOSE (see __mptcp_close_ssk()); mptcp_close() holds the same
> +	 * sk lock this function acquires via lock_sock_fast(), so no caller
> +	 * can observe that transition mid-flight. If it does happen, the 0
> +	 * fallback below just leaves write_seq/snd_una/rcv_nxt unnormalized,
> +	 * which is harmless since the socket is already gone.
> +	 */
> +
> +	if (msk->first) {
> +		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(msk->first=
);
> +
> +		local_idsn =3D subflow->idsn;
> +		/* subflow->iasn is incremented once in subflow_set_remote_key()
> +		 * to account for the peer's virtual SYN; undo that here so
> +		 * rcv_nxt normalizes against the same baseline write_seq and
> +		 * snd_una use.
> +		 */
> +		remote_idsn =3D subflow->remote_key_valid ? subflow->iasn - 1 : 0;

[Severity: Medium]
Could this result in a data race? In mptcp_diag_fill_info(), we are only
holding the socket lock via lock_sock_fast(). However, the writer in
subflow_set_remote_key() holds only the data lock.

On 32-bit systems, a lockless read of the 64-bit subflow->iasn can tear.
Additionally, since there are no memory barriers (e.g. smp_load_acquire() a=
nd
smp_store_release()), the CPU could reorder the reads and observe
remote_key_valid =3D=3D 1 while iasn is still uninitialized.

Could this happen when getsockopt(MPTCP_INFO) is called concurrently with t=
he
softirq processing the remote key via mptcp_propagate_state()?

> +	}
> +
>  	info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token =3D msk->token;
> -	info->mptcpi_write_seq =3D msk->write_seq;
> +	info->mptcpi_write_seq =3D msk->write_seq - local_idsn;

[Severity: Critical]
Does this regression break userspace ABI?=20

By changing the semantics of mptcpi_write_seq, mptcpi_snd_una, and
mptcpi_rcv_nxt from absolute sequence numbers to relative zero-based offset=
s,
existing tools relying on absolute sequence numbers (like tcpdump correlati=
on)
might break.

Furthermore, because the kernel does not expose the local_idsn and remote_i=
dsn
offsets in the mptcp_info struct, userspace has no way to reconstruct the
original absolute values.

>  	info->mptcpi_retransmits =3D inet_csk(sk)->icsk_retransmits;
>  	info->mptcpi_bytes_sent =3D msk->bytes_sent;
>  	info->mptcpi_bytes_received =3D msk->bytes_received;
[ ... ]
> @@ -1024,8 +1045,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, s=
truct mptcp_info *info)
> =20
>  	mptcp_data_lock(sk);
>  	info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk->last_ack_rec=
v);
> -	info->mptcpi_snd_una =3D msk->snd_una;
> -	info->mptcpi_rcv_nxt =3D msk->ack_seq;
> +	info->mptcpi_snd_una =3D msk->snd_una - local_idsn;
> +	info->mptcpi_rcv_nxt =3D msk->ack_seq - remote_idsn;

[Severity: Medium]
Could this regression leak the raw sequence number due to a Time-of-Check to
Time-of-Use race?

If mptcp_diag_fill_info() samples remote_key_valid as 0 earlier under
lock_sock_fast(), remote_idsn will be captured as 0. If
subflow_set_remote_key() then executes concurrently before we acquire the
data lock here, it updates msk->ack_seq to the absolute sequence number.

When we compute info->mptcpi_rcv_nxt =3D msk->ack_seq - remote_idsn here, it
will subtract 0 from the raw sequence number, returning the unnormalized
value and causing a discontinuity for userspace.

>  	info->mptcpi_bytes_acked =3D msk->bytes_acked;
>  	mptcp_data_unlock(sk);
>  }
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index af81ad5e699d1..794c6dd9e4150 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
[ ... ]
> @@ -493,6 +492,9 @@ static void subflow_set_remote_key(struct mptcp_sock =
*msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +
> +	/* publish last, once iasn and the fields above are fully populated */
> +	subflow->remote_key_valid =3D 1;

[Severity: Medium]
As mentioned earlier in mptcp_diag_fill_info(), writing to this bitfield
under the data lock without memory barriers means that concurrent lockless
readers might observe remote_key_valid =3D=3D 1 while iasn is still
uninitialized.

>  }
> =20
>  static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903054853.3400=
545-1-kalpan.jani@mpiricsoftware.com?part=3D1

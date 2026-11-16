Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800667;
	b=haTOfQ8FTpQzJfqouChDlFQiN2/j9vZ8IGq7k+T+jBNZeeA+IY09FmVB3eh/NQkDP1Oe
	 /8E+8ih2tY4tixtaxosTLNV26jhKN9h1SnNIkkFW9yEqlT3trBLB7WWk6WpIZV0U3cekR
	 fg5y1ECAoAC7CKo04xzAoyPIV5kwWBqXJ80nnEUJZmVFLH5dstcJCwYtPeQwYWswtVPno
	 aCDPbOas7vtk6qhdD3XnbfpAqzQc5Yuh0B+WvY/TOps+1KhD9yHQcgO1vHgb+fVG5YKy4
	 tmZ5wYusFoY8JBaf2HslJN68oO+V0rrnzJRFbflkiwnGHibbXC6WlJtD3KQyTzCmcDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800667;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SpFJZXe87ZHwnTNTRBHTKpxyab9mSDsfByQ6/9MmGk4=;
	b=YA1FEMpR9KQDLsuL1WuidMksCbJB7LY8ZfA1TfdoWEaAwN61yg+Tybpr2y/3DctZokmW
	 iNuuio1pFsLZgaZftuoHnqrb83yCQnOIogSfv3sN9k7nMONmeyiBl1TQqgI1Ca+u5fWxX
	 HmVy8y+faV3A/LV7V4NsVdCJGRC6nCDv/L3Wjxh8tpsIgQCn2YezNsm2L2FuAtro6BIdV
	 3lXX0VOM5AZ/omnkkK+z8TXM5PlPLgMaF4JU/kuYTSesw270CKbhIioMYMnMqOw0XXAp7
	 GozxX/mJFR+ilU8QrM+qibyOcLTVXJtHzHV4rRyd0S2YoA0igM/Q0p6KleBm85asi+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFkgyDAC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C765606A337
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFkgyDAC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265F81F000C5;
	Mon, 16 Nov 2026 03:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794800667;
	bh=SpFJZXe87ZHwnTNTRBHTKpxyab9mSDsfByQ6/9MmGk4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JFkgyDACSaA7Tfkacy+z6DKOR9l0OSxRMgRnoI2rgqZAaX//mF1Fov+xWTeJiEvlD
	 CoCqyJLD39V/thIq7BXS3OsrEwmIoDxKxVe/BTMNgd/3xoK2dChJBcD4HRDR+gFK8X
	 iOlObEnF64YbOe793AX+ke9bQylxuNcN1ppag3Q5HAYf/9/CiU7UkQfusK3SZvZH1L
	 E4WDtzHMGU7K/50340GTi2wNOu+m8xekOJ1HxrGlG0fnbztCdT6LiDoAlfoyGAV40O
	 NmnHhllNp5DSU4wSywPtkvBC0Lj5+e+j6fEbqGN7oPlCnSfJEBl9adkqa430XL4Mcp
	 OUwtlDrd9jjGQ==
Subject: Re: [PATCH mptcp-next v27 5/8] mptcp: drop the cant_coalesce CB field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 16 Nov 2026 03:44:26 +0000
Message-ID: <179480066666.3133.7423698266063058153@kernel.org>
In-Reply-To: <fa94d3136758974ad5a26837ee39da26e5c24f12.1794663678.git.tanggeliang@kylinos.cn>
References: <fa94d3136758974ad5a26837ee39da26e5c24f12.1794663678.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In net/mptcp/subflow.c, subflow_set_remote_key() defers the TFO
  sequence sync with the atomic set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags).

--

mptcp: drop the cant_coalesce CB field

This patch removes the cant_coalesce MPTCP skb CB field. In its place, the
TFO skb's map_seq and end_seq are fixed up using the IASN once the 3rd ack
arrives. The fixup runs either directly or, when the msk is owned by the
user, it is deferred via a new MPTCP_SYNC_SEQ cb_flags bit that is handled
in mptcp_move_skbs() and mptcp_release_cb().

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6f07544bfe40b..f9dfb6662e3c8 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -537,6 +539,12 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
>  	WRITE_ONCE(msk->ack_seq, subflow->iasn);
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> +	msk->tfo_iasn = subflow->iasn;
> +
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_sync_rcv_sequence(sk);
> +	else
> +		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);

[Severity: Low]
This isn't a bug, but should this be __set_bit() rather than set_bit()?

Every other place that sets an msk->cb_flags bit uses the non-atomic
__set_bit() while holding the msk data lock. One example is the caller,
mptcp_propagate_state(), a few lines further down:

net/mptcp/subflow.c:mptcp_propagate_state() {
	mptcp_data_lock(sk);
	if (mp_opt) {
		...
		subflow_set_remote_key(msk, subflow, mp_opt);
	}

	if (!sock_owned_by_user(sk)) {
		__mptcp_sync_state(sk, ssk->sk_state);
	} else {
		msk->pending_state = ssk->sk_state;
		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
	}
	mptcp_data_unlock(sk);
}

The same pattern holds for MPTCP_CLEAN_UNA, MPTCP_PUSH_PENDING,
MPTCP_RETRANSMIT, MPTCP_SYNC_SNDBUF, MPTCP_FLUSH_JOIN_LIST and
MPTCP_ERROR_REPORT.

The new consumers in mptcp_move_skbs() and mptcp_release_cb() clear the bit
with the non-atomic __test_and_clear_bit(). The commit message says this is
fine "since the cb_flags are protected by the msk data lock".
mptcp_release_cb() also does a plain read-modify-write on cb_flags.

All three callers of subflow_set_remote_key() already hold sk_lock.slock:

  mptcp_propagate_state() takes mptcp_data_lock()
  the options.c path wraps __mptcp_subflow_fully_established() in
    mptcp_data_lock()/mptcp_data_unlock()
  mptcp_sk_clone_init() holds bh_lock_sock(nsk)

Nothing races today, so the atomic set_bit() is redundant. Mixing it with
the non-atomic clears makes the locking rule less clear. The set_bit() is
still present at the end of the series as well.

>  }
>  
>  static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794663678.git.tanggeliang%40kylinos.cn

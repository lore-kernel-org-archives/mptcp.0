Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6F36F8F2
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539031; cv=none; b=r8m1CVUgdcaykq78iohYWgueMnjfcbhu8gns9pGBCRoUYldJRiXiiUAI5jjkTG5GuR7ejRR0Bd1usKPtb34gVzGTpKnCJzFmml2z3lgm1DR8GOqnW30SUyHGpVbY19wtXBiE2KBQc4cdc0sJ081mEuughJnLm94mOX2wpQwFmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539031; c=relaxed/simple;
	bh=zjznfCyEP9Cf4KnoyEdtPlbSVyAX8QFYvRlT/0lyPjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cP4z7pduMz6+htc5EwFGTdrU8KoH2kzIK9bg9vZdDcHk3E+K+t2jPtOlmIlETZOh/tk2C+D/cJJyJbTuwTkmIu2zqKObjaHN/VSrHd3YJf/LcH6nonfCCTNyyrV5nf3qIhyvVzgSOxnlNsJrXoXzvzN+PLN10Il7j1C5eBkTRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABkEzgZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABkEzgZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA001F000E9;
	Mon, 24 Aug 2026 02:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787539029;
	bh=pmnGAE3UZ4v3Nr1rwN85+QMDnFFY56urvLqmoYIJvfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABkEzgZfZvOGiJnf4RzKkK0MvMicgJ4yWGyhL6H/W/qyryF4hiXN/A3tKH+VSkyHj
	 DoPVgF537Het4arMhuhrkhCyy9EpdUsrxx+TpoPyrsGUT/2B5/l4TBE+DP2gM1aV02
	 a9Atzjk6sA/WAlIPpYjrKFGdF385H5OANUZk2IxTbI+cIO9ChU1afyC9DWWWttXwqq
	 om/SzuMH8On4kfY6t/O6aEi7t9qt3ITat00rAlb8Jfwhs2LrQqsZBlSkEMez1z/aBE
	 yir+yX0S/bd+Sy4BeDq5ns7rZ5BPOsVyLcr6u/KycebxV9tav/Lkt1nN5KAadKtuc6
	 aJdMzSremjnPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v7 4/8] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <5237bcbcc25cd63b713a6cf254ec64550b8476e2.1787537436.git.tanggeliang@kylinos.cn>
References: <cover.1787537436.git.tanggeliang@kylinos.cn>
 <5237bcbcc25cd63b713a6cf254ec64550b8476e2.1787537436.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 02:37:08 +0000
Message-Id: <20260824023708.DEA001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Spurious INT_MAX returned by SIOCINQ and CMSG_INQ due to deferred =
`copied_seq` synchronization window, causing potential application OOMs.
--

--- Patch [4]: [PATCH mptcp-next v7 4/8] mptcp: remove CB offset field ---
commit 9bec5b4a8e5f51b288f8330e08515f372476e6e8
Author: Paolo Abeni <pabeni@redhat.com>
Subject: mptcp: remove CB offset field

This patch replaces the offset field in mptcp_skb_cb with a socket-level
copied_seq field. This tracks bytes consumed and delegates synchronization
to the release callback when userspace holds the socket lock during remote
key reception.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c23046b1e51b5..a9faae858a21c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2391,26 +2391,23 @@ static unsigned int mptcp_inq_hint(struct sock *s=
k)
>  {
>  	const struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	u64 hint_val;
> =20
> -	skb =3D skb_peek(&sk->sk_receive_queue);
> -	if (skb) {
> -		u64 hint_val =3D atomic64_read(&msk->ack_seq) -
> -			       MPTCP_SKB_CB(skb)->map_seq;
> -
> -		if (hint_val >=3D INT_MAX)
> -			return INT_MAX;
> -
> -		return (unsigned int)hint_val;
> -	}
> +	/* Avoid races vs ack_seq updates. */
> +	mptcp_data_lock(sk);
> +	hint_val =3D atomic64_read(&msk->ack_seq) - msk->copied_seq;
> +	mptcp_data_unlock(sk);
> +	if (hint_val >=3D INT_MAX)
> +		return INT_MAX;

[Severity: High]
Can mptcp_inq_hint() return a spurious INT_MAX here when userspace calls
SIOCINQ during connection establishment?

If the user application concurrently holds the socket lock while polling,
subflow_set_remote_key() will immediately update msk->ack_seq to the
cryptographic sequence number (iasn), but defer the msk->copied_seq
synchronization by setting MPTCP_SYNC_SEQ:

net/mptcp/subflow.c:subflow_set_remote_key() {
    ...
	atomic64_set(&msk->ack_seq, subflow->iasn);
    ...
	if (!sock_owned_by_user(sk)) {
    ...
	} else {
		/* Ensure ack_seq is visible before setting the flag */
		smp_wmb();
		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
	}
}

Because mptcp_inq_hint() unconditionally reads the updated ack_seq and the
not-yet-synchronized copied_seq, their difference will be a huge value
causing this to return INT_MAX. Is there a way to force synchronization
or check MPTCP_SYNC_SEQ before computing this hint? Applications often use
this value to dynamically allocate buffers, which could lead to memory
exhaustion and crashes.

> =20
> -	if (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
> +	if (!hint_val &&
> +	    (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
>  		return 1;
> =20
> -	return 0;
> +	return (unsigned int)hint_val;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787537436.gi=
t.tanggeliang@kylinos.cn?part=3D4

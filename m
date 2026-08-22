Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418D2417D9
	for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787369781; cv=none; b=i11XdoARw0XG6HE83k4u8EfJhRMy0pilR+qY2hzrhh/uvIx15DlWeWBhiEdHwqAoA16bJq37wWThKZm2rsrAAMaIS8s5zYkLgTrrCRtaOevEL3yVoJH5dxuAzna93Vrww2PUYPWfpJlSekYDo9U1MeuriKyMaMHWZIs5Eu7RWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787369781; c=relaxed/simple;
	bh=+tSQASBIBMxfFGwZiieE09vT0F+RfBFKxxEFWMwfHSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RCR9eS9HQaFEP0vFyGw3Wp9JfOoyn5RfhjGgc8DwEKUgfFwhztZODepm+Op2Cd0zSFdWhBh21nfmDYhAjXsPIbC+YRmUIpfSlzscmezLnmBd9CnzocOFzMuHaHNhCRTKG7BBHUoNUHFr3u03vRdxAxWT5RKCTaH/rC2BnfGk43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbAc/G8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbAc/G8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D2B1F000E9;
	Sat, 22 Aug 2026 03:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787369779;
	bh=/2LNL+DS9vfjQGTwH1PdD78iFgXp60BlNgEay3BNqHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZbAc/G8KD/fe/sj7s0iFNuvxdmWchLCnCoh/b3Pa28MykbQtSR+slr6AZj8CDsCUx
	 uHjJt81osMTbF2K5KzhtsY9r6pR6wie/BayRYQp8Rg1yufmbQ1AGeqN3hjskBU6dNR
	 2YVCG0Gtq0yyCcOJeSMyZJTPKQC3MJL8VUIR4O0tEuwKLmupVw+lZWG+4uQVVurYX+
	 956JE5adwaP3DX+AK5mLhxuErXoEeaAJ2n0XScuxnlDS4wN73z50pxwjst5vZLp5+g
	 bW5FYcxpH4LXdkYcAmpZZI56wg6iJ2Apj963HalOyrr0P1h3m/7smIuIB56dfq9VGw
	 Y3NVWoWQ3Ctlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 3/7] mptcp: remove CB offset field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <7ea2978b1777ca56a0bdfe72f8f8da0cc1667d94.1787368526.git.tanggeliang@kylinos.cn>
References: <cover.1787368526.git.tanggeliang@kylinos.cn>
 <7ea2978b1777ca56a0bdfe72f8f8da0cc1667d94.1787368526.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 03:36:18 +0000
Message-Id: <20260822033619.77D2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing memory barrier before set_bit(MPTCP_SYNC_SEQ, &msk->cb_fla=
gs) causes a data race, allowing a concurrent lockless reader in __mptcp_mo=
ve_skb() to read a stale msk->ack_seq.
--

--- Patch [3]: [PATCH mptcp-next v5 3/7] mptcp: remove CB offset field ---
commit 9bf62f08e2b81be277b483eb357610241e9d800b
Author: Paolo Abeni <pabeni@redhat.com>
mptcp: remove CB offset field

This replaces the SKB CB offset field with a new msk-level copied_seq field
to track the bytes already consumed. It also introduces explicit synchroniz=
ation
for the TFO SKB in the receive queue using the MPTCP_SYNC_SEQ flag.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -464,6 +460,9 @@ static bool __mptcp_move_skb(struct sock *sk, struct =
sk_buff *skb)
> =20
>  	mptcp_borrow_fwdmem(sk, skb);
> =20
> +	if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
> +		msk->copied_seq +=3D mptcp_iasn(msk);
> +

[Severity: High]
Can this lockless reader observe the MPTCP_SYNC_SEQ flag as set but still r=
ead
a stale msk->ack_seq (via mptcp_iasn())?

If a Fast Open connection receives the remote key in BH context while a user
thread concurrently processes the backlog here, a missing memory barrier on=
 the
writer side might cause mptcp_iasn() to calculate using a stale sequence
number.=20

Could this corrupt copied_seq and lead to incorrect offset calculations for
subsequent packets?

>  	/* Be sure to sync the eventual fastopen dummy mapping before any other
>  	 * skb lands into the msk.
>  	 */
[ ... ]
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
[ ... ]
> @@ -497,10 +497,13 @@ static void subflow_set_remote_key(struct mptcp_soc=
k *msk,
>  	WRITE_ONCE(msk->can_ack, true);
>  	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
> =20
> -	if (!sock_owned_by_user(sk))
> +	if (!sock_owned_by_user(sk)) {
> +		/* User space could have already read partially the TFO skb */
> +		msk->copied_seq +=3D subflow->iasn;
>  		__mptcp_sync_rcv_sequence(sk);
> -	else
> +	} else {
>  		set_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
> +	}
>  }

[Severity: High]
Could the lack of a memory barrier here cause a data race on weakly-ordered
architectures?

The writer updates msk->ack_seq earlier in the function and then sets
MPTCP_SYNC_SEQ using set_bit(), which does not imply a memory barrier.=20

Is it possible for the CPU to reorder these writes, making the flag visible=
 to
__mptcp_move_skb() before the new sequence number is committed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787368526.gi=
t.tanggeliang@kylinos.cn?part=3D3

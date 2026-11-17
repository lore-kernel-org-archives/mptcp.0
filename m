Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953356;
	b=caW8NJPSVb2N+sIvLt44sCyDwgIs5n1mExb6AUJy7CY2cCQSfxAn33pJR2BGGa8W595W
	 GZr+938TPaTVTujtZqeeCaqw2mOmG0w9q/MCdzEcczhIqtQH1QCTtLB1FTM05wicz8IoQ
	 Wa7/1badrI9mr5kq033D+bGT4Z4MmEcsWdeQSNjXeIf/+nGdVYdnazc799Q0mKS2nnxTN
	 yZD/aWBdskCX0QHdIBc/dQt0vX0gwEmojrOKcYtGdg/7xCCy226JA9lvtX2KjEFKjmQQh
	 m1KgY/QAborhip8LqoenfdYKsxJMAM1sZLqVUzAKd7sZ8SG1z+OmHhh3C16REdyHWUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953356;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pKLuTmzMeNylbG3UeR8YAXTqvTpZkhUCV2zQzQADyqc=;
	b=rcuExBlB+2VQel8WgK1MJ9sfrosUEpFsLDvdZwvWNss5dYfEYwffYNYpqyTVpJtakOaw
	 U69KApfTtA99zVHAeSLdcmsbd+znJx8kzIb8yeecRiHeeKM5bJ7m5ZWuPLkzhu0cJ+EgL
	 mACYbAY8eOatbiW+dFX1eFpebUZLhJXULDQaD47oK2IHQaXVCEsyc36i6khxJgm6RLvYx
	 XJEgNS24EvVvfl6XTKDU+fxX1XUAnjPhDSev9HUH8GO+yQ7MVdVk1lZ1cuofrqar6j5Ov
	 WkOyfGinApGdTFvEqZ4NZK7vZVaB+Cg7jlDxIqR+sgR9jcTbl0cTwDFV3nUXlPro37g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9IGlnmh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC640606A32A
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9IGlnmh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F751F000C5;
	Tue, 17 Nov 2026 22:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953356;
	bh=pKLuTmzMeNylbG3UeR8YAXTqvTpZkhUCV2zQzQADyqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N9IGlnmhNcCru/hhGDlaNO/MNrMwV9g1eo7aFm7rXmiUwVHlDQW/vZxjHB0/RKEdf
	 dvkzZgYyzVc4F2cu3TUT3lpbEcGdX0JUpkE74RtDFTYcLWFLwT5kFWf9A2k+8NmLAO
	 DhwBVMTeJ0jGtz6HVpscQIK8L2dkQ4FLnAJEwBuw27hco0dzLiZdu70COqaVTazz4B
	 OYhGhExixy27NZrQR6ntUq1+GmGui7+7I7FGI3LxWoI6h/heJGRgUcDkzo2uhu0ANo
	 Pl6axlJ5i3yk0HLlzcEwZ/iR5Lx9h6lvdOlUKf6VmBCfLuFKvdcNArlgI+j96VjgtB
	 cYwo2P9l0Hs+w==
Message-ID: <sashiko-outbox-219731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 5/7] mptcp: push queued data on subflows falling
 back at the handshake
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-5-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
 <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-5-bf7656de653e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 22:09:16 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] mptcp: incomplete fallback cleanup in
  check_fully_established()
- [Medium] mptcp: spurious data push on incoming TCP RST in
  check_fully_established()
--

commit c7b2d96469f365f0990144845b235e48664597ea
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: push queued data on subflows falling back at the handshake

This commit pushes pending MPTCP data in check_fully_established() when a
subflow falls back to TCP because the first packet after the handshake
carries no MP_CAPABLE option.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index bcf3440d1901b..617358ff7f990 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1035,6 +1035,10 @@ static bool check_fully_established(struct mptcp_s=
ock *msk, struct sock *ssk,
>  			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
>  			goto reset;
>  		}
> +		/* this ACK will not reach the fallback path: push from here */
> +		mptcp_data_lock(sk);
> +		__mptcp_check_push(sk, ssk);
> +		mptcp_data_unlock(sk);
>  		return false;
>  	}

[Severity: Medium]
Does returning false here after only calling __mptcp_check_push() leave
sent and newly pushed dfrags stranded in msk->rtx_queue?

When check_fully_established() returns false, mptcp_incoming_options()
returns immediately without running the rest of its fallback path:

net/mptcp/options.c:mptcp_incoming_options() {
	...
	if (__mptcp_check_fallback(msk)) {
		mptcp_data_lock(subflow->conn);
		if (sk_stream_memory_free(sk))
			__mptcp_check_push(subflow->conn, sk);

		/* on fallback we just need to ignore the msk-level snd_una, as
		 * this is really plain TCP
		 */
		__mptcp_snd_una_update(msk, READ_ONCE(msk->snd_nxt));

		__mptcp_data_acked(subflow->conn);
		mptcp_data_unlock(subflow->conn);
		return !mptcp_over_limit(subflow->conn, sk, skb);
	}
	...
	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
		return sk->sk_state !=3D TCP_CLOSE;
}

Because __mptcp_snd_una_update() and __mptcp_data_acked() are skipped,
msk->snd_una is not advanced to msk->snd_nxt and dfrags in msk->rtx_queue
are not cleaned up or uncharged from sk->sk_wmem_queued until a later
packet arrives.  If a sender fills sk->sk_sndbuf within the SYN+ACK window
and the peer's pure ACK without MPTCP options acknowledges all in-flight
TCP data while waiting for more payload, ssk's write queue empties while
sk->sk_wmem_queued on msk stays full and writers blocked in
sk_stream_wait_memory() or poll(POLLOUT) stall indefinitely.  Also, if the
packet triggering fallback carries payload, mptcp_over_limit() is
bypassed.

[Severity: Medium]
Can this push queued data onto ssk in response to an incoming TCP RST?

When an in-sequence TCP RST arrives before the subflow is fully
established, tcp_validate_incoming() -> tcp_reset() calls
mptcp_incoming_options() while ssk->sk_state is still TCP_ESTABLISHED,
before tcp_done_with_error() closes the subflow.  Because a RST carries no
MP_CAPABLE option, check_fully_established() falls back and calls
__mptcp_check_push(), transmitting queued data from msk->rtx_queue on the
subflow right before it is reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-net-mptcp-=
misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org?part=3D5

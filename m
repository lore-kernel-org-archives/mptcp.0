Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953356;
	b=XfFKrAS9teBUmxIWCL7i5/DI/wOFKWZR24Oi3ybelw89n6639ylSJH3DlNl+/hRtoyse
	 Ah6UfGTPs4NciKI2Ricv8p1/8AT7cnZUIudt+UzvJx0FMidptSQfXhp8faWnBTAeblznv
	 xhhjzUzlqb451SZL6+6Q98S2SFJvOnLZ/dBUPl339DvYiJVCBF0rTecf4v7KVDREGw3Ur
	 pcryyPjT321NXdVJvPLA3m5x44ZNnXYamlcFmaqTDqYacvvOH80+dw5MsUxc6GN08pyxK
	 txRXChjGjQD33cHUvh4Euxxco6GO782ccjXnGKeXzc3FtT7ytTkx8ASyfnHIZehTq5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953356;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fHpECUcY2uQeSd70gmVnY3dL4QlV54T3kOUg08WEhRI=;
	b=ozXaaj+GBTQfZuY6GPQaE9LILFe5psPTmv+2a7kCIXsM5Ka4qMSbIyalS5skh2XX7rbY
	 /05vfqXs+mobg650CntaCCI6sjVnZlkgtLORpNRtxkLS0uktq+UjN/nSJdDCsMg/NFjx6
	 gsOkSxC1s0w0DLR2IhgPeNDoX82PS1J6p+lBbQ9YKZADDDJnt6/2VwmrpSFJSQKGFfnIm
	 y4n7J2C9ebvLZHYA8F3TIsXKeMAM8uCPEckmqLdRS187cyLOPfTG8uJpzFPtcHOHQT60C
	 JvaUaAxVigvOwDV3NDvFzH7CH3cFAmkjIfJKPykF7DviLdpWv/w2ceNBnB5LH4m4OQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbAsQMDJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDE8606A32A
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbAsQMDJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24F31F000C5;
	Tue, 17 Nov 2026 22:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953356;
	bh=fHpECUcY2uQeSd70gmVnY3dL4QlV54T3kOUg08WEhRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kbAsQMDJBh4MJqATEfRXATkVckt6SBo14gXuQjMfAJT/Vsi5Ij9TOjmcI7Xt1MYyT
	 QzL9cU6a57GHk1dg7vHukYzGO4SoGhQH7IG6NCdMfwA5cA0DY4cGvSC8C7px0wLoVc
	 lVxfq/ecXSB9fVf/tyA2PBDxigAW55rF1CeHOmWrTB9R6xBxCCHqE2WMLqZrCzWoR4
	 Q/pMOjHWj3bVMcNXOlGDmhYYDFgSn1tVYBK4p/eEjQ9JzKXvFqoTlYpbynKaJ7xbA4
	 vzfxatmBit39FWDAtkztmp/wefPI4HIUFxlC7rOy0+VSOcqx4w9fRAaRXkccABNqoa
	 nOvyxWmiDqETw==
Message-ID: <sashiko-outbox-219728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/7] mptcp: push pending data after a sendmsg copy
 fault
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-2-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
 <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-2-bf7656de653e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 22:09:15 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mptcp: Fixes trailer in commit message cites 69800e516e96
  instead of d9ca1de8c0cd
--

commit 54f71c9aefbcf7d32b7ddbd0cfb6524d738c4d31
Author: Quanye Yang <quanyeyang@proton.me>

> mptcp: push pending data after a sendmsg copy fault
>
> mptcp_sendmsg() copies into the msk write queue first, then
> __mptcp_push_pending() on the success path. tcp_sendmsg_locked()
> does the opposite: its do_error path jumps to out, and out
> calls tcp_push() when copied > 0.
>
> A later iovec fault (copy_from_iter / -EFAULT) after a successful
> iteration therefore returns the partial byte count but leaves the
> already-queued dfrag on rtx_queue. No subflow packet is sent, no
> retransmission timer is armed, and DATA_FIN stays blocked on
> first_pending.
>
> Push in do_error when copied is already non-zero. Do not move
> the push to out: copied is a size_t, and sk_stream_error()
> stores a negative errno there.
>
> The issue was spot by Sashiko, but easy to reproduce with Packetdrill:
>
>   writev(4, [{..., 32728}, {NULL, 4096}], 2) =3D 32728
>
> Fixes: 69800e516e96 ("mptcp: propagate fastclose error")
> Cc: stable@vger.kernel.org
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/640
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

[Severity: Low]
Should the Fixes: tag point to d9ca1de8c0cd ("mptcp: move page frag
allocation in mptcp_sendmsg()") instead?

Before 69800e516e96 ("mptcp: propagate fastclose error"), a copy_page_from_=
iter()
failure in mptcp_sendmsg() already jumped directly to out:, bypassing
__mptcp_push_pending() and returning the partial byte count when copied > 0.
Commit d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendmsg()")
introduced the loop that queues data into msk->rtx_queue first and pushes
only after the loop, while jumping past mptcp_push_pending() to out: on a
copy fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-net-mptcp-=
misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org?part=3D2

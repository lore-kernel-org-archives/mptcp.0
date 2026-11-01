Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561949;
	b=GrcG2jXQmJX3BrHvcANzPKCbYFdQNL4oCsjN+iphGaoFWEWwborsqAAj6OHI5QWlJwpe
	 gOKYBRcM8zsuU/D4lfHy43bZDMOKY4dm/SUi0CI8Hy1Dk+lF3ocXQohmmGEYx0krvP/YP
	 +fo7tyON7hssLfZs9ukAPy0E3+MQKU6Q1Xm4cE8Het+VHp8z3K+86F0R5cwspzjFg2dLB
	 ezBlQTvQP17nLJLZ/GdkD8Z+oRCvUxQEm1g9V/xBJQlg7yJxN/n9RiuhLdWs1GbIQq8Tj
	 W6ZjLzMsJ1JphTYJt43H4uEBUraxTLJuFGlmIX72wYzH+kgD3xJi6Z1JThUFcKjQjXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561949;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=i7u2q9xABEbuGevGg50ejgZjSkxMHnughNz6RLshO9k=;
	b=plUBQloei65ruK+2YE/I8hI+pzvWDKZRe3uioHqoQ+AIh9UQPV1cvI41ux/SzAv8M9Lb
	 5GiBrH+duqMz3N/nerTvczx5WPOY/iOKU32K1QAGyShYe+QYk68yoHArE6Ck1hRGsx0Fo
	 ibDdF0UBBHTjnb0kvbsOtZAMoi50OJETjXOQDRvwrClkESou+7GOjLKoTkHatcwBu0Qau
	 GUFWoKZVNDA2zA/O3dMtLLeHCnztX8ecgXFIveT4zKODAZZyFlgWc8lb2+ACLgTgK5IP0
	 JWDUnae8NGQPq4cD7AELsRl1MYCDI/Pis0vo8+yQsMKRp2pQ1kfrPNSU+MNrnE0Lvsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNIMmFMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212C606A324;
	Sun,  1 Nov 2026 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNIMmFMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B141F000C1;
	Sun,  1 Nov 2026 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561948;
	bh=i7u2q9xABEbuGevGg50ejgZjSkxMHnughNz6RLshO9k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WNIMmFMhgDTcI3xilNudvcmzn1RjYkKPCuyVRxaEZ/mXuFYfUPjE+WAtv5B9bUi32
	 A1N89/VnWAYiSQc38gL6DUAQ3bzo/1IlWpyZuc2XxZe3eflKHyWhyDWh8fe2csqs7w
	 HjtuSF9DYJMC30ypAkYmAvBNDCO5ffvFtUH01SufuiXrHqSZf+JU1Cd7S9Hr4pgENA
	 wiwtA81VJdIx6EZEVPLuFbX8DXTQPi0l83FjQeNGkrU4g93Fwkd09NR56uZqv7lTNN
	 St99v/2BDwjdQF9Wk74u8oy3tMhrmd2AQOzv7NXRhWky0t/kppeOy2f8qWYXpx1ViW
	 xx9cCBunDolqA==
Content-Type: multipart/mixed; boundary="===============6320018426206090260=="
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <ece4075cdd214d2797932e4bfd1235d27561ecda973c6935262e18c4a697c278@mail.kernel.org>
In-Reply-To: <20261101192057.2296489-5-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,matttbe@kernel.org,mptcp@lists.linux.dev,mason@kernel.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 19:39:07 +0000 (UTC)

--===============6320018426206090260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Subtract all dropped bytes from the return value

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit; the
freed/subtracted byte mismatch seems to date from ca70b8baf2bd, not
4f738adba30a.

> bpf, sockmap: Subtract all dropped bytes from the return value
>
> When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
> message. It then subtracts tosend bytes from *copied, the return value of
> sendmsg(). But tosend is the number of bytes that the verdict applies to.
> After bpf_msg_apply_bytes() tosend can be less than the message size. Then
> sendmsg() reports dropped bytes as sent.
>
> Subtract the number of bytes that sk_msg_free() frees. After an error the
> SK_PASS branch already does this. The SK_REDIRECT branch does the same if
> the message is not the cork. Nothing changes when tosend is equal to the
> message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Is the Fixes: tag pointing at the right commit?

In 4f738adba30a (kernel/bpf/sockmap.c, bpf_exec_tx_verdict()), the
__SK_DROP case freed only 'send' bytes with free_bytes_sg(sk, send, m) and
subtracted 'send' from *copied, so the freed and subtracted byte counts
matched.

The same held after the move to net/ipv4/tcp_bpf.c in 604326b41a6f, where
the case did sk_msg_free_partial(sk, msg, tosend) and then
*copied -= tosend (later tosend + delta).

The mismatch appears with ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge
logic in tcp_bpf_sendmsg"), which replaced sk_msg_free_partial(sk, msg,
tosend) with sk_msg_free(sk, msg) in the __SK_DROP case while leaving
'*copied -= (tosend + delta)' untouched.  That is the point where the whole
message is freed but only tosend (possibly reduced by apply_bytes) is
subtracted from the sendmsg() return value.

ca70b8baf2bd is an upstream commit from October 2024 (v6.12) that predates
this series.  Should the tag be:

  Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41341848185
--===============6320018426206090260==--

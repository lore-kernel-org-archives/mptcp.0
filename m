Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675120;
	b=tXyMELdxW8NlEdztjfdbhe4u7qC4vQQsfSgtgRKMtRdKNc3YtgKhOHWbrvAop3HvxWIz
	 HycKI/hZZXTagbtliwHsVbLdSk/8LAEn1D/O7loCiYrdr0rVubvqYtF8f/+DQIhROmErx
	 9azqnHPEO1WVOF6pt+xQlquYg5SfZtjscHux0qvGiO3ELKCtPLCw8PK3GBTYRCusiGK1r
	 CneTvxSnlEHuwUIW42Co+PLKWhiXCRePUREtCvptruMPcnCr8d1kFgE5ij6anehzM7rha
	 CX9BTcEhT/cKkGqV+LR1q8GRPqgsAkAgYenrQrYRP322knZNFZnQkcZk+wbAmMzvYyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675120;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZYjnh0mPnqJPwghCSs2kYNZYtk47oZpigd1q1saV6v4=;
	b=xuPho75m+2CDvp6TpaNfH5bwQFVuTw8gebmqt7xWR/cHkI9lytuRt47SppeG0ekVIsQh
	 gf8M90XKemMPEYJ9owTGUx2R/j2ujv9gE786dXDTSF9m6bhLAyioyVFb4PpPl4qOu0cW8
	 38aVp7GTNbw9BwrwWBb78ajP+hHXGtR3wysEzWDnBX0V1xnZ1JdhJPBHf4fFlWWX3p7fa
	 oMzF+Nt1FMXrQAWqMnH3fvhQ/uPeu57VwZzKHPnwZhURjP8e/1E2x8mWdXS2vewDkQIwI
	 FpZCCE0pGTxS5vdBAdZbOTWYh+8jqgWsFaXzjo0j+U+9C0+rTDt4omRcnidN4vXDtQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZ0slr0o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986B606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZ0slr0o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3271F000C1;
	Thu, 22 Oct 2026 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792675119;
	bh=ZYjnh0mPnqJPwghCSs2kYNZYtk47oZpigd1q1saV6v4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=jZ0slr0oHTj0BuE1DCSU+kPiUCgJ3e1NfzuLnetPyKFpzQWtXad2s7rkzBIGQiIJp
	 K24cTN7i/Ik4uN+vYoS0gmdlKPLWFoBU1MAZVs4MZe4z+V6/moV4N4PXVpNVaoVwAX
	 qTKPbWEyO8WakOYkJNYFv1oon/Fmk+JyoeF/Q1seNLztGUuFBem66u212MSFkiXx33
	 thpB/NaY7oAzDw5FhxTmpspEJi2XWtVOxLXNm2rwPC4hvIh3ppJjgHU8a9ZXY61noX
	 H5BDoiBmlCZIp5KL5H0l/hhismvhG0aCOUZ3ckHkYeLZRdKjam1JYyYfn0j9ITmsBh
	 VzqTEUSx3f9Iw==
Message-ID: <8a1d2674-86d9-4eb7-99b6-521810a313a7@kernel.org>
Date: Thu, 22 Oct 2026 15:18:37 +0200
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: push pending data after a sendmsg copy
 fault
Content-Language: fr
To: quanyeyang@proton.me, MPTCP Linux <mptcp@lists.linux.dev>
References: <20261017-fix-mptcp-issue-640-v1-1-50a7bace7d43@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261017-fix-mptcp-issue-640-v1-1-50a7bace7d43@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

On 17/10/2026 14:46, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
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

Thank you for the fix and for the test, it looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I just added that it was spot by AI, but easy to reproduce with
Packetdrill (to justify why we want it to -net):

New patches for t/upstream-net and t/upstream:
- f94544594473: mptcp: push pending data after a sendmsg copy fault
- Results: 8d14bfc65f4a..b13e2e43af96 (export-net)
- Results: c2dd59af75f8..9257a00903b8 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/501231f7acb612561523f4e194cf01c77938bdad/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/f2f79e9af965c1c49decfe56312fa547095fbbee/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669293;
	b=v1YsjEvxSDmL6WxPPn2TMNBo5UQ202OLcbGBd7CJS804iklTmv7SrphqKWLJs1zu5UFb
	 mWseX6/qdVp2yqnUFAkTEPmhz9se55Kpwe78bA0bP8WYZzJjMTPdSdzMlrTptolkfEKwG
	 6htuX2NTbpKVMcy0dGd2GcwhBUqorYvlg1QvdaQhAfOIbfMO1Fzee5IxQ4bxwVpILmTsR
	 u9PwhwD0pgZQnyY5TE7TLhTOk2FXJdZ05k8pi5CqjRXwUwNo4+9xrbGvneWSR6ta1Wv99
	 gyyFAfxLTZErG1UeSJA+e0pLHYxCjUsbFP2vzUsT3UgvRdfTG3XHKik4W+JNGhyCTTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669293;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=weTRpf87XHCKVmKeuRnXUiUaRUVcjXRZxpafjWmzXng=;
	b=NB92fhgndkPmWCglkyzayHLK9U5TGVaDTEogBTiEIlLMaK1cXyxtF5Yx8pjIGgkTH0j2
	 1Ux6yl54dUMln+fuA7iz4aqBXPRn2hnvlDE51o7J2UTpCl/ym2hrxRfdTIaxV36FY+4FX
	 yg9TPq+sCtfCPfXh15p9NsVP7n+dZZyq3Cr44zQcf+n42MmRO+mPWVsxeQLqcdPcc8UtT
	 HpwfVSJyIE1F9Chbg0PPckswacn2xxY6KOpDW2IUpAQLDyrvqs8umvH8+wAhmPl5gskpu
	 saKMxLOGFDYYuMpnCOh0kggvOtlcZT4tSY21Cw9OeUVN5LsglSk3RUwGe3czV8RwEhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXQtWDU+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDF606A31D
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXQtWDU+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451B41F000C1;
	Thu, 22 Oct 2026 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792669292;
	bh=weTRpf87XHCKVmKeuRnXUiUaRUVcjXRZxpafjWmzXng=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=lXQtWDU+RJqqFZwezblhoEDirUMomSUv6EVus9/7a7xUslRk/PXGk/VIzYVQZ6C0K
	 5FoupPLMe0kPAWJwr8g4T7kdL0fG1iGl8jUdacyiDLyPg9+S/Xpst7bmWPEvfYarYr
	 HBeVtS5wSUyg+QzHlmw/5MOmv2mW//lPVhd3Ux0A061bA3r/k4H9FzbRQG6W2fM8cT
	 FdZctXQbkCW/XeG1cyioDQ4olyHd3Q4k1QwVc105/Pwl2l9BnDlJoARwX4pK3/9CzE
	 db2m9ZAUdsxyQe4nU80QIzll3z7Nkg07VcdVMUjrs8lLiwH7aTaBde5m32oUx+CPBC
	 uCbM08HCDtnKg==
Message-ID: <ab542a7f-ab5e-45a0-a16d-3dc851fdf2e9@kernel.org>
Date: Thu, 22 Oct 2026 13:41:30 +0200
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
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: drop unreachable FIN
 accounting
Content-Language: fr
To: quanyeyang@proton.me, MPTCP Linux <mptcp@lists.linux.dev>
References: <20261017-fix-mptcp-issue-637-v1-1-cda9bf1c79de@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261017-fix-mptcp-issue-637-v1-1-cda9bf1c79de@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

On 17/10/2026 10:53, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> connect_one_server() sets eof when read() returns 0, then immediately
> checks total != len. The receive loop only observes EOF while total is
> still below len, so that check always fires and xerror() terminates the
> process. The later if (eof) block that increments total for DATA_FIN is
> therefore unreachable.
> 
> The client also does not wait for the peer to close: process_one_client()
> blocks on hangup first, so a peer DATA_FIN cannot arrive before this
> assertion. DATA_FIN sequence advancement is already checked on the server
> after EOF. Treat an early EOF as a hard error and drop the dead
> adjustment.

Thank you for the patch!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I also just applied it in our tree, but for -next, and added this paragraph:

This issue has been reported by Sashiko and not seen in CI environments.
Yet, it could be visible, especially when the test is launched manually.

New patches for t/upstream:
- 5531a8151ac8: selftests: mptcp: sockopt: drop unreachable FIN accounting
- Results: 15904a7a5590..c2dd59af75f8 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/08e13d22410569c3de4f17c5568d2b19d29eb4be/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


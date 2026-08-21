Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C0407575
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290677; cv=none; b=oRou2rwicbWDE/lToHbtiadX4qcPeOo7CWLOl0MAmq5Du9MlZ4nJE/RG3amC0j/mawV8JmXaQwxb31cw/I7xurwg29aPNVaUlrPfGxy5KbEdOyIHlU6XEBFb2WzG6SC8Vg9NvL9LoMHY0k1Gt+p028Edrk2tf04dIhB1CHYlTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290677; c=relaxed/simple;
	bh=76dtI21STRlUrMqEOEqFb7M7OdF0MpxUAhj2Vp8I3Ic=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVHmGWhG39NCJvNVzuOD5zktEJBcDRG51yjVQMsJ5WCkAWm/u51DS7IJaw+mmdqV6Ez60EWGzVKOlpZpEcNaIVdp3z9lHupM7pix907eNCKbpAxL/9L8LbvyTFESLQf2wuFBDqwig+QuPWdlyDyhVtiKLm3/O4Qe/pTArI1t90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Dp/4fN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Dp/4fN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD801F000E9;
	Fri, 21 Aug 2026 05:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787290675;
	bh=dSpuQkl+/savX/9qo/t3sLeYW8UtJTpAxROfnGGLAy8=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=k7Dp/4fNc3olLF46bkK1qs5E+2MVoiz7+4oy5vceOBgelRoKYrFpF5zieSCcozZ5H
	 2xWLQoB+cNZrHnaujANPliEDqYiCpzG2eQYzI1E4vGV4+AGtnsTRftsuwfYH6gM8wB
	 qwdEeI1RTPwIYr4X5XMvyp4ubVp/inzN8QvI0Z9tt9xmacLczCZ9vvNNhW2y3JW/Tu
	 SKJ8b/OAdFOfLLio/2S1azuWuFZC4fCx/XDl9Tb/oEIH6n7Pqe1r49cbVfi4iK0cCJ
	 ciUH1DIomq+udiIkJ0GrNoiol7d279oW0YRNivC7jF1v2sz+H2En80QFlLYnLAnmkG
	 rwfZTosU4W+1Q==
Message-ID: <0234c8e501a033d22733138b77ce19270fed7401.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: avoid uninitialised read with MPJ
 with SYN cookies
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 21 Aug 2026 13:37:51 +0800
In-Reply-To: <e9ea4afd-f549-1fa5-3eac-910b12ad7e4d@gmail.com>
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
	 <e9ea4afd-f549-1fa5-3eac-910b12ad7e4d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2026-08-18 at 19:20 +0000, MPTCP CI wrote:
> Hi Matthieu,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (except selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (only selftest_mptcp_join): Unstable: 1
> failed test(s): selftest_mptcp_join ⚠️ 
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Success! ✅

This series looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

nit: You could squash patch 2 into patch 3 if you want, but totally up
to you.

Thanks,
-Geliang

> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/32171215149
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/4172949dd486
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1148008
> 
> 
> If there are some issues, you can reproduce them using the same
> environment as
> the one used by the CI thanks to a docker image, e.g.:
> 
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm
> -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
> 
> For more details:
> 
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Please note that despite all the efforts that have been already done
> to have a
> stable tests suite when executed on a public CI like here, it is
> possible some
> reported issues are not due to your modifications. Still, do not
> hesitate to
> help us improve that ;-)
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)

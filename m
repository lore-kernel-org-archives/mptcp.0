Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902806F2F2
	for <mptcp@lists.linux.dev>; Mon,  3 Jun 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429918; cv=none; b=YzE2ZfdqgcgkUzBj+oyi6jkK3EDALJbVets9genERf1ErJeDoVEX80oyLXnBnO4DY0IaXcVU00dK5rV8LhDDShQk0bNrk2tQuW7jt2OKv3vQU0sqy0vUTJsde1nc48dBlP+wRwMHtYktR3PxdBkOPgCkL09I9MWf3OUhAfukVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429918; c=relaxed/simple;
	bh=smMG305t3dXLIw9LtN2/x7BwjaXLSL61RCVpOn3RMaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkfjlJrQrUnok1kGUsRDb3ACIHM161CaSPBf2kqm0sa9WB2e8PD/Mc4GOne8C4Q+D4TVgOfL1DwqjbkDQMAvoN1O70ZXWyOpCTEY5RRvdv6NdQ/Xki43KAz5zzFsxpkzNB3t8ZGfWkUtaqAcEU843BxiNJKryRwkiQW26qxSzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA+8xbPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA+8xbPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB50C2BD10;
	Mon,  3 Jun 2024 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717429918;
	bh=smMG305t3dXLIw9LtN2/x7BwjaXLSL61RCVpOn3RMaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HA+8xbPP0tB7f92cbhFBsD3HbnTdfPz4rXV4Q1I0fiZ4+CZ27kZKCNtFg2tZ51kxX
	 ul0BNI6vvgxp5Z0YBJkHuF99e/kldeajjLFN0buK1IzVx8pn1edzCS6JAQM0/SoIZE
	 L/foSP0JqjNXdSlYKIGYg8fsd8bm2MUHkMW501OoDBooIY6Fd/2WxQjf+HPIuH7/xW
	 cD8adw+tXteiPSKeq9epiakXQPXYR8UbQUfyu8H3dG6NU2uyEW7J16DImw6aKoH1/j
	 eLfO7eRr2tnte0tZti1aA8VHiBDSDC2HL9AQgKNO0hzb4vj9Crqvql1SyIKeQ2wldC
	 AzkzhUfn20YoQ==
Message-ID: <f82edec4-2259-486e-adfe-db3c26a3b0a2@kernel.org>
Date: Mon, 3 Jun 2024 17:51:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2] mptcp: increment RmAddr MIB counter once
 per RM_ADDR
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: YonglongLi <liyonglong@chinatelecom.cn>
References: <20240527-mptcp-rmaddr-counter-once-v2-1-3e61360a90ac@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240527-mptcp-rmaddr-counter-once-v2-1-3e61360a90ac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 27/05/2024 18:03, Matthieu Baerts (NGI0) wrote:
> From: YonglongLi <liyonglong@chinatelecom.cn>
> 
> The RmAddr MIB counter is supposed to be incremented once when a valid
> RM_ADDR has been received. Before this patch, it could have been
> incremented as many times as the number of subflows connected to the
> linked address ID, so it could have been 0, 1 or more than 1.
> 
> The "RmSubflow" is incremented after a local operation. In this case,
> it is normal to tied it with the number of subflows that have been
> actually removed.
> 
> The "remove invalid addresses" MP Join subtest has been modified to
> validate this case. A broadcast IP address is now used instead: the
> client will not be able to create a subflow to this address. The
> consequence is that when receiving the RM_ADDR with the ID attached to
> this broadcast IP address, no subflow linked to this ID will be found.

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 9c592aa6f604: mptcp: increment RmAddr MIB counter once per RM_ADDR
- Results: bbdf7fd48eef..e85c0954b4e4 (export-net)
- Results: 05497250894c..5e8a75a149b7 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/0cd8eb1e3be7cc7691835ad2b30d34a122253081/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/37ac616090e02d163a41ceefbc28d3ff41afe470/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2BF2E7BA5
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792107; cv=none; b=XuFINZAzQc9SgK88KRtGGbmdwSSLizHBlJWGekiKbbUg5E0edkSgDn7z84UKPtg74I9rSAjVBYGE5ts4vLlErw/yWwn6hWTX8b9D7NohwHKrhRf8P9+S8pm7GuF9d3EW77+xgWPVjpzl7gFt1IuKktV0KMfDsLsbyJ+Wd4LrZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792107; c=relaxed/simple;
	bh=ata6fW8ad5HqN2jJ2S2HCnsi9vGNK65SKNbkV5MMkHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OEPNU5w6VeRU3OBrqNgXDkZgcdyBrahhlNLvWFfTFOL2mBTR+zxLTCKpWWrKExTb6o5b1/XBHEz20WQeputgczv83KFwW2INObQOpSMxyg8XuSWnSs/2bipZxPqxMB0qrWyeuD3fMRZCRErlZrt8uNjGoEt2PGDHuW3VkrG44fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4olDsOc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4olDsOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6594C4CEF0
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792107;
	bh=ata6fW8ad5HqN2jJ2S2HCnsi9vGNK65SKNbkV5MMkHY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=a4olDsOcYI9hHYB9zqaGqxBFl8LaK5FAvYy4puWGnLsjoXGPthdAh1cmkloTT3zUg
	 X4tGuWSW2mFaGaB9QAs6zujpjtaSxpCCIirSLKqHHfv1sWH4vMMeXJm8CkG8/Uyrj6
	 1iZ1fcWNQxpQtr5HTC2rCtQR3RtC0OC0cDZta9DVztemjXdLWlKurVg17iYdovVEru
	 MRAhz8KH+GRHodrMuHHToz/bPIuj/nMzApVL4LTa6xSose3DJrb/vLjazbsySKIxWp
	 EODueUJetZvptoh6I3iSsq90WFHtRyKyB66vzPkaYBe85DNRCDL0dWSQYUi5k9ZAMI
	 P5I74USkxiJig==
Message-ID: <be083b3d-1173-476e-bc50-4fde29650998@kernel.org>
Date: Thu, 25 Sep 2025 10:21:44 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 0/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Content-Language: en-GB, fr-BE
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 25/09/2025 09:54, Matthieu Baerts (NGI0) wrote:
> Currently, upon the reception of an ADD_ADDR (and when the fullmesh flag
> is not used), the in-kernel PM will create new subflows using the local
> address the routing configuration will pick.
> 
> It would be easier to pick local addresses from a selected list of
> endpoints, and use it only once, than relying on routing rules.
> 
> Use case: both the client (C) and the server (S) have two addresses (a
> and b). The client establishes the connection between C(a) and S(a).
> Once established, the server announces its additional address S(b). Once
> received, the client connects to it using its second address C(b).
> Compared to a situation without the 'address' endpoint for C(b), the
> client didn't use this address C(b) to establish a subflow to the
> server's primary address S(a). So at the end, we have:
> 
>    C        S
>   C(a) --- S(a)
>   C(b) --- S(b)
> 
> In case of a 3rd address on each side (C(c) and S(c)), upon the
> reception of an ADD_ADDR with S(c), the client should not pick C(b)
> because it has already been used. C(c) should then be used.
> 
> Note that this situation is currently possible if C doesn't add any
> endpoint, but configure the routing in order to pick C(b) for the route
> to S(b), and pick C(c) for the route to S(c). That doesn't sound very
> practical because it means knowing in advance the IP addresses that
> will be used and announced by the server.
> 
> Patches 1 & 2: some clean-ups and refactoring.
> 
> Patch 3: "standardisation" and small perf improvement.
> 
> Patch 4: squash to patches for a commit queued for net-next.
> 
> Patch 5: new 'address' endpoints.
> 
> Patch 6: validation using selftests.

Now in our tree:

New patches for t/upstream:
- 4fe7e61755f9: "squashed" (with conflicts) in "mptcp: pm: in-kernel:
usable client side with C-flag"
- d375b4ca4ff1: conflict in
t/mptcp-pm-in-kernel-refactor-fill_local_addresses_vec
- 69fb168252bb: conflict in
t/mptcp-pm-in-kernel-rename-local_addr_list-to-endp_list
- Results: cc985c0839fa..37e786078698 (export)

New patches for t/upstream:
- 1cd0a903e63f: mptcp: pm: in-kernel: remove stale_loss_cnt
- 16b6562ab1bb: mptcp: pm: in-kernel: reduce pernet struct size
- c1b677272323: mptcp: pm: in-kernel: compare IDs instead of addresses
- 7cb258b504b6: mptcp: pm: in-kernel: add laminar endpoints
- cbbae49b8661: selftests: mptcp: join: validate new laminar endp
- Results: 37e786078698..8dfa18091410 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/eec459027a40629949db468c833b33ed7bd53477/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


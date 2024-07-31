Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610121CF93
	for <mptcp@lists.linux.dev>; Wed, 31 Jul 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417061; cv=none; b=Sxq5I7rNQK6i9khR84x8L66tZSbeaAEN6K8Ia55ijjX+BN20KpuksEae8qB9kF2f0x78/3v2X+NcHcD5o0/4DT45G9xjEV6w0mVq72wWxZcven8a6ypJQlb/COu+52qIZh0AeeSOMh8pUvoXUKKb9x+zWWLrVw7GXVrgCBjxWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417061; c=relaxed/simple;
	bh=wFyE10AIIFu3g7yp23LOi1XdCchb8UBMwkZLS11l2F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHCm5XXPUnpTyhJt5OOAuA3+ZK9JB2E/gN9LRolK9OZ0qGVg1BTzVx5N6kStNRzhtv0CxfVTQpuBD1PW4x5ckS0osFDfGEP03AIGxoeRwxiwVxWtVR6Rugvbte8nUMeyBVhfu9FuHkkm9mfKIj06FxRc4Zo96nfO5KFNf0BIzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHpmHjiD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHpmHjiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723CAC116B1;
	Wed, 31 Jul 2024 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722417061;
	bh=wFyE10AIIFu3g7yp23LOi1XdCchb8UBMwkZLS11l2F8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OHpmHjiDVaYo9lE0j4FiMwZlt7EZVQL9RqptVlr3SZAsIUzhAkK2AZOX8MiBYnd8Y
	 VP2j0j6fBe05x+Ez4dxm5fW17PxSwE5v3p3C8tuIMBlk+WIBh0KPnUETEHwwhXme+D
	 Tq3c2FBSbHwcycMBtYNDAles2npmON1K35FfLgLjJGhxRSRcDB5n8PLcTsgRHX9vzG
	 doM/Y2iRUhNdqmguVVAV55tqIAj8S2PVxH/90SJ4Y0TsjKPmhUd7HvWFuqTxHRWIx5
	 nG3aZRJj05XnrmI61ZQLMKxktnxR6rZWL23cYEnctPUeThJVgyEGd8FDgBjNwd1OME
	 4/iv/LqcKUTAg==
Message-ID: <6c0473f0-4ca8-4337-a6e4-101195cc25bd@kernel.org>
Date: Wed, 31 Jul 2024 11:10:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v5 00/13] mptcp: fix endpoints with 'signal' and
 'subflow' flags
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Geliang,

On 26/07/2024 16:28, Matthieu Baerts (NGI0) wrote:
> The first 11 patches have already been applied. Here are the remaining
> ones.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v5:
> - Split patch 1 (previously 12): the renaming has been done in a
>   dedicated patch at the end (patch patch 12), for -next.
> - Patch 10: fix typo and avoid memcpy.
> - Patch 11: fix comment.
> - Patch 13: fix build issue and use a new dedicated struct.
> - Please see the individual changelog for more details.
> - Link to v4: https://lore.kernel.org/r/20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org
Thank you for the reviews!

These patches are now in our tree (with the requested modification in
patch 9/13)

New patches for t/upstream-net and t/upstream:
- 4fdf3e16474d: mptcp: pm: re-using ID of unused flushed subflows
- f4dcf600f081: selftests: mptcp: join: test for flush/re-add endpoints
- 54cd819d5f1f: mptcp: pm: remove mptcp_pm_remove_subflow()
- 5be0e90ef7d3: mptcp: pm: only mark 'subflow' endp as available
- fdf749c7585a: mptcp: pm: only decrement add_addr_accepted for MPJ req
- 6eb489c794e8: mptcp: pm: check add_addr_accept_max before accepting
new ADD_ADDR
- 91dc97dedafa: mptcp: pm: only in-kernel cannot have entries with ID 0
- 3cc3d86a170e: mptcp: pm: fullmesh: select the right ID later
- 19c879bdde12: selftests: mptcp: join: validate fullmesh endp on 1st sf
- b84992e37697: mptcp: pm: avoid possible UaF when selecting endp
- ba96900cae7a: mptcp: pm: reuse ID 0 after delete and re-add
- Results: 36737d2814d6..6cd1e6d73592 (export-net)
- Results: dec783f2e72a..2f4228f46030 (export)

New patches for t/upstream:
- 1d3e4f41c9fc: mptcp: pm: rename helpers linked to 'flush'
- 54792ce59a08: mptcp: pm: reduce entries iterations on connect
- Results: 2f4228f46030..6197303cc231 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/af4eff14c4262c736783183997c94795ccff10d0/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/2ec038c21e3561ad3df17324253524d53d6ff97b/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


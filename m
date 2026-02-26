Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC956372B5F
	for <mptcp@lists.linux.dev>; Thu, 26 Feb 2026 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092165; cv=none; b=lbIs8vbsXzdfJU/28RXp6SfN3ANo7kCImyMKCmPFSYr504Yku/+LeV3xEHNivvcdutN8Gu2fF9GMQDJaLMpkLthwaO2zq/iC+TVcR9iHQB/yEnJm4XyTJ1PN7HXNLTxOcAhP8qDLUQIpNf5MZzOBJamgBz/bft5YzcKfZMn8zd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092165; c=relaxed/simple;
	bh=k/wxBtxaxuaxQLhJgOqCnzzZ90w2fs9LqE7GflJvgLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYY84lIYqEvNJ/rirSaEMhpCrD+AwylHPLmOzx1MrlbONOSBUouMIVo6brnh2XBOBBERlMfsNKioq5LW8zrSVvf4d8/gssyvUtV3xOzcD2Lef1iLjdb532Uc9+4vodYaLyKK/dMvbaIXElLT8DtwRifM07Gsfh5VzILx8SGWPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdXrnh3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdXrnh3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC92C19422;
	Thu, 26 Feb 2026 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772092165;
	bh=k/wxBtxaxuaxQLhJgOqCnzzZ90w2fs9LqE7GflJvgLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MdXrnh3QrT47DhMC3Kes3fATzYAcp+dDRkaqAWl5qC4UDnqd5onMRgzcj9T4opXJ+
	 K/vNoC0vqfXcGgSPP4IQXDUiqw0a20Mtw9zHtoAsplxzHtcMzHvQqqvPZloZE8j5R4
	 T2W2fTyxUYahJfSUZYJTUSmyiAI/6+UJYXyPMrrwJYeed41FfAvsFd5now1pqRvwtD
	 2wI0OWKNYM+rh3x/eHLKsIv3qickiS/onhtuZ3uP0RRBi50qU3YwTPicyt4P3KOsMi
	 QNZ1fsaVWGg6oSSqXWjAN8J2IKf51DwjlrYel2y5bGJ4CWpXou2vRtKBz0vtKH7AoC
	 dQSEpUZTLhDlg==
Message-ID: <1df224ba-93ab-49b0-a3ad-dd43084f5be9@kernel.org>
Date: Thu, 26 Feb 2026 08:49:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: check removing
 signal+subflow endp
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20260219101033.716403-2-matttbe@kernel.org>
 <e9828ca4-f91a-3f31-5ef6-6608012acf89@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e9828ca4-f91a-3f31-5ef6-6608012acf89@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 25/02/2026 18:51, Mat Martineau wrote:
> On Thu, 19 Feb 2026, Matthieu Baerts (NGI0) wrote:
> 
>> This validates the previous commit: endpoints with both the signal and
>> subflow flags should always be marked as used even if it was not
>> possible to create new subflows due to the MPTCP PM limits.
>>
>> For this test, an extra endpoint is created with both the signal and the
>> subflow flags, and limits are set not to create extra subflows. In this
>> case, an ADD_ADDR is sent, but no subflows are created. Still, the local
>> endpoint is marked as used, and no warning is fired when removing the
>> endpoint, after having sent a RM_ADDR.
>>
>> The 'Fixes' tag here below is the same as the one from the previous
>> commit: this patch here is not fixing anything wrong in the selftests,
>> but it validates the previous fix for an issue introduced by this commit
>> ID.
>>
>> Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal'
>> flag is also set")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Linked to "mptcp: pm: in-kernel: always mark signal+subflow endp as
>> used" sent earlier.
>>
>> Based-on: <20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 402de2bca118: mptcp: pm: in-kernel: always mark signal+subflow endp as
used
- e8f38bbd8b67: selftests: mptcp: join: check removing signal+subflow endp
- Results: 652750a9d6a6..eefe19f1a175 (export-net)
- Results: d3854ef490c9..c0858783271a (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/ca3a60dc7df9f019289be14d7ca6898f8431381e/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/866d58409123388cf9032de57af875fbe418a642/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


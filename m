Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A2193096
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205980; cv=none; b=lB8VdJTG1z6f13ndKR1ND6iHZIj/GthSyf6gyKyqtxYSzFwwXV2QmrwcMK6iHIsD8koDG7RxKJ6aik3uyEsf2Xqrs3BVOyVxfVhYd6EWruPY2K4ucgo1clpSvr5iDvN97GKt4TZXuZqPAPcua6FpyNA2tOGHmjR/42bA8w/WoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205980; c=relaxed/simple;
	bh=ES/0DRqPD8uLX5NiKQnDlg3B+p0p6N3jUXPXrIT3E9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ww4/cYXlCmEAAsKQ9z2p0cIQxc8FhgWqC4giGDjcEVX9QbI465MSqyGF3vjZ3BH/RXBNc3L6doRBBIJq2+39uRohy2hHBTsTsErb2HjM0beHGOWRoIp2uWTMLSYYtjOX5F1ISIkTsQewMmmj+DrFo/afgYd/xvdEt7x51H/rS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYO32tyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYO32tyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410C7C32782;
	Fri,  9 Aug 2024 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723205979;
	bh=ES/0DRqPD8uLX5NiKQnDlg3B+p0p6N3jUXPXrIT3E9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kYO32tyJE89w4kwSyorw8X1TymawTdBiG5HRW/DRFpmrKk2DksRg6jCTpab0GWNZP
	 kFvtW7WVTLC7AD7JTBmNUzTVqbPlTuN+OjalG1GIpFWiltj877m8+dJe7FEIdfYUV0
	 bMG/2LSF+DahgcMl1jvh/ySAXrdEIDK1OI3ctge5GeNjuHiqz8jFZxxKe+Yk5O4F0K
	 JXg56tSyoXL2zZNrMYreD7J2PM08NybdmV9qLn8yKIXBVlj2B+dfR60zPZbXLSb3Fv
	 bqmeEnCXy/0etThilkUqGlbvx7gwh5NaNjGEb6madoEWwoCqDAhJAC3VAgoPm1GZNW
	 xN7/lAlDki3Cw==
Message-ID: <ea2671b6-310e-4957-926c-ace89a337251@kernel.org>
Date: Fri, 9 Aug 2024 14:19:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v6 00/11] mptcp: pm: more fixes around the ID 0
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
 <05750c29-565c-925d-18f0-016d480d0a8a@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <05750c29-565c-925d-18f0-016d480d0a8a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 09/08/2024 02:36, Mat Martineau wrote:
> On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:
> 
>> The two first patches are some small improvements for previous patches
>> that are already in our tree, but not sent to netdev yet.
>>
>> Then we have a fix to send a RM_ADDR with the correct ID 0, instead of
>> using the ID of the global endpoint. The test that is linked to that
>> doesn't check if the ID being sent is 0, but we can see the reaction of
>> the other peer if it closes the connection or not.
>>
>> The next fix is to correctly reset the ID corresponding to the initial
>> address: to avoid some confusion, or not to send the wrong ID if it is
>> re-used by another address later on.
>>
>> That leaded to two extra fix: sending an ACK on an active subflow, and
>> allowing to create a new subflow if the subflow was not closed: that's
>> because when the RM_ADDR was not correct, the other peer was not closing
>> the expected subflow, and the connection ended up being half closed.
>> This last issue is fixed by the next and last fix of the series.
>>
>> The last patch is not for -net. Something that sounds better to do.
>>
> 
> Ok, after revising my response to patch 5, and a couple of minor changes
> noted for patches 9 and 10, I think the series looks good:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

New patches for t/upstream-net and t/upstream:
- 5ebe23ff5ade: "squashed" patch 1/11 in "mptcp: pm: re-using ID of
unused removed ADD_ADDR"
- d4e53d9d534b: "squashed" (with conflicts) in "mptcp: pm: fullmesh:
select the right ID later"
- 90ebd895d917: conflict in t/mptcp-pm-reduce-entries-iterations-on-connect
- Results: dd8eea82e12f..64bb700808df (export-net)
- Results: e4105976662e..79be0d5eca50 (export)

- d8e98c0f3bf2: mptcp: pm: fix RM_ADDR ID for the initial subflow
- ebdca4f0dafe: conflict in t/mptcp-pm-rename-helpers-linked-to-flush
- 4d0382127a23: selftests: mptcp: join: check removing ID 0 endpoint
- 67433e9c8864: mptcp: pm: send ACK on an active subflow
- 0840279fb33e: mptcp: pm: skip connecting to already established sf
- a7844983a8df: mptcp: pm: reset MPC endp ID when re-added
- 1ec2de2a8c89: selftests: mptcp: join: check re-adding init endp with != id
- Results: 64bb700808df..5c1437dbc580 (export-net)
- Results: 79be0d5eca50..beede3e0f15d (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/8283dd520fc366ce169363fe1d27df40e0e5b056/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/e76eecedaea68d03d2bd1ab1632589b1e7cb568c/checks

> If you want to rework patch 10 given the reverse-compatibility question,
> then you're welcome to apply all but 9 & 10 so you only need to respin
> two patches.

Yes, I can do that, thank you for the review!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


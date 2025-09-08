Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E2183CA6
	for <mptcp@lists.linux.dev>; Mon,  8 Sep 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351869; cv=none; b=a0LxFT/6tvXWf7045qoaBkUXhU3pdgFQSociUz0V9E0CPRfetROb+LLupGWghnXkXDpbGTdnhXStu9fzWoZU4S8aRomui7lCotgQkBCl8iFHQWtcsy4hEyfLfIMskxoUE5jKbEF8Po2s3tfmbt7Jtxr0+W+mjumZk7yIEzF4XXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351869; c=relaxed/simple;
	bh=h+rMHewEgzCklryLPCQLR19Lc8aPD9KNp04BH0/OHsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8SCut5cmFVBaOIGkxdTMkMoUadzhum5PkKTmvPv7fjKUoBM1fy2MAuYpu1bE/LQWkP/aT7RRFAdC3L1PT7xwQFcP3hGChwQ+dy8J44GBBlAJh8ekacViJtc+02JUTmSqXsPFKf/tW8CEVrJU3DBzNDpqdohQxPsuFFSOUA1wlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNhniVZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNhniVZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB76C4CEF5;
	Mon,  8 Sep 2025 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351869;
	bh=h+rMHewEgzCklryLPCQLR19Lc8aPD9KNp04BH0/OHsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CNhniVZoINcDTUYxLmiiVI5pS1ABPOV7orRxMssBv6kAuipbto0d5T2wBnAenqTJB
	 c4xnS2bO9qKGc6H2U5Lehu/Qbxd8I2BykfdQJwwIo/cMArToIzuZ5di6wBg2WYAsT7
	 +SPuglfde+DiRUmub89HGxE0U+8+BRiRetetvjOubnTEoD4lUyhTF3ThWbsEi3vCiq
	 QD2WHHwfYQR/5L0/lGaSTi74z2PU1axJD4t1VnW3IolC4YDVLcyECLoaVlsJjSJ+bE
	 nsRQhfIdlpRceo4u5lfD3tgBg+b1HbMJAIzqNsXWKvrh6zTAeL/inhd9jJs3/5Jmd3
	 2LZzpSkubSZxQ==
Message-ID: <a3bd2233-b8bc-4aa3-8812-f2f6cacf9f73@kernel.org>
Date: Mon, 8 Sep 2025 19:17:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH RFC mptcp-net 7/7] mptcp: pm: nl: announce deny-join-id0
 attribute
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
 <20250829-mptcp-pm-user-c-flag-v1-7-78b25dda7708@kernel.org>
 <c0361d0e-bbe8-d04b-2afd-4f27c3d30546@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c0361d0e-bbe8-d04b-2afd-4f27c3d30546@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the review!

On 05/09/2025 02:54, Mat Martineau wrote:
> On Fri, 29 Aug 2025, Matthieu Baerts (NGI0) wrote:
> 
>> During the connection establishment, a peer can tell the other that it
>> cannot establish new subflows to the initial IP address and port by
>> setting the 'C' flag [1]. Doing so makes sense when the sender is behind
>> a strict NAT, operating behind a legacy Layer 4 load balancer, or using
>> anycast IP address for example.
>>
>> When this 'C' flag is set, the path-managers must then not try to
>> establish new subflow to the other peer's initial IP address and port.
>> The in-kernel PM has access to this info, but the userspace PM didn't.
>>
>> When a new connection is created and established, the Netlink events
>> will now contain a new deny-join-id0 attribute. When set to 1, it means
>> no other subflow to the initial IP address and port -- which is part of
>> the event -- can be established.
>>
>> Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-20.6 [1]
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/532
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> This patch is marked as an RFC, just so we can agree on the attribute
>> type: should we use a new dedicated attribute, or start using flags? It
>> even looks like we have defined a "flags" attribute, but it is currently
>> not used. Using "flags" would allow us to save some bytes, and in this
>> case, 'server-side' should have used "flags" too. The problem with the
>> flags is that the userspace cannot tell if a new flag is unset because
>> the kernel doesn't support it, or because it doesn't need to be set. But
>> is it really an issue? If the kernel doesn't support it, the userspace
>> will probably not know what to do anyway. So fine to use flags? Or not
>> needed, because it is unlikely to add new attributes later on?
>>
>> If yes, I suggest:
> 
> Hi Matthieu -
> 
> I do prefer 'flags' for this. It is the "C flag" after all :)
> 
>> - switching 'flags' to u32 instead of u16 because it doesn't change
>>  anything, and it is currently not used
> 
> There is already iproute2 code that references the 16-bit flags, even if
> it is just for 'ip mptcp monitor'. Better to not alter the existing
> userspace API here, especially in a -net patch.

Good point!

We can expend it later if needed.

>> - deprecating the 'server-side' attribute, and adding it in the flags
>>  (but keeping it for the moment, maybe we can remove it in a few
>>  versions?)
> 
> Good idea, can duplicate the information between the server-side
> attribute and flag for now. Then update mptcpd to prefer the flag
> version and remove from the kernel sometime after that.
> 
>> - adding deny-join-id0 as a flag: MPTCP_PM_EVENT_FLAG_DENY_JOIN_ID0
> 
> Sounds like a good plan!

OK, I will then do that, but also remove patch 2, and replace it by this
one (as a fix then).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


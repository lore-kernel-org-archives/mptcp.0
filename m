Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF572628
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666722; cv=none; b=qYj48IO3nGwE/mnRBOJGnkOmaWVf116AO3CNNlPC46RnRrXOtJl/C+JjinajAY1kec0AUrctlyXvj+R/C5STYVbA7WycDs2ewcdjG6Sc7FZVk90JAqvYMDFPxVp8jIsVorZ2Jm7CtP3lgYHKknQboS1EryK955HzCaauRtggjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666722; c=relaxed/simple;
	bh=3nZrNo6/DcxVqBBxO1A3q/XtFPE96lSENwh3urTjlSg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gLi7d0x7s1mX5U480/5s2TX8o0KckKo5zhdwt/E1uYck6dho3MP0CERLihmc3+X2j98pusBd1ir6LoRbRzSLpicoC0Lv6LGCO7fs2qe7MS1ghOPDciAhB3gzOEf6xa0bPTzn5uSdRpCjFs5gcr8ztGN0OvLqQXR0dX33MqsoLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBil17g3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBil17g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548CCC113CF;
	Tue, 23 Sep 2025 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666722;
	bh=3nZrNo6/DcxVqBBxO1A3q/XtFPE96lSENwh3urTjlSg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=vBil17g3MxRwzxpEFMn9EuXCbqN1q7LtCP4a0eo1ptokfgKK/rkuVeMT/NhP6GojB
	 RPPS/Lecqf+e0h1yIwEU+D4qVsbVs2jWFeD3FmC1SeuOQtaGz0g+5ZoYygmPHd+C5X
	 dRoql+QTfnuSXbPYfj+deY2UWuGSwJHxbMdUz1eZBh6PoPvXZvpbOXN+SMY423tMaC
	 qONmP2XqTp0PdlGGTNzBw9kerpEqPCPGQj2eveakJxlSyqle+BpMYyMZZ2f/NLdKM3
	 +XlsoE9NTJzDmweGdZjngZpG+gJ4MTetad+yP0o7bSh5atLK3HJLeBXKDToEY3klks
	 29gC4Wmem9Ejw==
Date: Tue, 23 Sep 2025 15:32:01 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 5/6] mptcp: pm: in-kernel: add 'address'
 endpoints
In-Reply-To: <ab0cd497-5e48-44f1-8e4b-d6e2aeda3fff@kernel.org>
Message-ID: <e8da0ce4-55a5-ee7f-ea84-0de88efea9fd@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org> <20250923-pm-kern-endp-add_addr-new-v1-5-60e3a8968f45@kernel.org> <777986f5-0f6a-ccea-28b4-be8e23806567@kernel.org> <ab0cd497-5e48-44f1-8e4b-d6e2aeda3fff@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-694977073-1758666722=:57519"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-694977073-1758666722=:57519
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 23 Sep 2025, Matthieu Baerts wrote:

> Hi Mat,
>
> On 23/09/2025 06:17, Mat Martineau wrote:
>> On Tue, 23 Sep 2025, Matthieu Baerts (NGI0) wrote:
>>
>>> Currently, upon the reception of an ADD_ADDR (and when the fullmesh flag
>>> is not used), the in-kernel PM will create new subflows using the local
>>> address the routing configuration will pick.
>>>
>>> It would be easier to pick local addresses from a selected list of
>>> endpoints, and use it only once, than relying on routing rules.
>>>
>>> Use case: both the client (C) and the server (S) have two addresses (a
>>> and b). The client establishes the connection between C(a) and S(a).
>>> Once established, the server announces its additional address S(b). Once
>>> received, the client connects to it using its second address C(b).
>>> Compared to a situation without the 'address' endpoint for C(b), the
>>> client didn't use this address C(b) to establish a subflow to the
>>> server's primary address S(a). So at the end, we have:
>>>
>>>   C        S
>>>  C(a) --- S(a)
>>>  C(b) --- S(b)
>>>
>>> In case of a 3rd address on each side (C(c) and S(c)), upon the
>>> reception of an ADD_ADDR with S(c), the client should not pick C(b)
>>> because it has already been used. C(c) should then be used.
>>>
>>> Note that this situation is currently possible if C doesn't add any
>>> endpoint, but configure the routing in order to pick C(b) for the route
>>> to S(b), and pick C(c) for the route to S(c). That doesn't sound very
>>> practical because it means knowing in advance the IP addresses that
>>> will be used and announced by the server.
>>>
>>> In the code, the new endpoint type is added. Similar to the other
>>> subflow types, an MPTCP_INFO counter is added. While at it, hole are now
>>> commented in struct mptcp_info, to remember next time that these holes
>>> can no longer be used.
>>
>> Hi Matthieu -
>>
>> I think this patch brings up a few larger topics of discussion: path
>> manager strategy (in-kernel/userspace/bpf), interaction of in-kernel PM
>> flags, and (once again!) naming.
>>
>> I'm not sure the reply chain for this patch is the right place to have
>> the discussion, but adding another in-kernel PM "mode" makes me think we
>> need a community-level (MPTCP) discussion on our path manager strategy.
>> The original plan was to have a single general in-kernel PM, and rely on
>> userspace/mptcpd for anything else. We've obviously made some changes to
>> that plan, adding fullmesh and having the BPF PM in progress. This has
>> made path management more complex to understand, use, and maintain - so
>> I want to be sure we are making a careful choice about which PM features
>> to add.
>
> Good point!
>
> (Regarding the BPF PM, it is similar to the userspace PM, but can be
> used in environment handling loads of connections in parallel ; and it
> introduces a better separation between the different PMs, which makes it
> worth it for the maintenance to me.)
>
>> Our userspace API for the in-kernel PM also makes it complicated to
>> explain what happens when there is a mix of endpoint types. Typical use
>> would probably be reasonable (all fullmesh, all 'address', etc). But
>> it's good to avoid confusion, and more importantly bugs!
>
> Indeed, I fixed quite a few issues and inconsistencies last year, around
> the same time I opened this issue #503.
>
> I have to admit that the 'fullmesh' mode added quite a bit of unexpected
> complexity for such a niche use-case (but it allows "workarounds"). I
> think the new mode suggested here is simple, targeting one specific part
> of the code (an ADD_ADDR is received) and fix the lack of control on
> what source IP address is used to create new subflows when an ADD_ADDR
> is received. Not as invasive as the 'fullmesh' one.
>

Hi Matthieu -

Yes, I agree this addition is more targeted, and I also think it's a very 
useful capability. All of these small additions do add up over time, and I 
want to be sure we keep track of the "big picture" and think about that 
full context when deciding how to expand our PM features.

>> As for naming, unfortunately "address" is a very frequently used word in
>> our subsystem! In mptcpd the similar plugin is called "sspi" (single
>> subflow per interface). I'm definitely open to other ideas that are
>> identifiable and descriptive.
>
> Me too! I initially picked "add-addr", but I wasn't happy with the minus
> sign, nor by its name. I guess a good name could be "endpoint used when
> an ADD_ADDR is received", or maybe "received-add-addr", but that seems
> too long, and more than one word.
>
> I ended up picking "address", because it is short, and similar to
> "signal" and "subflow" (which are not very clear, but hard to do better
> with one word...).
>

I still get 'signal' and 'subflow' mixed up sometimes and think we can 
improve our next choice :)

>> I think there are good use cases for this feature, that's why we
>> included the similar feature in mptcpd! I'd like to get our core group
>> (you, me, Geliang, and Paolo) aligned on a general direction for path
>> management, does that sound reasonable?
>
> Yes indeed, it is important.
>
> To be honest, I thought we already had this discussion at the meeting
> following the opening of this ticket #503, but that was a bit more than
> one year ago. I started working on it because the lack of control on
> what source IP address is used to create new subflows when an ADD_ADDR
> is received came back in a few discussions, even prior #503. Even
> recently when a client wanted to use dedicated interface per path. It
> feels like something is missing in this in-kernel Netlink API to use
> endpoints to create subflows to addresses announced by the server.
>
> But yes, we are exposing a new option to the userspace, and if it is
> accepted -- and not modified/reverted in the new 10 weeks -- we will
> have to maintain it for a long time. So better not to get it wrong. I
> think it is "self-contain" and worth it. I would like a better name than
> "address", but I didn't find one. At the end, I'm happy with it as it is
> similar to the others and will have a longer description in the doc, but
> I'm open to another name :)
>

Ok, thanks for clarifying. I think our discussion of #503 15 months ago 
was fairly brief and I'm guessing the significance of the additional 
endpoint type didn't sink in at the time. Definitely easier to understand 
the implications seeing the patches!

Will discuss the naming details in the v2 thread.

- Mat
--0-694977073-1758666722=:57519--

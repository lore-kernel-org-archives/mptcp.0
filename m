Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FC1B808
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131866; cv=none; b=Ix+CkVXiYYTFWDizCcOfqA6bGozGJ1GNKfYL4TWGqchtR6wAo4P2u6VU1RCXzvQ5wrk3Yjmhz8FcCdYj4Q338SGdjZVLCj2DEgA+anks/KO0LWTwr4o3UFOlAMfdQ1CZuEBEFj9AHW2dNeK2VVo6iC41lsv7X9AjjS/2ngkB/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131866; c=relaxed/simple;
	bh=jNBYuLHC5972e392r9GN4Ywe9VG5SdOA6QK3izVS+rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzme93Cndm84SynSjwRdH5k6iyK96+i8HFqhDx8irV1+MG8E8lqOT2jzshDq4MqwtRMY/sASLpy40MJYOlh94ZDDJmyea894kDAO3+GHWvdVH5ZIkAyzW528ofMA1gbh0WKamHc4TMHwrE2TMP7zzkzLM1fLznkGbtBN2JMqhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3iG5qGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3iG5qGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538F31F00893;
	Sat, 30 May 2026 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780131865;
	bh=f+grcKTAKD2mRsdWW/fMh2pnTzONAzJzUogV7OH62G8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i3iG5qGxZNArrE1/KC790+6Kfa3pOOrO6zXz4Y/RshdOlQHE3VvMTgbjMYhgXU3kM
	 U6HC9/FTwm3/We5i/mhnIfEZNKE55bE2ZtjK3ueinyxiaNaemvC8xku0JiSTRa6y36
	 wgOD1UUhLAUztspqVotKFjJ4gajvVvV2DTWD4gUXb7AXWGnrDGFJdRTDjaMr3GQ7oe
	 PWGO7ysTAQIeAO8D2F3DzN6VKU4J9WKk9CEgvlM55a01/kXIRqDmY0bjIeG5h1++/P
	 17pTnthbKfasA9s5GNXGukgubhBAMP7kbxiXWtu4bQhaUPT0uzFCHRbQ4E1Eh9UMjf
	 LdKkhu9hzEI0w==
Message-ID: <3ea430aa-cb75-40bb-ae9f-ada6649077bb@kernel.org>
Date: Sat, 30 May 2026 19:04:21 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net mptcp-next v4 00/15] mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
 <6b4b5e7d-1663-c84f-b09a-e2afeb7b866e@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6b4b5e7d-1663-c84f-b09a-e2afeb7b866e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 30/05/2026 04:12, Mat Martineau wrote:
> On Fri, 29 May 2026, Matthieu Baerts (NGI0) wrote:
> 
>> Currently, it is possible to add a "signal" MPTCP endpoint with a v6
>> address and a port, or to directly request to send an ADD_ADDR with a v6
>> address and a port, but such signalling option cannot be sent when TCP
>> timestamps is used due to a lack of option space. Instead of simply
>> dropping such ADD_ADDR, the TCP timestamps can be dropped only for this
>> packet.
>>
>> - Patch 1: fix for PREEMPT_RT kernels, for -net.
>>
>> - Patches 2-4: small cleanups to avoid computing ADD/RM_ADDR twice.
>>
>> - Patches 5-8: the new feature, controlled by a new sysctl knob.
>>
>> - Patch 9: extra checks in the selftests.
>>
>> - Patches 10-15: refactoring/cleanups: some of them were part of a
>>  previous patch: "mptcp: pm: clearer ADD_ADDR related helpers names"
>>  [1].
>>
>> Note that the mptcp/add_addr/add_addr6_port_ts_server.pkt packetdrill
>> test is supposed to fail with this series, until this PR is applied:
>>
>>  https://github.com/multipath-tcp/packetdrill/pull/198
>>
>> Link: https://lore.kernel.org/20260415-mptcp-inc-limits-v5-20-
>> e54c3bf80e4e@kernel.org [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v4:
>> - Patches 2-4: uniform "size" type: signed for all suboptions. (Mat)
>> - Dropped previous patch 16.
>> - Link to v3: https://patch.msgid.link/20260520-mptcp-add-addr6-port-
>> ts-v3-0-bffa658a7678@kernel.org
> 
> Hi Matthieu -
> 
> Thank you for the updates in v4, all of my concerns are addressed and I
> agree that this approach to fitting ADD_ADDR headers w/ IPv6 seems like
> the best tradeoff.
> 
> I'll also give a +1 on the packetdrill PR.

Thank you! Merged!
> For the series:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review! Now in our tree:

New patches for t/upstream-net and t/upstream:
- c619bf382586: mptcp: pm: avoid sleeping while holding rcu_read_lock
- Results: ba5ea3e35898..b744d5cbf545 (export-net)
- Results: 24c473fa6c91..0a3014718f01 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/8f01bd3c80a4051904fdb16bc4a7d2d56e01b102/checks

New patches for t/upstream:
- 140b3313d086: mptcp: options: suboptions sizes can be negative
- ecb59042f997: mptcp: pm: avoid computing rm_addr size twice
- e152c63b3234: mptcp: pm: avoid computing add_addr size twice
- 3e1f23bf6d20: mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
- be190e710733: tcp: allow mptcp to drop TS for some packets
- 2bbbbbf511cf: mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
- 12de239a0b82: selftests: mptcp: validate ADD_ADDRv6 + TS + port
- a701782ba7ce: selftests: mptcp: always check sent/dropped ADD_ADDRs
- f72cd39ee480: mptcp: pm: use for_each_subflow helper
- 29db124b818c: mptcp: pm: rename add_entry structure to add_addr
- 35e6e38f8cad: mptcp: pm: uniform announced addresses helpers
- 5b33e846c45a: mptcp: pm: remove add_ prefix from timer
- 1c5f13b9f12e: mptcp: pm: make mptcp_pm_add_addr_send_ack static
- 54551d64573b: mptcp: pm: avoid using del_timer directly
- Results: 0a3014718f01..75370a1de11f (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/228692121494a157d7050d141422c9b49c19ca25/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


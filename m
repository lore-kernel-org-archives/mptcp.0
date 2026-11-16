Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842884;
	b=oPs1/bapsx+nt9wEu8jKQygBJ3bHK++lbUZCqaU1bJTuKbifwiofWFZowhK3u4R2XSKG
	 KlyR3OmnbrJPj4PstwiNXfuoo9AaXjckUI+1EwTLevZTAJst5seX1zSxUZpyFPgFZtycm
	 cB7xqBfxLCwOp9n/FehL9s5xT3xJASfCMdBH9gFfH31GQgA7RLThmKeM0G8HzRf62xLy+
	 Hul7W9+AJe2vPQTK/jExexpvFwYX9nji3ITW/3nbYIl6t/irahrss+plhdoBAfTN7YgrU
	 Mk3B6/aVaLizMY0MnmobiILxYQjUgPEb0qZHB0NUDz/1NzfoJsxFEuJReIKcbkLfOWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842884;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MbLerJVgXvZP5G07rQdoslGLdEZELRrZ4Ip1uggXiho=;
	b=Zyy47HOcJQ50Qxq6c8Ejb41Xfxfa+j4lJsBhRs1YKtAhU5IC9/d3iXt+mFIKDak6TSEf
	 rqfxHXjdusa0G2S5zzDhTS75PqFcJaaZuseKexgWsOuRrtjXiAKjs8AAZj3BrH4evWa1d
	 t/7Meoedj5Gk7Q59asBxhAEyOrNkUzYu6an6lUQuHuEh5YAQd4oCTjB1U2g57USIzQgYL
	 LPmOxAEMS4TfG3dQ6qfKkMsdRLAJq8Inw50n1+jtn5cZjDFoIPoh9uFS7m6qGSZEJ2Sdz
	 xE5O0QFyZ0IoG9276yHJzu9LnFhB89vv263lISUloYquIq65oaZRvagRbRTdpupGXcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAWIYZCX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783B606A332
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAWIYZCX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D222C1F000C4;
	Mon, 16 Nov 2026 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842883;
	bh=MbLerJVgXvZP5G07rQdoslGLdEZELRrZ4Ip1uggXiho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hAWIYZCXlmRUu3VPo15fPcc6W/RzE/BzyPah+LqsmkX336F3OJW/N4mbblZqaFd0c
	 5ABhNDekM/WHhMe5k7syPXy46+pGLeviJ8dJRm47GrHBkTppzFnz1YR85JY1oVWkrm
	 v6/Wiz6wQIfttnj+Hg1J8hQ6nAvX4F7OFOGnLeSqleQex/9M0KqoEy5e3EetWTh1PB
	 jk6iBto+qzdn/BohlyFs6Ttgjiq1F62/WmLGrD7fhU5Yb/tsAM85gHUxyInfIDa7fE
	 repoTiEcYph81ddWwK8//y8emUsfHXi/fQgimJMGnkGq9BIT1WwUWeFvhLTYIcs/xD
	 IFe3lUp9VfSbw==
Message-ID: <d4f74b14-8924-4a7f-be42-a4c405049964@kernel.org>
Date: Mon, 16 Nov 2026 16:28:00 +0100
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
Subject: Re: [PATCH mptcp-net 32/34] mptcp: fix dummy mapping of overlapping
 segments
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Chris Mason <mason@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-32-9205b77e9a2f@kernel.org>
 <c504da100dc5c5028bda391a6aabf0485464145c.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c504da100dc5c5028bda391a6aabf0485464145c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/11/2026 12:05, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2026-11-13 at 20:54 +0100, Matthieu Baerts (NGI0) wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> An MPTCP socket that has fallen back to TCP can silently lose received
>> data if a segment partly overlaps data received earlier, and recv() then
>> blocks, returning neither later data nor end of file.
>>
>> After a fallback, subflow_check_data_avail() makes up a dummy mapping
>> for the skb at the head of the subflow's receive queue, in which map_seq
>> and map_subflow_seq must describe the same byte. But since commit
>> 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation"), it
>> computes map_seq from the first byte of the skb, while map_subflow_seq
>> is still computed from copied_seq, the next unread byte.
>> mptcp_subflow_get_mapped_dsn() then returns the data sequence number
>> (DSN) of the first byte of the skb, instead of the one of copied_seq.
>>
>> These two bytes differ for a segment that starts before rcv_nxt and ends
>> after it, since TCP does not trim it. mptcp_init_skb() then gives the
>> new bytes of this skb a DSN that is too low, and __mptcp_move_skb()
>> skips some of them as old data, leaving a hole in the stream:
>>
>>     bytes 0 to 999 are received, the skb holds bytes 900 to 1499
>>       byte 1000 gets the DSN of byte 900: too low by the 100 old bytes
>>         that is 100 below ack_seq, the next DSN that MPTCP expects
>>           __mptcp_move_skb() skips bytes 1000 to 1099 as old data
>>             ack_seq is the DSN of byte 1400, copied_seq is byte 1500
>>               later data starts at the DSN of byte 1500: out of order
>>                 the TCP FIN becomes a dummy DATA_FIN after the last byte
>>                   ack_seq does not reach it, so there is no end of file
>>
>> Fix this by computing map_subflow_seq from the first byte of the skb as
>> well: mptcp_subflow_get_mapped_dsn() then returns the DSN of copied_seq.
>>
>> Chris Mason sent the same fix in private, and found this issue with the
>> help of an LLM. It has been reproduced in a VM, with the reproducer he
>> shared, and with a new Packetdrill test: after a fallback to TCP, a
>> segment overlapping data already received is injected. Without this
>> patch, the new bytes at the beginning of this segment were lost, and the
>> connection stalled, with no end of file:
>>
>>   reader   30.64: conn 1 BREAK: at my offset 1000 the bytes claim offset 1100: A GAP OF 100 BYTES
>>   reader   30.64: READ-TOTAL conn 1 outcome iii-gap-or-repeat bytes 1400 of 2500 [...]
>>   [...] end: hang: no data and no end of file for 30 s
>>
>> And with the Packetdrill test:
>>
>>   dss_fallback_overlap_client.pkt:24: runtime error in read call: Expected result 2500 but got 1400 with errno 115 (Operation now in progress)
>>
>> Fixes: 2834f8edd74d ("mptcp: cleanup fallback dummy mapping generation")
>> Link: https://lore.kernel.org/4c48d016490d43b6892c622cbae858b48f176cff.1794304840.git.tanggeliang@kylinos.cn [1]
>> Co-developed-by: Chris Mason <mason@kernel.org>
>> Signed-off-by: Chris Mason <mason@kernel.org>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> [ Combine the commit messages of Geliang's [1] and Chris's versions.
>>   Commit message: how the issue was found, and its symptoms. ]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> This fix LGTM! - sashiko has no complaints about it too. Could you please apply
> this patch to the export branch first, so that I don't have to carry it along in
> every iteration of the "Reduce the differences between TCP and MPTCP for TLS
> usage" series? Also, Chris and I both sent out this same fix at different times,
> which further confirms from another angle that this fix works.

I was hoping to send a v2 for this series soon, and apply patches "soon
after", but the patches keep growing (50 now :-/) because of the
pre-existing issues found by Sashiko/Clashiko...

I will look at applying this patch 32/34, and others with user impacts,
e.g. 11/34 and 24/34.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


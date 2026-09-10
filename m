Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028F396B9D;
	Thu, 10 Sep 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035219; cv=none; b=aFk3bPR2T9Pa0j9xtC35h6F7bk9apNYY+mY8TtX6JHd5EESLIvYXAL68TiiIM7banQ/3sW5sYuzY9uq7LNPeeHssLgcHn0/TCkalmRo8hencEFIbsB6HFJWTnfIg25FLePaFdKc423BV2ofYo4vzLEDYhsoaVSNim5dUczkFDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035219; c=relaxed/simple;
	bh=t7XBJTdeA5LYyiKBQx1hBo7BxbXRQJjB0d9EpiSTDYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwpLJZbLpISacoLcPQqdyOLJzCqI4JpVHSReBwYznvi2RSKwaTvxe9hV6yMaD7GC/BKo0Ily6IhM3XLHk+M8836fHU1ksg5/uKL35svAb27OjAqqRkpMDR+6hX4psxkYuUqjhSMrsxIGRrNjqSKtch7UaqFaPFdte1Ayhs1hk8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5XciVZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5XciVZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795AA1F000FF;
	Thu, 10 Sep 2026 10:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789035218;
	bh=wO6RPWe/NhhD5fik9dJ1h/oDDE7OmmVRzqbqef2u77U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i5XciVZlh+ll3ruG0ZwVvzT0wkMAhLCwaptabd00GA7o8uuHOKwthb9Yug+o2/SaC
	 yiysL8CK2YS/Em7SC8DBRtQUAfrsGmwtDcGjZNEoU0tQ9CXTRbM8+AqkECuVjHkcot
	 g5wKQ4UJd2AXlnDn07c4GN57/70gom7yJ6yZqcyaFjC3d/GJwzsTVKlODT5uNPrEoO
	 QvVbyqdJPK53J21MddUQl+eJBIO1MAzUaoo3Y5gTD/Qo0sjSoc0+t4dQ5qKB4DvWZL
	 S9PkznTb/zVJVOukrQxbcdOEmnd74M36gAf0PC+q8X8jOe018VEZAsyWgS+vy6HFYc
	 l1z1QR/12UPnQ==
Message-ID: <cd7d7f5e-d729-475e-b772-e201a2ab37be@kernel.org>
Date: Thu, 10 Sep 2026 12:13:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Kimi Security Team <bug-report@moonshot.ai>,
 Yilin Zhang <yilinzhang@moonshot.ai>, Mat Martineau <martineau@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
 <c95bc6f8-b8da-426f-a056-1c692559d14f@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c95bc6f8-b8da-426f-a056-1c692559d14f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for having checked!

On 10/09/2026 10:12, Paolo Abeni wrote:
> On 9/3/26 11:40 AM, Yilin Zhang wrote:
>> subflow_syn_recv_sock() sets drop_req when an MP_JOIN SYN takes the fatal
>> fallback and destroys the cloned child. tcp_fastopen_create_child()
>> ignored the flag and could queue the destroyed child.
>>
>> With an MPTCP listener using server-side Fast Open, a valid-cookie
>> MP_JOIN SYN could then expose the freed child through accept().
>>
>> Release the locked child and drop the request before tcp_conn_request()
>> sends a SYN-ACK. Initialize drop_req when allocating the request so the
>> check cannot observe stale state after request-socket reuse.
>>
>> Changes in v2:
>> - unlock the child before dropping its reference
>> - drop the request instead of sending a SYN-ACK after the MPTCP reset,
>>   as suggested by Jiayuan Chen
>>
>> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
>> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
>> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
> 
> This looks like the wrong fix. IIRC fastopen is not compatible with MPJ
> - as the latter must accept data only after the 4way handshake completion.
> 
> @Mat(s): could you please double check the above ^^^ statement???
> 
> If so mptcp should reject entirely MPJ + fastopen and no addtional code
> required on the TCP side.

I didn't check in details, but when I try with this packetdrill repro...

 https://lore.kernel.org/20260903070649.3965366-1-yilinzhang@moonshot.ai

... it looks like the kernel replies with an MP_RST, but also a SYN+ACK,
and a WARN:

  refcount_t: underflow; use-after-free.
  (...)
  inet_csk_listen_stop (net/ipv4/inet_connection_sock.c:1533)
  ? mptcp_subflow_queue_clean (net/mptcp/subflow.c:1925)
  mptcp_check_listen_stop.part.0 (include/net/sock.h:1486
                                  net/mptcp/protocol.c:3482)
  __mptcp_close (net/mptcp/protocol.c:3534)
  mptcp_close (net/mptcp/protocol.c:3572)
  inet_release (net/ipv4/af_inet.c:425)

With this v2, I don't see the SYN+ACK, only the RST.


If I'm not mistaken, with TFO, syn_recv_sock will be called first
(tcp_conn_request -> tcp_fastopen_create_child -> subflow_syn_recv_sock)
then MPTCP will only check TFO when the SYN+ACK is being sent
(tcp_conn_request -> subflow_v(46)_send_synack).

In subflow_syn_recv_sock(), I don't think we have a strong indicator
that the caller is TFO. It looks like we would also need to change the
TCP stack to pass this info, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


Received: from mta0.migadu.com (out-144.mta0.migadu.com [91.218.175.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE301484242
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042544; cv=none; b=n3KbTKbOl1z4IaW3Lfk87qFsGtYcCKdz5MtTamEBmS4p1s29tOhU+tp/Aidci1E4Po0SQEboASmVZwqlUcvlKW2Ka9bmFETT7hsFfFd4r4aqtZvU/JOVof7Ty41AW0+cEzFOFOvRj6JPhZTaajkHSvtcoAymg0g+8/f+xTYKfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042544; c=relaxed/simple;
	bh=sHK07o4ZNtPtjY+nN7nBwsM5doAvUH1ZVu4hBnEZvkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fee2xKg1HoW5gAyF2MMOrcegreoZe2V3e7lxf7jBX/i8vBC3i8wZvGOz/Pkg4OqWCl2h8MtlhggrpLmNol7IrUE+ftiOj1Lefh+s0lqayx9/5BE1NJerXNtw3UAcTqRsKfSuhVC0O8dtG8XYqlQOCRy1EDQD1BX/j0+VBEnJX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iZ0fbtmp; arc=none smtp.client-ip=91.218.175.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iZ0fbtmp"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=sHK07o4ZNtPtjY+nN7nBwsM5doAvUH1ZVu4hBnEZvkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789042535; v=1; x=1789647335;
 b=iZ0fbtmpXuA5jrHvHfE9CQd8buynQx3juB6Xw+fQvHzFH8itjqGIgta44v1skWCxWJ6vnfcn
 kHLFqTg/V9oyabOcwbtAZvB+0p/n0topzh4pltaHDm/aIfA+xG3sH7Jbg5lxjBbPnrBHQdPz7al
 5iPlE2jlY2RcGfv43zcE9cPU=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id a1d0e7034e635d35;
	Thu, 10 Sep 2026 12:15:23 +0000
X-Mizu-Trace-ID: a1d0e7034e635d35
X-Migadu-Flow: FLOW_OUT
Message-ID: <f8028773-9ed6-4a34-9fd4-68150a459cfb@linux.dev>
Date: Thu, 10 Sep 2026 20:15:15 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Kimi Security Team <bug-report@moonshot.ai>,
 Yilin Zhang <yilinzhang@moonshot.ai>, Mat Martineau <martineau@kernel.org>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
 <c95bc6f8-b8da-426f-a056-1c692559d14f@redhat.com>
 <cd7d7f5e-d729-475e-b772-e201a2ab37be@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <cd7d7f5e-d729-475e-b772-e201a2ab37be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/10/26 6:13 PM, Matthieu Baerts wrote:
> Hi Paolo,
>
> Thank you for having checked!
>
> On 10/09/2026 10:12, Paolo Abeni wrote:
>> On 9/3/26 11:40 AM, Yilin Zhang wrote:
>>> subflow_syn_recv_sock() sets drop_req when an MP_JOIN SYN takes the fatal
>>> fallback and destroys the cloned child. tcp_fastopen_create_child()
>>> ignored the flag and could queue the destroyed child.
>>>
>>> With an MPTCP listener using server-side Fast Open, a valid-cookie
>>> MP_JOIN SYN could then expose the freed child through accept().
>>>
>>> Release the locked child and drop the request before tcp_conn_request()
>>> sends a SYN-ACK. Initialize drop_req when allocating the request so the
>>> check cannot observe stale state after request-socket reuse.
>>>
>>> Changes in v2:
>>> - unlock the child before dropping its reference
>>> - drop the request instead of sending a SYN-ACK after the MPTCP reset,
>>>    as suggested by Jiayuan Chen
>>>
>>> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
>>> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
>>> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
>> This looks like the wrong fix. IIRC fastopen is not compatible with MPJ
>> - as the latter must accept data only after the 4way handshake completion.
>>
>> @Mat(s): could you please double check the above ^^^ statement???
>>
>> If so mptcp should reject entirely MPJ + fastopen and no addtional code
>> required on the TCP side.
> I didn't check in details, but when I try with this packetdrill repro...
>
>   https://lore.kernel.org/20260903070649.3965366-1-yilinzhang@moonshot.ai
>
> ... it looks like the kernel replies with an MP_RST, but also a SYN+ACK,
> and a WARN:
>
>    refcount_t: underflow; use-after-free.
>    (...)
>    inet_csk_listen_stop (net/ipv4/inet_connection_sock.c:1533)
>    ? mptcp_subflow_queue_clean (net/mptcp/subflow.c:1925)
>    mptcp_check_listen_stop.part.0 (include/net/sock.h:1486
>                                    net/mptcp/protocol.c:3482)
>    __mptcp_close (net/mptcp/protocol.c:3534)
>    mptcp_close (net/mptcp/protocol.c:3572)
>    inet_release (net/ipv4/af_inet.c:425)
>
> With this v2, I don't see the SYN+ACK, only the RST.
>
>
> If I'm not mistaken, with TFO, syn_recv_sock will be called first
> (tcp_conn_request -> tcp_fastopen_create_child -> subflow_syn_recv_sock)
> then MPTCP will only check TFO when the SYN+ACK is being sent
> (tcp_conn_request -> subflow_v(46)_send_synack).
>
> In subflow_syn_recv_sock(), I don't think we have a strong indicator


You inspired me. Maybe we can use such code:

     if (subflow_req->mp_join &&
         (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN))
             return NULL;


We now skip RST and SYN+ACK also can be sent by tcp_conn_request().




> that the caller is TFO. It looks like we would also need to change the
> TCP stack to pass this info, no?


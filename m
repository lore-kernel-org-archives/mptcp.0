Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DF3E63B7
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065677; cv=none; b=IQC+8NQ6B3OEQjBQu+bg7loDeOt6lNQy136CrwSTBDLrTMPJTXJ20Wh9mBodS/L3zcBEPJShdpTeF+FDOtqSwVSxmRohXA2C2eSWvBetsvPXnguJmWs6MkvVU5E8GrDZc0Ys0ZcFDGqEJxtpjU+Wsp+m8j1Ha+kDq5e7biXGekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065677; c=relaxed/simple;
	bh=QEyKrhAUCCsgR/JFr/+RQCGYNhICKHCayUigtQY8wIM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=sEyYKZFHUF0At4h/KB3iIRhTby0Qd7kvtaZfRtaCbDsa8oR8WCEv5gnzPR5cx07tEfIFEQeexGEthwDGVMaeIPL4ngd65E7i/okkIGuVVj8NKyEq8cz3HtHk5K6066gi7/iBJ340EUCT1iFC389aFH6x4nZ8cXjXO83Z97iMY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVS7Vwi0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVS7Vwi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780065675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LognZzQTBbDOR4m8uRUpzNkSGO5IbUqSXyRaaKY/GHI=;
	b=fVS7Vwi0yDEbDYWHrc8eDl2NcsDGjn1BTnM6M2cQyw2lUTAjwg7kMcJpaOO4jn+fGABUzm
	K7d9RkK7WKERE0hrxdkmgQZzwLhBF48hZ+KSEJrBvx2E0pN+2/70z5ISlE9t+pZeUzB9zd
	2PbuW6KY/rVCsYHz8j5ATRa3tIcI06w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-6P2Mgo3-NEyg-PJ-e_iUUQ-1; Fri, 29 May 2026 10:41:13 -0400
X-MC-Unique: 6P2Mgo3-NEyg-PJ-e_iUUQ-1
X-Mimecast-MFC-AGG-ID: 6P2Mgo3-NEyg-PJ-e_iUUQ_1780065672
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49081106196so26772655e9.1
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 07:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065672; x=1780670472;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LognZzQTBbDOR4m8uRUpzNkSGO5IbUqSXyRaaKY/GHI=;
        b=UFiY6RFQTw3AcmEETWylP60RrvLjIFuM4sbMksb/eGLN86Ys2rc8noO0ARe6ASzEr+
         PlGUvx4aJq+cGTZEtqzvZ/3qY9NyZZ3LsNgpn/F/EIeOLXGuCZHZy2WPq3MNANeMcitV
         sj0nZH9pfawsoIxpl9NFXm3VndZRNLIORMybYSTDJouQkN6rTDn4s2p+2iWrS9Ny3+mV
         pheOfIWwjLiteu+ptQ5OxFNKMxddYow1bF+3047/hqgJSN0fFRbfSKsG4utcYDrgtCfC
         QfG+BPsjfM1IY8kgC/45BdDc2WhRONl201tIC9qx+/PJoTfvBlk8ivtANKD+g/9KbGoP
         TOzg==
X-Forwarded-Encrypted: i=1; AFNElJ9emlkVKuCDaGQW2vSoAAcU/mdECqlaAz6OQIN4h6Jc9nb7+zkt9yxCQDpjuEBotDCm3XOzZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFKljk9188+bkqK4Gx5G8XKJNyaeGlTs54qnxzIolh6pg7TQzN
	ykVhdpQ0/ZUkxfCOFB3GlP9gQBaobTSfW6eBzlaGt+Ql4ByeI+Hfg/G0uia1XIJD0t0la2GVfEt
	1He8kR5LM/Pn4OVvJkHGCbzdm6vz8vGrFnn266xRRaUuFMgJLIv7iTjht
X-Gm-Gg: Acq92OH994uaa8b25k10xr8rQRdfC4bANz2qduMoV2P7pCJn0Blnju4LNomLedig3gx
	xRHdJHE6RIkvG5cmKOyhyATK9j3+C0MzniFMIksie1TROwK9vBAlbxyS9g/Xfp4y2DSdbDaiH67
	lp/2qdfn6NpO7ZlDgeK7EF8sFDl6igOc1x7v907Vw48yb5mcpc+Y+TPtdfUVefMI0GengPAGwYS
	zZySnNkPicrGsx/NZfXr0RzJiWyNmEyVMI4sWYoU+dzI7ntUDJaAY9KFN1b7fJwZajGLH0wBley
	iNMOfjUm3SDiX3xAogdbUjq6B0GwoAXhhx+LLtdLMSGjMsiIgFezRcFgxsp9S9uXv7LrEjFzrJU
	nqFBe0U6JdncwB/J/fdEZ/h68jxVwj/tJLme801dv38/qiDMsuq4zp8RrT5X5PtiW+bDO
X-Received: by 2002:a05:600c:a55:b0:490:3ff5:737f with SMTP id 5b1f17b1804b1-4909c0af305mr59269405e9.18.1780065672183;
        Fri, 29 May 2026 07:41:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a55:b0:490:3ff5:737f with SMTP id 5b1f17b1804b1-4909c0af305mr59268745e9.18.1780065671633;
        Fri, 29 May 2026 07:41:11 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e79sm91820085e9.13.2026.05.29.07.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 07:41:11 -0700 (PDT)
Message-ID: <d521e62f-688d-4c19-8c82-ab374c40a606@redhat.com>
Date: Fri, 29 May 2026 16:41:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 mptcp-next 3/3] mptcp: let the retrans scheduler do
 its job.
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1780049797.git.pabeni@redhat.com>
 <199d3b27cc1f092a1bca686963103f922d0d27cd.1780049797.git.pabeni@redhat.com>
 <61de072a8e750ec6c7d7228cca6d7d55885e0abf.camel@kernel.org>
 <e90f30c1-59c5-4707-8a95-a5e876d20399@redhat.com>
In-Reply-To: <e90f30c1-59c5-4707-8a95-a5e876d20399@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5NXOr6mU9qnREymsNUU-Pe4Vmqw0owoE6d05WEERgmw_1780065672
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/26 4:14 PM, Paolo Abeni wrote:
> On 5/29/26 3:27 PM, Geliang Tang wrote:
>> On Fri, 2026-05-29 at 12:44 +0200, Paolo Abeni wrote:
>>> Currently the MPTCP core enforces that when MPTCP-level retrans timer
>>> fires, at most a single dfrag is retransmitted. If some corner-cases
>>> it
>>> may be necessary retransmit multiple dfrags, and the MPTCP socket
>>> will
>>> need to wait multiple retrans timeout to accomplish that.
>>>
>>> Remove the mentioned constraint, allowing to transmit multiple dfrags
>>> per
>>> retrans period, as long as the scheduler keeps selecting subflows for
>>> retransmissions and pending data is available in the rtx queue.
>>> The default scheduler will transmit a dfrag per available subflow.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v9 -> v10:
>>>   - simpler handling for data-fin rtx
>>>
>>> v7 -> v8
>>>   - fix corner-case retrans_seq update
>>>
>>> v4 -> v5:
>>>   - fixed already_sent update
>>>
>>> v3 -> v4:
>>>   - avoid quadratic behavior, fix retrans_seq update
>>>   - fix rtx timer re-schedule miss
>>>
>>> v2 -> v3:
>>>   - fix infinite loop issue (should address tls tests failures)
>>>
>>> v1 -> v2:
>>>   - fix retrans sequence update (sashiko)
>>>
>>> Note:
>>>  - sashiko may see issues when dfrag = mptcp_rtx_head(sk) != NULL and
>>>    dfrag->already_sent == 0. That condition should not possible: if
>>>    mptcp_rtx_head() is not NULL there should be some data already
>>>    sent.
>>>  - sashiko may see missing data-fin rtx when the initial `dfrag` is
>>>    not NULL. data-fin RTX is NOT needed in such scenario.
>>> ---
>>>  net/mptcp/protocol.c | 119 +++++++++++++++++++++++++++++++----------
>>> --
>>>  1 file changed, 87 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 51756800edc2..7fe618e22d1b 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1201,13 +1201,6 @@ static void __mptcp_clean_una_wakeup(struct
>>> sock *sk)
>>>  	mptcp_write_space(sk);
>>>  }
>>>  
>>> -static void mptcp_clean_una_wakeup(struct sock *sk)
>>> -{
>>> -	mptcp_data_lock(sk);
>>> -	__mptcp_clean_una_wakeup(sk);
>>> -	mptcp_data_unlock(sk);
>>> -}
>>> -
>>>  static void mptcp_enter_memory_pressure(struct sock *sk)
>>>  {
>>>  	struct mptcp_subflow_context *subflow;
>>> @@ -2830,8 +2823,12 @@ static void mptcp_check_fastclose(struct
>>> mptcp_sock *msk)
>>>  	sk_error_report(sk);
>>>  }
>>>  
>>> -/* Retransmit the specified data fragment on all the selected
>>> subflows. */
>>> -static int __mptcp_push_retrans(struct sock *sk, struct
>>> mptcp_data_frag *dfrag)
>>> +/*
>>> + * Retransmit the specified data fragment on all the selected
>>> subflows,
>>> + * starting from the specified sequence
>>> + */
>>> +static int __mptcp_push_retrans(struct sock *sk, struct
>>> mptcp_data_frag *dfrag,
>>> +				u64 sent_seq)
>>>  {
>>>  	struct mptcp_sendmsg_info info = { .data_lock_held = true,
>>> };
>>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>> @@ -2841,6 +2838,7 @@ static int __mptcp_push_retrans(struct sock
>>> *sk, struct mptcp_data_frag *dfrag)
>>>  
>>>  	mptcp_for_each_subflow(msk, subflow) {
>>>  		if (READ_ONCE(subflow->scheduled)) {
>>> +			u16 offset = sent_seq - dfrag->data_seq;
>>>  			u16 copied = 0;
>>>  
>>>  			mptcp_subflow_set_scheduled(subflow, false);
>>> @@ -2850,9 +2848,12 @@ static int __mptcp_push_retrans(struct sock
>>> *sk, struct mptcp_data_frag *dfrag)
>>>  			lock_sock(ssk);
>>>  
>>>  			/* limit retransmission to the bytes already
>>> sent on some subflows */
>>> -			info.sent = 0;
>>> +			info.sent = offset;
>>>  			info.limit = READ_ONCE(msk->csum_enabled) ?
>>> dfrag->data_len :
>>>  								   
>>> dfrag->already_sent;
>>> +			DEBUG_NET_WARN_ON_ONCE(!before64(sent_seq,
>>> +							 dfrag-
>>>> data_seq +
>>> +							
>>> info.limit));
>>
>> Same as I reported in v8 of this patch [1], 
> 
> I'm sorry, I missed the previous report. Thanks for persisting :)
> 
>> when testing based on v10 I encountered the following error:
>>
>> # Starting 4 threads
>> [  879.268966][ T4341] ------------[ cut here ]------------
>> [  879.269413][ T4341] !before64(sent_seq, dfrag->data_seq +
>> info.limit)
>> [  879.269417][ T4341] WARNING: net/mptcp/protocol.c:2883 at
>> __mptcp_push_retrans+0x562/0x6f0, CPU#18: kworker/18:6H/4341
>> [  879.271883][ T4341] Modules linked in: mptcp_diag tcp_diag inet_diag
>> sch_netem
>> [  879.272450][ T4341] CPU: 18 UID: 0 PID: 4341 Comm: kworker/18:6H Not
>> tainted 7.1.0-rc5+ #94 PREEMPT(full) 
>> [  879.272813][ T4341] Hardware name: Bochs Bochs, BIOS Bochs
>> 01/01/2011
>> [  879.273225][ T4341] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
>> [  879.273527][ T4341] RIP: 0010:__mptcp_push_retrans+0x562/0x6f0
> 
> Which test-case produces the above splat? Is the splat deterministic?
> 
> Sashiko reported such problem, but I don't see how that can happen
> without i.e. an independently generated data corruption as root cause:
> 
> info.limit can be 0 only when dfrag->already_sent == 0, and that can
> happen only if mptcp_rtx_head(sk) == NULL - if the current rtx head is
> not null, the current retransmit head data fragment must have some
> unackledged bytes, that is already_sent must be greater than 0.
> 
> That incoming ack can touch/modify the RTX queue while __mptcp_retrans()
> is running only when __mptcp_clean_una_wakeup() is explicitly invoked,
> and the code always check `dfrag` afterwards.
> 
> AFAICS if that warning fires, there is some bug elsewhere.

Well, sort of: __mptcp_retransmit_pending_data() explicitly breaks the
assumption above by explicitly clearing `already_sent` in all the data
fragments in the retransmission queue.

__mptcp_retransmit_pending_data() behavior is actually "correct" - to
ensure recovery. I'll and explicit `already_sent == 0` check and will
drop the DEBUG_NET_WARN_ON_ONCE().

/P


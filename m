Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356B3769E4
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074255; cv=none; b=ioB6MxcqX0yiONzy2FRWmsoAEzCx4EA975P8r8W69a94UQb/tfb1En8N4Ov9lWmc6X5D+IX5NJbVy68VtzzLIPban76wfpzCv85eLKHd+QQBgY5CwSVW6zid2tLHf6k6M5TlTeTQ/UQVLDDLU9pHONY8YiDSiIa5l5Q095sH7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074255; c=relaxed/simple;
	bh=QEyKrhAUCCsgR/JFr/+RQCGYNhICKHCayUigtQY8wIM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=d/Tvg9R8fZ7TnyO3BAYyxk+Se/garPe95BAcCm+RZgv4Opa7FYt+CwS/rQ9N8nxH9qahMKdbk8GsTyOwWCMIrdHwLT6nx3ID4mLNTfYXID/w0Me0ahXqTmma1AaWrleFSWUoHi29Wz2CNhTmQ7RTuD/l8p1F4CcuC3t0107cEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4JuBcEU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4JuBcEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780074252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LognZzQTBbDOR4m8uRUpzNkSGO5IbUqSXyRaaKY/GHI=;
	b=Q4JuBcEUaOHUb6VSer4sk9z7E8hY8izjrlnpN78tSU+5xvJ6BDoxapbtGCx39bdlO3fD56
	Guu/TniPlUxdy5QV+m2HM1gd4e15c8Z/AzV5ThySNVaSAQUV5lcJPSEYwI66QxIVmfg9Zv
	KuzAMrO4uwO94t4zqFPfFhr+G0wT2b4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-1UkXMuNYM7-hx_u4gpAioA-1; Fri, 29 May 2026 13:04:11 -0400
X-MC-Unique: 1UkXMuNYM7-hx_u4gpAioA-1
X-Mimecast-MFC-AGG-ID: 1UkXMuNYM7-hx_u4gpAioA_1780074250
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d127eb013so68062905e9.1
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074250; x=1780679050;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LognZzQTBbDOR4m8uRUpzNkSGO5IbUqSXyRaaKY/GHI=;
        b=DGFQ+9MQda73Um7snhc7Z19+MuN9cigrHc8GGxgGVwK9ahbOCOgMdAEA3c9suMM4zL
         r206NJ3F12Crb6vU3DlXHXRR2Nb19yZ3MREENDEPznAmL3FKoxuLQnazn5eqpgxqAnnp
         LWMRTYxyFBSsoXL1GaGkwPTJhAZDDynDt2xrMEUbsfVqz8Wzx4qvizfiDTnG6yowUwi+
         cuY/I1mVOcBb0Vz/8etjLmRCerWgIqiziDh6uvDMNymFO2Lc26un3m2HAGeiJbSzDn8L
         G0S8ekSxtfRzOe/LWOXfExfRze/kLZy3HBSWuZlJ3xzFEAdwjieDCONMvob1d74jbWf9
         gTuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+e25Qr5x83ZJIWZpXJemuYBZjlzrRZwI/Z8tUEO5dO6VrS+idKnocrmkjIRfr3kXETNLD13w==@lists.linux.dev
X-Gm-Message-State: AOJu0YypfMAasqrsOHYeMGabfdjgqaClzZMGXzayAbEHyEKzsMQ6RVjm
	zyhSl07dVwOA3sZWnujCjMptptK0RRH2zRB9s9bdFh4XGZpL7X1ZrRfGHdLWwUuEJ+YoPI5ysE3
	ym8bhpt8wZpPRhXHzdvAjBxpE0TcBhaZZlbEfVqpRCdeWh2+hkkSaXKxvbn4bCIRt
X-Gm-Gg: Acq92OHfOOKNgDydAhsqNVqX6jDtkiGvXDiNbiFHUiDuc3983Edqav9+CTzfDSc8yVp
	TJPrmNHGljlGSp9eIf9BHOJ5m+4zX61NfKk0G5Cclln2+qv/jUd445dKrRp52NYEdRZ3quZnThr
	E9Emjd9NITe5jLjNhopnxO6ubvkXHbITZuyLiB3AlvY4zn1/e4kRmt09gkfFMHiiYeJYxVTfNVx
	yl5CarAp/v9CbmMPTAo5OLImC2CukHAh4KV9mv3AK5I8fenjdspURvJ4SnAzX9M0g45Bb6EEPzh
	elF5YVj2lfln6WMJf0VPTIwxSdeH3xzNzWLh4y4brcNmQQBYXod6a/lJ8lLn8IQSgr/YQvIpm+J
	EHIZkdkXR7K14KJVZzQt1q6g33508XpiuuRPDJ8EIRtAV5J3Xfq/dnWBQ7EydzARJ1KnR
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr7092645e9.15.1780074250062;
        Fri, 29 May 2026 10:04:10 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr7091915e9.15.1780074249508;
        Fri, 29 May 2026 10:04:09 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef358c07bsm4937780f8f.36.2026.05.29.10.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 10:04:09 -0700 (PDT)
Message-ID: <20f8009c-438a-4103-9864-f2648eb6a2f0@redhat.com>
Date: Fri, 29 May 2026 19:04:08 +0200
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
X-Mimecast-MFC-PROC-ID: QuCg31tWcV1it9kL3nUlYYUr3uKpxFQ1tHUPmr7vsCI_1780074250
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


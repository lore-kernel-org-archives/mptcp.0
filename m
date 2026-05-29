Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0E19E96D
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064083; cv=none; b=KX94apDFb3xbtgLbtYpEt8VgD0FJ/B4oROojoI7M9dclcZXFt7UtXL6GbR/dCslKD1YnC2LPsRER04M1eT/vEBT5rbaT4QEk/h8OeMZ5QACx3GOSZkRirPPDbcAEu7j2pzLnJ9/m1HdXR58LCdPH5H0kP7CE/6NzdQe0Hwg3ufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064083; c=relaxed/simple;
	bh=lT3psj+JS2Da4TMq7bRaQhvAdsBoaMnxfe8g4BV0Jpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nMm33hck3q3qWQtyU4oTfF0ujf8T5RgErbY15X3J1uXnGHW4NVkLnUD7LlishvP8E0+HuwxKa3t1p6P27qtm3EfBcGKn6LamxZgCsoJQBrprCU/khmz3hYJ59glv/wfiLedLX/Lloqxknwd3L5+LZeGzqNPrEp18jAx6WF+TKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c10BUXNa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c10BUXNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780064079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3POjkEG9PB1B5roHRQJcL+l8+Bx7dl1NUtiShHsbeM=;
	b=c10BUXNazCaLooGMkKms1xA1JGeatzwAlDmJXQX+pUZmFE+IXEcjlA6mj6HNgswKY/TJG+
	lnzk35vYWwrsBTa3Myp1/xNXORVGNVhqQPtDacGSCqrPyFh9Ax9ax1vaFphvwkAsFwxKzu
	fCu2tYOrx+WpSAGUPn1YmiwYc7TCoDM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-mScCnBSRO1ijzputTUQQ8Q-1; Fri, 29 May 2026 10:14:32 -0400
X-MC-Unique: mScCnBSRO1ijzputTUQQ8Q-1
X-Mimecast-MFC-AGG-ID: mScCnBSRO1ijzputTUQQ8Q_1780064072
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso642160f8f.0
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 07:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064071; x=1780668871;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3POjkEG9PB1B5roHRQJcL+l8+Bx7dl1NUtiShHsbeM=;
        b=seKCcLQGUO0dCfPMi0nRyZHMvYotav3T5CMnOmP+aS8m1W5MIYW6tARUnUVX/qIDCf
         FPTukP4V/je1L4PZNZPO5X5xe1atm2Ekb3idnLoerFUQqjWieUWb9spwABF2BDH4IOFd
         vPbND4R9NboV90maNNWoBvaKvKTxgXamdiitO/BfyVl5I0cGrv6NT3ymGU3S5yWMhIit
         HKPnLOxQiN0wNBq76Cb44wrsxiqUs7l+fRrRok7cBekN8XHv9Y9STEiDgGdfTbQOl9TO
         PFbh9S+zUlGrkRhSmLHd9EGyuBzgOHZos5RQ1sSq4NW+RSYZ/hYdZSYfdwLw5nIEmHwB
         D2fw==
X-Forwarded-Encrypted: i=1; AFNElJ+soNLP9SoMnejyGOvt5bzVt4xsoOJd9dJlyPuzzkS+UqGWO3lwEpKr6qLJx4ODVdGvSeMlpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAMqUi3C4wFku5exFloEBNFnatk95J0iYhiIUHnvcz54LQkcXN
	ib3n6Kxu0hG38dgXqku31jQBXamFtM88taMolHW6JYhpczx8pIhSFtr4btM590Sje7CezYsMRY6
	EE7sOLje9teop16aVLogG5B7EKLaZB86m1v1FyVbm1m0wdTr9DCD8St6+oS7OmL8R
X-Gm-Gg: Acq92OHNojl1/a+TLdEVb3kZJLZm9v/kziz8zha1iTcjrCkB1dOqF8QR1jubxZtko6H
	SqVeD0BWXS07bfTPF306Cqo/i+P/DfLU8+XCUU4ax8LtgxsctvChzqpJnLEryKnFE4NaJkvFWV1
	LSn7ZNVbrrG6iE2VZLdvI56w3eD7+U/DJo7xcbh6+Uq8peQpHj45IeVIRufu+91Tf0NcCKjPF0a
	0M3Gd8VAvm7mxxu9KiiApOLxrMdjGkLdRe6T8EbEULkn/oHGQ9Efjbaj19ClNGqynWOZ9Nmy2ws
	poEXZjxudQgr1RHNE1X7/UnXR+IEizsop/B/2HQ7OKRngoMQSlfh+KnW+C2LVeybNVMiHpZQ+AQ
	y25D2AjkUze+1NmGQNbVqrs4B/PwSdcbJyxknbAs7VDwAQwdz53hWmax1AgGIjTVkzIp3
X-Received: by 2002:a05:600d:8445:20b0:490:3c90:2cda with SMTP id 5b1f17b1804b1-4909c0af5cfmr42210895e9.20.1780064071528;
        Fri, 29 May 2026 07:14:31 -0700 (PDT)
X-Received: by 2002:a05:600d:8445:20b0:490:3c90:2cda with SMTP id 5b1f17b1804b1-4909c0af5cfmr42210565e9.20.1780064071113;
        Fri, 29 May 2026 07:14:31 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909dff2a80sm48923635e9.3.2026.05.29.07.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 07:14:30 -0700 (PDT)
Message-ID: <e90f30c1-59c5-4707-8a95-a5e876d20399@redhat.com>
Date: Fri, 29 May 2026 16:14:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 mptcp-next 3/3] mptcp: let the retrans scheduler do
 its job.
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1780049797.git.pabeni@redhat.com>
 <199d3b27cc1f092a1bca686963103f922d0d27cd.1780049797.git.pabeni@redhat.com>
 <61de072a8e750ec6c7d7228cca6d7d55885e0abf.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <61de072a8e750ec6c7d7228cca6d7d55885e0abf.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rxggm_UB9KWu8toghV_4bfYy25kgoPSqZFIgke4mbJQ_1780064072
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/26 3:27 PM, Geliang Tang wrote:
> On Fri, 2026-05-29 at 12:44 +0200, Paolo Abeni wrote:
>> Currently the MPTCP core enforces that when MPTCP-level retrans timer
>> fires, at most a single dfrag is retransmitted. If some corner-cases
>> it
>> may be necessary retransmit multiple dfrags, and the MPTCP socket
>> will
>> need to wait multiple retrans timeout to accomplish that.
>>
>> Remove the mentioned constraint, allowing to transmit multiple dfrags
>> per
>> retrans period, as long as the scheduler keeps selecting subflows for
>> retransmissions and pending data is available in the rtx queue.
>> The default scheduler will transmit a dfrag per available subflow.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v9 -> v10:
>>   - simpler handling for data-fin rtx
>>
>> v7 -> v8
>>   - fix corner-case retrans_seq update
>>
>> v4 -> v5:
>>   - fixed already_sent update
>>
>> v3 -> v4:
>>   - avoid quadratic behavior, fix retrans_seq update
>>   - fix rtx timer re-schedule miss
>>
>> v2 -> v3:
>>   - fix infinite loop issue (should address tls tests failures)
>>
>> v1 -> v2:
>>   - fix retrans sequence update (sashiko)
>>
>> Note:
>>  - sashiko may see issues when dfrag = mptcp_rtx_head(sk) != NULL and
>>    dfrag->already_sent == 0. That condition should not possible: if
>>    mptcp_rtx_head() is not NULL there should be some data already
>>    sent.
>>  - sashiko may see missing data-fin rtx when the initial `dfrag` is
>>    not NULL. data-fin RTX is NOT needed in such scenario.
>> ---
>>  net/mptcp/protocol.c | 119 +++++++++++++++++++++++++++++++----------
>> --
>>  1 file changed, 87 insertions(+), 32 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 51756800edc2..7fe618e22d1b 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1201,13 +1201,6 @@ static void __mptcp_clean_una_wakeup(struct
>> sock *sk)
>>  	mptcp_write_space(sk);
>>  }
>>  
>> -static void mptcp_clean_una_wakeup(struct sock *sk)
>> -{
>> -	mptcp_data_lock(sk);
>> -	__mptcp_clean_una_wakeup(sk);
>> -	mptcp_data_unlock(sk);
>> -}
>> -
>>  static void mptcp_enter_memory_pressure(struct sock *sk)
>>  {
>>  	struct mptcp_subflow_context *subflow;
>> @@ -2830,8 +2823,12 @@ static void mptcp_check_fastclose(struct
>> mptcp_sock *msk)
>>  	sk_error_report(sk);
>>  }
>>  
>> -/* Retransmit the specified data fragment on all the selected
>> subflows. */
>> -static int __mptcp_push_retrans(struct sock *sk, struct
>> mptcp_data_frag *dfrag)
>> +/*
>> + * Retransmit the specified data fragment on all the selected
>> subflows,
>> + * starting from the specified sequence
>> + */
>> +static int __mptcp_push_retrans(struct sock *sk, struct
>> mptcp_data_frag *dfrag,
>> +				u64 sent_seq)
>>  {
>>  	struct mptcp_sendmsg_info info = { .data_lock_held = true,
>> };
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>> @@ -2841,6 +2838,7 @@ static int __mptcp_push_retrans(struct sock
>> *sk, struct mptcp_data_frag *dfrag)
>>  
>>  	mptcp_for_each_subflow(msk, subflow) {
>>  		if (READ_ONCE(subflow->scheduled)) {
>> +			u16 offset = sent_seq - dfrag->data_seq;
>>  			u16 copied = 0;
>>  
>>  			mptcp_subflow_set_scheduled(subflow, false);
>> @@ -2850,9 +2848,12 @@ static int __mptcp_push_retrans(struct sock
>> *sk, struct mptcp_data_frag *dfrag)
>>  			lock_sock(ssk);
>>  
>>  			/* limit retransmission to the bytes already
>> sent on some subflows */
>> -			info.sent = 0;
>> +			info.sent = offset;
>>  			info.limit = READ_ONCE(msk->csum_enabled) ?
>> dfrag->data_len :
>>  								   
>> dfrag->already_sent;
>> +			DEBUG_NET_WARN_ON_ONCE(!before64(sent_seq,
>> +							 dfrag-
>>> data_seq +
>> +							
>> info.limit));
> 
> Same as I reported in v8 of this patch [1], 

I'm sorry, I missed the previous report. Thanks for persisting :)

> when testing based on v10 I encountered the following error:
> 
> # Starting 4 threads
> [  879.268966][ T4341] ------------[ cut here ]------------
> [  879.269413][ T4341] !before64(sent_seq, dfrag->data_seq +
> info.limit)
> [  879.269417][ T4341] WARNING: net/mptcp/protocol.c:2883 at
> __mptcp_push_retrans+0x562/0x6f0, CPU#18: kworker/18:6H/4341
> [  879.271883][ T4341] Modules linked in: mptcp_diag tcp_diag inet_diag
> sch_netem
> [  879.272450][ T4341] CPU: 18 UID: 0 PID: 4341 Comm: kworker/18:6H Not
> tainted 7.1.0-rc5+ #94 PREEMPT(full) 
> [  879.272813][ T4341] Hardware name: Bochs Bochs, BIOS Bochs
> 01/01/2011
> [  879.273225][ T4341] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> [  879.273527][ T4341] RIP: 0010:__mptcp_push_retrans+0x562/0x6f0

Which test-case produces the above splat? Is the splat deterministic?

Sashiko reported such problem, but I don't see how that can happen
without i.e. an independently generated data corruption as root cause:

info.limit can be 0 only when dfrag->already_sent == 0, and that can
happen only if mptcp_rtx_head(sk) == NULL - if the current rtx head is
not null, the current retransmit head data fragment must have some
unackledged bytes, that is already_sent must be greater than 0.

That incoming ack can touch/modify the RTX queue while __mptcp_retrans()
is running only when __mptcp_clean_una_wakeup() is explicitly invoked,
and the code always check `dfrag` afterwards.

AFAICS if that warning fires, there is some bug elsewhere.

/P


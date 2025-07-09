Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A72877FB
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054936; cv=none; b=euOohoF6gRxQkX0yZBNvozvUkGsdlNoHTwlX2LMB9Z49RSiKkZFBmZ7u157dsfRFiKtW1JnS69NSISJpjBCVvD3sDKnZuBLUcFAKO8QkrUaccSK3mt9qyX9ec2RDd/w92ktj0aSRnPhJ9TFUGz7Az2Sv4pNYmGoCP6VpVTSPv6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054936; c=relaxed/simple;
	bh=YQH6dhf8zivilVjHOwKY3TrnmjwWCPN4PZCl2lX78xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HnW4U6WwkdSFj3hsGAyDiqAUFaoQ4AKH9Je9lg5VcP0cJaMlsDjK2f8ldSbIWuOYN01iIGY6ObZjQAQJoAMhvKtpsNDqIW71j9dDJ/B5RYPMNRUbOJtcdDbHKNM+E1U8jyNiVc1M4r9fOx5li027E5QnmvMiLvSQgS3aPcJA1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRIYx7bI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRIYx7bI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752054932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbUrRyj+APR6M5UNIx7E8ZWfNlwCaRFhwAKYmEjRt3I=;
	b=hRIYx7bIOAbiIY9UHOJrXdIICEO8QbtMk5RFvoyrv/+Egpxn9oz6tcxPLM0NOYg+MnzX9L
	CxLGhf7LY39/QA69kvQ6wI8NjjCDJufV7LR4UEcidsfURT+hP83W9RtmrKuCNQiVb6HvGc
	1Tj3630Hu0B3LPnt768jv/7RQAIixoQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-XVKMUySGO52DNG1pgHxgxg-1; Wed, 09 Jul 2025 05:55:31 -0400
X-MC-Unique: XVKMUySGO52DNG1pgHxgxg-1
X-Mimecast-MFC-AGG-ID: XVKMUySGO52DNG1pgHxgxg_1752054930
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so31557415e9.2
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 02:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054930; x=1752659730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbUrRyj+APR6M5UNIx7E8ZWfNlwCaRFhwAKYmEjRt3I=;
        b=KYzuoq9SjC+wqfVEGvCPlXSwKAKXiS8Lp4BvUPxGB+NluQYHQlLQdwNyKCFe5vOXe2
         z+/ZXXuCqi0WswQ9SBJ/g9FmL+eNpMrmTRPWofG44IIi/4VEggLMzJCWDjymV/Uqc0q+
         n7AU47CbndRGT2D6nyrSPOKyaNrDQVb1WCkSm9uV3J+ARsrEieRtssHkbtv/cSad3n1U
         VwEKzxSuexHVCT4xXCbi6DzHve8OL+aMY/axucezWEkgRUR1KQl7ajrD7CXQ66FlxO/Y
         MWBb61rRTYTFK6gBWxrCsxybfAbfzqmpagrXCct7vSdU3hxw2NJ4mzjZ0MyeN9sODGZ5
         XenQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm5y8jLGvtUKP4yZS40Bs/ctSk3Maku1r8kyqFYaJci0j9VGohZ8yjzaprmDKqdvsokPAIIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH8Bfi+QD941dp5RrR/iyYnYLTujL7uUPInDNt4F0ktDSjQiRQ
	4FCxqDRyh7c6Ug4RyEDPySmELPj53BCozj6fIVpbCaZnL+CEL8Wb4qECUaFQs+80ssTBHp1nfSI
	NVJZS8IL3/izgmza6lH2oJHALX53eoz+h63VSLYuWfJNZdscfYrwI4tzq
X-Gm-Gg: ASbGnctlzWgVwguYgXOpjWs1Uo71s8r044Tg7kvZN1YE/3ZrjMMb65lMh0XfzE8ljKh
	GJ81A2s6t0DG9e9mR1naJf1NoSQZZs40ctmp5HqJc7QLropWCe81w/l027Gp4tHhJcxwgD59BeY
	ihg1XANkc6hIN8/wE3Brp5otK5m0ZR0YTzhTD3t46GfAMmZLAtPHU9f8Vr5BDVlsLc3nq3iZenG
	lCUctdBgLzvdjMALZvlugeO6WTCwErD4R4j4pkGkJzX3mxioaaHg6dmHz8IfgwDn0Og2jgMAu3w
	/HmAIOr12BFxIIpfUqEtYKbFwAFNlK7q4Py2Cld7qy7QKZzyRCJytt1BY/Gp+ln8W9t4Yg==
X-Received: by 2002:a05:6000:4209:b0:3a5:8d9d:27fa with SMTP id ffacd0b85a97d-3b5e448a261mr1078049f8f.3.1752054930328;
        Wed, 09 Jul 2025 02:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcdiiVIy2dqehM1IR2dAm3cA5ykDujJMLoichjPRXPZxfKO59H0IEixvBA/rdGilGEtn9EnA==
X-Received: by 2002:a05:6000:4209:b0:3a5:8d9d:27fa with SMTP id ffacd0b85a97d-3b5e448a261mr1078028f8f.3.1752054929723;
        Wed, 09 Jul 2025 02:55:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50516e3sm17769855e9.15.2025.07.09.02.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:55:29 -0700 (PDT)
Message-ID: <279b70c8-603a-4fda-af5e-30cf4df7ebed@redhat.com>
Date: Wed, 9 Jul 2025 11:55:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 4/5] mptcp: track fallbacks accurately via
 mibs
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <5a78b3e0fc95d2f6356ff4754ec3bdf1dcf6b2cc.1751700000.git.pabeni@redhat.com>
 <a6b76e9d-b84f-428b-b0bc-bc9d9aa782f7@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a6b76e9d-b84f-428b-b0bc-bc9d9aa782f7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uukw9mDYu3EkDs6lzgH7_oTQAX6HnBKa8YvnreKbIsI_1752054930
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 5:56 PM, Matthieu Baerts wrote:
> On 05/07/2025 09:24, Paolo Abeni wrote:
>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>> index 0c24545f0e8d..064f5eaf0595 100644
>> --- a/net/mptcp/mib.c
>> +++ b/net/mptcp/mib.c
>> @@ -80,6 +80,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>  	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
>>  	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
>>  	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
>> +	SNMP_MIB_ITEM("DataFallback", MPTCP_MIB_DATA_FALLBACK),
> 
> Should it not be prefixed MPCapableFallback like others above?
> 
> Maybe: MPCapableFallbackData / MPTCP_MIB_MPCAPABLEDATAFALLBACK?

Fine by me

> 
>> +	SNMP_MIB_ITEM("MD5sumFallback", MPTCP_MIB_MD5SUM_FALLBACK),
> 
> For the name: is it limited to MD5Sum? Or any TCP AO?

To be more accurate should be MD5_SIG_FALLBACK, or just MD5_FALLBACK

> 
>> +	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSS_FALLBACK),
>> +	SNMP_MIB_ITEM("SimultFallback", MPTCP_MIB_SIMULT_FALLBACK),
>> +	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACK_FAILED),
> 
> Do you think it would be worth it to check in the selftests
> (mptcp_join.sh?) if any of these counters are incremented when they
> should not be?

Could be a nice follow-up! (which I don't plan ATM).

>>  	SNMP_MIB_SENTINEL
>>  };
>>  
>> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
>> index 250c6b77977e..99c8788694c3 100644
>> --- a/net/mptcp/mib.h
>> +++ b/net/mptcp/mib.h
>> @@ -81,6 +81,13 @@ enum linux_mptcp_mib_field {
>>  	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
>>  	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
>>  	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
>> +	MPTCP_MIB_DATA_FALLBACK,	/* Missing DSS/MPC+data on first
>> +					 * established packet
>> +					 */
>> +	MPTCP_MIB_MD5SUM_FALLBACK,	/* Conflicting TCP option enabled */
>> +	MPTCP_MIB_DSS_FALLBACK,		/* Bad or missing DSS */
>> +	MPTCP_MIB_SIMULT_FALLBACK,	/* Simultaneous connect */
> 
> Maybe clearer with CONNECT or CONN in the name?
> 
> Maybe: SimultConnectFallback / MPTCP_MIB_SIMULT_CONN_FALLBACK?

Fine by me.

> 
>> +	MPTCP_MIB_FALLBACK_FAILED,	/* Can't fallback due to msk status */
>>  	__MPTCP_MIB_MAX
>>  };
>>  
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 4680d980e605..c9e1f3ec3772 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -978,7 +978,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>  		if (subflow->mp_join)
>>  			goto reset;
>>  		subflow->mp_capable = 0;
>> -		if (mptcp_do_fallback(ssk))
>> +		if (mptcp_do_fallback(ssk, MPTCP_MIB_DATA_FALLBACK))
>>  			goto reset;
>>  		pr_fallback(msk);
>>  		return false;
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 0dc55a17f274..5f99f02c827c 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -67,6 +67,27 @@ static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
>>  	return &inet_stream_ops;
>>  }
>>  
>> +bool __mptcp_do_fallback(struct mptcp_sock *msk, int fb_mib)
>> +{
>> +	struct net *net = sock_net((struct sock *)msk);
>> +
>> +	if (__mptcp_check_fallback(msk))
>> +		return true;
>> +
>> +	spin_lock_bh(&msk->fallback_lock);
>> +	if (!msk->allow_infinite_fallback) {
>> +		__MPTCP_INC_STATS(net, MPTCP_MIB_SIMULT_FALLBACK);
> 
> Is the name OK? To me, a counter with this name should be incremented
> when __mptcp_check_fallback() returns true just above, no?

Typo above should be MPTCP_MIB_FALLBACK_FAILED.

> Here, we now try to do a fallback, but we cannot, a reset is probably
> needed instead, but that's not because we try to do the same fallback in
> parallel, no?
> 
> I guess you wanted to use MPTCP_MIB_FALLBACK_FAILED, no?
> 
> Anyway, even with 'fallback failed', because in the first patch, the
> helper is now also used to check if a fallback can happen. It means that
> here we can be in a "normal" situation where we just want to fallback if
> we can. If not, that's not an error.

Modulo bugs it's either:

- mptcp_do_fallback() returns false and we reset the subflow
- It's an early fallback and mptcp_do_fallback() should not return
false. Corrently the code does not even check for `false` return value
in this case, but we could/should add a WARN.

In any case it's not an error, but it's a fallback failure: the code
path should have caused a fallback, but instead the socket has been
reset. I think we should track the exceptional event with a MIB, and
FALLBACK_FAILED still sounds like a valid name to me.

> In other words, I don't think we can have a generic MIB here. If we do,
> this counter will be incremented in parallel to one linked to a subflow
> reset, e.g. MPTCP_MIB_DSSCORRUPTIONRESET.

AFAICS some reset i.e. in option.c and in subflow_finish_connect() don't
get their own MIB incremented. Even what that happens I think it's good:
having more mibs incremented allow understanding what happened exactly.
Not that there are already other exceptional events where multiple mibs
are incremented (IIRC even in the MPTCP code).

I wonder if (1) this helper
> should not be renamed to avoid such confusion -- see patch 1 -- and if
> (2) another argument should not be passed to increment another counter
> linked to a subflow reset or an abort (MPTCP_MIB_FALLBACK_FAILED can be
> passed if that's not normal). Or maybe clearer to add one new helper to
> do a fallback or a reset + increment the right MIB counter depending on
> the situation? (And another helper to do a fallback if possible, and if
> not, only increment MPTCP_MIB_FALLBACK_FAILED?)

I would not over-complicate the code here. The reset depends on the
caller, having that separate AFAICS makes the code simpler.

I'm ok to rename [__]mptcp_do_fallback() to [__]mptcp_try_fallback(),
but I would not do that in patch 1, for backport's sake.

> (also, detail: why not doing that after the spin_unlock?)

So we don't need to lock/unlock BH again to update the MIB>
  			 */
>> @@ -1424,7 +1423,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>  			WRITE_ONCE(subflow->data_avail, false);
>>  			return false;
>>  		}
>> -
> 
> Maybe better to remove this line in patch 1/5?

Fine by me.

/P


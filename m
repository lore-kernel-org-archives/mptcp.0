Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF9271443
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969009; cv=none; b=PRLD4lVd9Mf4kxd5D4zFyT7q8IkFLeePvqS8xeJFFYdUvOpyxOYlPljui85gT68P3Z2hVxTK9T25LimwlwG1fZpGDCtsrEGHLuDPNKPALbkK2IKTjmF7Qs6t0RCyT0RS/zLLI+i+mJrufy3rXHIlwyD1pxaM7kivus3G/1N0MOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969009; c=relaxed/simple;
	bh=nFE1mVHqzRhOWK279L/SKUnOy2Ov3lQzrqja+W6JOSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1HaIql2XURC4G/qjJUSCJWGJg+IQYGoaToDF7F/KyXsv8eIc0QLr9Ejzu7ohly9AmQ2uTysKwr5zQ/cAiU0X4wPukyN5Z8kNKdubKKCt3LkSjVdXle6NCBLy3E5Ok8BF7vr2S6j7VyNeA0vedKt8y/Q1J5lejHBnaGpQS926do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aI93jCLc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI93jCLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788969007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7Zn/OFO2zbwAV9G4cd03zWGTSa7F4U3l04SAQu/SgI=;
	b=aI93jCLcNv5t1CUsVcgfEHY8WjnUBkNVZi7U4M6LXSMj7FbGbicn8AKuxWZxy3NT3/07t9
	R3BsZ6dm+9W3hQV1Hk8Eg5+mc9lRU9YZg4NOOK/8eTYlQ8crH7QvyIRk097Cg6ICZUp39r
	0fzEc0PhAvtRfelOX0Xzh6/l4FtxmJQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-4iPgKwtpP9WzIyxOwkbyJg-1; Wed, 09 Sep 2026 11:50:05 -0400
X-MC-Unique: 4iPgKwtpP9WzIyxOwkbyJg-1
X-Mimecast-MFC-AGG-ID: 4iPgKwtpP9WzIyxOwkbyJg_1788969005
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd55ee2f7so51562635e9.0
        for <mptcp@lists.linux.dev>; Wed, 09 Sep 2026 08:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969005; x=1789573805;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7Zn/OFO2zbwAV9G4cd03zWGTSa7F4U3l04SAQu/SgI=;
        b=QTqzBMEbeMjEwTYKwC5a/DtyIBjmvPQ2EVbEXYkT6WN2NnW1FAFalSBzot5G4O9aZC
         aYi+qrc8teBkPeP9HLyzxy3oznkJkhlq77nxkzAJFL98p8crxZ24m2yqF5EVNhenOFXX
         Dan498OxTez7zstQMlVtOAlO060lP4SwshSjmj/5bTBu1fkWTuvNAIgPqhx53RzYWnNk
         zbHV3cw6DXyvDRTI8HwvhJ7rSQUBG+yMq2ygxOcuF2MTWTUlQVJ5hxKncRAQh3Ibn2bD
         EjdaoRVzsLqHudSFx1QvgnUAvdweQEqmtIiyK0ZSzvTYjqwoyRgRZfRSj93pm4K7Nz8A
         7B/w==
X-Forwarded-Encrypted: i=1; AKwUvBxB5CHIojb+he60WLKts41DOwm0p+YGLIPOVLm/dVx52sDIazEevodMeHOct/rJ0cmeIhl9Sg==@lists.linux.dev
X-Gm-Message-State: AFuF++mCHz3N513yrepKbxrGg3She6ujlOAjtWGtc+SQe1TJjJT/lO4N
	iSTqcqdZfuUyjavjeYx9lCfnbkUV5L013PWB2eES2Qbk5DotkZdgiTkddEj9aAw4C71UpA/Qo6f
	kJ04PJBWL9mWicbr5p4HHph8aDEtE7JQ0r7NQhya9OPy1udC/7zXfitkU
X-Gm-Gg: AYBFou2T+nQEVS8V3cJLDDhPmu+dsSboeH7LfQHFiHVngbtSGJG4N9fcab/1sO6Alzo
	f94L3MEkU+9iJOgMldFKaENx5VrYC6vwnwVV0zqMPJzw1N6KBGA/VM9sOWfiuCdKyvZSfP0xt/N
	MsSB2RKEgdoZGPBEYsUylM/QG8GzaVnjcR0AS5X6WfGHVQCqqb6oCJV1fTddeA3e9o2dcS55hrv
	/FOApH4ZhdJ/MXABfufNGNhUWI+2xD3iDkxkwVb7mSyDBv/dIsYzhBXp8F35wsFVTzkXt8/9Tme
	kFcSXUpVYt8HBuH7yv+gSArg0YnZr+Pqn8ssX9hKurDH71j/SbpRYKzpqXyJnyYwvl8rhofFJdv
	XRAU9ExShfYEOvY/cQwoabAw5i6FE3wYimMaTtEy/Tl9hx1TR64G0NfkTCHGQbqi28bMWEpG9Hw
	==
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr387804235e9.6.1788969004586;
        Wed, 09 Sep 2026 08:50:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr387803645e9.6.1788969004052;
        Wed, 09 Sep 2026 08:50:04 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm137463835e9.4.2026.09.09.08.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:50:02 -0700 (PDT)
Message-ID: <121f90e5-a19c-4066-af03-8cf5594bb30f@redhat.com>
Date: Wed, 9 Sep 2026 17:50:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 15/15] mptcp: avoid pruning for OoW data
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-15-df1de70348b6@kernel.org>
 <178896537782.219967.1022060629733006428@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178896537782.219967.1022060629733006428@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ePhHJkXW4QuDuz_vB6meY0PSM4yRs_A8ep4hrMlGXY0_1788969005
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 4:49 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] Incomplete realization of the patch's stated principle ("do it
>   only when we expect to accept the skb triggering the cleanup"): after…
> 
> --
> 
> mptcp: avoid pruning for OoW data
> 
> This moves the mptcp_try_rmem_schedule() call in mptcp_data_queue_ofo()
> so that it runs after the out-of-window check instead of before it, which
> avoids running the destructive OoO queue pruning for skbs that are going
> to be dropped as out of window.
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 4309fca6b119..0098e2830931 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -313,12 +313,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>>  	u64 seq, end_seq, max_seq;
>>  	struct sk_buff *skb1;
>>  
>> -	if (!mptcp_try_rmem_schedule(sk, skb)) {
>> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
>> -		mptcp_drop(sk, skb);
>> -		return;
>> -	}
>> -
>>  	seq = MPTCP_SKB_CB(skb)->map_seq;
>>  	end_seq = MPTCP_SKB_CB(skb)->end_seq;
>>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);
>> @@ -335,6 +329,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>>  		return;
>>  	}
>>  
>> +	if (!mptcp_try_rmem_schedule(sk, skb)) {
>> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
>> +		mptcp_drop(sk, skb);
>> +		return;
>> +	}
>> +
> 
> [Severity: Medium]
> The commit message says pruning should be done "only when we expect
> to accept the skb triggering the cleanup".  Does the new placement
> fully match that, given the duplicate-data check still happens later in
> the rbtree walk of mptcp_data_queue_ofo()?

The change suggested here would add quite a bit of complexity for little
gain, and would diverge MPTCP behavior from TCP. We learned the lesson
the hard way we need very good reasons to do the latter. I'm pretty sure
we are better off with the proposed code.

/P


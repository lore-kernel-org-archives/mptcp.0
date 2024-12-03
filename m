Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4713F43A
	for <mptcp@lists.linux.dev>; Tue,  3 Dec 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211631; cv=none; b=T/j9672tR5i+tLj9OZRSm7Z7eOOCcG+6K+cNeqSIJQwsrLH8Vf+YyyBMVsEYIcmiZKHNxXcx9Iz9Xjm5d43foJcd66Kwip+FniXm33mfKxKwD5F5zYSWVx9mQRteemnFIV/1Jbu9VQHXq+oes1wYGCpwwbV6RKWxqZXDcITOwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211631; c=relaxed/simple;
	bh=kF7b5/5hk7eSH7yd5bb52nz8jWWzc8NSmlBjVPhS990=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ia8RdTIjIignMd7vMmh2R51WjVr9f+eVHZMx0pxmQDKObEfZyyL1pjUGAVejwsHcw9u3+2rh57drQ8FVgl2uPOWFMmAHeKMQ6w843TH4Ck9zYg4CvL/mhTXmbuOJLyV29gqa5ycXzt/rE6gdK1h1rUVmqMuTQAbcW244Ara4rxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8veJ9Ly; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8veJ9Ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733211628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mO0RMPYr3gBckMcvYd+1yZ/kjF4eH49nhAT9n8HqpzA=;
	b=L8veJ9LyvwcmLCztjobZ4+QzsrHRXyxaODmRXcXVzFnrSxm62hzZwFM0xO92jrluggbOqi
	asRbbVDx9qxlEirZ5I2WFTEDFQKeH6586d8zpHZeQHbGGi4EjqhFOE5/p4L60EPspSVWU9
	eOUuVZsStNxU9MuVfZbQE/qhHP+d1Dk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-CZoZK7aTO0iH6jym_l4HVQ-1; Tue, 03 Dec 2024 02:40:24 -0500
X-MC-Unique: CZoZK7aTO0iH6jym_l4HVQ-1
X-Mimecast-MFC-AGG-ID: CZoZK7aTO0iH6jym_l4HVQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e9c698e7so1522453f8f.0
        for <mptcp@lists.linux.dev>; Mon, 02 Dec 2024 23:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211623; x=1733816423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mO0RMPYr3gBckMcvYd+1yZ/kjF4eH49nhAT9n8HqpzA=;
        b=wu4JNbCpxRRov17UkyuJ2Z2H5DugO4O/y2Wa7eZWnxXNwQ+DUIquOjIpn2TXE6SfnN
         jO9pycZIKTSEjtKM4k2oHfoPVJ5qFmKceRh1l/4jpeQORLCkqCqvMiTBNvf2d6yNoRQj
         /AKF27nrAuw4aLtmPVFAZIjQj3rSouKbH6vM+riW4ObsLLkaJvGXhjSqsvB3AlwRKp45
         mAGID05lDqpwhoAXYkCA5wUG82ExlPU3yCiYPf+ahKRTxSamKzBkFHA0go84J51QD1lo
         82xROGWA1+C2qwW9lwU1llkRkMfGM7A2h6rsGqcjND3akqBxWaUvlFXs8V5NT3dRqtkl
         /lTg==
X-Forwarded-Encrypted: i=1; AJvYcCU4tEHSK/URsTEvgmWDqGbDyBMegvdJtX0RBLSMi3brOxo3YqoGdwF2D8FmZ+EH/WdZ0939Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9eq85yV/6Q9oDZgB4lkqtHj6guy4PPBqWAhubgRvbXeh7cv9B
	PqogOtVHdFrpINnlfSR/MmAvx1RDUg56OLZpBEafgjpcDWC1bWXvS/F2gVTTHzovlWxqTPt5jkJ
	tDwQwuSNB7ILR8/wnM/Qphqk0M6bZw6V8Lvujowe70VLob+5uHBwG
X-Gm-Gg: ASbGncukCmdSiHdgXxqKEJJ7+3hRXH5llojWCYsD5lcvIcZ2Wr4zFDRVawrH6PaEBNS
	TZvPbZzmBV+fBre6WeClYu2iiFy8keSStW43jTH2IgbYVOpaEUqOBScNBo9f+NZ7DpTtD4efK41
	QGloyqnBQzgTax0rldKX1zycFF1hG27Rf0I7XHfbCFFp4vkTIceMV8X7WJ6gDfbpDCDsoFkj0Fa
	Q/jfc+F1Jpy6m3E4PHfDbHDtZjriXRmdshp8o+AfjZhem0etA4e98LeY37C9BFzpnXUa++LcWNX
X-Received: by 2002:a05:6000:785:b0:385:e2b1:8fa with SMTP id ffacd0b85a97d-385fd9c3017mr1176897f8f.30.1733211623195;
        Mon, 02 Dec 2024 23:40:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFtP3UrwLUD1F7MgJv/x9Gwxf2cZnO82Q5U9sPLrCsI7ne3+dcv/1fzFSgZzr2a4qgjuS7cg==
X-Received: by 2002:a05:6000:785:b0:385:e2b1:8fa with SMTP id ffacd0b85a97d-385fd9c3017mr1176878f8f.30.1733211622857;
        Mon, 02 Dec 2024 23:40:22 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df9ef1d6sm11492956f8f.102.2024.12.02.23.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 23:40:22 -0800 (PST)
Message-ID: <88d69b94-133c-4b5b-a075-2f58d4820419@redhat.com>
Date: Tue, 3 Dec 2024 08:40:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next-next 2/3] mptcp: move the whole rx path under
 msk socket lock protection
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1732902181.git.pabeni@redhat.com>
 <19310c3f96743f3298c029ec5a89b4e4f1ed10b9.1732902181.git.pabeni@redhat.com>
 <ed1926c2-feaa-4e95-966f-e095ae4c445d@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ed1926c2-feaa-4e95-966f-e095ae4c445d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Y6jtbbkta26i37Anom67W76tIePdk6d6KIcquU7I-o_1733211623
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 17:56, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 29/11/2024 18:45, Paolo Abeni wrote:
>> After commit c2e6048fa1cf ("mptcp: fix race in release_cb") it's
>> pretty straight forward move the whole MPTCP rx path under the socket
>> lock leveraging the release_cb.
>>
>> We can drop a bunch of spin_lock pairs in the receive functions, use
>> a single receive queue and invoke __mptcp_move_skbs only when subflows
>> ask for it.
>>
>> This will allow more cleanup in the next patch
> 
> (...)
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index f768aa4473fb..159add48f6d9 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> 
> (...)
> 
>> @@ -2290,9 +2283,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  		}
>>  	}
>>  
>> -	pr_debug("msk=%p rx queue empty=%d:%d copied=%d\n",
>> -		 msk, skb_queue_empty_lockless(&sk->sk_receive_queue),
>> -		 skb_queue_empty(&msk->receive_queue), copied);
>> +	pr_debug("msk=%p rx queue empty=%d copied=%d",
> 
> A small detail: the '\n' at the end is missing: no need to delay the
> output if it is not supposed to be used with a pr_cont().

Thanks! I'll fix in the next revision. I think there is at least a
fixable race in the current code (the one causing the ST failure -
different root cause from
https://github.com/multipath-tcp/mptcp_net-next/issues/483, this is
specific to the refactor).

I hope to be able to share the next version much later today.

Cheers,

Paolo

> 
> (Something we can fix when applying the patches.)
> 
> Cheers,
> Matt


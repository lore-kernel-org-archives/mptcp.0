Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732841F2C2D
	for <mptcp@lists.linux.dev>; Tue, 21 Jan 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469908; cv=none; b=cNv7AaXlckoY11P3U0GVDRY6BKysKRzJ5uMo24TR//l+jI1oAd+YifVBSRSgaIIWITiWzYl9wUaHj6QPonkCs2V5Ku+CaoLo4VO6BKzPjbc5hQmrMWMueYAZgxrqogRtFxmliqWljAeQChDSYE6xOWmJxUGddNmCEuwwfQun6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469908; c=relaxed/simple;
	bh=3tRE2Ua/oYSwvlDRUays5+h5m8lY7U1w1O/mQ3aYjPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDgX7G3f/7lu4BTDBX3V2RcqW2Lf91nuBJnEtSCv7doHaEOdHoO4Z2dM4Qu++FyzSXPgCYnSPlko1FZbmX+lU6hhFsbUB3RNcdF/Yb7ELkpgvQLoa3HUIjZC/mhNdrIg2v3XuDcLg1tJX2KDWaSj5x3xt4ZlgR/z+Eeh4A+ofAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEOhRKju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEOhRKju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737469905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJ4EAIcpqBqbKgluod7SiWToqh4Hf463VR3OZdcsVOA=;
	b=FEOhRKju0TNs8e/MKNNAJbFIv4NKj+nBEHo9fk9RJ2YDB+Mr7hJ9p4bjnvFplegD0Ud8vD
	mEAQTrQpXTk6yrJDR1GDsrykvkywx9IOSoyk7EuFnxHrxKmxEgDMwkkm60Y8qonXeYKCZn
	7Bi2QOW7DsEhTGhub6yePAsl7qYzL2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-eGlvyc02MDa5db0gOabxwQ-1; Tue, 21 Jan 2025 09:31:43 -0500
X-MC-Unique: eGlvyc02MDa5db0gOabxwQ-1
X-Mimecast-MFC-AGG-ID: eGlvyc02MDa5db0gOabxwQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e49efd59so2475035f8f.0
        for <mptcp@lists.linux.dev>; Tue, 21 Jan 2025 06:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469902; x=1738074702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ4EAIcpqBqbKgluod7SiWToqh4Hf463VR3OZdcsVOA=;
        b=jXN5uRh3MuuY5xpPVCKdi2JCb8ndRT2LFnsND2vnLmQcmER+1ax5MxzhqAUg8dUpY9
         HYhDoI6CZmckxJTxtJLBvV7U1z+qMAVKocVvwxMEJojIzeeUWrvc2rBBO9Ece1OLjl6q
         wGn6aNcA53Rv/b55truqx6Sq7kUHblo2PeYJ85ZQ+g+xnaAiy2rinzzzFJh7gt7Jpirn
         CGNv5sZvhA2nQog1lOpEYaSo06EJA8mH9YgXZ3WeS4Rng02H9AhOxuD0zFvE24h4wCjx
         nNlylJ0wxKlle+Jtm9MhSKuF217h1eP+E6V7+EJBUl29oJS0kql4D7f0gRaTcAv1PkDs
         dV9A==
X-Gm-Message-State: AOJu0Yyv2TQ+wUbwJhae27iGVd8rKsHuDSGt179/zIYWKP0gtFrTQhBV
	41bXxBdqZCmVeETogEGsH6WpdmzOZ7wC/eRDd4dERx8DZvnY4ip0e5QATlZwNQCy2BPohSBxbXa
	xTsAUP9TJ2z+E9xuK0ppS1MIHB0Kp3kHuid2IBFzhI+FsqwxrWiiyJd4XsSTn
X-Gm-Gg: ASbGncv3O2mpGaYi6BWt12m44kgjGIKMO2R6U4b18TYoJJaq1/58+zgnZrtl5aQt+cy
	wMXs8K87pKE9HzjPtU80qHtdraeVB0ss8dWHBGnrTc31ACV31idUnAhNT83V8Dv4G8fRXtLN/KT
	TTTzdXluVzvKsWwPtsY/rXoWpOG3YRAkYUXCefxSubeWufjxjIOYBk4yCX3GIKc1+yStVMfQg/T
	pYywKs4OtIBAOtd9w+68CdunaIJ8Fyk6ciPRXwY4X9+ynOGNeAQpzIpqb/rIRnRYh7BXR8rkLzr
	EOKUufLkviBOMS5hZtLTah7w
X-Received: by 2002:a5d:5f51:0:b0:38a:624b:e619 with SMTP id ffacd0b85a97d-38bf59e2019mr19144648f8f.43.1737469900807;
        Tue, 21 Jan 2025 06:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWH1yeGQh5C8KC0IfrA/cBlUgcCbzSCVpEGWZP74LDGXcEglD21hYUvzG2yhJ2A6NDsp1bXA==
X-Received: by 2002:a5d:5f51:0:b0:38a:624b:e619 with SMTP id ffacd0b85a97d-38bf59e2019mr19144426f8f.43.1737469898918;
        Tue, 21 Jan 2025 06:31:38 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32754dcsm13632610f8f.77.2025.01.21.06.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 06:31:38 -0800 (PST)
Message-ID: <28a55bdd-a362-49ad-a63a-e0e9367e47fc@redhat.com>
Date: Tue, 21 Jan 2025 15:31:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <e96b1f70660ffd750c09c051991e2b65a7d1b492.1737398231.git.pabeni@redhat.com>
 <58a57216-3bc9-4ca5-9b08-70e85e9135ec@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <58a57216-3bc9-4ca5-9b08-70e85e9135ec@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ocfk74Q4rYmlvpH0WpE6ejuD1e_yWYylRFILHiX9oJ8_1737469903
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 12:55 PM, Matthieu Baerts wrote:
> On 20/01/2025 19:39, Paolo Abeni wrote:
>> When we will move the whole RX path under the msk socket lock, updating
>> the already queued skb for passive fastopen socket at 3rd ack time will
>> be extremely painful and race prone
>>
>> The map_seq for already enqueued skbs is used only to allow correct
>> coalescing with later data; preventing collapsing to the first skb of
>> a fastopen connect we can completely remove the
>> __mptcp_fastopen_gen_msk_ackseq() helper.
> 
> Thank you for having looked at that!
> 
> It looks good to me, just one question below.
> 
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/539
>>
>> Must be applied just before commit:
>>  "mptcp: move the whole rx path under msk socket lock protection"
>>
>> To such extent, the patch will require a little mangling, as
>> __mptcp_fastopen_gen_msk_ackseq() at that history point still lacks
>> the
>> 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
>> annotation.
>>
>> I preferred such option to a cleanly applying patch for the target
>> place in the repo log to trigger the CI at submission time.
> 
> I prefer that too, for the same reason, and also because it often feels
> easier for me to resolve conflicts when I have the end results.
> 
>> Optimistically sharing this only with very little testing, to distract
>> myself from the net-next PR burden.
> 
> :)
> 
> It looks like the queue is progressing well :)
> 
> (...)
> 
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index b1ece280e139..2c1232bfd722 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -130,7 +130,8 @@ struct mptcp_skb_cb {
>>  	u64 map_seq;
>>  	u64 end_seq;
>>  	u32 offset;
>> -	u8  has_rxtstamp:1;
>> +	u8  has_rxtstamp;
>> +	u8  cant_coalesce;
> 
> Out of curiosity: while do you prefer to use a "full" u8, instead of one
> bit in the previous u8, or a bool? Is it a small optimisation because
> this new item is used in the fast path? We have free space there, so
> that's fine, but just wondering :)

This is a minor optimization vs bitfield usage, I should have mentioned it.

With this patch, the 'cant_coalesce' field will be tested in fast path
frequently - almost on every packet.

Testing a bitfield generates worse code - the CPU has to mask out the
unrelevant bits. With u8 (or a bool) the CPU can load directly the
relevant byte with a single operation. In a similar way, single byte
store operations are faster.

Both u8 or bool could achieve the above. I preferred u8 because 'it was
already there'.

/P


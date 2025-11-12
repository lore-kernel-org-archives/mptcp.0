Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4826CE04
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939494; cv=none; b=Utci1efP4jyaD38vxUqzunhGSlTwoDe3DmcS1vt2TIuHDA/SaytHfLnYssSJ4oTK2lnUUheOY23ryJCYXJbaUFXFTO4XUN8+/FzqeTO1nqu8YD1TmaojruEePhUoQIamaaG5srRYEd9C7IxIRB+evNIPfRPaoLEO0WiCRDUo+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939494; c=relaxed/simple;
	bh=ch4oymKcwAX9NImwasbCsc3lLH0Zwf9a+R++/33qbXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SZd/nJu0q66fq9H8OmJtL9gLXJojcHftbzeUs0AZlXQzeGrDsrVigGS9MkSTyxdFh93n3cu4gTN5Yflwt0IzMaN1OfimqQJjuei7n2Rf0UnTlp8JfypCdZwoy8RJtz+gh67/bKLbNWCyYD9mwPkfy0ow3OvPQlAsgBEVhgYlI/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aS4eQq/d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS4eQq/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762939491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeIj7fQbaSDxpalvkrGZka3QFs1HIou4eusHhqz4eEY=;
	b=aS4eQq/dyzLd2dKsMbAHyborgQOl43FwrYVOu0Yza1Eewa6gZAuTm4E3cTjDAneoIAj9Ck
	eUXDgq0sK32sDQ3sHeYma3Q1/QOu24RGHGKQBxw9Hf221zieTw9wIHzEvvkws4FEwf0j1r
	OsiapIM4oS6cuArx47uz+NSm/65lnTM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-uykaFUEkM2KNnfD54GnEng-1; Wed, 12 Nov 2025 04:24:50 -0500
X-MC-Unique: uykaFUEkM2KNnfD54GnEng-1
X-Mimecast-MFC-AGG-ID: uykaFUEkM2KNnfD54GnEng_1762939489
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563a0c75so3880715e9.1
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 01:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939488; x=1763544288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeIj7fQbaSDxpalvkrGZka3QFs1HIou4eusHhqz4eEY=;
        b=GgKcmE26PWojUk4EwKYYFUoSuBur82mIVfy9D2vBrpw/79N/FDKAzUoLNo/vdVz5w4
         BYOlKed1tCtw8s/xXM99CCOmlVesj8ydomZwDzIR4q/SSIRv4RDmvl2omHbcTIJZzIYU
         xWUDUlVSJwj4PsjAkLriX/KFu7VeEFA5Hm05Zuv67uJNULX9VxOzfcOdFZg3djhU2iQ9
         x7AwzKdBHSy3xaZ2ibK8PzorcTcdHrn4eGkHXbKgZyqcQSxdglc3RJukPaOlBdPv8IKg
         XJaPE4ZO1wlyGWSci0mmma2cn8OZTIf5KTCXEkdlor+Ha9dsSMFmz/TQ5K75jfV9XPZb
         nUCg==
X-Forwarded-Encrypted: i=1; AJvYcCWS/OvnXKVSBGhJT79WeG+gbpqCeYpMO1DgAz2oWPEqPXCOO18IykMiUlvgf4E93vZ6/EfoYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1shqx0uFnkP+6A7vpBoKtutqNDhvNgxWybN98H+nwPT5YCF50
	v9on6bIX3NtLJEzqTcz6Vb+HgsyDFWNzYv5y+fqMkTlOV5ugxgsCB3S/agpAaPZPbygjfIrAy4F
	D4w3PWgRtHAuwDXUPBzfkNLA58TC40FH6SUzELHljDv0GQNBXuwwkl3J8qmA1Ayrr
X-Gm-Gg: ASbGnctdkWMCiWMZIXwi6ZKDEIr+O/sB40RnE4m1VGe0ZCHymKAUhGoVoPUGwmlmcDb
	8ENMLy94fc+r6jmNPxxYHPezgb/BW51vge91wke/R2KkC535VZ0V+sOUbWPnwYu93JbbkGQM5Mx
	riWZZoVTq8cOs44CgkG2EDpS9JYs304wkJR5pA1PHwVI0tJwf2LPULXRrRhjOl1y75MaPqTJhKg
	kJlf3olp9kmyS7a79K1Ziie09LP0+d0JDqrKIWO3ENwEFcTVUdKlixx6REyd+RKCq96bm1l7WXT
	4lmkprj62+fK4tGRA3yQ6ZAKJG3ebC7uwavxc+kxke21p08gYRAPHjLwVPbphZOhJzilUmAUAHH
	E3w==
X-Received: by 2002:a05:600c:4752:b0:477:942:7521 with SMTP id 5b1f17b1804b1-4778707ca14mr17266595e9.14.1762939488239;
        Wed, 12 Nov 2025 01:24:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQyVq6IQd8i5ohv0e2VCC7t5cMwPaVJOyoOx871V7Us5Q2sVbNvvish7iT3bwrACrCXrQTkg==
X-Received: by 2002:a05:600c:4752:b0:477:942:7521 with SMTP id 5b1f17b1804b1-4778707ca14mr17266435e9.14.1762939487770;
        Wed, 12 Nov 2025 01:24:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e798sm25290675e9.10.2025.11.12.01.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:24:47 -0800 (PST)
Message-ID: <27e7304b-d485-4e01-bd47-a169c5b25849@redhat.com>
Date: Wed, 12 Nov 2025 10:24:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-next] Squash-to: "mptcp: leverage the backlog for
 RX packet processing"
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Geliang Tang <geliang@kernel.org>
References: <ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
 <704b4358-30b2-4065-abbb-752f4f9a3c79@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <704b4358-30b2-4065-abbb-752f4f9a3c79@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5vN3bhTvmGdNfeplWblRcNhph7RfuIaChIq3pQcZ9qU_1762939489
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 5:21 PM, Matthieu Baerts wrote:
> On 09/11/2025 14:53, Paolo Abeni wrote:
>> If a subflow receives data before gaining the memcg while the msk
>> socket lock is held at accept time, or the PM locks the msk socket
>> while still unaccepted and subflows push data to it at the same time,
>> the mptcp_graph_subflows() can complete with a non empty backlog.
>>
>> The msk will try to borrow such memory, but (some) of the skbs there
>> where not memcg charged. When the msk finally will return such accounted
>> memory, we should hit the same splat of #597.
>> [even if so far I was unable to replicate this scenario]
>>
>> This patch tries to address such potential issue by:
>> - preventing the subflow from queuing data into the backlog after
>>   gaining the memcg. This ensure that at the end of the look all the
>>   skbs in the backlog (if any) are _not_ memory accounted.
>> - mem charge the backlog to msk
>> - 'restart' the subflow and spool any data waiting there.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 46 ++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 5e9325c7ea9c..d6b08e1de358 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -4082,10 +4082,12 @@ static void mptcp_graph_subflows(struct sock *sk)
>>  {
>>  	struct mptcp_subflow_context *subflow;
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	struct sock *ssk;
>> +	int old_amt, amt;
>> +	bool slow;
>>  
>>  	mptcp_for_each_subflow(msk, subflow) {
>> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> -		bool slow;
>> +		ssk = mptcp_subflow_tcp_sock(subflow);
>>  
>>  		slow = lock_sock_fast(ssk);
>>  
>> @@ -4095,8 +4097,48 @@ static void mptcp_graph_subflows(struct sock *sk)
>>  		if (!ssk->sk_socket)
>>  			mptcp_sock_graft(ssk, sk->sk_socket);
>>  
>> +		if (!mem_cgroup_from_sk(sk))
> 
> Should we not call mem_cgroup_sk_enabled() instead? It does this:
> 
>   return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
> 
> That's what is done in net/core/sock.c and net/ipv4/tcp_output.c. Not in
> __inet_accept(), because mem_cgroup_sockets_enabled() is checked before.
> Maybe we should do the same here?
> 
> (Note that it is not clear to me if mem_cgroup can be enabled later on,
> and if yes, what should be done with existing connections.)

It's just an additional optimization, to leverage static branch, but
it's not strictly needed. Can be added, thus.

>> +			goto unlock;
>> +
>>  		__mptcp_inherit_cgrp_data(sk, ssk);
>>  		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
>> +
>> +		/* Prevent subflows from queueing data into the backlog
>> +		 * as soon as cg is set; note that we can't race
>> +		 * with __mptcp_close_ssk setting this bit for a really
>> +		 * closing socket, because we hold the msk socket lock here.
>> +		 */
>> +		subflow->closing = 1;
>> +
>> +unlock:
>> +		unlock_sock_fast(ssk, slow);
>> +	}
>> +
>> +	if (!mem_cgroup_from_sk(sk))
> 
> Same here?
> 
>> +		return;
>> +
>> +	/* Charge the bl memory, note that __sk_charge accounted for
>> +	 * fwd memory and rmem only
>> +	 */
>> +	mptcp_data_lock(sk);
>> +	old_amt = sk_mem_pages(sk->sk_forward_alloc +
>> +			       atomic_read(&sk->sk_rmem_alloc));
>> +	amt = sk_mem_pages(msk->backlog_len + sk->sk_forward_alloc +
>> +		     atomic_read(&sk->sk_rmem_alloc));
> 
> (Same as Geliang for the alignment here, and eventually calling
> kmem_cache_charge() like in __inet_accept())

This and the next are the more obscure point. I chose to not call
kmem_cache_charge() because I'm (was) a bit doubtful about such call
being legit in __inet_accept(): active (plain TCP) sockets are not
accounted, just passive ones. Re-thinking about it I guess it's better
to be consistent with TCP than trying to be smarted (history has proved
it does not work so well :-P)

TL;DR: I'll add the missing kmem_cache_charge();
>> +	amt -= old_amt;
>> +	if (amt)
>> +		mem_cgroup_sk_charge(sk, amt, GFP_ATOMIC | __GFP_NOFAIL);
> 
> Just to be sure: no need to check if there was an error? It is not done
> in __inet_accept() either, so I guess no?

The __GFP_NOFAIL flag ensures that the call can not fail. Adding it with
GFP_ATOMIC is at least "original" (this is the only call site with this
flags combo). In the next version I'll move the call outside the
spinlock (we are still under the msk socket lock) to replace GFP_ATOMIC
with GFP_KERNEL.

Many thanks for all the review effort!

/P


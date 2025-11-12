Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AAA2BE02C
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938252; cv=none; b=bT/ET2gvcQLa5pTuM/cZY88dvVfxwN3okw9W45JLWVQfuI6/5e3mPHgc85o6mDM9n3dHPn3+Qo7M7OtEpVPYcDZssGO+nKrb+WdpOLFMvJZedGbfL9P5cSbSg/OdIOycbeQbeTzDJSGb/t3OrXDiUUsJc7an5SZ3UVVfKaP+CUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938252; c=relaxed/simple;
	bh=hb8hZV1AA01UDlVlPtYJOq4OaffjK80xvjhOyFL6Rvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLHNXxw9l+jmRAqnWhBn0Sa3Uu4QyTBtecuLwbEbXHIJTdqUqyd5zvt3XVc3xYRDIxCRwioe9JHXL1P96/nd8k7xkWqLKVMKcLV+25kScoPPdugBhdvB02Yz3YQE5BtKe/WyrRGjcei3U2eyJDI7fVj4RApq332Ed9xBT5yv9RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlHfElrX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlHfElrX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762938249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gda5iOuOIn6Pzr7a0PSLjHHBQrcdGlNbGIDrvFTVg+U=;
	b=LlHfElrXmZnf1M5g++Z9ppWrBM14xNirm/Fp6PlFiHqUhM1JLlh4g68EC2b1btM/bChsjV
	eUgPj2LeWAigv3c/CEZ4PGXRO5a+6FOzOnUAFNr10V510v0VgfN0l0InemXtlPikgXiIMx
	gRXmmOLk+3ZOhV0QqCcaWg6DoK5n2jw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-kHP8Ith7OY6UFpQ6F2wsoA-1; Wed, 12 Nov 2025 04:04:07 -0500
X-MC-Unique: kHP8Ith7OY6UFpQ6F2wsoA-1
X-Mimecast-MFC-AGG-ID: kHP8Ith7OY6UFpQ6F2wsoA_1762938246
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b4961ec4eso293864f8f.3
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 01:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938246; x=1763543046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gda5iOuOIn6Pzr7a0PSLjHHBQrcdGlNbGIDrvFTVg+U=;
        b=ZlpDvdUK6ujQmJWnHrHydaLCCU5t5VqI6SPcv0Z1yl5/O/SDpzYLD3/jSkgTMAiSW3
         +u5oHq9azThCqKmCpQcI5rmEoKdbmJf4zsvrcNiQGhKxYYIugShnUyBtG0ZVblQb7BU+
         knYQKEWAo7bxhzz+Iz4MdMmcYr0LmQrzAHgOi8ILHftIuP0aSQ3nup3YsGQRiCPjWqcH
         f8l0u3MI5As+Z9TCXZALppp0jWpimuDW4XkFxE3U9xVT161sZVVBhxcRFkqQyveDPMeF
         7mA8V1VrFy7VcgaYccdp4UnAEaQ/aHMrnYCDbcIvqv6gi5mAGCCLXKpl8Pi/uPrVH4/T
         MQDQ==
X-Gm-Message-State: AOJu0Yzov5KF/owGg1KpTiBpQu4BhRAUhtAX7Qkrc0sFDEfummZATjiH
	L5fEh4m9nBvpiTxg++VGB0yryclKLDL8Kn5tB7vNH4x9VC5tmTv0/QDRdSdcJmkBKIGqphSXvHR
	1SDboA10KpD5jyOgabKd3+Mp7QkeEaJdZ9PtVS1dEtjAvPInmQwwSvnf1l+7pNFjt
X-Gm-Gg: ASbGncsBKNCmgOoq25JmgwPeew9I2ftt6awZpBCcLhMkKmMhwejGL+X4GXc/R2jvQ3o
	c4IZoSWrau0YQ2guu8XXxKRql36lTlIIK5Kk56kUREz9VO2gztosYkF8KQGNItREP63FIY3cJYi
	eeBRcka0jCMazcDMFfy3F+HaXX6vOFnBRLAJ2X/iNrbcbrXC8YdKVt1zfLtXjFuH5K2xgfkyY7N
	hgAMRmtyFhm87B459gfwdiQKUd76k+sYu/gk21nXESoBx0dgW6FScJKO2xG2PlrKI18A8Ioumki
	buhxSL7uy27aMZNqi6UjvvJ6UDeE2QKkuxW6KF5BfNxRZ9cnnb3wgl1P3WDsgY+ACKbHLLE/+Q9
	EfA==
X-Received: by 2002:a05:600c:1e8b:b0:477:7a63:611f with SMTP id 5b1f17b1804b1-477871e6b0emr18680045e9.36.1762938245980;
        Wed, 12 Nov 2025 01:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx5EF12wpJkyJOGqlUt4x+bvzTdW6bW+2nAwxyhdIgqAiwLgsEn3Bm7B76Bsp8yhvSom7NCA==
X-Received: by 2002:a05:600c:1e8b:b0:477:7a63:611f with SMTP id 5b1f17b1804b1-477871e6b0emr18679805e9.36.1762938245535;
        Wed, 12 Nov 2025 01:04:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e58bf8sm23830285e9.11.2025.11.12.01.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:04:04 -0800 (PST)
Message-ID: <63928360-2947-49d7-8e8e-9f83745f3556@redhat.com>
Date: Wed, 12 Nov 2025 10:04:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 1/3] net: factor-out _sk_charge() helper
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1762551942.git.pabeni@redhat.com>
 <063e2bc8e98ce050286eb4309bf4bd47716cc3f8.1762551942.git.pabeni@redhat.com>
 <a2449ccf-69a5-4503-a687-074b4436223a@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a2449ccf-69a5-4503-a687-074b4436223a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K4wTv40ukq5eTJ3Fjd8b7mkksCcs-wcOxDplAtnjrNA_1762938246
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/11/25 6:38 PM, Matthieu Baerts wrote:
> On 07/11/2025 22:55, Paolo Abeni wrote:
>> Move out of __inet_accept() the code dealing charging newly
>> accepted socket to memcg. MPTCP will soon use it to on a per
>> subflow basis, in different contexts.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  include/net/sock.h |  2 ++
>>  net/core/sock.c    | 18 ++++++++++++++++++
>>  net/ipv4/af_inet.c | 17 +----------------
>>  3 files changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index a5f36ea9d46f..38d48cfe0741 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -1631,6 +1631,8 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
>>  	sk_mem_reclaim(sk);
>>  }
>>  
>> +void __sk_charge(struct sock *sk, gfp_t gfp);
>> +
>>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>>  static inline void sk_owner_set(struct sock *sk, struct module *owner)
>>  {
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 3b74fc71f51c..b26a6cdc9bcd 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3448,6 +3448,24 @@ void __sk_mem_reclaim(struct sock *sk, int amount)
>>  }
>>  EXPORT_SYMBOL(__sk_mem_reclaim);
>>  
>> +void __sk_charge(struct sock *sk, gfp_t gfp)
>> +{
>> +	int amt;
>> +
>> +	gfp |= __GFP_NOFAIL;
>> +	if (mem_cgroup_from_sk(sk)) {
>> +		/* The socket has not been accepted yet, no need
>> +		 * to look at newsk->sk_wmem_queued.
>> +		 */
>> +		amt = sk_mem_pages(sk->sk_forward_alloc +
>> +				   atomic_read(&sk->sk_rmem_alloc));
>> +		if (amt)
>> +			mem_cgroup_sk_charge(sk, amt, gfp);
>> +	}
>> +
>> +	kmem_cache_charge(sk, gfp);
>> +}
>> +
>>  int sk_set_peek_off(struct sock *sk, int val)
>>  {
>>  	WRITE_ONCE(sk->sk_peek_off, val);
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index a31b94ce8968..08d811f11896 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -756,23 +756,8 @@ EXPORT_SYMBOL(inet_stream_connect);
>>  void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
>>  {
>>  	if (mem_cgroup_sockets_enabled) {
>> -		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
>> -
>>  		mem_cgroup_sk_alloc(newsk);
>> -
>> -		if (mem_cgroup_from_sk(newsk)) {
>> -			int amt;
>> -
>> -			/* The socket has not been accepted yet, no need
>> -			 * to look at newsk->sk_wmem_queued.
>> -			 */
>> -			amt = sk_mem_pages(newsk->sk_forward_alloc +
>> -					   atomic_read(&newsk->sk_rmem_alloc));
>> -			if (amt)
>> -				mem_cgroup_sk_charge(newsk, amt, gfp);
>> -		}
>> -
>> -		kmem_cache_charge(newsk, gfp);
> 
> Mmh, this code has been moved from inet_csk_accept() to __inet_accept()
> in net-next only, see commit 4a997d49d92a ("tcp: Save lock_sock() for
> memcg in inet_csk_accept()."):
> 
>   https://lore.kernel.org/20251014235604.3057003-2-kuniyu@google.com

Right you are!
> Should we only apply these patches in our export branch, for net-next?
> If yes, then I guess we should remove the Fixes tag in patch 3/3.
Technically is a fix. Even prior to the backlog introduction bad thing
could happen, as passive msk does not have memory by the subflow only
accounted.

TCP-level OoO could potentially use a lot of system memory that will not
be memaccounted.

Unfortunately it's not easy to have a clean net patch.

I suppose with can have this as net-next fixes (including the fixes tag
in 3/3) as the change is invasive and the thing is broken since the
beginning.

WDYT?

/P


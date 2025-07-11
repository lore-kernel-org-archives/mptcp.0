Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA71F03C9
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218770; cv=none; b=r3R7O3EV5DnOOKnmCxRjBGyI1hXquBkDrRed7xXrDvNrCQnubPeL269wmY85TgMza39THXYG55VwYEWCVWUpaTlHfisHGENLXjx6jJA+KOsJ6vknElSBCZWd8ZduPZisz/lNMVuRj9piQUkEgpg7qRTmQHA/kV0gPIcxns2yoZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218770; c=relaxed/simple;
	bh=279bhRqqVtcLOwJ+FrJaAFMENV3wZcNwCxWeXm7ZVUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ICKzEcFcBznh/Er8MYI08GlUG3X9kdCM+eVk8bk4xy8bMpoGb3PcPDLqq47CE+7r1olljN2JyC9LXzwC007J8MXSfnBf4M4AeiTnjGiFXZAJcq6+QPsZhORVKdsp0Hz+Oq5u5YyT8b1WaM4Ku4t8Ut8R/I54hOC67n6mEXy9FIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4mQVRZ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4mQVRZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752218767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5socG8ca5yB0H5lTQ7HaZ7PTgB6Ve5kKAzhxqQ48O0=;
	b=b4mQVRZ0e68PuY9MFTp4syQs+gSRzUmFR8xyt/EejpFyWvoR0wSY4c60Qeebv1YT+hsACr
	C2ZjZVXkJAaFubr4KdpRmO+zNn7sS7221xekNYaDm6dmIHGO6pFljobxtuWUhghOPyS7Dw
	6I5lJzPfp+g5fOPGO4GHXxsuLV/k6Yw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-vCtHL5KLMvW4IlpYv9HNDw-1; Fri, 11 Jul 2025 03:26:06 -0400
X-MC-Unique: vCtHL5KLMvW4IlpYv9HNDw-1
X-Mimecast-MFC-AGG-ID: vCtHL5KLMvW4IlpYv9HNDw_1752218765
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d5600a54so13970265e9.2
        for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 00:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218765; x=1752823565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5socG8ca5yB0H5lTQ7HaZ7PTgB6Ve5kKAzhxqQ48O0=;
        b=kten1XzY9rweytuBQoLwm1cJvj32VCPVXIn4WV4ZPBwy0MX60dsWA73tjv8y2rnX4C
         RU+tbuZaO/4vq45aXN5D2pnS3A0E6vhurmMZUPBV7rvIGiC0tEHxUUMYdKNc115crLUu
         ETkJ60eSUETFR+OnYbyXgTjS/Sf43mZiTpnjy7YlJ9/iGoA1PKoxqs1dvnGhbI7ufTdC
         5KSmBa680s/C69eB8yJAGUWk6cr+Rz/AAFAkxSP8DS2WNy5eFZTXlZZyEPOxyNHBnWXb
         /bEPGIFUKg/GQ/GByGNpp9d4GAFgOjKonmwnT3NVJvMseJtYMBBPnYVZWbIr6PLI3AnD
         OcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6LfJR+cmqgt4k3suzpHE37QxhcPJWoURF5V51evCiaLBNMb7bn09coyprRnPuggyPTbtnKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtMnSu/QAlhA339NbJoGGa4CGV4DarrtSovPvfuwQhqgiXfez4
	qhD5uZEkAYbHDgAk7xlZWmqwDjKA3ekCuO0WW4LxVjHV21qlGsjqIZoU+Cxi8/SFvTNIYcQ4Yen
	fbEEWwBpfoz9txHMqZUL0zfTj3rbxUiqocMqM/PyNzd9L2+A49u4w/PvmkqXJmlC3
X-Gm-Gg: ASbGncvW3dRY136R+64XDiHGvIdfaM3CFUIFtOchX73d1O+FWXc3/JdyFEUEuGzzOkq
	hz/CU4dnCLAuRtWHaLRZ4WTsYzsTYSBTfWK2gPjQHgDc+tavKqU/nYXl7nxShmj+ERwHZxMeLuP
	6MXq116jB82u9uCxtV7t984qPtHKtktq0tAcF7ssVs0SKfdJ6R/I4wU0q7yiWyAVzrJJNGHi1WW
	P0Nu5sQc+oa2VANmPqP/tBrZlvtQ4eF1xMlERRr0nTr8k2hkCcO7Ur0hIhG3B2Vd1mhsQR0nG2m
	2sb8zOz1pDrt/7SFnD92wWO4MEfmgykbZwegzYRznRKy3BdaVSTzq7TkV2FRgC4i9geezMHdUJ8
	889l/djpYwpk=
X-Received: by 2002:a05:600c:3514:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-454ec276a0emr19712895e9.17.1752218764760;
        Fri, 11 Jul 2025 00:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDj6hcPZjoitfGZsgoqN5OQh6H1O81lTkjoGbTW9r2WcSFrqm6jbJnIsIpEuZ3w2xFlqKbWw==
X-Received: by 2002:a05:600c:3514:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-454ec276a0emr19712525e9.17.1752218764247;
        Fri, 11 Jul 2025 00:26:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2716:4b10:9b16:cae0:6065:2782? ([2a0d:3344:2716:4b10:9b16:cae0:6065:2782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d512c2bfsm76672445e9.39.2025.07.11.00.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 00:26:03 -0700 (PDT)
Message-ID: <50effbb4-ac41-495a-95e0-9962cd97638e@redhat.com>
Date: Fri, 11 Jul 2025 09:26:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-net 1/5] mptcp: make fallback action and fallback
 decision atomic
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1752073685.git.pabeni@redhat.com>
 <2cc6457002f97221dd59b49841efc2816dcc1617.1752073685.git.pabeni@redhat.com>
 <bab09d84-a327-449d-95df-882a7bedf3f8@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bab09d84-a327-449d-95df-882a7bedf3f8@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _STchFQBkHIBO9wR-1VpUbOsj6DbwQXNOzGW7PzRaZk_1752218765
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 7:41 PM, Matthieu Baerts wrote:
> On 09/07/2025 17:12, Paolo Abeni wrote:
 @@ -803,6 +802,14 @@ static bool __mptcp_finish_join(struct mptcp_sock
*msk, struct sock *ssk)
>>  	if (sk->sk_state != TCP_ESTABLISHED)
>>  		return false;
>>  
>> +	spin_lock_bh(&msk->fallback_lock);
>> +	if (__mptcp_check_fallback(msk)) {
>> +		spin_unlock_bh(&msk->fallback_lock);
>> +		return false;
>> +	}
>> +	mptcp_subflow_joined(msk, ssk);
>> +	spin_unlock_bh(&msk->fallback_lock);
> 
> (just to be sure, do you prefer to explicitly have the lock and fallback
> check here and in mptcp_finish_join, and not in mptcp_subflow_joined?)

Moving the check into mptcp_subflow_joined would need to change such
helper return value (void -> bool), and likely changing the name (as the
join could still fail there). Overall more code delta, with IMHO unclear
gain.

>> @@ -2543,9 +2553,9 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>>  
>>  static void __mptcp_retrans(struct sock *sk)
>>  {
>> +	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
> 
> (You might have missed my comment in the v2, or I missed your reply)
> 
> Is this modification needed? I might have missed something (or used
> later?), but it looks like this 'data_lock_held' is not used here or in
> mptcp_sendmsg_frag(). Then no need to set it to true, no?

Sorry, I forgot to reply. This code chunk is needed to make
mptcp_alloc_tx_skb() - in mptcp_sendmsg_frag() - atomic. After this
patch the mptcp_sendmsg_frag() call in __mptcp_retrans indeed happens in
atomic scope and the memory allocation there can't be blocking.

/P


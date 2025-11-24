Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEEC1D5154
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763972498; cv=none; b=ghgu0Z6d24pClkScERzO1HH/wSCWwOeDBcZJfbjqreS+ixBqE52KQqDOldxaT7ptGFCZL54xstlqp8Kh7Z64PXAsLRRAW1fBbe/uO+1aHWLMWBk84k7jXIFKcKxpZVqYgN0tBvJwRT4Bhy4A6EpIh7RLV70zaMUlyMv6CIHMCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763972498; c=relaxed/simple;
	bh=Fjm2oVCIMqH91Qok1EY7a2pPUp+TCVKeNAR+K/F5AtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=VexwdEsBA4pB0agpUYjHrVR41L+sHqHteYFzXJMCS7pRvtBpznnKpGpyCwKWY+5LykNDZxWOP1qLsrAFnf8mo7fsB6HQ65ZJlz+ufkmQ4u4r2OMtUJlexEnnuW3Kf6LWEjBDM067ikIqRrnanq1Y1c+9/sl/wij50thcfwL2PYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITSF5rbj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITSF5rbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763972494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQuNNYEfPBEXa8HIMuJ6YZ8XUYZTwvQZ++hqJgpDpP8=;
	b=ITSF5rbjNddhkyCEmGcWQslllKM1/+IxAhkmdyhP8bFCEHsaaIexIblHBA2pLk1NeVK+03
	QBxkLh0WTj6ZlKHXAQkeurIdFXvSjeKeRhvZa/2LaW1QgjMXurIxH4kuCCo2jUSMadGtsh
	ifG79aXUzE7KGHXu5Rc5AfkLC1dEpmw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-XIKJT_VfMAGpJ0-NiVeD4w-1; Mon, 24 Nov 2025 03:21:33 -0500
X-MC-Unique: XIKJT_VfMAGpJ0-NiVeD4w-1
X-Mimecast-MFC-AGG-ID: XIKJT_VfMAGpJ0-NiVeD4w_1763972492
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so3332920f8f.2
        for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 00:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763972492; x=1764577292;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQuNNYEfPBEXa8HIMuJ6YZ8XUYZTwvQZ++hqJgpDpP8=;
        b=vQmhOrTabgT8+/whABKETSuNl7WY1tGh0y6dcMKzXTIdyur9NLaYiffXXjQHuVDlxo
         Ns4ioV1aOHhQXEXHatdiXaVX0Krzs5CQEbJHydu5T5K1gI6y7Kx/PNhIpMB9TQJXYT2u
         o9u1tVQevvOdIzsRmN/kNhTDtXqGCYOvG11bDzlUiDQrT13MMVHdv7zw12q1KEnf27Jy
         LfWzX2ZU9MHDTlj8b2kzG6+j+0u8FeyAvFOy1yGXT6np7REDMt/wMrP0rXgMe3ytoLwd
         9ez7xYKpRK9buDG5SpTPL6WicrczxFnzluTKhx2AwD4xsJvMZWR6W0rJ6gmeYB8/bSkv
         WXsA==
X-Gm-Message-State: AOJu0YyORlTsEFSCo0mtEHhVF4XfuBUQvDHBhlTWvivuryRSxA2OhjqB
	u0ORujOlZGyZo0/R9abKpHlJbMNIaeLoLtmu4198VXtHWA9CXlbMx94kPF5hHXnjy+uqpTfkouZ
	C599ItCEJmL+RfS7a8m6Ya1k2SAfUPRr+DV6yLUWV0i38KBzP5qL1RfqA
X-Gm-Gg: ASbGncsNgEC9FaxmEWsi/TyHSs641ua2pAEH+NtmIZ5WcNHfjEiEsI8bUrCOFnvLTT9
	irRoF80W0OXt3rUr1GxWypafSwOLh5YlVcA7OO1gucHa+bLlEgqLzYDFbZECLlLNnzZEZJhBj/w
	I7pvRYtc+b4hv3KB72AT7geg6FcwEqNUaD0OdgROK3OcEvwzObput5LLWcCbNmvjahH09OI7hN4
	YUTJrx3PhfJ6vm1SdtiUFPMd8bfWOSwt8KCNdFWM1f74wPIgWbFBw0BQJVdOtoNWOCIM/k/vgnm
	09ucSUeS4XKcMwrcOKA+4ciJf6RN0qZtloWPkFPPS+v5uQFWhBby/AmF8PSk9iL4ffvAYy0GFVJ
	Lnyq0nBmP3rQaIg==
X-Received: by 2002:a05:6000:2f81:b0:429:c711:229a with SMTP id ffacd0b85a97d-42cc1d23087mr12475004f8f.56.1763972492040;
        Mon, 24 Nov 2025 00:21:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYhvCUGUpzjYpacP6ceNOjhvjs9FVqcyEIPQxT8k0d9yu0FGjP5MxCV2aWpTVpTmAOFXRXJw==
X-Received: by 2002:a05:6000:2f81:b0:429:c711:229a with SMTP id ffacd0b85a97d-42cc1d23087mr12474967f8f.56.1763972491614;
        Mon, 24 Nov 2025 00:21:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cc231dc6esm18680867f8f.7.2025.11.24.00.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 00:21:30 -0800 (PST)
Message-ID: <6ca6b0e1-5591-4187-b1c2-2dc9a0c119ce@redhat.com>
Date: Mon, 24 Nov 2025 09:21:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: schedule rtx timer only after pushing
 data
To: Geliang Tang <geliang@kernel.org>
References: <9f5e5b6c05fa0e6d303126c6a68a19305d166d36.1763715034.git.pabeni@redhat.com>
 <b5cf59c34d0f47f32cce5ea0fe0f419beed4fa7d.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Davide Caratti <dcaratti@redhat.com>
In-Reply-To: <b5cf59c34d0f47f32cce5ea0fe0f419beed4fa7d.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ra4RTGxvn-Q8wK60OPyFGX2kbLhAKOmg3R6d4hBcnRo_1763972492
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/22/25 1:14 PM, Geliang Tang wrote:
> On Fri, 2025-11-21 at 09:52 +0100, Paolo Abeni wrote:
>> The MPTCP protocol usually schedule the retransmission timer only
>> when there is some chances for such retransmissions to happen.
>>
>> With a notable exception: __mptcp_push_pending() currently schedule
>> such timer unconditionally, potentially leading to unnecessary rtx
>> timer expiration.
>>
>> The issue is present since the blamed commit below but become easily
>> reproducible after commit 27b0e701d387 ("mptcp: drop bogus
>> optimization in
>> __mptcp_check_push()")
>>
>> Fixes: 33d41c9cd74c ("mptcp: more accurate timeout")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Note that the blamed commit states we always need to rearm the timer
>> even
>> with no data pending, to catch link failures. That sounds
>> weird/possibly
>> tied to broken zero window probes?!? Hopefully mp_join self test
>> should
>> catch that
>> ---
>>  net/mptcp/protocol.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 3b327e9ccb78..b3122f53827f 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1649,7 +1649,7 @@ void __mptcp_push_pending(struct sock *sk,
>> unsigned int flags)
>>  	struct mptcp_sendmsg_info info = {
>>  				.flags = flags,
>>  	};
>> -	bool do_check_data_fin = false;
>> +	bool copied = false;
>>  	int push_count = 1;
>>  
>>  	while (mptcp_send_head(sk) && (push_count > 0)) {
>> @@ -1691,7 +1691,7 @@ void __mptcp_push_pending(struct sock *sk,
>> unsigned int flags)
>>  						push_count--;
>>  					continue;
>>  				}
>> -				do_check_data_fin = true;
>> +				copied = true;
>>  			}
>>  		}
>>  	}
>> @@ -1700,11 +1700,14 @@ void __mptcp_push_pending(struct sock *sk,
>> unsigned int flags)
>>  	if (ssk)
>>  		mptcp_push_release(ssk, &info);
>>  
>> -	/* ensure the rtx timer is running */
> 
> nit:
> 
> This comment remains valid and can be moved inside the if (copied)
> block together.

I intentionally changed the comment because the original one comes from
commit 33d41c9cd74c ("mptcp: more accurate timeout"); such change
explicitly _always_ scheduled the rtx timeout "to catch link failure
even when no data are send" according to the original changelog, see:

https://lore.kernel.org/mptcp/d4ab7e417c82dfefa3dc91ab6ea4adcb7c5752c3.1626210682.git.pabeni@redhat.com/

I want to update to commit message to outline the behavior change and
keep track of the relevant history.

BTW I suspect the above statement was due zero win probe being not
functional/buggy back then and I run the link failures self-tests
several times in a row without any problem with this patch applied,
still I guess there is some chance of regression here.

(hence I suggest not pushing this patch to netdev before 6.18-final)

/P


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCC2D8385
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241890; cv=none; b=ryo8O6pgFqejoUJS8H95cLMY4i9RewiTdmmob+G1OOZgJSNBO+29c758AApiDGICBHgiqGphYmkebnrDKOTy2HmXe43/9ELf2JJcl80nm7iqKjI1lVaug52V6EU94TBC6ofFfUfZotvvmqNa0KTV+O4skbKKdqxSeCNXPctrh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241890; c=relaxed/simple;
	bh=r5kAfkAi7w0iHfmiEDwWKDifCtkaA0K0JX1JQliviHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UU7g0QYWYgGm8GQbDqSwFDp2IiRXDAYZx57o1IPiLDMHeJ53LVgN2+LD3woR6NeZiYzZuFDQmo98KLL5k+e2CD1pWwhtt2QUAtqOb9Q9CppDFP1/rUrUe2GbTDVnh72TGv+Yg+bG8ZdGXXIo0HxxY1jLZ09SJ86wJC8sbHDU7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFq/1ht5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFq/1ht5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752241887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFuHWPcNNWz7UckBc6B1oAWTMXJCjP/14SJr3vRPU9s=;
	b=gFq/1ht5is2mMTCXKCzqX4EeCQKZ2W9jENsXwI39OoqJDhXLo77LBY8d9lf9QJdo9HEGrA
	FqjKqvxojF0IXwnTVL9BaoYkJ0usLhl/ZSO9aUnHmkzw6nmp49s+QJGuJtbgn+53V4Y+6N
	GP9SYs2ghK027nFXtrj/Q2j6tadUv5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-GUQKpjHIO4-9G4_DGMEcYQ-1; Fri, 11 Jul 2025 09:51:26 -0400
X-MC-Unique: GUQKpjHIO4-9G4_DGMEcYQ-1
X-Mimecast-MFC-AGG-ID: GUQKpjHIO4-9G4_DGMEcYQ_1752241885
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so11669605e9.2
        for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 06:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241885; x=1752846685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFuHWPcNNWz7UckBc6B1oAWTMXJCjP/14SJr3vRPU9s=;
        b=vqBUAmQy6fLr+/0g6G3lkVCyhdfk/VsZ4i0KdcGz7jIIwdJ7iUlgNEllWiIerIkYP4
         hUNO1GWH+DlAjm7ZVw016JlONOfGO5AIBx6AWZmlP7oYZbe0MiWqZnrTzqdpupCFRDTf
         6x5DjPqK0l1JK5OdeQiPRvs1xEjzAmO1gbdLi9DnpcRrmflRPc+h6UGkhR1mlKK+306O
         dWfQWzbqCNuGsDZ8fWowPI70L9FgUh2cwQZBPRUOmKmKzomHnYZFRhzyXS1feNPNO7BP
         GW9m3JdLuziTRvkTJi9UFoNEBCZgjeSCqpzkO5u5/nLljH+bJbOdqpWiZ0Yxalh2nZ2L
         TEiA==
X-Forwarded-Encrypted: i=1; AJvYcCVegdlhGfvxpWqXpgu+zsm+tjbl12rJGHYZkEAv14YG5UA5bxdx7RbfDcIKXmV/gR4yzt+SgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIGez5WGXZTk1VXsuM7iDTCbx6nEgmLrqr7P8jnhGZnYKvXLwd
	ekeivmyhn0ZEo0J51eSieReBEBuDK6sCRJwb1UMcaEOGAgkJnwLjpn7j5EsLC4TAkqGhEUfl88e
	ZQmrYMQ/061ON9lcbsKsy6RK7+ysB7KtCBeaLe8qJK0pwuZHPFUNOSJw6
X-Gm-Gg: ASbGncuwUTyEsi0R1ITpXn9cIVg1gIoR2G1RsJid1yQ1pRFL2zDqOy47E46LezG3VuU
	b3zic+G+4ZRteFQTQXjQ36b+RZDjY2yH3izsJfmTBDSlCGmwNV3+8Dkoau4ryn4NLQ5Ssq80qP4
	loH3VuLFvn8NXMYggS6L9ulKnV8d3JnFFvNY2a0Nez6FPWYW1H9x+1Gq2nbKj1JYcZSDm4HmQm4
	YuMCVRMYvBMlymgye4LLbMKa2t/x9tAFZ+oERTKDjhj/Mos85HWRcDvu23ZZX/dfuOeAvhMCHxr
	XGnHxSkIB0Q1b2ku+xV8hAPy58NpHbZrA4vQYj9p9RcCVLNrdEKECtquD/Bmt6VOCGsfU2Ufy9H
	ufdDxnolOn2w=
X-Received: by 2002:a05:600c:46c3:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-454f4272789mr33324445e9.4.1752241884754;
        Fri, 11 Jul 2025 06:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk2cVnXpeaN3wQkYQ/5dMadB8ILpqDFYZD8J4gcn/FhnmvJdUAYvUUee60E1q935d8YXP9xg==
X-Received: by 2002:a05:600c:46c3:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-454f4272789mr33323305e9.4.1752241883574;
        Fri, 11 Jul 2025 06:51:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2716:4b10:9b16:cae0:6065:2782? ([2a0d:3344:2716:4b10:9b16:cae0:6065:2782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd439051sm48259605e9.8.2025.07.11.06.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:51:23 -0700 (PDT)
Message-ID: <5364ad7f-a7b3-4244-bfc9-00fb3ff2e67a@redhat.com>
Date: Fri, 11 Jul 2025 15:51:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 mptcp-net 0/5] mptcp: fix fallback-related races
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1752221786.git.pabeni@redhat.com>
 <697f6cb1-1783-4b1c-8d76-75aad0faf8b2@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <697f6cb1-1783-4b1c-8d76-75aad0faf8b2@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0wC2Rq8KDjwWiBQpS_51YySrtNZU1rrbiBHaCEY4ctA_1752241885
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 11:36 AM, Matthieu Baerts wrote:
> On 11/07/2025 11:29, Paolo Abeni wrote:
>> This series contains 3 fixes somewhat related to various races we have
>> while handling fallback and 2 small follow-up likely more suited for
>> net-next.
>>
>> The root cause of the issues addressed here is that the check for
>> "we can fallback to tcp now" and the related action are not atomic. That
>> also applies to fallback due to MP_FAIL - where the window race is even
>> wider.
>>
>> Address the issue introducing an additional spinlock to bundle together
>> all the relevant events, as per patch 1 and 2.
>>
>> Note that mptcp_disconnect() unconditionally
>> clears the fallback status (zeroing msk->flags) but don't tuch the
>> `allows_infinite_fallback` flag. Such issue is addressed in patch 3.
>>
>> Patch 4 cleans up a bit the fallback code, introducing specific MIB for
>> each FB reason, and patch 5 drops the, hopefully now redundant
>> pr_fallback().
>> ---
>> v3 -> v4:
>>  - fic MIB exposed names
> 
> Thank you for the new version, it looks good to me!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thank you!

> I can apply this series, restart syzkaller on top of it, and send
> patches 1-3 on Monday if everything is OK. WDYT?

I would wait a little more for syzkaller. The underlying issue is not
very recent and the fix is not that invasive, I guess it's not a tragedy
if it reaches Linus' tree the following week.

But no strong opinion either ways.

/P


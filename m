Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A947279B
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842263; cv=none; b=BJMvC6KrwB1Nuwit8qngyhRINbhxpg/KD+7BSKlP+EJ4zZdDCoUUiNRmTqdbuFRk6yndCtcjGEp3WWKXE1yO6fCqyhgRJbu9vKI+cjmKDiWzm7ad8jVP0X7eC/0lszMApNwlXjBcPE7o/fIkr7+IqyAldOz9LUYbXWv+t+IcrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842263; c=relaxed/simple;
	bh=/ECf90eOrhXSOkdV53PEEz07VINGrfgsW10pHNon/cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kf/a5+58Ev1A4Vc9CXnnkWcqT/hbGoRs6Nq5HxVnBNWvXOY571YSbTIudElnj3oSph14fJ25xSgJyShCA9CvI1j8BFlDe4NXTT1OlzbWo3vGXtfx7tCY0mlGQYVP78Lgn3DxFz3bwhbjDh1v87gzQUOOGTqcfaoMAgsXk0us80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmRaDcq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmRaDcq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778842261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2GcfIXT4hgjoWK/Zjyn99ZRplmcZPLBAZBxpyE5X50=;
	b=DmRaDcq1vLV92WTfmRXi3DVbAxid4iP8zXf7J9ix939UPN4uBQqyQrI0rGOInE507oSmxr
	NyuhmuyminkXz9CWEbiZZLJd2+PQQwt/XR8Sjbe8Iklqul52eEVOb4ponzh98CarmGEhtG
	/IPa1ZvvhzWpgI2AzO8heoaiqCBtjiQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-wnN53nSbO6uaGLgjnfsZOQ-1; Fri, 15 May 2026 06:50:59 -0400
X-MC-Unique: wnN53nSbO6uaGLgjnfsZOQ-1
X-Mimecast-MFC-AGG-ID: wnN53nSbO6uaGLgjnfsZOQ_1778842258
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd3dbd16aso22828785e9.0
        for <mptcp@lists.linux.dev>; Fri, 15 May 2026 03:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842258; x=1779447058;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2GcfIXT4hgjoWK/Zjyn99ZRplmcZPLBAZBxpyE5X50=;
        b=YqvGCj1voJKsnXJDIDbp9o6P17VxJI5ExNmyPeRkvSAtiKn7224c7DWYLuA/ooUFld
         5uI8dFxCKi7sCR3GGqCzJqoMalZ1fdl1ffavirbGUji89zycqf+1HhTEttx0mT+FUfPU
         UwtzoqgOI7S3Za7CNNkEvsF/vGIgVNrmK48qH7xt1qQGLmLVt9AWt4DWt024VoyRV9hK
         SL81nnWIhh96IcOZkgcMg8ycGj+N+CqSoMlA8qWcuqJCj0yjU1nQczYWfUDc7AtR6JlU
         FvPriyr8nf9JNtutNjA9lludO4TqffchDpgJShQwouWpGTDybrdEbloFtX46wPdk3tIY
         eggw==
X-Forwarded-Encrypted: i=1; AFNElJ/n6eZc9W8AAWEoH1hSfdHERUDFS0O785pycubc1AsoU66kWfBzgrHuMt3itpi9F5EoH6wVvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOFCck52oHA9ycAO377dMj+HJMVT4FR7WIIsrqVMNglWntrXsN
	IHfHMaoCNI9j76PB3svhiRI3Gnd01F+X0msmZsu3Pq70/rPGhGLMEp42e0XbUpMaJ8GDvx2dVT6
	0WeYmKym2168U+/Y0HI7/qWidzoNosHldlvldAJtq1Q8F16IIdjaeb5FeTOcfQI5j
X-Gm-Gg: Acq92OFW/ZNOwruGJWL6e9PlaT4FCtzRUEgLWpjf0l371YfvPq/nNl+MCNAqrHvpYdn
	i7QditS47F0mrENIBI02R6Dh+o/r5rRmmPDJnfVX9Y3tYr45wl/gXprB+rpWeBvw7nrVyKqO80D
	OVmcYHERnNJGkmj30wWduPPKEfb81hRPq7m65XE80l4RJBZsF5r1aqnphMG/hNsM7Okfm3xshWf
	0YgCagm4cASobLuDCgzvUJm6mUodxvVRaJ3EZoR6XfivYQjqB+8nZsW07GbDpu2NQms924e4eKr
	wuoGGskqhqJnWHST785Ctx5GGKMMQvlvY0Ix7DOs33CYfqmqiEjSmjZnhBgI7d1b5x9MLGd0AAm
	40uSR+kcyHcoAGRjoF+//NwwEVUXSz+HbtqsS8KeoBjaB+oIeLQ5ywRKouA==
X-Received: by 2002:a05:600c:6992:b0:48e:6f39:f7be with SMTP id 5b1f17b1804b1-48fe60ea533mr44239595e9.10.1778842258215;
        Fri, 15 May 2026 03:50:58 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:48e:6f39:f7be with SMTP id 5b1f17b1804b1-48fe60ea533mr44239305e9.10.1778842257815;
        Fri, 15 May 2026 03:50:57 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm55416005e9.14.2026.05.15.03.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:50:57 -0700 (PDT)
Message-ID: <9f183916-6db7-48fb-bf39-dfe87a31b7d4@redhat.com>
Date: Fri, 15 May 2026 12:50:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v4 1/2] mptcp: use sockopt_lock(release)_sock in
 sockopt
To: gang.yan@linux.dev, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
 <20260509-sockopt_lock-v4-1-33f3a1c4d7a0@kylinos.cn>
 <cb257c5c1af85f1512a175730e832c7b8cc7ba14@linux.dev>
 <2678c535-2b51-4a04-803e-14a2e3ac348b@redhat.com>
 <62bce132417a3c98a6ad6aea821dba9de1002916@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <62bce132417a3c98a6ad6aea821dba9de1002916@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v-nzOOJtTRoKg3-L-4R1V7NuBS9NzW-CR-0jJ-PfRsE_1778842258
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/15/26 11:39 AM, gang.yan@linux.dev wrote:
> May 15, 2026 at 5:06 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>> On 5/15/26 3:27 AM, gang.yan@linux.dev wrote:
>>>  The subflow locking concern is valid for future BPF support.
>>>  
>>>  That said, the observation about the subflow locking gap is a valid design
>>>  concern. As sashiko pointed out, when the MPTCP setsockopt handler is
>>>  eventually called from BPF context, the MPTCP meta socket (msk) is already
>>>  locked externally, but the subflow sockets (ssk) are not. The internal
>>>  delegation via sk_setsockopt(ssk, ...) or tcp_setsockopt(ssk, ...) calls
>>>  sockopt_lock_sock(ssk) which skips the lock due to the per-thread
>>>  has_current_bpf_ctx() flag, leaving ssk unprotected.
>>>  
>>>  However, solving this is not straightforward. In BPF context we don't have a
>>>  good way to call lock_sock() on the subflow — as sashiko noted in first point,
>>>  lock_sock() unconditionally calls might_sleep(), and will cause 'sleeping in
>>>  atomic context' problems in BPF context. So properly locking the subflow in
>>>  BPF context remains an open question that needs to be addressed when MPTCP
>>>  BPF setsockopt support is actually introduced.
>>>
> Hi Paolo,
> 
> Thanks for your reply.
> 
>> I'm sorry for the late feedback. I think such concern is actually quite
>> relevant. Note that replacing
>>
>>  bool slow = lock_sock_fast(ssk);
>>
>> with:
>>
>>  lock_sock(ssk);
>>
>> does not change much WRT the sleeping issue.
> 
> I'm not questioning your point, but just to confirm — when you mentioned the
> "sleeping issue", are you referring to the BPF context?

Yes.

> In fact, this patch addresses an issue that occurs in non-BPF scenarios like
> sashiko said in [1]:
> 
> https://sashiko.dev/#/patchset/20260420093343.16443-1-gang.yan@linux.dev

I think that bit/chunk should in a separate patch targeting net.

>> I *think* the only viable path in the short term is making the sockopt
>> requiring subflow-level lock fail when called by BPF.
>>
>> In a possible long term alternative could be delegating the
>> subflow-level changes to a workqueue, but that really looks invasive and
>> I would really like to avoid such option.
> 
> I agree that the short-term approach sounds reasonable for now. We could
> either implement the sockopt failure for BPF calls that require subflow-level
> locking, or simply add a comment to mark this limitation clearly.

I suggest avoid the comment, because application/BPF programs will trip
on this. Returning an error will make it clear that is not working and
will prevent racy accesses.

> As far as I can see, MPTCP currently doesn’t have any real-world use cases
> for setting sockopt via BPF anyway. The workqueue approach also seems too complex
> and invasive for the current stage, so I’d prefer to avoid it for now.
> 
> WDYT？

I'm very fine with keeping this as simple as possible.

/P


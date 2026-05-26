Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF81BC08F
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808675; cv=none; b=XfStvUiQXRKBS/ggRi0O+RSmwN6KkIXb3/zvkBrVwcOu7ZeS8cyoBq+/1Z/mK1msOZE37S+V75PA9DpH6mGmtt9E/df5RqBWgGH9U1hMDwKx9NMbE1JGNZdfrkNSY0Hys2qiYuQhvJ7ywqiBnkSFQ8eBQ4LW1Uou9BbFqSGwKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808675; c=relaxed/simple;
	bh=zlNqE1tdxDYKD2i3iSeOXlYj4EmyB+jZBn3gsOaUr4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ikr3WcNe0YjOqmagnyr0FM9mVdavvzCkd241aAVIzsC/EXQtpvq/IBcyY5UOCurSY0MGK1S4eHnI/kvBAojdDWVzu+W3QmFgZeMlvhUqmYe9yVXP367FDV6HndlraH6qyguZs+Gj5ZNOhl1jZETn8jm7BlbkoprFp5QGHtDoJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYLz7oeM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYLz7oeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779808673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlNqE1tdxDYKD2i3iSeOXlYj4EmyB+jZBn3gsOaUr4I=;
	b=iYLz7oeM5qbdmdAOesrXA5ObEEG+wg08qh3jppunj7D5RGUNE/s/HPjqxhDYAKpjPCyy/2
	B2xxSzcWHSgu9x+vGUfWRVR2WtnJQPfBX8ioaQGGHgROQ7SC1FberAZJD2MSWazUWKCG5x
	UbnedEwYR/aZKilm+6PZ8rilXnKGpUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-m7VD0JPCPkCSl62PPNArMQ-1; Tue, 26 May 2026 11:17:51 -0400
X-MC-Unique: m7VD0JPCPkCSl62PPNArMQ-1
X-Mimecast-MFC-AGG-ID: m7VD0JPCPkCSl62PPNArMQ_1779808670
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso62612145e9.2
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 08:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808670; x=1780413470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlNqE1tdxDYKD2i3iSeOXlYj4EmyB+jZBn3gsOaUr4I=;
        b=fNPHU3Dfd9Tq9SKjpiXF6HLANcA4qNPauGZt4+SQnXE3FaU/mW/64a/vSzKJYxGqKO
         hqZPXTGlp/oEL3biZLq9OZGVtcTmdzrMpTSl1sjfiyyvrYeqZ6CUYafm12h5ZYx9oA03
         xF+wtLLTumeHUkkEYCOraApLbbvtPkZr10ws72hnQxE3vydqdxfMWbzfdtxmBvPDb7GC
         qNlC1mTqL8phBgVOFUWiNRiJ0ujeLLsyiSdN3jptQp5Dqf7lUVfxm97zx3CUaPp7CZcp
         2XKqHtOkoqyimXORKE6jOPzn+uwN3BalwklwCTF7uWAUbFHmm/CSyfKCTcb8v8cwPoK0
         Ij8A==
X-Forwarded-Encrypted: i=1; AFNElJ+3/xtJSe7JRh1Q9BVWnERbwHaJ70hfHzWjp8uX+cgKJ8po0fxJElL7GPY5o/I3cZX+H7jL8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFkgz6HMahPBiQb1qo6UGn5AOnOIooFz/fxtqayv21+Kpm9FG3
	i6/nKruU9HaczWtWRzEkctlvZmSabZEGgD1aEXLEGLpAdq9rVQCc02wyjRxrDTR/kN2i+hxpfk0
	ix3qdomtyyhxsLm/6+IE9G3HYtEQabF55Fz7zlJfuW36nVinHcKRgNIY1
X-Gm-Gg: Acq92OHeCWaOC9lq3L0EFXbCC6WLJIYV9YJhilOHfQtIcI6i4ik/oNagmaGamlNeUSt
	MkjfI1HX5yqVTxfn98jhrqPbqOX1FH798euH1zGGmNoV/Y770Z3cjBhurZfMDwrA+ezqELCHl23
	Zt9bL+7Hd9JwubkqkLGBQ7ppTKie0gXYvYYFtFQgLI+fsdM36I5TLbOL9Md8UXT/JzfBsgwFkp2
	kHr6MYo0ijlSLD/L23LJhjkQojY5XQIH4TjDEo/r1OBczc179oIaAzDhZqxGC2PxDiTh93VHMDj
	QVlqnA+CnWHxv0sX4xlUvhWcItx9Q8NGHzisKL3DOtm1nkidn/3jqDyvqkVz6ei5aLlBwHI9yA3
	anod2FmCHCBCpLG58gVbBI2+NE4LSHoQNXSPjVDGYYRecK2qb3mBABWCGTg==
X-Received: by 2002:a05:600c:468f:b0:490:47e0:e131 with SMTP id 5b1f17b1804b1-49047e0e229mr325077825e9.16.1779808670234;
        Tue, 26 May 2026 08:17:50 -0700 (PDT)
X-Received: by 2002:a05:600c:468f:b0:490:47e0:e131 with SMTP id 5b1f17b1804b1-49047e0e229mr325076945e9.16.1779808669603;
        Tue, 26 May 2026 08:17:49 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ed90f8978sm4025139f8f.7.2026.05.26.08.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 08:17:49 -0700 (PDT)
Message-ID: <eede8443-e2d9-4bf4-8e66-76e4302706ad@redhat.com>
Date: Tue, 26 May 2026 17:17:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mptcp-next 4/9] mptcp: allow subflow rcv wnd to shrink
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 mptcp@lists.linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <661603fa10737a624bba854fb2515c7abb129a80.1779485511.git.pabeni@redhat.com>
 <a017ffa9-1dbe-4094-ae85-7c17e7b48b0d@redhat.com>
 <085ebc3e-0d49-4a82-aea9-a8b05a02c7ae@kernel.org>
 <0624d85c-1992-4b4f-bbdb-32c454ac7765@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0624d85c-1992-4b4f-bbdb-32c454ac7765@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rkuoRUlpMJ4WzWU5nICzoQAHNxHbfEJeXZPStFPwR2o_1779808670
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/26 9:49 AM, Matthieu Baerts wrote:
> On 26/05/2026 17:02, Matthieu Baerts wrote:
>> On 24/05/2026 18:34, Paolo Abeni wrote:
>>> On 5/22/26 11:43 PM, Paolo Abeni wrote:
>>>> In MPTCP connection, the `window` field in the TCP header refers to the
>>>> MPTCP-level rcv_nxt and it's right edge should not move backward. Such
>>>> constraint is enforced at DSS option generation time.
>>>>
>>>> At the same time, the TCP stack ensures independently that the TCP-level
>>>> rcv wnd right's edge does not move backward. That in turn causes artificial
>>>> inflating of the MPTCP rcv window when the incoming data is acked at the
>>>> TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).
>>>>
>>>> As a consequence, the incoming traffic can exceed the receiver rcvbuf size
>>>> even when the sender is not misbehaving.
>>>>
>>>> Prevent such scenario forcibly allowing the TCP subflow to shrink the
>>>> TCP-level rcv wnd regardless of the current netns setting.
>>>>
>>>> Fixes: f3589be0c420 ("mptcp: never shrink offered window")
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>
>>> Sashiko failed to review this series from this patch included onward:
>>>
>>> https://sashiko.dev/#/patchset/cover.1779485511.git.pabeni%40redhat.com
>>>
>>> and it's not clear to me why.
>>
>> It is not the first time I see failures. I guess it is not linked to
>> your series.
>>
>>> I think patch 1/3 are quite uncontroversial and reasonably even this one.
>>>
>>> WRT the stall addressing patches, this iteration survives mptcp_data
>>> testing without timeout tuning, hopefully should be fine for Geliang and
>>> Gang usage.
>>>
>>> @Matttbe: please LMK if you prefer a complete repost or if you could
>>> apply patch 1-3 (or more).
>> Sorry for the delay. Yes, on it. I guess patches 1-4 can already be
>> applied to -net.
> Just reviewed them. Please tell me if you are OK with the suggested
> modifications, or if you prefer to send a new version.

I think patch 4 does not need modifications. On the flip side that one
is a little delicate and has not gone through sashiko yet due to the
mentioned issue. I think you could apply patch 1-3 and I'll repost the
following ones.

/P


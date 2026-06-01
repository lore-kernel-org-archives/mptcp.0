Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A853438AA
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298265; cv=none; b=SKsV9TzrIrOOTlg6iQpr5RbFSOqKP1eV9Ati0nQisjj8TxMFYE+rHWsTFyLv1rFcBKUHAkXQYmYkWd7/Z0tp5/bbO7PgEYtZbLbI4Y0Dd+z5mkLX1bzmOqiTTWLbHhOjsN/jb3S4bv7woDXbAteiVJjUWMXt91MznKNgfneYuxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298265; c=relaxed/simple;
	bh=BEmtnCpo2elsMmNc/elXXX+BVBMnci9PtDjLwKSUHEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F1cM/i/18dj5x3J5ouZmmXHkiu2h55VFxPf8QyphiV3MJqewFqlpynOSqrfZyCWz8UtX9aVzGdFMcIePtN373f0vfWqEm5dPLKwHvJN0kdg1gUrOmJsfy5HzKgmzzYSCAMpnRaLBgPSZi17j/RuZiVO7ctbpUmoKteVk4/fjtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEVKSXDm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEVKSXDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780298263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzTCKpCHlK6BDrqWzsPgXek+KWkfoV5euMwcvLlDIBI=;
	b=gEVKSXDmstxMGceGk/gqUTnOaH+/kUgZq8SNZj8SfCHBNotIcX2QkTqYJlgZTs1AeuhcWh
	3fg+GC+7P/8cb3GAbLcPWMMUSQuU39ykZOyE3KlIbqZAXpVaoOkaJWK2Td7EteFK3PW22K
	05/C5eouK+Ka8D7SgXnWKl5Pcxu5sGs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-ITd-w4XbNAWf2aVZIB-rPw-1; Mon, 01 Jun 2026 03:17:42 -0400
X-MC-Unique: ITd-w4XbNAWf2aVZIB-rPw-1
X-Mimecast-MFC-AGG-ID: ITd-w4XbNAWf2aVZIB-rPw_1780298261
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49045243094so122604855e9.2
        for <mptcp@lists.linux.dev>; Mon, 01 Jun 2026 00:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780298261; x=1780903061;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzTCKpCHlK6BDrqWzsPgXek+KWkfoV5euMwcvLlDIBI=;
        b=f9JBGQgY2ssJ19lWihTiMEuIp5C2fcZpxF6w/sJIgNjIe59xys5l6nhUN0udhvkw8Q
         sm4IMR3tzhzL7Z9LVtLJWJuCrX1kzmOIGINrVPV1SByW8LeVNYx7vMlS1405IhqFh7GB
         hpcllo/WXlZkVkCL0RDoBeUKwNf1veF4+LY9+9U4ix9QiHpB56oUaZbcOq30RcNuWQAw
         baCcfXMQU2KtAEdmSPE+G+AkGc4LeqWji+164b/J9PRhznK+jU0rFnqjpZPv3WNt7EqV
         TST7mIqjujOD4AkIUtlDAS6YucX5AqbOXHtcxaD2kJQ4ivJpwmyH4hiIWAgc14JQrnWu
         Of5A==
X-Forwarded-Encrypted: i=1; AFNElJ/x95HlwbLtSNWErMBoWUp3XPTijlWPBuy5VtY0usQ6X61ml5FrjBzYAaxe5uenjsP9iUQk9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjGRwdnDPQB3YOyiWP8NJTP9y+j4p1ZliHR2rcot86vIZS5wIa
	h0ysTz/WKdEYQT+bCzJ6x34vWordzCidIAaN0zcJYF7lTBBmOeM4rdI8C+QUxvTj4OAGYsRybZI
	hcWwhBfMQfnxX9IO/2OyJMrlUIYBiR4qp08Y88Z5fvNflhscuYokyufWT
X-Gm-Gg: Acq92OFjalb2u+43daYvgvrtqBhR39LHHiOpuLFE+KHpI+JIfy9QwvB3iZ5eqAndVJc
	9xHKWG9WF87xrnevLBVeclb4QklkF+6kYQJjIqFR635x98mdZnQhk3B8t5vJhqGYqXcVfUYKnM4
	m6erh9gK7LSxs+qWuDO3Kw+oqHKKB8H5wPuZxOVkg0Mw1EMtoM0ixQlOuKAZvxFejHJTw4cNNXa
	wC2r4iP0sxvV4Pldyt4Si6i0maiae7aMgjn2o4uK8VxDqugWZlFj6gqeGPROazePJ9qiRQMwfZU
	9ISUls4ay7ElvgBcMaasHtdfEESjynj1jeJgHYG2OqodvMdvhExuDAhK5Z9TMk8KeRnznWiTdY1
	s4CKulzDXjf8jnBe24ReJTemszVA0iJdCaZyoEr8qAoZANpXmUFGkCkK5BIQevc+R+Ovc
X-Received: by 2002:a05:600c:c098:b0:490:50ff:7943 with SMTP id 5b1f17b1804b1-490a2923a87mr154942685e9.5.1780298261074;
        Mon, 01 Jun 2026 00:17:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c098:b0:490:50ff:7943 with SMTP id 5b1f17b1804b1-490a2923a87mr154942215e9.5.1780298260604;
        Mon, 01 Jun 2026 00:17:40 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm254530635e9.15.2026.06.01.00.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 00:17:39 -0700 (PDT)
Message-ID: <5ec7e9c4-6985-4582-b0d0-124d3ff568e1@redhat.com>
Date: Mon, 1 Jun 2026 09:17:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fix uninit-value in
 mptcp_established_options
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <d776e14d19a313dd697e3715121f4e42e915287d.1780045909.git.pabeni@redhat.com>
 <e08df8df-a6cc-43f0-b6bd-fa68fcb6db47@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e08df8df-a6cc-43f0-b6bd-fa68fcb6db47@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UlWAMrwWIHhzruYpL_rzek4bHUD17p11AAfE_sUVSRw_1780298261
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 4:42 AM, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 29/05/2026 19:13, Paolo Abeni wrote:
>> syzbot reported the following uninit splat:
>>
>> =====================================================
> 
> (...)
> 
>> =====================================================
>>
>> The output path currently omit initializing the mptcp extension `use_map`
>> flag in a few corner cases.
>> Address the issue always zeroing all the extensions flags before
>> eventually initializing the individual bits. To that extent, introduce
>> and use a struct_group to avoid multiple bitwise operations.
>>
>> Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
>> Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
> 
> Small detail: I hope that's OK to use this one instead:
> 
>   cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
> 
> Before this commit, the whole "opts" was set to 0. So no need to
> backport this "too far".

Sure, thanks for doing the right archeology!

/P


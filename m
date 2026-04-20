Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725163890EA
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681194; cv=none; b=S3CH1tyPUdNUBDHkQXqIwz8TG3OO9YeYAtjlV0GuY4YgJqwg9boB2AFcAIa9H2VPY0kpS5DxIq2A0Iaj9c2a3DwJBgeJdT8QYRNnnBYfh3ggT6ONEu9F9bkXdlWWdUlH+mQUfQ+cAAaLB0x2VvMTLI8WiMlniw1LMRHJLGaMyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681194; c=relaxed/simple;
	bh=OxWCtPMlmZrESoxNswhdOZymrIu9ck5Orf50kHZYlVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LARJ9VrW26b+UWZhBphXwPr74zSBLMI+pZbhmmPaey5FwgQdmnUmHIPSIb6p2UPRkUAJvNL2MRzei7IHcyFbD9y+mQE5fT7OXVIF4vBW0oR9T0Y2mReMs2X5gtgmsuhKT7GreepqnNAcqDmoFQwd9ND5DCm7bcqJg+U41G4C5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAiW1UWR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAiW1UWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776681192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8Gi0s/RJ+0Z26J4jyVJ+wp0KdvPaLbZDHfQ28H4roc=;
	b=iAiW1UWR59Q9pWfAMrhB1YigIVbVnTqVfeL/bI46dzr2TICIh8wDX9LOM9L/WvP10fAexZ
	tK+GuQr3JQROa1cDynEUE4Vo7iOS24W4+RViTDZq1/9Q05tjzYZyjbYbb+f2Qonuz21ij5
	5tGnmxuXs3YPwkfWnNShFnZfbszS4SY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-l1ocB7WRPc2AmYY4jCZwGg-1; Mon, 20 Apr 2026 06:33:11 -0400
X-MC-Unique: l1ocB7WRPc2AmYY4jCZwGg-1
X-Mimecast-MFC-AGG-ID: l1ocB7WRPc2AmYY4jCZwGg_1776681190
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488e12db7e0so24119145e9.3
        for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 03:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681190; x=1777285990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8Gi0s/RJ+0Z26J4jyVJ+wp0KdvPaLbZDHfQ28H4roc=;
        b=QgpBOQbu5fIansUJbQVuxq5aADTuUiZgoXiPF5DG9dmHzopc19U+urFlsdYcie0OCT
         I+EsfK+QNNrJSw/2ZHrObnAPKR0D0DhvceW1y2i+jEIHPzkc20zKtOclncFhQnLAfF71
         HLhuTZDhiKWN7SfwCBFm0+qM8csD16MbIF3Yck1Rbc2tgprkIOtVcKu/X9W/BQpT6dHb
         JY3YlHLc82uJQy5xuGZ90ExxVJqqYd74nJ7UwwKefzkXQnNehYXakIJv7LxtRzpdnmEy
         cWZlkU8iySYMfr8Y/O3RnS7HUZv3VnEx807Nw/d/uolUTAcLjz5MHhJRu5qwvtax63MP
         aqHw==
X-Forwarded-Encrypted: i=1; AFNElJ+DnSEqUTIVvd8fkb2aofEndCsugpqJaH37VdhTZQ346tkPCsf1JsqLWf44JfVck7gsAyw7Ew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp9lt2+CMHS3ECkYOXa/pxYxiDgJN2Wg20srwW81+G+Lgl/YWy
	GaLEnGo5L8gaCzObW4B/iGX2PmCVxnTy4cCDmZcr2AyNU5yr2uslj6bwae1PQTth0wD8mjfEu0g
	OE85vzBm55rXWOjUkFJpLNYI6Sao8vU9LgToeCLn7WVXhZLCiw+2HFja8
X-Gm-Gg: AeBDieuVnl9leom7DhjPLOnj75ZY39gb1JJvYwDsuuLyGGHNdkIPziZZefnSWROuS0F
	BvVsOp7kfWjvNaPEKY6LqU9hC54X3k1vaxK2Q+JowBLo8DK7yK+i0/k7/MsIAVEBkzsa3yP9AuA
	oOQ519djt8Oy6eJD27e52YHQALBM8OJY+Cgihz97+7aYgkEt61iEqGz3evWvSn+aV6KArbt9d4x
	pzjvZscIHRdac0631nbgfpnSAX7c0bEUQUdPz/x/0hzV/9G+Q25+5MogsE5iUdr1Qjxrky7q4tE
	ytoCkllxVll4NH5Bws2cYS5aPmCkni1c6TgSOGCF+4PRuZB9wlL8ExMVbHCYgNvX5Cs5Uund08U
	aX8ItpIUJU/8qIMswV/4eAY6lructO4yOREv5ye6jcsHoC3IIjYon9ABtBracS3F/BiQ=
X-Received: by 2002:a05:600d:16:b0:489:19e9:b139 with SMTP id 5b1f17b1804b1-48919e9b29fmr45692705e9.1.1776681189900;
        Mon, 20 Apr 2026 03:33:09 -0700 (PDT)
X-Received: by 2002:a05:600d:16:b0:489:19e9:b139 with SMTP id 5b1f17b1804b1-48919e9b29fmr45692325e9.1.1776681189402;
        Mon, 20 Apr 2026 03:33:09 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm135479335e9.1.2026.04.20.03.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 03:33:08 -0700 (PDT)
Message-ID: <2a14005f-a0ef-4a1a-a13c-f7237f0659ec@redhat.com>
Date: Mon, 20 Apr 2026 12:33:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 1/5] mptcp: replace backlog_list with
 backlog_queue
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <cover.1775033340.git.yangang@kylinos.cn>
 <085a4d26a05fc6625e6e4e4c0e0225b38a01f178.1775033340.git.yangang@kylinos.cn>
 <d749b513-158d-4a3d-ad95-09bfc29c6648@redhat.com>
 <d34641c0-01af-4273-83d7-5e7ed92e8da7@redhat.com>
 <ef0ce8465f0b852d5e4dc5e54031a156f606b636@linux.dev>
 <e04bd2eb-0107-4011-97d5-a672d770767c@redhat.com>
 <7dc554be0c3343fee71e09a4fda5179cfe0571f0@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7dc554be0c3343fee71e09a4fda5179cfe0571f0@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nQ5wG5dLtH7VhwBtyA7IC1UgvvpjirBYlw5jdqMc7wY_1776681190
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/20/26 11:41 AM, gang.yan@linux.dev wrote:
> April 20, 2026 at 5:34 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>>> Regarding the TCP-style mechanisms like 'tcp_prune_queue' for handling full
>>>  rcvbuf conditions — I have actually attempted similar implementations before.
>>>  As you pointed out, this approach is indeed highly complex for MPTCP. There
>>>  are far too many aspects that require careful modification and consideration,
>>>  making it extremely challenging to implement correctly.
>>>
>> I agree duplicating the TCP pruning code inside MPTCP does not look a
>> viable solution.
>>
>> I think we can instead share it (at least the most cumbersome helper),
>> with some caveat. I have a few very rough patches doing that. Let me add
>> some comments to at least somehow make the code readable and I'll share
>> them here.
>>
> 
> Thank you so much for your help and for working on this!

Thank you indeed for all the effort and the patience to cope with my
slow feedback.

Also I hope it's clear that the goal is trying to find the "best
possible" solution and it's _not_ preventing or steeling your (much
appreciated) work!

Cheers,

Paolo


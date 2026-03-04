Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD1347523
	for <mptcp@lists.linux.dev>; Wed,  4 Mar 2026 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615782; cv=none; b=Vp1KikugvaJhlCYY4YshBjc0ZMKMXOiK1/0hNB3vpv495StCVH/lzkJMZs+xwOTGcpOxN9r3f5zBJbXpHSFCY0wgdJxElkjTG/vURZGTx7hJlMGRkTXRGZ5ONY/Opn/vIS/AjruvHA4tHrMSgE3ZiI6BWwSf0tCbtBZVx2eMoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615782; c=relaxed/simple;
	bh=YpQvbmqpeYpb2AK+FdxS8aZVqvtbgfJX3SSqHUCfjUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeWsLm/RuzTTRW8Mo70xXPAtMQKldIqjAkbdU+iQ0sSf3ru6qCC+D4sDKMB8a4zbrtJFHlOaSAqhrZInNKjG8KPrkIS+ulmMsawQs98fU1DqNgu2bWsx7E1csomm0hZ7OgH1WM0PA/lkbQg+pq1OY/rFCfRaM44JeEENYWJDNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xv0oRSae; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xv0oRSae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772615780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXas3AyRjkAslEjrx2sAXcKxe2TuLSXc5Z/CuPrz3WA=;
	b=Xv0oRSae8Ziu6iuQahSJYr7wMi4B7VcSY0u82kdHvRp5acnvI9KWIJuTK7DS9FTWAkWcVS
	wsaEzpJ1ulAlaJ+lUGud+Lqo1w5Vpa/l12UpgySvPdCs7AyxvuwyvbOLnS2JQjkCQ2RgV4
	sIQlcbojy830y4iWkdXNEa2o5yWpGoE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-DCys2MuINx-uHtksZ5s8tQ-1; Wed, 04 Mar 2026 04:16:19 -0500
X-MC-Unique: DCys2MuINx-uHtksZ5s8tQ-1
X-Mimecast-MFC-AGG-ID: DCys2MuINx-uHtksZ5s8tQ_1772615778
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so65214715e9.0
        for <mptcp@lists.linux.dev>; Wed, 04 Mar 2026 01:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615777; x=1773220577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXas3AyRjkAslEjrx2sAXcKxe2TuLSXc5Z/CuPrz3WA=;
        b=ryZd/ryr1lwj+KTGEb9XntN65to7XYisJlTFVh0N/26cqz7fPl6c6//F+XJ5H0sTsC
         isHHpt8qa2JW5uYcPcXoNbbmQtUJGg7HW49Sj/+WjsWloubAp08tYRP/7ANtlR2mFbfq
         CI4fQPyOJvTNStTEIFdq60OLzmo5tF9DyYXiefWkWZxmnbtFAmDt8BGdA8CViPt2eCeg
         uzncIioic/EelzouiY4PCxCadJ/24pwnnzsmUyhBWiGo1iLlptcyFynv/j744b4FcPqL
         MshonqKQ8TPrm2grkTbLCvAzIxNh93l8JVVI00kczxKL9lJl2orkNu5n/MPPpCydCSob
         O49g==
X-Forwarded-Encrypted: i=1; AJvYcCU7Uru/drmNhLgOloYbzU7wHOk00y4HnADpDIYc+HKhm5U/ZD/riFdDU3bok8dlQ/IwIlB9TA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqKqDoAQS8Uz7w1yItcxIBMtliOFDU4nq1YRxnaiHdxcuBQhSU
	CUqY8dYNzrDJ6KP9/pTgYy8ixk5mFG3xfVTVl3QA2ayNRfh8LFDtsq9gW86XZqvrS0449TDi4Nd
	bLa9sXbIxzvl40CaVoqaWAuHwjXu7EcZGckfMSNveZFGiKRnWDuONASddxrytkqN5
X-Gm-Gg: ATEYQzzI5AESAlNE6BwYYqAz/wVYbJjJ+TqKctsngGVSAydCDxOvlPUsqG+meo6YCyH
	o+e7EYS3hyG9QnOqRjLEgYMs+Lovbtd9ViWii07Dpiy1Z3Zn0QI/exSuJSkkP1CZK9jR4/bpRID
	1twqnp0IEBL1oJnXraybqsi8Iz3hKP5fMRV0sr7N7snj+BisBO7Voleuzv53alJwh0tz6S4yns/
	wHNmZ7rMH8A6sKoWb3KR2eF3jnre7zN42H5ek8qedjrW53LkRSblbBhy1op034YRSFw+afW9YGV
	AIj+FbOWbRwYZF6C0w9H00NYHu1w+CA6nbr6iTjhJvGdkFVbn46+k0+Hcqqg6nAiL88ipZTr/ST
	2oqbhuJqm+/8WIfiue2JNgxLXpg==
X-Received: by 2002:a05:600c:37ce:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-485198be785mr19265015e9.12.1772615777529;
        Wed, 04 Mar 2026 01:16:17 -0800 (PST)
X-Received: by 2002:a05:600c:37ce:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-485198be785mr19264545e9.12.1772615777063;
        Wed, 04 Mar 2026 01:16:17 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851883a012sm73307135e9.3.2026.03.04.01.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:16:16 -0800 (PST)
Message-ID: <8f6304a2-c0d5-4c37-a569-b34dff431c29@redhat.com>
Date: Wed, 4 Mar 2026 10:16:15 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 mptcp-next] mptcp: support MSG_EOR in mptcp_sendmsg
To: Geliang Tang <geliang@kernel.org>, Gang Yan <gang.yan@linux.dev>,
 mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260203023029.855434-1-gang.yan@linux.dev>
 <f3235ddf-9d39-42a7-8e44-a847b7402e39@redhat.com>
 <cfe4ed715628a84625c7fdafcee587581d880338.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cfe4ed715628a84625c7fdafcee587581d880338.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7In1runvrdrLcbWhrbELmJOLZCGWFS6tA8fY2_lkZEI_1772615778
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/26 10:12 AM, Geliang Tang wrote:
> On Thu, 2026-02-12 at 10:04 +0100, Paolo Abeni wrote:
>> On 2/3/26 3:30 AM, Gang Yan wrote:
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index cd5266099993..8b243062009c 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -267,6 +267,7 @@ struct mptcp_data_frag {
>>>  	u16 overhead;
>>>  	u16 already_sent;
>>>  	struct page *page;
>>> +	u8 eor;  /* Is MSG_EOR marked? Prevents coalescing with
>>> next frag */
>>
>> I'm sorry for the late feedback, but the above will waste quite a bit
>> of
>> memory due to alignment. I think you can change the 'overhead' size
>> to
>> u8 and place 'eor' after such field.
> 
> I completely agree.
> I think it's better not to let 'eor' use all 8 bits here; just one bit
> is
> sufficient, leaving the other 7 bits for future use, similar to:
> 
> 	u8 eor:1,
> 	   __unused:7;
> 
> I changed the state of this patch as "Changes Requested".

Note that adding a trailing filed will still increases the struct
mptcp_data_frag effective size by 8 bytes.

The maximum value that can land into the 'overhead' field is
'sizeof(struct mptcp_data_frag)' + 7; we can shrink such field to u8 and
move the new one in the created hole. This will prevent struct
mptcp_data_frag size increase.

An eventual build time check on the max 'overhead' value could be a
plus, but it's probably too conservative, given that max is currently 47
and should not increase.

/P


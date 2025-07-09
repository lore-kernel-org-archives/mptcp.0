Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3E621766A
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058188; cv=none; b=iFhlitTQaLXu8fK2W37x04ejiI48qFv98coCjsGCNetn36Rh6odejgTB1yE7IVjGcqvBbFoRBGtu/I0Tl3XsBRL8tsEWx/9D5NRnQfC/0Rj4GU/sNadYWVTegOn8P9biqdma3aa77prBbx8wHBxMyZi7DCTlv7G7P+j/gfzyN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058188; c=relaxed/simple;
	bh=EPo2KT5dHDHVtiJvMwjx01iuXzKUA/XTITDh3dHF9rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rgvpQ9f2KMNMJ6PyM/v1fRAQrHJcJdkUlIGE7W+XTRAvcNZEJq2YrfvJf8xZlhL4q8orD+cbisvSx4A/Lpkwx41konw5XRVMo6ilmsCFs5q8q2DxD3b3f+aAh83kxkmWK/0DfGE9B+C8OJ8Vw4YXRQA/TAmO4u60s1gzZo9FP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJrWSO4H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJrWSO4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752058184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhzwYE4KQ+baFGuz/Xkp8bCp3O1yGWZP5jJJZ1Lb0kQ=;
	b=NJrWSO4HREGaFGDHi0BcScf4mrkJfjM+j+5RwhvBXBWSZ/2PI0jrC1yCHrXWw1Jhn98XTt
	bmNhbjUQ6OM+7325vdG1tdV8zrEmexx/N3kdsTbwqO37MO3jcpuxifDaVLs1aj8qNMDxa6
	hCGGZ2YJREV9R384yOmnV1BFlvBSKpw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-lUtx6UFcNQOU4h5KqMvDfw-1; Wed, 09 Jul 2025 06:49:43 -0400
X-MC-Unique: lUtx6UFcNQOU4h5KqMvDfw-1
X-Mimecast-MFC-AGG-ID: lUtx6UFcNQOU4h5KqMvDfw_1752058182
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4532514dee8so37701525e9.0
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 03:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752058182; x=1752662982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhzwYE4KQ+baFGuz/Xkp8bCp3O1yGWZP5jJJZ1Lb0kQ=;
        b=q8pdLQm5fOV00AEbzse+XeF9UYhiYU4Oc2fAQApprmUGv0dMfgc6VhYIwDXoAXiojL
         PIdCXh2dtP/gbxlOYpjun64UjVrbcNkL8pTIDjBQjIPKu+Nel/0lZeWMDZRg9bZB8K6F
         45RNlSGd9/mEo2tPbYBBXLAwIepp2WWXJvyrRQl7LCGHmcawxhxJEWLI5wcNnsSXOiOL
         8H826MfYVtTRN3G6KmfEdOjex63Ayyx7eynVYjpb/0HX51z8ZEfvnvOob6DINHodjoQv
         vUoQ0VupQ38PK5RQHxqW4udp2/SJHm1wjUnYZr3FaCVc1Vr3azk7T19NNLKf/SPPgXE3
         HQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTghJcnpiKh9g2O8esdP0mNqDHUL2ceuHx2GvRO091AitD4nNicEcMc0ukCBUs1ugoIrTuqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygerhk0T+NW0jnJP9cYVqWfWFwfdvyxa0G0PVBkVIrzABQ7vbX
	pHyww+MRWwTazDucyLWwcfUNIvzZdw0N/8H2VduedriWeeAx08XegfEb5LFxmzTcUPKmdfex/PV
	8NHEQdCUzChOLbAmO7Q66IhI50nscx3fMlXNwLkdlr/mtxP5KJwzlhk9Xruuvms8+
X-Gm-Gg: ASbGncv4vSmU4tRCzUBO11mRUA0TLJ87rTnq5VfXyU51UT43ySkvAFhS2rMBNOs8F37
	RMFMS40Srzn0KbZDH2qfkXqz8DpOfa9HYPIk2qW4JOwAanrn0QMQx4VPwBUNvZlr6p7jAIUKt4G
	kx1CPW9prn7aKOT2g62W/K1mZlAOqp7l1vnbd6nY/ydCVXhPL8+rirzadlI8ie9xTzspM7thGhw
	OMJIZAxXti9XtW5zibUO5zHOYz3peNI4Kp9hleIy1wxKxOOs3+fuKDI5Ps1Ad6CDxj4BHni4Cnc
	F0joD7GFlawyiVsP3QrjbeQAiVvRjB2u63QPn/sEjgoRZyqmBPvh6NKYxDuqHOwNLk8f6w==
X-Received: by 2002:a05:600c:620b:b0:453:9b7:c214 with SMTP id 5b1f17b1804b1-454d53f20a9mr16792795e9.29.1752058181969;
        Wed, 09 Jul 2025 03:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8xYvd5a55PsesHeeLVReTJlhWLP+sS2h8AYsS7KlHA1bndHurT0qvsqwgqLsAE2Vvgx5wTA==
X-Received: by 2002:a05:600c:620b:b0:453:9b7:c214 with SMTP id 5b1f17b1804b1-454d53f20a9mr16792505e9.29.1752058181484;
        Wed, 09 Jul 2025 03:49:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50516f1sm18408945e9.16.2025.07.09.03.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 03:49:41 -0700 (PDT)
Message-ID: <9d16ac94-c866-47f8-b34a-1efd45149575@redhat.com>
Date: Wed, 9 Jul 2025 12:49:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 3/5] mptcp: fix status reset on disconnect()
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <a5a1798e9f474cf8f8c518ce1b47aebf4b7d5528.1751700000.git.pabeni@redhat.com>
 <a165fd13-3f27-41de-8a51-77ca6838cd72@kernel.org>
 <31fe0442-ab45-438c-abe6-25a9d4f08927@redhat.com>
 <b5ec832f-2fe8-4dec-af09-db0affc3e5a6@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b5ec832f-2fe8-4dec-af09-db0affc3e5a6@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0tEy1aZV9N7NnOscFLnludzNtlrKFXm8mt7CB-HZCK8_1752058182
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 12:39 PM, Matthieu Baerts wrote:
> On 09/07/2025 11:27, Paolo Abeni wrote:
>> The disconnect failure when blocking is not
>> possible should really never be a problem from a functional PoV:
>> disconnect() can fail per documentation and the application should
>> handle that case.
> 
> But it could set "O_NONBLOCK" and do the close later, no? Or is this
> correctly handled?

Yes and no. Meaning the kernel does not offer any mechanism to complete
gracefully a blocking disconnect returning EAGAIN. In such a case the
socket will stay in SS_DISCONNECTING (socket) state until close time.

>>> In which cases is this MSG_DONTWAIT flag set with disconnect()?
>>
>> Typo in the patch, should be O_NONBLOCK. The socket layer, the vfs layer
>>  and iouring could set that.
> 
> So typically what we do in the packetdrill tests. But maybe we don't
> check the returned value?

The only relevant pktdrill test I could find is
`disconnect_after_accept.pkt` and it checks the return value.

Let me check how it will run after the MSG_DONTWAIT -> O_NONBLOCK fix

/P



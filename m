Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05B3793AC
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035431; cv=none; b=WaIeAlSNpcnWNp3gtSecjuzIJ2cgh+jTw+Y1G3RiMhyHrgpFOloAgwhMMKqIgLPjJ2BxyU5KXx4YHOsihKTV7P+s1++cX1OY11R1cJ9pMI60deOdHFFGD00x9Gb5RizaXSa3j6S+F8GfsY3Ptf30LqbLc99SAHQI1r3YlADIHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035431; c=relaxed/simple;
	bh=1DhGW6QGb2ppiiKE39XjrIELL2CgtXtSheYratjOHZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SZoIad9P8bYKQQ9N9mRVNs1rCWPlympHW+mcUYTjrVBumbiNjKva1Vtank19vEx/EbkyVHNSqrrPQsEmNXPBdmEDq5YotN6vfreGckoTu6H1cadeCTMnaKsnaiZWMN2WKAajiQg849l8TjieQAQYDsj4csp9oiOqP8U5GTBtNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDS42nNv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDS42nNv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786035428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mCo3+fgghZ3RTr9p2XbX4DaVllSSeMLsbiNO8NPeTA=;
	b=DDS42nNvofYiSiWdxH7ejHkP4uWJzKIuKXPgx1Cdxe1zGUEdbfZ1GsthpX+2qvLKbDGI5k
	l4+szS42JyVvzphdhb+nH0xSMaXFIpOLUwtNsd+cWnATv9aF8fH59mWARJnF7EYic8fy78
	ZSU+h1SDbMC11uToLVMCUyP3yJwQxnw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-m7u-pBMfOy2qADv51W1Awg-1; Thu, 06 Aug 2026 12:57:07 -0400
X-MC-Unique: m7u-pBMfOy2qADv51W1Awg-1
X-Mimecast-MFC-AGG-ID: m7u-pBMfOy2qADv51W1Awg_1786035426
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955e865174so12618775e9.3
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 09:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035426; x=1786640226;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2mCo3+fgghZ3RTr9p2XbX4DaVllSSeMLsbiNO8NPeTA=;
        b=VEmTr1ZMf2RFgAVr8nTopd2x1dhiOa/KKnTcUzon5CW7Av4j6z0Y1XH2iiNK+Ip+rF
         WpB4If/Xt1pLNmgaxIwsl9C5ph02/1qv4eukyVJFjIKxQJ8PLTgLjfspFIWmXHeR4JCD
         19pC3UsxDS1xu/Ai19uxvl9pc6Qrx1x2f4+oenDAB2Hy2VOfaKeaPelEqpeW9YpyhP/b
         srN3JwfH3FREk7gprtgE/zTbxrLXuykbYsa5zwMRFK+N3pXkR33tAg5V416CugKQIRRN
         ZUZtCsWa6gS5BSsOIdphDWfJi1f++phtVf+RDKWk9coMsBSbE8GWlCBW+HeRj/jjh+xD
         we1A==
X-Forwarded-Encrypted: i=1; AHgh+RrXEf1tqUfp4nkocP4bkvSD1IiowMO1sSAxLAlgv+0e5JVFjM7+hHlriSpXe9jB8Kq6BiFH6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdJPOeW/WogfpUSwIMqmT7/3HLIW0b0a7Hxqqg/lUXfKa24lXZ
	VssHg5WUsdmiDm05AMWA3YobhIef7nFlvMQaz5l1r80xsMQa4kzY6HU4wNyrPXSSzn1kfBkBrXe
	TTgv6FLlrfiJ8P6vOQvAt7qam/H5qvW7Qbjb2EodexqbWhypN1yyyOZZgH32Kowhp
X-Gm-Gg: AR+sD10SyZIWE/xXuyHMFqx7/7PbSNn0N7DtZxftweXs99FJmzgbLnkR/mbMhpNzLXX
	xYSrKQvtKv/QwhMSq9Jk3SZGILDckVmJEo/r0neQXaDlTfEVyyN7XWgfoFxNuy+A3xxsVjJ28g4
	LA0cYhZenbxlornC77Wj4qkVAkPefHVNasRU9DZQkqTHQnTXvNgngY7NAtdzfdFsmMpR6wAIIPP
	E9FRKT+sh1lwDCbhmaoWUBurStAz+aoKLVpQWJARDi18mmRzU//RBViA/p8QNUXLibsxuNThxr5
	XLpHVJgHBm2DFbNYlYQxGs1+86Z3b07gSMwsjYDncz32uNNiERjuSfR44+yE15xdBRBlOGLBAxH
	1r1E9QsDeMjjGbK8aThwdDC/l1XeOcKfh/6jZ9yY300pyDgJ1dQQjCG2nE78nJc3M+wHKMEKL7Z
	8=
X-Received: by 2002:a05:600c:3422:b0:496:c18c:f9a1 with SMTP id 5b1f17b1804b1-4994e7cb6abmr172792225e9.14.1786035426085;
        Thu, 06 Aug 2026 09:57:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3422:b0:496:c18c:f9a1 with SMTP id 5b1f17b1804b1-4994e7cb6abmr172791665e9.14.1786035425644;
        Thu, 06 Aug 2026 09:57:05 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bb88b41sm1708585e9.0.2026.08.06.09.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:57:05 -0700 (PDT)
Message-ID: <47fa3b88-6534-41a0-ac93-81ed87f2f5e4@redhat.com>
Date: Thu, 6 Aug 2026 18:57:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 2/7] mptcp: move the stale logic out of retrans
 scheduler
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1785943854.git.pabeni@redhat.com>
 <57485667802eaecb541c09a3c0964b8528578058.1785943854.git.pabeni@redhat.com>
 <8a3758427e722a547c1a173dff8149c4cd33a479.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8a3758427e722a547c1a173dff8149c4cd33a479.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cNJO_JldZAaVYWdMlAqKlDPyKN95nFAPBHS7GqBl81g_1786035426
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 11:31 AM, Geliang Tang wrote:
> Thank you for this new version of the series. I have rebased the MPTCP
> KTLS code onto it, and all tests passed.
> 
> On Wed, 2026-08-05 at 18:17 +0200, Paolo Abeni wrote:
>> This allow separating the stale logic invocation and the retrans
>> scheduler, and will simplify the next patch.
>>
>> It's also a cleaner design as the retrans scheduler has currently
>> too many side effects. As a possible downside, the retrans work will
>> now traverse the subflows list additional times; that does not matter
>> much, as this is slowpath.
> 
> However, this patch makes the KTLS selftests significantly slower -
> specifically, this test case now takes several hundred seconds to
> complete, whereas it previously finished in just a few seconds:
> 
> 	chunked_sendfile(_metadata, self, 1, 4096);
> 
> Is there any way we can make it run faster?
I guess you test on top of the whole series?

If you tested on top of the whole series, I think the slowdown is due to
the issue in patch 3/7 noted by sashiko gemini and should be fixed in v2.

/P


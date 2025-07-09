Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B8274FD1
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053284; cv=none; b=CgtbDoCsIZdVm2rHQZd1gKmeu5hznanUymzEQGztJYMIW+FFCApeATx2ENUqnHIY6ZizB/XDiT6tl14dGsCWFwE3uFokS7ZO9NTlH721cxm581gfU5llt055QOVClaYDOmiEAmMemx/VpOEWoFav3f67f9Jb6a94vl8BtOdx0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053284; c=relaxed/simple;
	bh=nR5XC6txVRCHY6DgRe+svwlwGPRJAhdxqS/SRXW4O4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RO5a/5RTpk7afw/JZ4bMLwROLDz2qO92Mf6+N+aoEKGQbiUxMpncFbRmordheiQChmWU8o4iV6iBhlg0bBpqjgzJtwbYXS1yyDrwsxjDsd2tGg7LnkWu60e07DO42eX9dnNY4+ug+U396wt8NWlareJ7xynJhNoB3jE+WuvAbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNMO4Isc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNMO4Isc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752053281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8a1D5MFLEr+JjGILDMLDBmsj3jP5x8ri8x1Nf8nXh1Q=;
	b=hNMO4IscFrVL9djdQbYs2/obteVExN/wwqzeWl94GfumDNtAFx8BHNYadeniIyFh9X2IoA
	9esAtA6HINbp6Ld3a+KSkA+g+pY1+oFffaZ+WusThqloUAo6iy/hzEW94GmVeJPMTaKi9v
	gOjW/Y4NyEwy/uN8WS3bD1FoPYtACRg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Ah5WfzUPPK-q5UiLm-RNRw-1; Wed, 09 Jul 2025 05:28:00 -0400
X-MC-Unique: Ah5WfzUPPK-q5UiLm-RNRw-1
X-Mimecast-MFC-AGG-ID: Ah5WfzUPPK-q5UiLm-RNRw_1752053279
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a503f28b09so411795f8f.0
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 02:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053278; x=1752658078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8a1D5MFLEr+JjGILDMLDBmsj3jP5x8ri8x1Nf8nXh1Q=;
        b=YrNRf65Z2SD6BFc9O8UvD0gATMx48sTv5/qEmsBmnI7s6LzAA/b1tLMdQ4Fzjio6ER
         rUSEDy4FvCRiNv4vq0tziJku+pRGOfZbDvmMZ0CxKom9KZVUuxXG4Wyee/gkTb+h0uFe
         aloawdKBpwp6NGKuJd5D6Lyp3fXhZk5B9DumprZ0BF369e+dbGSpTojGvePI4pcNKFGD
         ZdwKfKSLiyHDLWkuzvOziyq5bokpVNl7vVr01OX+/+Y6vSmb4dPdqEJlhnl56TjHXPcY
         KxCtN8Oyw5/m7e7AbEkjV5LfRYk2nIiEl7subbGAgOCH04MyMEJ1pDal2zIf6/gDEUUi
         6+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6NRHPugcXhODE05cagb8UB5xDMkiO/ZbzIpEMtD2LhthVUe+pbk1PScOVAn3Ib6q8dbR3pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnpJCJYJ/xxpPAkEeXyjWbr7juHkoA3r5Nwi+Qti0RT3yIQcSy
	sOHUtAizW+MboHSO3qFE0MtrpawqYsZEEQFh/0oNho3qjDRtUAmWf/VUvCDl3fzZYmgtR7y6t7N
	36ZToYqPF7oMbNeGprICHgwRMZ1TAehAHOOtVhc6pm641yAlMLf5jSCX9A7qTLg6R
X-Gm-Gg: ASbGnctTIy0KT37SyWieNiO3odhGMKadHVPIUbOUIQ60Lgs1Fx1oPUItDiXN6uIa9HW
	7ceWTiQR/1mdetKJOzRwgJPrM/PfV56Qc3eeembUwLn1LPj3C+i7GwHgHHRoicswdroGPKz6gyo
	JNAMIHKYG9LEEtm0mFpAr0/9UMCXTKZvXa+egL5SI7NnQS5IYjvYkJLVBt8po69i8Gi3hort8/s
	kyihv78r32dlQ3Q7Ljd3zQL5hEGiT1rb6fyzwI0+t+15N3n52CehgqBVfgRv059ZgkLWiK/mSLD
	KZqwoQgSoUzKRhlb9pSU5irB6n4pmmFHlyQ3e8zRJwtZxtgU28UpQBjpSwBeOlu+Ejgwjw==
X-Received: by 2002:a05:6000:2f86:b0:3a5:2b1e:c49b with SMTP id ffacd0b85a97d-3b5de0359b2mr4907521f8f.29.1752053278514;
        Wed, 09 Jul 2025 02:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiLsURL7cziAt10f32w/qhoPeFI2dwaA4oC5u0w25/FVmnI9UR2QxS0GGUrxi2B1iSwoBxAg==
X-Received: by 2002:a05:6000:2f86:b0:3a5:2b1e:c49b with SMTP id ffacd0b85a97d-3b5de0359b2mr4907495f8f.29.1752053277977;
        Wed, 09 Jul 2025 02:27:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50616dasm17114835e9.21.2025.07.09.02.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:27:57 -0700 (PDT)
Message-ID: <31fe0442-ab45-438c-abe6-25a9d4f08927@redhat.com>
Date: Wed, 9 Jul 2025 11:27:56 +0200
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
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a165fd13-3f27-41de-8a51-77ca6838cd72@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 75NsWe9ymFf3dcN_tCpjDMHD1QJ9zkfBkgJ7IN2uVmQ_1752053279
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/25 5:43 PM, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 05/07/2025 09:24, Paolo Abeni wrote:
>> disconnect() can still race with subflow fallback leaving the msk in
>> inconsistent status. To avoid such race, disconnect() must be blocking,
>> error out if the argument prevent such wait: the socket will linger
>> in SS_DISCONNECT state forever.
> 
> Good idea!
> 
> Just to be sure, this is not really a behaviour change compared to TCP,
> right?

Actually it is, as the TCP disconnect never blocks. On the flip side the
race actually exists and I haven't find another way to plug it.

An alternative I thought about was to create a new first subflow on
disconnect and let the old one 'detach' from the mptcp socket, but that
was problematic as the 'detached' ssk would have a NULL subflow->conn
and currently we assume that to be ~always != NULL

> No risks of breaking some cases? (io_uring, etc.?)

Do io_uring work with mptcp? The disconnect failure when blocking is not
possible should really never be a problem from a functional PoV:
disconnect() can fail per documentation and the application should
handle that case.

Blocking could cause some additional latency or slowdown in that code
path. I think it should be not problematic, but I have no real idea and
tend to be too optimistic WRT this kind of issues.

I suggest not sending this to stable (with a note in the commit message).

> In which cases is this MSG_DONTWAIT flag set with disconnect()?

Typo in the patch, should be O_NONBLOCK. The socket layer, the vfs layer
 and iouring could set that.

/P


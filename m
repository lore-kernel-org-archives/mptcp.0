Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07391C120
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530615; cv=none; b=usvABejiQiLsMXUxsG7reAXJoOdZmrLthRNSpQpsVRgjsmkgBNj3GBcLh+OmKARld8VdhhSejjPovcB1v8kHgVovNOn8nJvIkWpAvRcR1i/N9RjjtoIbp7tlqBhkxmETt9OSr5oJyvAPS/jOgdfbX/UMlZfDRo1uAvoeZf7qJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530615; c=relaxed/simple;
	bh=uCjQigN1kRw0t7XsWjmYuaX3+BYKWmhFyIbl8FVFBV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URcF5TeVRQ8J+ghkD3jx4iZWaMtYV8ms10FNOHYcZGDDUIbJBUpcmaKIvBfGSHL20SUBVAvcIGX8Ao/VqAit1TlTZc6PgJOuZHfOyLyiRvaQJM/j2e6ptfYfTAoThNZ3irFJG2Uk+TaklxkJ8skuwIxHSySvjLYMpP7DAOR/rS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLW/LZSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLW/LZSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758530613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ2GYE75Xp41QnEOMB5k79JqmDsDmnnSVEv5VyuVeJw=;
	b=jLW/LZSFLX4KKSsWHqh1AKHMgodF/EuBoe3fqS1XhiIuW+XP/PZXTvs7vgVzGw9p5CUIgU
	5vluJLcPspaH15LetDppsgT4ipmJqBhOsQb5t1Y8V28dRhI62q3o8OGmGlCITkX/CME2s5
	kJMlyJB1FB/V8ybQTEiFcFY1y85HOyA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-F2BGaCB2N1qxyypkQ477ng-1; Mon, 22 Sep 2025 04:43:30 -0400
X-MC-Unique: F2BGaCB2N1qxyypkQ477ng-1
X-Mimecast-MFC-AGG-ID: F2BGaCB2N1qxyypkQ477ng_1758530609
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so826992f8f.1
        for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 01:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530609; x=1759135409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ2GYE75Xp41QnEOMB5k79JqmDsDmnnSVEv5VyuVeJw=;
        b=mupBgf5BcKlrRPU0YLAH7K3o1YJYxJrXdlyE4xo8/irYxE6sdDVVofCypjP0Q4lT+B
         1Dxi8JFRORcumHsY2i71xnBkuucZXE/lTH9veEkb1nPYjliAtqBvlVyNsCcikHShcxVG
         0G5hMkjXuIc/HlvNWEzvEIk+slomGD/r5tJ3gl1xw8l89/DrQa1jYmV0OUIZ9RhV3T0z
         VRLB4bpdcFShLhQ54cIvR6EWT/HKFNPw0TFvxVx6awVenl6uOaGvIBM0rWy3GrUd00Or
         9az+SmWUcIk0uM3IaUdo0u20yQPEnqeIP3Nf5Vo5x2n6ZwoUdsw3X97dBpupvfu0sXy9
         J8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWunGkneM94rx8E8sAg8McyhK1wiB+8yfCdeO8knqMqURc6g8jwWOO/6LZ+b59sL27sOs1lFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMOABBSog2gkkOp53SUpWZbhYTTf5ZY/wpa07jmZyyJvYcK0Gk
	Nm7D3AJ0C69XXGkr3fraWaMlmYSvTXtCVCvxekYMH5CEb6fdSbvSiB7er1VlQeZj075Z2mWQ4HH
	DoDu45IjapDEZP26K9MUhsmW507qsSGH7n9nHgrqkCWq/LkZnaX7ItC3b
X-Gm-Gg: ASbGncsJT0QX6Tox57ZohzRTBkEKh5oIwvXG5Q7L073HrrPEq4cSW2rkItjIUFB9LFO
	bPNr1/HTMC3/UXxheNcDbkfDg/LSzO0Z7NxUGk/dNk+ADVN+twQmBawKAhvYwzY6VN93IbiGguK
	X8J2NUcqQu/wUlVbxOtxSlF9KOFqwQT5V5kDg2tNKz5X/Fd+/rbdnvdLctLI9VkzcLVWeizTy+d
	fziNiDT7YmnyY/J+JqVIuqJok0VAYR3g/V46tif5bZM84y1ViLj1c0UTXFEJqbqB1TEjUqznoWn
	WKeDFiQBCv3FP0KrvqH40lNLClE27bLyWWsnvJCWIUw1wmZABbT+/i7TQLKCssGnX/K6KOzERw2
	J/1YjTqe4EThN
X-Received: by 2002:a05:6000:2f87:b0:3d0:e221:892e with SMTP id ffacd0b85a97d-3ee1dbb6b17mr11556812f8f.27.1758530608709;
        Mon, 22 Sep 2025 01:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO8dEAeTUQPoEtxWjc/krfU/A2K3LXmTeu4Aomkb7KAHkc8PvelVc/GI1fP8st/EzeCdBZhQ==
X-Received: by 2002:a05:6000:2f87:b0:3d0:e221:892e with SMTP id ffacd0b85a97d-3ee1dbb6b17mr11556793f8f.27.1758530608345;
        Mon, 22 Sep 2025 01:43:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f00cc58b91sm13019547f8f.1.2025.09.22.01.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:43:27 -0700 (PDT)
Message-ID: <b225ce15-3af7-4dc9-99ec-b19bf0bbbeb4@redhat.com>
Date: Mon, 22 Sep 2025 10:43:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 0/2] fixes for "mptcp: receive path
 improvement" v3
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1758339666.git.tanggeliang@kylinos.cn>
 <1f39fb1b-8fab-468c-9a6d-f80c5eca186a@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1f39fb1b-8fab-468c-9a6d-f80c5eca186a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: op7PUCG5PK4y53qJyaz2X4klIuKYMU1Jb3gqTcyFSV8_1758530609
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/25 10:35 AM, Matthieu Baerts wrote:
> Hi Geliang, Paolo,
> 
> On 20/09/2025 05:44, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> Try to fix errors reported by CI.
> 
> @Geliang: Thank you! The modifications make sense to me.
> 
> @Paolo: do you want to send the v4 series to netdev directly?

I also have some questions :)

Does this follow-up address the CI failures for good?

I think patch 1-3 could be merged and export and send to netdev. Patch
10/10 is possibly a little too invasive at this to enter 6.18 this late.
I *think* it could wait the next cycles (together with all the pre-req
and follow-up), but I'm ok to go ahead now, too. (But CI has to be happy
before sharing on netdev).

WDYT?

/P


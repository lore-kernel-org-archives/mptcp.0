Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A76AD53
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 09:31:10 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso2158455e9.1
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686216668; x=1688808668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RveStrw+qnC+IelThp8LM34IajTyvBDfcWZZ3N9FL3U=;
        b=No1G9E/LOIUajD9POlpC8lOtjDWnUKut64IB3vxOHRKpljL2e7D9hDbqpmEfMX60iq
         qwgvc+5U5j6jjp+hSpOYfglZ1CPBKIR8bvJc6nxK9yZvXmd0YT9wRdBKe+oSeQIdESw0
         HA5HG4/gcZbmCicctzLWciRJ+V434HMMkcbwjjGGNvppja3lEwGg7RrIYrXcvYadIU2k
         c4xNK98eqvTkLsKaoFeVSISVzMjrGlToynaaFQZ8hwDt4RmK7UQtfxUCO5gILCHYTOhi
         zauyjp5/3arxij2co8jfv8Q6wFu6SdWucbz74q1whIKaqVatX9+lHUPoqOtLhXsR20OL
         n3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216668; x=1688808668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RveStrw+qnC+IelThp8LM34IajTyvBDfcWZZ3N9FL3U=;
        b=BOQ96hdX51gA6aGAkw2/wA4vg9SXxgaFO1gIr1a6EzQtaldGcQllrlR5TUVa5ca36g
         IMwnlDjkGK3Ip7R7bdjfVlaEb4G/smuKeaMcXOIc583sanIfoEJd1ENlvoS7R2oOMuWb
         /pGFmH9VIY9SHPCQuO9ML7PY6YZjpGzDa5wPaVUwRmkCllP44K9QKCq1FudWHi+6oT6c
         DXF+2UYKm8WFyLoe5qGppZuVJwJ0JlFNCnk+v3waT3gX1AcIc+euauQZOwqPDRw0tcyH
         XZF3Tol+VH4IpnW/kiukaPCQO1NemUj+3k68JDSQshdUOZtNmkHnnT0Y9x98Ctz5IJcV
         vIAg==
X-Gm-Message-State: AC+VfDzQpfOsY/XCM9MEABoS4jak5gUxJHRrEJpCqg1e62CnKRRpNfv4
	8zUxQ3rcLaxhTCFa+rDkk05Ws1t0lV0vHd/w6P4dNQ==
X-Google-Smtp-Source: ACHHUZ7/D4gfL3Okh4NaUlLL2QLAh08FTgR8bEPjUlsx5KY4RPOle4ov4Y1ItvTlPM2ZXro8V2bVDA==
X-Received: by 2002:a05:600c:22ca:b0:3f6:f7c:b3fa with SMTP id 10-20020a05600c22ca00b003f60f7cb3famr833844wmg.31.1686216668295;
        Thu, 08 Jun 2023 02:31:08 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e0ac:edb8:d8a:7342? ([2a02:578:8593:1200:e0ac:edb8:d8a:7342])
        by smtp.gmail.com with ESMTPSA id u5-20020a7bc045000000b003f709a7e46bsm4608114wmc.46.2023.06.08.02.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:31:08 -0700 (PDT)
Message-ID: <be966876-ba83-db95-755c-c83d21f78379@tessares.net>
Date: Thu, 8 Jun 2023 11:31:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: mptcp: fix potential msk leak: Tests Results
To: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
 <c83d56bd-9f91-7da8-068f-31da06bfd71c@gmail.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c83d56bd-9f91-7da8-068f-31da06bfd71c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 08/06/2023 11:27, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:

Sorry, please ignore this report, I accidentally accepted the
auto-correction of "patche*w*" -> "patche*s*" when applying this series
manually in order to get the CI validating it.

I already started another build:
https://cirrus-ci.com/build/6429875590922240

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

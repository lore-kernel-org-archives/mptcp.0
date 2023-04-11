Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F028EE
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 15:18:16 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso16893727a12.1
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681226295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWUNQnZ5IGLENSlcyE5EnzDCOGMpMV3nVoWoS6ehi8c=;
        b=2KXc5K+JERqBBn5ckTbdEEyZ9AHrPaXxlcrFilnT2vVOemhWUMivSkuOd34Uzwd3PK
         +TTW8L1KxZ2S1rZlJN8QZ+146m50Zu3o2kqkCeHgt5aMru4C7+qgJrkbpjtilGO6zzeB
         SVqBVVyWU6Jd/k0gYjVpHYLRYw3juvdt8IDrPBU1ZvcemM4D3FmzTZYebQ5M5yuc7x0b
         kKHkjTcF83O2LifZtygCyn80KgwJhMauSd/NuXoycgflCKkrD0P1SdOswqWjcrCia1G1
         Pu7kmP96K5g0lY+4hQj7EzKge4cn+M2DNCIk32hgYPbe3JNOfQJKmY91j6e7N6BsCC4+
         IOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681226295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWUNQnZ5IGLENSlcyE5EnzDCOGMpMV3nVoWoS6ehi8c=;
        b=YuMA//l6lmR/QKN1vCIYDl5e6BCEBY4/DPDVj2CbWAAL+asWcpUusNZUCai/K0/hNv
         PMGEde73vDa3aZVtSrAnub8a8czoSbMKBxCiqYkNRNixPs7pwclSEN94GRQuL+duoB9V
         2/kRaLyPKSpqw0Bj/9SZyY7KNsMjTeEFJDHnBafX1uw3eMX50xJ3YI8JZBBuYL+NYOXA
         phPPolHQuf/VprIzhLf4i3UBW2E2F+bsEq5fEUfXS/GixPFTeehQtppUqtMTr2ndltL8
         hPQjjYP32he5JDFZFI27m6or6pZYoctG0Y9rtFEACKISMXMQNi90md26xovGdArG01V9
         vB6Q==
X-Gm-Message-State: AAQBX9eiXw8LdILLrVXqVzE5PUJRvPDxveKE9x+mH/tb9mv/m64qBsWQ
	h3GYjIdRLy3YPkUNdKZKDKP1QQ==
X-Google-Smtp-Source: AKy350aJbmjteQ+ozupIW517GyMUz9fQPPw3r8jV9eNskE92l7+OtsnF/OTuCuhlPDGOOCELTQ5JtQ==
X-Received: by 2002:a05:6402:26cc:b0:504:999f:525a with SMTP id x12-20020a05640226cc00b00504999f525amr7267773edd.20.1681226294935;
        Tue, 11 Apr 2023 08:18:14 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906021000b00949691d3183sm6204721ejd.36.2023.04.11.08.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 08:18:14 -0700 (PDT)
Message-ID: <f83fe4a6-8d42-cc33-6f51-9e4d4086024e@tessares.net>
Date: Tue, 11 Apr 2023 17:18:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH mptcp-next 0/3] mptcp: misc. small cleanups
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Abaci Robot <abaci@linux.alibaba.com>,
 Mat Martineau <martineau@kernel.org>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
References: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
 <1861e413e6befae96bddaa8b7ec25b52b1073c3c.camel@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1861e413e6befae96bddaa8b7ec25b52b1073c3c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/04/2023 15:25, Paolo Abeni wrote:
> On Wed, 2023-03-29 at 15:17 +0200, Matthieu Baerts wrote:
>> Here is a series of small unrelated cleanups, nothing very important nor
>> big.
>>
>> I don't know if the modification of the MAINTAINERS file should go in
>> -net instead.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> Matthieu Baerts (3):
>>       MAINTAINERS: add git trees for MPTCP
>>       mptcp: remove unused 'remaining' variable
>>       selftests: mptcp: remove duplicated entries in usage
>>
>>  MAINTAINERS                                       | 2 ++
>>  net/mptcp/options.c                               | 7 ++-----
>>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++----
>>  3 files changed, 8 insertions(+), 9 deletions(-)
>> ---
>> base-commit: b2c5489c86ee1881dae3bc431ff6f284eb74f7ef
>> change-id: 20230329-mptcp-misc-cleanups-90754eb81610
> 
> LGTM, nice cleanups!
> 
> For the series:
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the review!

Now in our tree (feat. for net-next):

New patches for t/upstream:
- 144a31d2ebfc: MAINTAINERS: add git trees for MPTCP
- 4cd4a5a79d58: mptcp: remove unused 'remaining' variable
- d61fbc5070ca: selftests: mptcp: remove duplicated entries in usage
- Results: d11915457436..34df362b6d0a (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230411T150102

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

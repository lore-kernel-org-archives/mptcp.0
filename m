Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B9D50F
	for <mptcp@lists.linux.dev>; Wed,  3 May 2023 12:36:17 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-2f7db354092so3212257f8f.2
        for <mptcp@lists.linux.dev>; Wed, 03 May 2023 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683117376; x=1685709376;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBLrN5VmbdyK7a9XWzXkgcsghwjXJ6g+eQT1tv8EkCg=;
        b=t+BW7jtsA00/d1KxuqtfjaMDB0oOq9hrHEmARrQI36oQfxoA/epHyVTInSNEnanrbp
         E+yxZ+2Y/x5wUFTlpIXuuOcp051mZaquHdtom74OhPB5coDLrKW2isGzOiYhKLMmycUs
         XTXjUg3Qb7OX1a1U/wrQjZFahRurDcC68aA8lnE/uMgf6i00FLSLQwOJWY9/1leSC4eV
         XDqRAOymLtRxzhJMUz9gIxu4fsc3ahSj3uSeq16Uq2BqsbRzlicS9f1Il6dKyVOOViLx
         nwPWOytNzXFPQTK9wU0md2eRjfcAsYkW9s5GfmTH0Lr/1vePENj0VbE/a3J7J+6eSvMi
         r3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683117376; x=1685709376;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBLrN5VmbdyK7a9XWzXkgcsghwjXJ6g+eQT1tv8EkCg=;
        b=dy2BQiBGOyxqdeScLrJOHphxN3SB6gBEfZkcJoVauGYwSB2039kpU2140gZ9pGY5QF
         iPcj6EP6TuoxZRqc7Zv68luelhi9KEjjht/W65ge5ywlgPoc5oVKJoYiR+Yhzv3UYzOb
         QQETsNCZPGZJMTef857tkFuhoYyKbAL6kAPcQ1jg+zPQ43WLsfSnycb9WwalMEbCu9E7
         4bShqzDFLs67FtFK4L6g5XCPUyB6NbRK6bv7DUIEVfk7AxmyD2B3W5NxP81+haPC3wsI
         WePeIa1UsxacK0LJRXojaHeUJsMp6f7dep2DpfH2mF/22jJbgbgcR1kWV+jqtEefbQW0
         eifg==
X-Gm-Message-State: AC+VfDzxvjtbOJiH/d7+aiJhsS6G4mBS3V7GtyN26BNgBevkPOifhtme
	9dVV79P+B++9OPYl3LH1jDeY1A==
X-Google-Smtp-Source: ACHHUZ5EaqUhX3TOQegMnqgnd+O52sgmJipMo+bYwlOMUWVwm9wotMFZHyJdcLLO0Ss5IVhN8DNezw==
X-Received: by 2002:adf:fc8e:0:b0:306:2d76:4306 with SMTP id g14-20020adffc8e000000b003062d764306mr6577349wrr.56.1683117375777;
        Wed, 03 May 2023 05:36:15 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ffdc:60e3:7c6d:ec67? ([2a02:578:8593:1200:ffdc:60e3:7c6d:ec67])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b002feea065cc9sm33704630wrv.111.2023.05.03.05.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 05:36:15 -0700 (PDT)
Message-ID: <375a40ab-c299-1555-4828-fde379b2de18@tessares.net>
Date: Wed, 3 May 2023 14:36:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 mptcp-next 0/3] mptcp: add more mibs
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1681481877.git.pabeni@redhat.com>
 <71b42aeb-e405-d65b-6028-ce7ab0e55134@tessares.net>
In-Reply-To: <71b42aeb-e405-d65b-6028-ce7ab0e55134@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 21/04/2023 13:32, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 14/04/2023 16:19, Paolo Abeni wrote:
>> dumb cover letter for CI's sake.
>>
>> Slould be applied only after the current tree has been crunched
>> by syzkaller for a little bit, as this will likely change quite
>> a bit the timings of some critical path, possibly hiding old races
>> and make more easy to reach other ones
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/378
> 
> Thank you for having looked at that!
> 
> I have a small request in patch 2/3 (and a question in 1/3 but that's a
> detail) if you don't mind.
> 
> We can also apply the patches and do the suggested improvement after if
> you prefer.

As discussed at the last weekly meeting, I just applied the patches in
our tree (feat. for net-next) with my RvB (and without a typo):

New patches for t/upstream:
- 11f98962ef03: mptcp: introduces more address related mibs
- ae2301fadbf9: selftests: mptcp: add explicit check for new mibs
- 3001ad5baef7: selftests: mptcp: centralize stats dumping
- Results: 269bb6df6e7f..b2cd747b2dff (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230503T123221

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

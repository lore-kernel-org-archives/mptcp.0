Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228EED2
	for <mptcp@lists.linux.dev>; Wed,  3 May 2023 10:04:33 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f1950f5676so50844855e9.3
        for <mptcp@lists.linux.dev>; Wed, 03 May 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683108272; x=1685700272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/V9xDE7J5xmGY0DjC+cg+8Wz8Nir8tUJR0/iyHrauw=;
        b=FmN9zwH+OG74biIfYe80o2MjJhKMgsrOPiiSr7rwKuOlI7L0A2z1vBudNlkfHf2Mrz
         sMD8z/Vsi6q+uo9UuLEDLrDM/TP1+p/pk/cX/xctorOupoSgXaByo1CUNV4ZroHwXO/o
         SAd8Sel3UNCOyQBgIYtgpUnHx9zLl7GeMX/J+h1dc2LNoHuphM/AvrHKxra0H+O7rPxQ
         v03piaVsXoO0FKAeuwwdz4S0JsiesK6Y8TiYyQt8YX7wv3BZ8rBz1XlJ1vCSYj/rcVo3
         zmlAhWBImljB/++XQ61z8eUTjhb734Ee5p8cWolTxhPa/El5azvchftJAF6L6ilAgrq7
         4x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108272; x=1685700272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/V9xDE7J5xmGY0DjC+cg+8Wz8Nir8tUJR0/iyHrauw=;
        b=eCEqj3sJ7tx5DIqjFxAX38Y7BYsG/Wjt7EW47EY0WEM3ur73pXUnLEDn5jzSwZM6dh
         +kE5Z4kF6RzNBx/Wmdmu4s8vGNOPMX77pW4MBqStkk8JoJC6BwKgxxIUEWKTbwJdaouG
         S3PGoEOki5VPDyI9pD7WodJCRpmlMotR2DBN1aQsRYQ7Lxe8qiIJu6qx1VsZyWn9Wb5k
         UjhTXRmOkfJpF69UF9pY6vYQIZSj66RrJ/b5IEkRN2+KOArSWQuff0whUC2tzOzQK7rd
         kAYRX5n3dR9L6s0E0Ngexx0trqXpDvKFm+jCMIoqyfetZChhuDRxrCrTc1OeIw87rX5N
         6wfA==
X-Gm-Message-State: AC+VfDxh0L6ww/Q0XGGVAu29A1R3heSyVCnYwOCnpVYZ4iaOYam9RdST
	sSav3q2XIGhSE8drh+T/esBuJQ==
X-Google-Smtp-Source: ACHHUZ5ISr/DTdCSRBN51+LRqm2XBeZKBTVUWV8cT70FLluu2B0kkA+gfcRYikNFCqHhd4K5esojUQ==
X-Received: by 2002:a5d:5689:0:b0:306:44a9:76a0 with SMTP id f9-20020a5d5689000000b0030644a976a0mr846731wrv.9.1683108271822;
        Wed, 03 May 2023 03:04:31 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ffdc:60e3:7c6d:ec67? ([2a02:578:8593:1200:ffdc:60e3:7c6d:ec67])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600012d200b002ceacff44c7sm33468369wrx.83.2023.05.03.03.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 03:04:31 -0700 (PDT)
Message-ID: <4bfffe32-e967-5c9d-6799-866f72bb1422@tessares.net>
Date: Wed, 3 May 2023 12:04:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-net v3 1/2] selftests: mptcp: join: avoid using 'cmp
 --bytes'
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-0-eab5dd7bc996@tessares.net>
 <20230404-mptcp-selftests-join-busybox-shellcheck-v3-1-eab5dd7bc996@tessares.net>
 <75508308-c622-654b-94b0-e08d923934cc@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <75508308-c622-654b-94b0-e08d923934cc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 26/04/2023 16:36, Mat Martineau wrote:
> On Wed, 12 Apr 2023, Matthieu Baerts wrote:
> 
>> BusyBox's 'cmp' command doesn't support the '--bytes' parameter.
>>
>> Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
>> failing [1] because their 'cmp' command doesn't support this '--bytes'
>> option:
>>
>>    cmp: unrecognized option '--bytes=1024'
>>    BusyBox v1.35.0 () multi-call binary.
>>
>>    Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]
>>
>> Instead, 'head --bytes' can be used as this option is supported by
>> BusyBox. A temporary file is needed for this operation.
>>
>> Because it is apparently quite common to use BusyBox, it is certainly
>> better to backport this fix to impacted kernels.
>>
>> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose
>> test-cases")
>> Link:
>> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log [1]
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> v3:
>> - use a temp file and remove it in the cleanup phase (if we are really
>>   unlucky), from Paolo.
> 
> Thanks Matthieu, looks good to me:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Sorry for the delay and thank you for the review!

Just applied in our tree (fixes for -net)

New patches for t/upstream-net and t/upstream:
- d8a6b5ec95a3: selftests: mptcp: join: avoid using 'cmp --bytes'
- Results: e37659a7613a..a85016ff1282 (export-net)
- Results: fec4b70c0183..269bb6df6e7f (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230503T100234
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230503T100234

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEC7B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 10:28:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f19c473b9eso76181555e9.0
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 03:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682418506; x=1685010506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEuSaO7ye0d7L/Fn6ODCec/5tPZxUWg5jzZx6TpD/xI=;
        b=e/0fyxvqp10ZjKkYqX4sH9nrLBsrbDSaDu8D79FT7QxUJvlP28xoQcxTvbobUO2fXq
         60HBkuopY9z4jjtLY81LSGcqwFBWbt4ed0ssfD141zxLjZIXXKHQ8wA1YglJ9D161lL1
         5Ua/EMa0weazle7HLCSegTNU8xcw3x4zZnGelZudUtnI6oNRFPADxyXehkmiRsjIfR45
         2oYlfZbFX8EXKAXGRce8hnrGSzwKi89hVCQsleXokpkXU+Ig6tcIBI+2lIz1AirnQV5c
         sgQy/E9V36Apw2yzC5o35e3ejdthRgPIepOHAXNl5N9kIz4UVjb3IfCiWKEH0xmCeqB7
         Zl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418506; x=1685010506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEuSaO7ye0d7L/Fn6ODCec/5tPZxUWg5jzZx6TpD/xI=;
        b=idhn6h7Tm6KzAHdd5uOm0wK7MKjM+rfi4um1LkkzewQp07bdrQnWNnlmp7iYSY03/T
         TleVv/pD9zkcxnxmQWbTAOpPZctAsxDiIhxXanxf/FwbnsAxjQXNh0fbERWxTd3Bb01s
         UWuAPPIpKf/HJeURjCqdi6i0zRLbJ8sGV0wxFvOBOhmOQmLpjXfUwL3tjKmwBN851LR+
         NlVG9gjZR6gC+eCPpD5S92iVVmirNCf9ytqyoeTCvbhv4M7gogwUImWvKUwoohGDNqjM
         G0G/BH3KTpR5Fw5R/ZhFIE+fmag5fCoOqh3MhopoY3Zx1E/SQzkcRyS73ajF8r0ZEDbw
         Rk+Q==
X-Gm-Message-State: AAQBX9dvlGdaNTMICUy2FhRr1krsKPIMn9QlqAE2CbOxS/muS5d5OFdP
	hdropHCFdb6xYkQvbMQuY+CCvJF4hq2ewZuYCEricg==
X-Google-Smtp-Source: AKy350aAGoZmjbJ1gbVHb/3ARhjyqFciMARUtFgF0LwICXV0V5XHCXPaJr9W1aFK2W4z2ckHZvEKAg==
X-Received: by 2002:a5d:456e:0:b0:303:68d5:ff91 with SMTP id a14-20020a5d456e000000b0030368d5ff91mr11496695wrc.29.1682418505858;
        Tue, 25 Apr 2023 03:28:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:61cc:5ecb:aad9:418c? ([2a02:578:8593:1200:61cc:5ecb:aad9:418c])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d5643000000b002e4cd2ec5c7sm12743613wrw.86.2023.04.25.03.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 03:28:25 -0700 (PDT)
Message-ID: <a6bf07b0-9760-dfce-e1f0-e8bc19d6839e@tessares.net>
Date: Tue, 25 Apr 2023 12:28:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-net 00/13] selftests: mptcp: skip tests when
 features are not supported
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
 <03935b76-591d-85af-ad97-62c5ed5acedb@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <03935b76-591d-85af-ad97-62c5ed5acedb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 25/04/2023 01:47, Mat Martineau wrote:
> On Fri, 7 Apr 2023, Matthieu Baerts wrote:
> 
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> These different patches add support for older kernels. More similar
>> checks will be needed but here is a first batch not to have too many
>> patches (because each patch fixes different commits).
>>
>> I tried to minimise the modifications and do the checks from the bash
>> script not to have to detect the feature when being used in a .c file,
>> then pass the info to the bash script, skip the test, clean the
>> environment, etc.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Hi Matthieu -
> 
> The "skip if MPTCP is not supported" patches (1-7) and patch 10 (missing
> ip tool) look good to me:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for having looked at these patches!

I was already working on a v2 and these patches will be slightly
modified. I will not add your RvB tag right now if that's OK.

> I have some comments on patch 8 and related, I'll reply separately on
> those.

Thank you! I only saw one comment on patch 11/13. Did I miss something?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

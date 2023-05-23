Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4E1B91E
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 09:01:53 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso22293855e9.1
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684832511; x=1687424511;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+TtD6WdZ518WYTpBN+4DMSmlb60cvl1VLx5NvSAcxc=;
        b=bvnsVY93hdbTP52cBPLkemLwYz3kQfq6TrgtRUc4emeSm2GRh+gX+yWXmyQS5cxM7f
         5g8fWDRyJ4FRz21AFuz9Zq3YuqGnmX3gxthJBzw0XXmAxBuQnxj3M9GF4GFclxJE0y7R
         ZsnRM3JBVYYOU6HfuOW8bKu/L1vy2C+Aa4FstaSmrdjCF30e7tohj9CB4QE4JMQyTbhS
         CMUrDCw/9jcmgzTHST9iw9JEYboYZEw+oiL0kVV/foMOpxnjo1g5OJGnEk/3/4i0rJGX
         gxG1B28nBuHP02rW+gihcb9yA72u5VsidTGC3z0+S6uQ0moExrf+V1U+WcDwCsfetVk/
         s9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684832511; x=1687424511;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+TtD6WdZ518WYTpBN+4DMSmlb60cvl1VLx5NvSAcxc=;
        b=E5xqvpJVtG3N44uz0i9sEWNaC1u9R0zxiN4lz6iiZFjeMpC18LkJ8KhebWY5iGMocN
         l5FZoky0FSOeohmDywj+2RKPfDi6uTOklABXa2dJSdEamVpTesDz1dyO4kTsIaI0xm/Z
         vt6beBDsFoP34RT24SzzbPD9i0kPkjnZiTRHLOJBIMEnD1FOp0QTtmakSkHUMkuO2Vw4
         vKRGJxldh7EQVAHLCuzQBABz38CyrsgFphOD4wxuMg4IqXnnKXe04PP2fp4l4+Sdc2An
         4Vkd8lP8X6oQq8nygdShFPcWrnQt3Ha/3bIRV8KEXydf0v41/+SXyv9A8k6DE/ETod1C
         JaYw==
X-Gm-Message-State: AC+VfDyf6L8nRQck7H4RQ3TUiAOmCU96+GNe5MNZEATs20pnkfk1Ml0K
	7Pjpp+A4Cn2/awLGYkCbaebJBAiRbtDOBUsq+BMF8A==
X-Google-Smtp-Source: ACHHUZ7QAZxorIPu4bRRyybbCCs6Svf8DuP7IWj/BWVV22K5SmM2Sh+yei7Uvjv+6Fv+vq7Nsy4drw==
X-Received: by 2002:a7b:cc11:0:b0:3f0:9564:f4f6 with SMTP id f17-20020a7bcc11000000b003f09564f4f6mr9482875wmh.1.1684832511247;
        Tue, 23 May 2023 02:01:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7ae3:96f4:110c:3f46? ([2a02:578:8593:1200:7ae3:96f4:110c:3f46])
        by smtp.gmail.com with ESMTPSA id a23-20020a1cf017000000b003f17eaae2c9sm11124653wmb.1.2023.05.23.02.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:01:50 -0700 (PDT)
Message-ID: <a0d10d10-99b6-c0e6-fb09-1df60cd60920@tessares.net>
Date: Tue, 23 May 2023 11:01:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net v2 07/37] selftests: mptcp: userspace pm: skip
 if MPTCP is not supported
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-7-50313e4f83ab@tessares.net>
 <12e78465ce6246a7584c5cff78906cbee72622f9.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <12e78465ce6246a7584c5cff78906cbee72622f9.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/05/2023 19:34, Paolo Abeni wrote:
> On Mon, 2023-05-22 at 18:37 +0200, Matthieu Baerts wrote:
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting MPTCP.
>>
>> A new check is then added to make sure MPTCP is supported. If not, the
>> test stops and is marked as "skipped".
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
>> index b1eb7bce599d..8092399d911f 100755
>> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
>> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
>> @@ -1,6 +1,10 @@
>>  #!/bin/bash
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> +. "$(dirname "${0}")/mptcp_lib.sh"
>> +
>> +mptcp_lib_check_mptcp
>> +
>>  ip -Version > /dev/null 2>&1
>>  if [ $? -ne 0 ];then
>>  	echo "SKIP: Cannot not run test without ip tool"
>>
> Up to this patch the series LGTM and IMHO patch 1-7 could be applied
> right now.

Thank you for the quick review!

I just applied these 7 first patches with your Acked-by (I hope that's
OK) in our tree (fixes for -net):

New patches for t/upstream-net & t/upstream:
- b809e4daae06: selftests: mptcp: connect: skip if MPTCP is not supported
- bb32747eda98: selftests: mptcp: pm nl: skip if MPTCP is not supported
- 62f43cd362f2: selftests: mptcp: join: skip if MPTCP is not supported
- 225c8e1cba4f: selftests: mptcp: diag: skip if MPTCP is not supported
- 6ca8a8d4621e: selftests: mptcp: simult flows: skip if MPTCP is not
supported
- 7a8db23cbea0: selftests: mptcp: sockopt: skip if MPTCP is not supported
- a6a7d97d9d46: selftests: mptcp: userspace pm: skip if MPTCP is not
supported
- Results: 8a13ec4e7433..dfcc25846d11 (export-net)
- Results: e9959fe44675..1a26d4e0d882 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230523T085808
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230523T085808

> I think the later patches need a little more discussion. Specifically I
> would prefer not introducing all the stuff related to kernel version
> and diag dump (e.g. all that stuff that the patches themself warn
> about).

I understand that it requires further discussions. I will reply on the
different patches but we can also discuss about that at the weekly
meeting today.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

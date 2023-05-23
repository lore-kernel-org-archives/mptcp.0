Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284681E500
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 09:34:23 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3093a7b71fbso6858453f8f.2
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684834462; x=1687426462;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjeScUQVu1Rike7/sLjFfzE1kG65THUKFVR1fpLAOBs=;
        b=TA6/CuD+hFkYApQHQT4A1U2YS9W8GniLjNmxo/extqTobFn5lCWiryr82ba9bv/nEg
         XavdWPttZSUzg6gXWj5gNPQeUWDV426r4uvxq72aExZiGnJjlW3upbqzuvzXsRiEG+jT
         05qT9mnBRIQotjbtJmZT6qfvDXSdeAZcsPIee7nneWUObmKfqhRmmw2aV1KLSMK7Wd00
         0HP14X5Mx/BRSgswFqVXVz2C/lgwvyR8K5iSJMXRjltLixbqKHI2WcROsZeLQB65E/wB
         cA8Wpvw+Dt7FfPdrlvyO+R4zBhkLAUTPMc1SUj/I5RTml6eFFRfHwsG0WQRh/QO0RK7Q
         umLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834462; x=1687426462;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjeScUQVu1Rike7/sLjFfzE1kG65THUKFVR1fpLAOBs=;
        b=byzMnmfMX9hPqzJ8gwzmT/lXVlFWSLR1P7BmYssjTW4b6d9EmDyDrYjYWZR1aDJoCw
         eAXK0vOOtwACzai9JXmqjXiu/xBHiqEqLG0UXtf6ORTnVY5kcQ2iX10kLIH8kwJCZqcb
         0HXFM6SSHujbjl4J+ziut7gzL1CfjuwqOUdkC83K9L+i6JhTdZOyKya73UEKpaO8mKQX
         wao1OkFuApS8ctMvStOBbg7hPimbzPmoe/uBAmP0AG3n8PrrSt8cwpCA5GoMQDwwTKt/
         UE1eoLQUcTB5sT9YZHtmvka7+7BwcTK//7tql7QMa5fH5Bc2CI2CewLA+2PnLnzDukkP
         fVsg==
X-Gm-Message-State: AC+VfDzTp3rWtvIlW5gTDDiDG38XQfK/Fz26lJ6Qf1WSHHmiYY8Rs2cK
	2dL6IWdtvLGBIC8NlijOc9rvtQ==
X-Google-Smtp-Source: ACHHUZ5LyRi5sDVMuJrhE3PfRhWyIn0QD2Xnf3i2jz+Id+d2Xa4OB1gCKdcVc2qFW7EbR/PU3/7Jhg==
X-Received: by 2002:a5d:44cf:0:b0:309:54b6:33b0 with SMTP id z15-20020a5d44cf000000b0030954b633b0mr9493970wrr.44.1684834461939;
        Tue, 23 May 2023 02:34:21 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7ae3:96f4:110c:3f46? ([2a02:578:8593:1200:7ae3:96f4:110c:3f46])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d4dc5000000b0030644bdefd8sm10500594wru.52.2023.05.23.02.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:34:19 -0700 (PDT)
Message-ID: <b9e72bb3-e81c-b950-97a1-97b1d6571e61@tessares.net>
Date: Tue, 23 May 2023 11:34:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net v2 10/37] selftests: mptcp: connect: skip transp
 tests if not supported
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-10-50313e4f83ab@tessares.net>
 <b27d8f3c79b0f8b019af868f33864a746439e62d.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b27d8f3c79b0f8b019af868f33864a746439e62d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2023 19:26, Paolo Abeni wrote:
> On Mon, 2023-05-22 at 18:37 +0200, Matthieu Baerts wrote:
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> One of them is the support of IP(V6)_TRANSPARENT socket option with
>> MPTCP connections introduced by commit c9406a23c116 ("mptcp: sockopt:
>> add SOL_IP freebind & transparent options").
>>
>> It is possible to look for "__ip_sock_set_tos" in kallsyms because
>> IP(V6)_TRANSPARENT socket option support has been added after TOS
>> support which came with the required infrastructure in MPTCP sockopt
>> code. To support TOS, the following function has been exported (T). Not
>> great but better than checking for a specific kernel version.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Fixes: 5fb62e9cd3ad ("selftests: mptcp: add tproxy test case")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> index c1f7bac19942..c6fcae6b2562 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> @@ -144,6 +144,7 @@ cleanup()
>>  }
>>  
>>  mptcp_lib_check_mptcp
>> +mptcp_lib_check_kallsyms
>>  
>>  ip -Version > /dev/null 2>&1
>>  if [ $? -ne 0 ];then
>> @@ -695,6 +696,15 @@ run_test_transparent()
>>  		return 0
>>  	fi
>>  
>> +	# IP(V6)_TRANSPARENT has been added after TOS support which came with
>> +	# the required infrastructure in MPTCP sockopt code. To support TOS, the
>> +	# following function has been exported (T). Not great but better than
>> +	# checking for a specific kernel version.
>> +	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
>> +		echo "INFO: TFO not supported by the kernel: SKIP"
> 
> Possibly sed -e s/TFO/TOS/ ?

Good catch!

In the future v3, I did s/TFO/${msg}/ to print a different message for
v4 and v6.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

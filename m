Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0E441F
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 10:39:42 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso10953815e87.0
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689158380; x=1691750380;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJatEJkIPwffmRIf009NDTO6w3vluym+Q7Oc+4X7FkI=;
        b=yMe4A3CXl0UI9MTlXy2ZmSWTzJ/Ab1z7bBJIZoRHsksD08VvXovgT0LkVhz8FsNdpy
         EJ3nMp8ZOoaCwouYHCBfsrrWa1/ce8R9IkUUu3a+jmx/lHoWwb5liLNyb8nIi9Ecm8AD
         AgvM9OlYKItXr/HzJGwxDcVFK0lkI/UE0V6fIlqYACsLgRWTaoM7WEqi5r71tzOkcS5k
         jw/RIHkOKcC4tl9AjUJo56fcnsuOME2s+4QEFJN1IfbP0GeH1Ql+lKMhloA1fdcq4bYW
         gmCpYBMhpzgv2LvAbpFXjXhgEfiJPeMhWpkwNaCSujXUKegg+E2x6F+eGrb5YvTV0cCN
         NQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158380; x=1691750380;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJatEJkIPwffmRIf009NDTO6w3vluym+Q7Oc+4X7FkI=;
        b=FecnIlmhNsdrpj2IWBbP7IG7U4Evcv+2KFOFu7PL0ydL1/ExeSfN6iZizo3lijarri
         v3+eLfzIkiG+XS0p3446+Iv+V/qOY5dDpZL8Lm34s/2qjWK0LUW9okr/rMAoEkPknI2Z
         3MchWfquku2x71OCKV8VrLCMT7YKsWc5O/kXXKY9HQPvFFKlV0Yz35O2a4ItRDkYI5Rw
         vBUf21JB7vRMbvfumYtWJFiPxqsjU1g6WAg1wZcsJtxv0NHL5BAxhPzAGMenOBuTF+LW
         RBKhQQWwrPe7Gb1UeKm2bwEHT2xcC9IJ7OYr90uPVQIfrLQnk/cAjSBX4vnEYkGhlFvb
         dMew==
X-Gm-Message-State: ABy/qLZzMWbF9hYDzL8KuAJGVx6uilfo+rItiItKxcv9vgM1/MEIh47D
	LIMBcsx3/NUU2ys6XGQi1C1E7A==
X-Google-Smtp-Source: APBJJlHp5feeajBfGt280H++p4+lxxYmDhWWEPLlJQ8t1GveO3m4SdwJal3sUGFPzp0dX+h3In9JLA==
X-Received: by 2002:a05:6512:eaa:b0:4fb:52f1:9ab4 with SMTP id bi42-20020a0565120eaa00b004fb52f19ab4mr17513635lfb.50.1689158380075;
        Wed, 12 Jul 2023 03:39:40 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e63d:32df:2bec:83e9? ([2a02:578:8593:1200:e63d:32df:2bec:83e9])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709064dcf00b00991e2b5a27dsm2384314ejw.37.2023.07.12.03.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 03:39:39 -0700 (PDT)
Message-ID: <95b176e6-cb95-aa62-2ca3-46f2faa4de68@tessares.net>
Date: Wed, 12 Jul 2023 12:39:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: join: rework detailed
 report
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230628144927.828117-1-matthieu.baerts@tessares.net>
 <20230628144927.828117-2-matthieu.baerts@tessares.net>
 <e8e801ee4344f0b68a3c484b58c6f413eba09a92.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e8e801ee4344f0b68a3c484b58c6f413eba09a92.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for the review!

On 12/07/2023 10:34, Paolo Abeni wrote:
> On Wed, 2023-06-28 at 16:49 +0200, Matthieu Baerts wrote:
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 5c5c8b5e068f..3a0e2fa7754b 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -197,10 +197,34 @@ cleanup()
>>  	cleanup_partial
>>  }
>>  
>> -# $1: msg
>>  print_title()
>>  {
>> -	printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${1}"
>> +	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
>> +}
>> +
>> +print_check()
>> +{
>> +	printf "%-${nr_blank}s%-36s" " " "${*}"
>> +}
>> +
>> +print_info()
>> +{
>> +	printf "%-${nr_blank}sInfo: %s\n" " " "${*}"
> 
> In most case print_info is invoked like this:
> 
> 	if [ -n "$extra_msg" ]; then
> 		print_info "$extra_msg"
> 	fi
> 
> so what's about moving such check here?
> 
> print_info()
> {
> 	[ -n "${*}" ] || return
> 	printf "%-${nr_blank}sInfo: %s\n" " " "${*}"
> }
> 
> Not a big deal, it looks like a nice cleanup no matter what!

Good idea, I will do that in a v2!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF6747C
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:22:27 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a23so4705169eju.3
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g4s7ptUFQqpPnCvzH98Auj86H8ogkXbRDxZbyKHQslI=;
        b=p1Kw5zA/ZRbtN0dcqr73ymaShVwrBAuUX7AgU8sQbLu4VQoACBdtrArI9k/n9XBUjt
         LHyRpPPplL1+5YI2iD1KZOubJ5lHABclhA+mRb9g5O5/xnxepTaHgzMzY1iXefI1WZi7
         QpEX589SArCCHczj8sNXe+oe4jqYYkshTE9QzdHPfDCYLJUfLjsBvFhQyY/1Mg45ZQdZ
         3hYdv34pLMQS/PLGqsXl8FaWXbqO6moeupXUIuZWtS7vaQ3iKjRP4hT7MeqyI9Oj15fg
         XTK+OrjCIQC6M4EjoguGPBYqM64NevMq/xTKjhbvFOsDWYAhNjBilBvu4kBunoPAD2le
         GR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g4s7ptUFQqpPnCvzH98Auj86H8ogkXbRDxZbyKHQslI=;
        b=NTFKLmm18aIpmsHmA9CX0Ml+57wWLuv8PYF12SRPAoSOXnD0Nid6AGgo8QOOQyth7G
         rgc7xy8HFvrZjPTFEV40g+s/DMGwXdwveyA7i6Ef28HuznkW6GLk3MLR4/Mm+89VyHy/
         cOdBsOljZdp48/UfiSfe3/bS70GIgSJTqre1vJOAopTTnUiL1qqO+QmckT51Mum5W/B5
         96Swxpi6iN+JYTIHleN8yDmIKp4A/5VTRT/wxa3+SFFz3MTjBrapXW+JGCGTwXvv+RBL
         PAFE8hp4syBafPSo+WZyGmidTXzoxh7zX+2IufVy3P459k2lzpnC4ewW/Hhve0QrmogL
         lBOg==
X-Gm-Message-State: AOAM533b79lSajPOJEKlo0qNYggt7KLkmtPKaHXeq7Q7c1OoEyq+tK2q
	T5S1fO4L6d6jNSMs4uRwVqlbm3hhPmW4kNNGEAc=
X-Google-Smtp-Source: ABdhPJx4vER8EZsBG+r9ypjxVahbiwT1p210iYRnVw7t6oRiH422N6Uil2dCIayTDNwOljuMqw13wA==
X-Received: by 2002:a17:906:111a:b0:6d0:4fa4:8c2c with SMTP id h26-20020a170906111a00b006d04fa48c2cmr2524809eja.730.1645712545640;
        Thu, 24 Feb 2022 06:22:25 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s9sm1451027edj.48.2022.02.24.06.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:22:25 -0800 (PST)
Message-ID: <6bfa5c29-199f-005c-6127-f9dc6df33f81@tessares.net>
Date: Thu, 24 Feb 2022 15:22:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v3 08/12] selftests: mptcp: join: list failure
 at the end
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
 <20220224135619.2523272-9-matthieu.baerts@tessares.net>
 <CA+WQbwsZT-eHu_OLF06S0qEHZC3YdF7iPPVmhMo7cizD_VRM5Q@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwsZT-eHu_OLF06S0qEHZC3YdF7iPPVmhMo7cizD_VRM5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 24/02/2022 15:19, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年2月24日周四 21:56写道：

(...)

>> @@ -2806,4 +2822,13 @@ for subtests in "${tests[@]}"; do
>>         "${subtests}"
>>  done
>>
>> +if [ ${ret} -ne 0 ]; then
>> +       echo
>> +       echo "${#failed_tests[@]} failure(s) has(ve) been detected:"
> 
> How about using:
> 
>         echo -e "\n${#failed_tests[@]} failure(s) has(ve) been detected:"

Sure I can. But then I would prefer to use 'printf'.

In fact I added an "echo" before because I added an "echo" at the end.

But I can remove the extra echo and use "-e \n" if we prefer.

>> +       for i in $(get_failed_tests_ids); do
>> +               echo -e "\t- ${i}: ${failed_tests[${i}]}"
>> +       done
>> +       echo
>> +fi
>> +
>>  exit $ret

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

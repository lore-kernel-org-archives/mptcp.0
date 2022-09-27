Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28365B
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 08:01:17 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id b35so12170967edf.0
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2mwfcKnqqu8dyHG9b/v7xv7uX591+O5pZrb8x3aGPqk=;
        b=dUtdbEYnl49RhSIQPCXeySapOVvg9YvZJVXOLESrvmQjZMEXxfLMRX5xA7P4EVP70u
         UH1KRzL7n173WefJMIQnNeiVJ9DvGgyUv3tGILIf9GkqwjDzM3n8z1ChIMen69Gn1cGu
         5k+P0i0x9/TvmZkUm7IlDMi/W/Pp+LlLnuXZTxaBUGEzspVhQlC2FZZxsOwbP/txlPEG
         EDxUlVAG49adXQl05lvFayzq7Cm94Sc31DAt4rbFoQzFRZ7Xeu2L4ZD5QMdwCasdmrr0
         92NDc8Rwq3F/QGvw31nZr4NtxQgSbJXEXZKdfZwSmVzC4DzkA30735EAR4/XtHv6isN5
         LdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2mwfcKnqqu8dyHG9b/v7xv7uX591+O5pZrb8x3aGPqk=;
        b=b+MCv9Be5DUiKk3lA2j9cpXK28272gXzQTQP57V6CKHX8Rrdnqf/FjGR6gfG9sVLyD
         sHJk6jFYyMruOjr3WuLTD0zN63/EGIBCup4b++o6w4VjYn2+aq4eTl3bCYqNzlsufPGZ
         2Q+Nsw7Q5BCi7LCtWvDPWQ/7pWk1UE934Ubdsb0inONz9qXDf0xdfRw8fdsnE/g1GsX1
         3ZUFIi6KiwT9zREIh6KyR8CCC931/c4a8809lYoIMA2fTBoOvbw3ijlDh2sMzNHXV3JE
         03Sahi+MJhRDCWGDv6xgwNkIjHxu1tsOejQQW2vlzK8RFojrCIWdekCusozpo25P0+Pj
         lNmA==
X-Gm-Message-State: ACrzQf3i0h4F74uUkAAKeTje69UJEpMLj8Vp79DkETnBbgxXGyEjWpFy
	kJ1TbGHjmAHn4j71AmNPw+tWLg==
X-Google-Smtp-Source: AMsMyM6BgP04Zbg1mfgxNP30teD6uTjc8kM6M38yewqVykqt29xMTQ5zMsUauzo+GDhQs0hm4pZJbw==
X-Received: by 2002:a05:6402:f23:b0:452:3d9f:a0c with SMTP id i35-20020a0564020f2300b004523d9f0a0cmr2604535eda.367.1664265675707;
        Tue, 27 Sep 2022 01:01:15 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9302:e21:26be:f795? ([2a02:578:8593:1200:9302:e21:26be:f795])
        by smtp.gmail.com with ESMTPSA id ka14-20020a170907990e00b0076fa6d9d891sm401142ejc.46.2022.09.27.01.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:01:15 -0700 (PDT)
Message-ID: <a18a971a-4a27-6b45-e582-f3755e8e841a@tessares.net>
Date: Tue, 27 Sep 2022 10:01:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: mptcp: update misleading comments.: Tests Results
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>
References: <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
 <8a1575fa-b620-2471-890d-0c90e4253806@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8a1575fa-b620-2471-890d-0c90e4253806@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Davide,

Please see below: it looks like Patchew is re-creating tags again after
someone sends a Reviewed-by, etc.

Yesterday, Mat sent its RvB tag and you can see it has been added in the
commit that has been tested here:

https://github.com/multipath-tcp/mptcp_net-next/commit/2474bd2962c4

Do you see what to change to avoid this? :)

Cheers,
Matt

On 27/09/2022 01:07, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal:
>   - Unstable: 2 failed test(s): selftest_mptcp_join selftest_simult_flows 🔴:
>   - Task: https://cirrus-ci.com/task/4956489147219968
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4956489147219968/summary/summary.txt
> 
> - KVM Validation: debug:
>   - Unstable: 1 failed test(s): packetdrill_add_addr 🔴:
>   - Task: https://cirrus-ci.com/task/6082389054062592
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6082389054062592/summary/summary.txt
> 
> Initiator: Patchew Applier
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2474bd2962c4
> 
> 
> If there are some issues, you can reproduce them using the same environment as
> the one used by the CI thanks to a docker image, e.g.:
> 
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-debug
> 
> For more details:
> 
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Please note that despite all the efforts that have been already done to have a
> stable tests suite when executed on a public CI like here, it is possible some
> reported issues are not due to your modifications. Still, do not hesitate to
> help us improve that ;-)
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (Tessares)
> 

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

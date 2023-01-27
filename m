Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4D3205
	for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 16:27:14 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id s3so5222237edd.4
        for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIuDyQCBC59yTcUqMU0VKcfy9ZS3ISeX7DN02WRDqLY=;
        b=s2M5oyL35vkELxz89aiICM7R7niKeMz6enHgVIyUuN85ckl34HfVId9G31Cr7a5be0
         u2+DxahMWFkPjmT7AE0nLtoVRb09Yo8xZweiM5Rs+ThU/uwR3BTN2I2VLOvqOHov8TfX
         jp09Q+y3tO2ddGQPDUPQxM3Mok/bVbDNeg690vPlSwGdmJq7mGPrxRXmFvHJDU5bh5tq
         ImjMACFAIyJ7BTPpYqc9DwvO1F9PE8HkAKEPDat1/hTvaQeOzj+1+WUquBrvZjHKT/b0
         9rP04oH1yVpSMBJgucuhGru5BXVIkfyQ4uzztxS52tQeXEOjuDIIfdl/0tAqAtSEr7WJ
         19TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIuDyQCBC59yTcUqMU0VKcfy9ZS3ISeX7DN02WRDqLY=;
        b=5keFSzgtmqwkjP1Ivq1wZiGM+Q28pEiq1ej7ckEWjoYLz6lVrTelGNfgBuGAYYFg5Z
         CtXTUqezPbAEN/igNuwCX+q4YeLXuZKrMNXBINBd6Axom4pCyt2TmLwQfTurdb2U9O8w
         svrCKwiQDIKTi5J0ma8jJLciAigchBBFvukb8yHiqa9Kvz9abt05MRL5E/kEQnDWcsRp
         jWK5SBzDBRhnZmoofVBhliK1uYKDUUwmuLhcF1yWkNaKVqP9E2OpxGmRB2SCELgiYXiu
         fX6DGGkcG98BuUkSVQgbOgE2wXFGFWKMPbiJQm0vmtSlIxu4GWEHac64YFLG4ciMIUD1
         LXhw==
X-Gm-Message-State: AFqh2kqobHlLzWJvd+05fw2HsB+1xhkvOOEWom/NiL6BjuADSW8mzw0B
	/TYBxSR4YYj56dS0JyW+N+rbZBFqzwYekxEmOSo=
X-Google-Smtp-Source: AMrXdXvcfYHfHy/8O/CT8f0gIhidogow4rrVLwDvr5iUr654A3fDPfBchaBFfsW824mWJBpeCWXmeQ==
X-Received: by 2002:a05:6402:35c1:b0:49b:52b3:cae6 with SMTP id z1-20020a05640235c100b0049b52b3cae6mr55997624edc.30.1674836832339;
        Fri, 27 Jan 2023 08:27:12 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id a20-20020a50ff14000000b004a211283100sm769904edu.44.2023.01.27.08.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:27:12 -0800 (PST)
Message-ID: <0605c1d4-29bc-31ed-b86c-ed90ad681ce7@tessares.net>
Date: Fri, 27 Jan 2023 17:27:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: selinux: Implement mptcp_add_subflow hook: Tests Results
Content-Language: en-GB
To: mptcp@lists.linux.dev
References: <4d5c94f133002e76ecb74c3303ab350df9175e90.1674767058.git.pabeni@redhat.com>
 <be0ae280-36d7-714b-01b7-9eb47fd88151@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <be0ae280-36d7-714b-01b7-9eb47fd88151@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 27/01/2023 17:16, MPTCP CI wrote:
> Hi Paolo,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Unstable: 1 failed test(s): packetdrill_syscalls 🔴:
>   - Task: https://cirrus-ci.com/task/6095622034423808
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6095622034423808/summary/summary.txt
> 
> - KVM Validation: debug (except selftest_mptcp_join):
>   - Unstable: 1 failed test(s): packetdrill_syscalls 🔴:
>   - Task: https://cirrus-ci.com/task/5307859534086144
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5307859534086144/summary/summary.txt
> 
> - KVM Validation: normal (only selftest_mptcp_join):
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/5532672081002496
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5532672081002496/summary/summary.txt
> 
> - KVM Validation: debug (only selftest_mptcp_join):
>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>   - Task: https://cirrus-ci.com/task/4617878406692864
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4617878406692864/summary/summary.txt

Regarding the results

- For packetdrill syscalls: the behaviour has changed
  https://github.com/multipath-tcp/packetdrill/pull/113

- For MPTCP Join selftest: known issue
  https://github.com/multipath-tcp/mptcp_net-next/issues/323

The results looks OK to me then!

(FYI I will apply the patches after Paolo's ACK on my other questions :) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

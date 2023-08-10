Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6E1E537
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 08:30:55 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe4762173bso916866e87.3
        for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691656253; x=1692261053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ic/FIND73BL5D8dtLTf6OFwKSIpm80u2WLfk7IAeXqo=;
        b=FMNHtP22HRJEulWVl5/oIS/VRcw3j4qRe7US5qjvm+6uFiA2uKbbZG2HnM/zl1pDxz
         tTvjQf3u16tpNls5Altq9hvBulEIvrHCR5UF5v8U97nTizO1kZqjPTuNKt2ZxInM418x
         E5RuGVbDdxbE+WB0t19ZaOfG8KRMuc7gB9ZPw/4GbQxXBvFZ6dpL7GGP0o+g10XsJ5h+
         Lq+GPodXGOKtd/2MXxcF2B3i3eRE6bp+L9Gt+BdTC/zyx+phYGqHUZpXwaXHbRa72B+2
         bFsc/Ty376Ni5D9XOjjgAYkwanBLIHVybutXdX53zeGAi4O4Ll6R9hBsf+qLBU1aOEcA
         E12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656253; x=1692261053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic/FIND73BL5D8dtLTf6OFwKSIpm80u2WLfk7IAeXqo=;
        b=RNrzZN/JsUK8XmNrwZdOoacXTw/HZyZOjn41Zzg/VVcORGpklhZistHdIt1l+y/HqT
         TmMV3Tc/qvJks72ViTm6A5TkyIs4SMsugbsllekp7bnzm0HW7+ic4waDeD00k9fTjOL1
         iFH0VpPoT/gFt5kxxF35GSL6PAeiMxQ4f8hnRGf0WyOSY096hE7gJ5Enz8nY5CdxXvjT
         +OhUfVEMQ9qGWsKbmbuP9OEfjE8xBClrttHfQetuKU/8A3Irjd05WuYbaEPZKCkv84Zj
         vtXCaOdmsEt/H0MMGS6GlpzEYqr7fCkjEOYnTt2YKfSBiNsRavoyrEdvgWFM1/0KlT+G
         KL1A==
X-Gm-Message-State: AOJu0Yx6tfanaye3j3TTVEIlTMlxYJCzpjwqYNFFSdq2at20tqNQJfwJ
	V4OzZgYaBenrAb4hMziCtKKZPg==
X-Google-Smtp-Source: AGHT+IGf5jnqKk+/Wxa0lewGnRv3LRxJbfFnKZbfVVzrPEJDu9BiLBaj/E4qhS+AnR7JHlwGGolFuw==
X-Received: by 2002:a05:6512:ace:b0:4f4:b783:8556 with SMTP id n14-20020a0565120ace00b004f4b7838556mr1352140lfu.66.1691656253270;
        Thu, 10 Aug 2023 01:30:53 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:99e1:a167:6a5a:9487? ([2a02:578:8593:1200:99e1:a167:6a5a:9487])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b003fc06169ab3sm4253012wmi.20.2023.08.10.01.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 01:30:52 -0700 (PDT)
Message-ID: <8e4969e4-043d-4bda-96e9-7deed4133049@tessares.net>
Date: Thu, 10 Aug 2023 10:30:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mptcp: Remove unnecessary test for __mptcp_init_sock().: Build
 Failure
Content-Language: en-GB
To: Kuniyuki Iwashima <kuniyu@amazon.com>, wpasupplicant.patchew@gmail.com
Cc: mptcp@lists.linux.dev
References: <eec230ed-7af2-c055-5c6e-9c70ff454188@gmail.com>
 <20230809233908.26135-1-kuniyu@amazon.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230809233908.26135-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

Thank you for the patch!

On 10/08/2023 01:39, Kuniyuki Iwashima wrote:
> From: MPTCP CI <wpasupplicant.patchew@gmail.com>
> Date: Wed, 09 Aug 2023 23:20:04 +0000
>> Hi Kuniyuki,
>>
>> Thank you for your modifications, that's great!
>>
>> But sadly, our CI spotted some issues with it when trying to build it.
>>
>> You can find more details there:
>>
>>   https://patchwork.kernel.org/project/mptcp/patch/20230809225918.21523-1-kuniyu@amazon.com/
>>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5815022877
>>
>> Status: failure
>> Initiator: MPTCPimporter
>> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e7b0047cdbb4
> 
> Oops, I used net-next and missed f2b529788d80 ("mptcp: add sched in
> mptcp_sock").
> 
> I'll rebase on the mptcp tree.

That's OK, I can apply your patch on our side before "mptcp: add sched
in mptcp_sock" (we will not send it to netdev before next week anyway).
When doing that, I will also adapt this other commit not to have the
compilation issue.

That way, your patch can be applied in net-next directly and our daily
automatic rebase will handle that without issue. I will send a reply on
your email including the patch where netdev ML was cced (the CI only
sends emails to MPTCP ML).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1727C
	for <mptcp@lists.linux.dev>; Sun, 28 May 2023 16:25:35 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-30a8c4afa46so1782736f8f.1
        for <mptcp@lists.linux.dev>; Sun, 28 May 2023 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685291133; x=1687883133;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvw5nTIR60XdeCT/mgT4kevdHpmKI/x+8vnz9ZcQ/BQ=;
        b=oz/Gxj3kBZ2Oskr7tYNjQOZkHAdr0zx+2W1R0SQ+yKH+x/bB6YN7xbM8PVRnHax5/r
         EmiC+nBg2dMY7SbTCUNh34pKklFkbpZhw+787ty/K4VlqLqInurQO4Bw9Xur5Z//1oVM
         AwPv1uBB1FXr+RAWWNMwQGx/H/oP9YemFqU9KKbnc+fpxGyQDKk8xX0fYWOUY3dAeEv8
         BRTvzwIZqBE+0guOy+a8tS64nET1TZQC9/c8ovbDtRdzYvTb2qlXBcKmVk0IXS9X5pOV
         jqZFseJ11NtHL+G30k5Qe5p1eIqsCh0zInHaItd76TplmjVO1P3sej7CHRBjubDf1J5i
         kttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685291133; x=1687883133;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvw5nTIR60XdeCT/mgT4kevdHpmKI/x+8vnz9ZcQ/BQ=;
        b=Um5i+YTgLtoIzG2UlrAc+kgOzzEuafxsZixpzhX33Md4lz/hTg3wvHMuiHcnjRmUJN
         qDKzzzlWJSMAEERa/LxCopIBvGwmzTr3wd1KvUSsgn+IbbDSCdJGsPGVCEIdVn8UjEpf
         58T0KiqAhsevZ/HI1ze/wmh4NiT54s3S5OWTJ/nyynZSw0XjNmkqT57pRxNddsBfhVN6
         2b4PZREzYpJwXdL+gLXiJhfVzpPpB70l4XOox1y0R6floIkijpf5+R2jDARK/q3fLnDa
         0Ux9p1dgC4tgbpJFaX2rir4sTmaBva8RmdPix1t7a7RNmq+20OO5VKTZ++SvUiiE2Jfg
         3seg==
X-Gm-Message-State: AC+VfDyM/H7g/E6oh99nu8ddV0tS4cRDrAbe44sT9tqR4LfMOzAC57N/
	EQxk9T8VT+kh+ZusfzYIeguV+Q==
X-Google-Smtp-Source: ACHHUZ43ojf4ie9nsSprj8SidpPfVQ2trWiCiA2NTIngF9KdVCFLUvyShFOBT1YijxdVrxgmo88fnw==
X-Received: by 2002:a5d:6584:0:b0:307:f75:f581 with SMTP id q4-20020a5d6584000000b003070f75f581mr5068616wru.18.1685291133542;
        Sun, 28 May 2023 09:25:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:80da:cc14:918a:5418? ([2a02:578:8593:1200:80da:cc14:918a:5418])
        by smtp.gmail.com with ESMTPSA id o8-20020adfcf08000000b00306c5900c10sm11293093wrj.9.2023.05.28.09.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 09:25:33 -0700 (PDT)
Message-ID: <04729035-0947-d5ed-78f1-9b51c68a2965@tessares.net>
Date: Sun, 28 May 2023 18:25:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 mptcp-next 0/6] mptcp: add some more diag info
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684997011.git.pabeni@redhat.com>
 <b6d9968f-9406-cdca-2867-c093f393f08a@tessares.net>
In-Reply-To: <b6d9968f-9406-cdca-2867-c093f393f08a@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/05/2023 17:18, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 25/05/2023 09:17, Paolo Abeni wrote:
>> Sorry for the high-freq spamming. I really want to close this topic
>> and move forward.
>>
>> Introduces unique id for accurate subflow stats tracking and
>> aggregate mptcp counters, plus some minimal self-tests.
>>
>> The tests themself do not take in account support for running on
>> older kernel.
>>
>> This is on top of "mptcp: a bunch of data race fixes".
>>
>> There should be non trivial conflicts with:
>>
>> "mptcp: use get_retrans wrapper".
>>
>> v5 -> v6:
>>  - fix another compiler warning
>>
>> v4 -> v5:
>>  - changed again binary layout for MPTCP_FULL_INFO structs (Matttbe)
>>  - fixed 32bit build issue
>>  - reordered the patches, less controversial first
> 
> Thank you for the new version! It looks good to me!
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> I'm sorry I was not confident about the previous version and I was not
> feeling good asking you to change it!
> I do like the last version, I hope you too :)
> 
> I have a few questions in the individual patches if you don't mind but
> that should not be blocking the series. I can even do the modifications
> when applying the patches if that's OK for you!

Thank you for the different answers, for the instructions on how to fix
the conflicts and again sorry for the previous reviews!

I added links to these tickets in the different patches:

  https://github.com/multipath-tcp/mptcp_net-next/issues/385
  https://github.com/multipath-tcp/mptcp_net-next/issues/388

Now in our tree (feat. for net-next) with my RvB tag:

New patches for t/upstream:
- c7cb50a32f60: mptcp: move snd_una update earlier for fallback socket
- 34d08f8b2ac9: mptcp: track some aggregate data counters
- f8d85c73f57a: selftests: mptcp: explicitly tests aggregate counters
- 7b8be8bf5ef4: mptcp: add subflow unique id
- 3f1aaf669e62: mptcp: introduce MPTCP_FULL_INFO getsockopt
- 28cb4413f233: selftests: mptcp: add MPTCP_FULL_INFO testcase
- 91ea9989b43d: conflict in t/mptcp-use-get_retrans-wrapper
- Results: 723979747226..e5a080352635 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230528T161955

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

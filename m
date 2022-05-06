Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E812568
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 17:40:17 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id k27so9508392edk.4
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=aoESxu0j6/J0Ere2fBS77cc9BbzbuUZqdt5zyP18isQ=;
        b=pnolCg6C6LsMUQqaiO0SP7yPRTCwOl9tQJ84/k0sCDBJa/UWm1aCZGYBl08UuF4ziW
         1J7rK0B3ch246mtRRycQxTT77p0fZV/NUS5XuMK2gijqfP6AV8QkOss137mXCmkvz3C1
         a6EexesGM7171LaQ6HW4s+d9c+nFdqWqlpcClpALJzUmsMwE55mf6jHcJn2Dy4mKylQ7
         INXm0uLEkB3Gvf5A2LhECb+7D5yL1BK6V6Hz9a/B6elzFoTgm4kn/6x7XB/4sIKIY7Va
         NPumtZcw2RF7FlecJaltbJ9eepQiob2/qx/FSA5VHfiTp73hA85SDgsNcJ2jblGboqWl
         r8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aoESxu0j6/J0Ere2fBS77cc9BbzbuUZqdt5zyP18isQ=;
        b=Vnv0EifhOrRl0U2QIfbQnOzYCZl3PE1O3TXJfK+0Dji61wxl+c4YTA0akSQMdyCx7L
         AkH0C1KO82kOds9U8hK/V9i9//75qgnWGEKuZkh7HMaS0iQ1tQP5lm5phsRMklYD5R6i
         Vcl9QFrzNehYfAr3LLBZceLJ1bO1LuFOPYx9r6Sa/2GwfKGa1t/hguK0wwkA60PWypcz
         bqOoOw5aw6cDio6Zg0LCF/0AohNz37R0cnyL/HZUNbjflklOaiN7tvFSMcMbtrETh+oy
         5Rx83Si8y2vZsDqhdWzPTL+8XSSmv9/fyobFiNTWaoShyI5Q/fDESKd0I5nzWIeM3BsQ
         D5jA==
X-Gm-Message-State: AOAM532n6O1u54uzF8sNnQ4dDDtXKtRo/cbsobkYse8tQ5JOT5P2drRp
	wIEUogh+wJRQnJ+PT1qrQ6wpSApCIPCl/YBF
X-Google-Smtp-Source: ABdhPJz3Ll6jCquFebZ93/gz/GaNyAty0lD2i0McVCV6qpSd5i22LdKsN4icFMQ/SXIE8gt/ZDUoTg==
X-Received: by 2002:a05:6402:364:b0:425:f88d:7d4a with SMTP id s4-20020a056402036400b00425f88d7d4amr4659701edw.68.1651858815678;
        Fri, 06 May 2022 10:40:15 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2a7b:53c5:db4:9313? ([2a02:578:8593:1200:2a7b:53c5:db4:9313])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7c80d000000b0042617ba63d6sm2473536edt.96.2022.05.06.10.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 10:40:15 -0700 (PDT)
Message-ID: <57fb5844-f74e-a300-c8af-e039698275bc@tessares.net>
Date: Fri, 6 May 2022 19:40:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net v3] net/sched: act_pedit: really ensure the skb is
 writable
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <7ec2ff1bd88c6d87e452afa58f1f6b6c756a2fb0.1651828857.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7ec2ff1bd88c6d87e452afa58f1f6b6c756a2fb0.1651828857.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 06/05/2022 11:21, Paolo Abeni wrote:
> Currently pedit tries to ensure that the accessed skb offset
> is writeble via skb_unclone(). The action potentially allows
> touching any skb bytes, so it may end-up modifying shared data.
> 
> The above causes some sporadic MPTCP self-test failures.
> 
> Address the issue keeping track of a rough over-estimate highest skb
> offset accessed by the action and ensure such offset is really
> writable.
> 
> Note that this may cause performance regressions in some scenario,
> but hopefully pedit is not critical path.

Thank you for the patch and the review!

Now in our tree (replacing the v1):

New patches for t/upstream and t/upstream-net:
- 45e0f5044b92: net/sched: act_pedit: really ensure the skb is writable
- 3b7454ae1d97: tg:msg: switch to v3
- Results: 825394fc0bc5..bc6528b2b1d7 (export)
- Results: ca8b19c6d86b..90e1181966d4 (export-net)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220506T173804
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220506T173804
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

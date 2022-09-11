Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AC7F
	for <mptcp@lists.linux.dev>; Sun, 11 Sep 2022 18:23:17 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id e18so9791579edj.3
        for <mptcp@lists.linux.dev>; Sun, 11 Sep 2022 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4QHHzYR2e6kFbtk04nwsTE9g5tRZeWnd5urrUifeDxo=;
        b=mIk2ThG0D139FJ9ECTCgD9jTqQHVTjg1FQ1aPAMcPXMdG3D5JDcwAnkA+gaD8Qvtc0
         xK0/o4vNZIaVeLvbK7nAWxvufgPSpwoXMW+yrX4UyNMgWmbiE+yxAdwZDSihwAPHxZp/
         3pKudm01OkA0xJSpH5ilmGvI5OCnkTx1aszY4BLWlBWWquU9ESQZ33zXkfjPdN2Wy44m
         xfnsYyIxZ4lACk+K+HiBYq2Ov+DxY34EeDVTWEkoPPlHuaCJwvdA5BBSmFVWWtLIyTT8
         iJU6csvlxpdMC3tTx3pSfHIX5zRWZMb/ZmeTIh6Ls5QRhqiZkpaEiNbopieyPhvpzsS+
         ReFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4QHHzYR2e6kFbtk04nwsTE9g5tRZeWnd5urrUifeDxo=;
        b=kUZPcm90r4HKeQUm9vadPxnMsuMaIEAR8WBbnKnAIbwBe3FHg/6Qz2YuNzNUuwuh1s
         fegj79G3oEY5igbGWtALJB49lmhke60hkdvrU7JzNCUvk9S9jozSHRAJFUlaoQpnvr6f
         h1FNkqjZ85wrL6a62yXeYIXsW3dFbOB5S2GsZumVfjyMWqtLW5+pQ2ZmiaA9AVc0gZHG
         CIEcXY1cHNQ0uCa0TjLSltbD+gm6fNa5Bg2TmYkbGDRpegoRscVX1Dlm3hvGUF/hPOfE
         VfOEi4MDS/cHGmcmh3Uww/naq0+cqTFaao3y0aHNUeILYL1Z2zRkK4zytY33W8z/bWyR
         dzPA==
X-Gm-Message-State: ACgBeo3nPMWdrjyp221k2uppdQI1V3KLiIt9iiCTwJ+ZdA249Woa/8Q3
	56MVHZ4hYyKVdCDSmtVlna6A+sHSj9W9FTtFbxo=
X-Google-Smtp-Source: AA6agR7kfD38ZQQfvhchiteGa6TC2pJhPAwbMnDC3oCE2zOvXcPTl1MpfuReCeituoF3HQZt4smp4g==
X-Received: by 2002:aa7:c74c:0:b0:44e:a7b9:d5c9 with SMTP id c12-20020aa7c74c000000b0044ea7b9d5c9mr19592879eds.19.1662920595964;
        Sun, 11 Sep 2022 11:23:15 -0700 (PDT)
Received: from [100.65.141.57] ([195.181.172.154])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7c45a000000b0044f1e64e9f4sm4366813edr.17.2022.09.11.11.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 11:23:15 -0700 (PDT)
Message-ID: <e0a72693-f9bb-f724-5fea-995ad6cde8ac@tessares.net>
Date: Sun, 11 Sep 2022 19:23:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: update and extend
 fastclose test-cases
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com>
 <ccf2c2fc0f7fdca9742c51b3fdc6bb6c5fabec5f.1662713367.git.pabeni@redhat.com>
 <801e3c41-d5c8-3ea6-958c-ac3b008810c2@linux.intel.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <801e3c41-d5c8-3ea6-958c-ac3b008810c2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Paolo,

On 10/09/2022 01:21, Mat Martineau wrote:
> On Fri, 9 Sep 2022, Paolo Abeni wrote:
> 
>> After the previous patches, the MPTCP protocol can generate
>> fast-closes on both ends of the connection. Rework the relevant
>> test-case to carefully trigger the fast-close code-path on a
>> single end at the time, while ensuring than a predictable amount
>> of data is spooled on both ends.
>>
>> Additionally add another test-cases for the passive socket
>> fast-close.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> The first time I ran this test, the "fastclose server test" failed with:
> 
> copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 4)
>  client exit code 2, server 0
> 
> I haven't been able to reproduce it, so I'm not sure if it's related to
> the code changes or just an unrelated intermittent poll timeout (I know
> I've seen similar issues before).
> 
> Looks like CI packetdrill noticed the changes like Matthieu mentioned.
> But that doesn't change these kernel patches.

About that part, is it OK if I wait for these Packetdrill adaptations
before applying the patches? Just not to have the CI complaining about
all new builds on top of the export branch :)

> Changes look good to me too:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

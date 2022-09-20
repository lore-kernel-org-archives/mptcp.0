Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E45A9D
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 11:44:47 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id l14so5443895eja.7
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QeWlHzxOMrK463u2ZF47hsivrA4/i7uR2Ypkqkktbu4=;
        b=74CvKoZ+j8tFEgglaV/OaLe0sXd3Roxw4yB6MZqCTcL1iOMlpw0uRpqT6BRqg8qmV9
         IJ0vZM31/7lmRYqG1EG3gKf8KZF7WIT1G2PgrixhHm2aDbFDvwLcbf6Aa37IcJOYWX9m
         fVDUXhnoNXp2CtsI4hl984eBiu9YBzSw7ypv0qwiE1oUw5Ig9aCJmo8uHlKeNL8AlCqd
         km2Xy6TFoHMdQRMUp84jwX5kxnEyOZvsvRV2q1MC9wEiOFE1UFYDJ/Y9AyBzAbsMdc7o
         rUVN6Pt1FhDPPP8YSy9ulCIQwmLlh7EuG2vYvZc8UK0F7dcFo5MxFDlol2duRl3EePVI
         Zppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QeWlHzxOMrK463u2ZF47hsivrA4/i7uR2Ypkqkktbu4=;
        b=l1acSE7G8EBqJ045l9LwAfHdPW107abndZWfZ5tQu01pwin76r+AsH+Jrypd64Ys8w
         y3BoSzQiw5HHi8EYI3acHh76O8zXRUziGO344fK+XqNP60Hs8zPCeZH2KAKsFe3PkIbn
         uSmIWxg6OwBEE7jAb6ncHWrclLK8LthYuu3qJqVgWs0huT2bMMpH9AND5WNxhbAo9hPc
         1d/t8mgLLkCR9Sa1BhYfM9pO0HJAkduOg3mX/arDvwFpQJ3ZRkAymIgoSrrOGKDp9ZkD
         hA1BMdvMDmkQfhR7WUleAjkafQ1xxv1UhH9erKgidxiNkhs7gSF5pwMKHa0/hML+pfcg
         96eA==
X-Gm-Message-State: ACrzQf3Xb5m68ERP3jQAohDqlEMLt0tbOA8G9vpAlTgcXirzMETKaUQk
	2gn8d3Mxt/NiSmojslBuCsrPyA==
X-Google-Smtp-Source: AMsMyM4VBm0gNn2TntdEvf/jNUFv4Li1SffJ0oV3Z1eW6eEt7UGXYl1rqipESWXlseSqIlLy9R0dAQ==
X-Received: by 2002:a17:906:6a0e:b0:77c:a049:7cfc with SMTP id qw14-20020a1709066a0e00b0077ca0497cfcmr15950055ejc.732.1663674285384;
        Tue, 20 Sep 2022 04:44:45 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3889:e22b:91b6:4dec? ([2a02:578:8593:1200:3889:e22b:91b6:4dec])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906815900b0073da32b7db0sm695199ejw.199.2022.09.20.04.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 04:44:44 -0700 (PDT)
Message-ID: <6b78ea19-4756-64be-3599-79f8d8b434b9@tessares.net>
Date: Tue, 20 Sep 2022 13:44:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp] net: mptcp: add statistics for mptcp socket in use
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: pabeni@redhat.com, mptcp@lists.linux.dev,
 Menglong Dong <imagedong@tencent.com>
References: <20220919132156.3649522-1-imagedong@tencent.com>
 <61ca3016-5f92-7779-9213-f8b75ff9ff55@linux.intel.com>
 <CADxym3a3q_Tz=SWPqfwL+apnVtEpCd1Ng47xmCbN9ywNXnnMaw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CADxym3a3q_Tz=SWPqfwL+apnVtEpCd1Ng47xmCbN9ywNXnnMaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong,

On 20/09/2022 04:10, Menglong Dong wrote:
> On Tue, Sep 20, 2022 at 6:37 AM Mat Martineau
> <mathew.j.martineau@linux.intel.com> wrote:
>>
>> On Mon, 19 Sep 2022, menglong8.dong@gmail.com wrote:
>>
>>> From: Menglong Dong <imagedong@tencent.com>
>>>
>>> Do the statistics of mptcp socket in use with sock_prot_inuse_add().
>>> Therefore, we can get the count of used mptcp socket from
>>> /proc/net/protocols:
>>>
>>> & cat /proc/net/protocols
>>> protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
>>> MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
>>> MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
>>>
>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
>>
>> Hello Menglong -
>>
>> Thanks for your patch.
>>
>> One minor thing: please use the subject line tags listed in
>> https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes :
>> either "[PATCH mptcp-net]" or "[PATCH mptcp-next]", so it's clear which
>> tree the patch is intended for.
>>
> 
> Thanks for your remind, I'll send the next version with
> mptcp-next tag.

Thank you for the your patch.

If you don't mind, can you also strip "net:" prefix from the commit
title? Having 'mptcp:' is enough and that's what was done in most
commits changing files from net/mptcp directory so far.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

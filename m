Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB643E8
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 14:57:44 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id z7so28907010edm.13
        for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=LSAQhv/lAR2E+Fq/uh0vDxnXH2BNz3wSXwawKHm2YiA=;
        b=49s6KeaDQy4JcLfbpfusNSHTvS3xJ6/Iuz5VLhbJTWm44TQSWJIgOA9Mck2yJCPXqE
         wtxq/xC/HtZOgIHSIlya+j8oaaooQleD9yUEHJTQbWxTkqKZt/KgL4k1NJXt3lR6Uw+M
         ekREer6evmQsFn/XwHFi1aFh0a4NeiLjTQTPBm1N2P6DhhLhDz1ReY9MY52cXfy4M0K1
         LAaQLCq9+ExcTkeS6O39Z5/7oknmq8gtVhD1h7EQxUMxuNEWyUNlD7ciTE6f0aCBPBS1
         7JyJ5kE5jubVx7zk4XatApl6e/HnaWy9/1gQBJLIZPseKXX4lBSAKlEEPjn7x3PjNgHI
         dejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=LSAQhv/lAR2E+Fq/uh0vDxnXH2BNz3wSXwawKHm2YiA=;
        b=GdpsSGJB0rh5TxS8Nlri0GzF3ma+trQcO19ZEEp1136NVnMiTI8014r4KoIngjPMj3
         4CuIU0TNuDrCg13vqb+IGQnYGUN6vmKw4HOrOdKJCetnexZfhHAu0kY+vpyA4qaQmcT0
         DdWD6bMmXURZd6M0s0XssFLIpvnGL/pzvXSepjhu59h4FT9Wxu64og94+ewU391CAEnT
         J+S/9YAtuu/FH2QRhuaZa9oZMXS6StSZg1lP1l5RW3Hy3Nfg6gwGGnyMtEYPXmPf8AtE
         GW32rIPP31MLHmBXb5poMvWIM8zqNzLx0x+gY+ZVwmBYpCOLN4yOmZ8PcdjXuNjpvmp6
         jWTA==
X-Gm-Message-State: AJIora/RRFmgjgPtvJ1MmYhhlE4hQ408q9OdbOQmx+WtCn4jmXTVffv/
	XOL2RItpb9IqJJsQtmH6b5kSCzf70cc/sw==
X-Google-Smtp-Source: AGRyM1smbBQ+NI18GZMrm0QS214WKM7gi5czQIhlzf7BMixYeZZrGtEsNisbzq7c+6jx7lqHjXRlFg==
X-Received: by 2002:a05:6402:3685:b0:435:8069:e44 with SMTP id ej5-20020a056402368500b0043580690e44mr11205464edb.202.1655996262743;
        Thu, 23 Jun 2022 07:57:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:5115:5050:7b92:9ea5? ([2a02:578:8593:1200:5115:5050:7b92:9ea5])
        by smtp.gmail.com with ESMTPSA id q12-20020a056402040c00b00435cfa7c6f5sm1735625edv.46.2022.06.23.07.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:57:42 -0700 (PDT)
Message-ID: <d4ca2d5c-f040-5155-f4f4-d3aac1648019@tessares.net>
Date: Thu, 23 Jun 2022 16:57:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next v9 0/6] BPF redundant scheduler
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <cover.1655995770.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1655995770.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 23/06/2022 16:54, Geliang Tang wrote:
> v9:
>  - drop the extra *err paramenter of mptcp_sched_get_send() as Florian
>    suggested.

Just to be sure, did you see the last report from the CI:


- KVM Validation: normal:
  - Unstable: 3 failed test(s): mptcp_connect_mmap
selftest_mptcp_connect selftest_simult_flows - Critical: 2 Call Trace(s) ❌:
  - Task: https://cirrus-ci.com/task/6077066394206208
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/6077066394206208/summary/summary.txt


- KVM Validation: debug:
  - Unstable: 3 failed test(s): selftest_mptcp_connect
selftest_mptcp_join selftest_simult_flows - Critical: 2 Call Trace(s) ❌:
  - Task: https://cirrus-ci.com/task/5514116440784896
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5514116440784896/summary/summary.txt

I guess it is linked to your modifications, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

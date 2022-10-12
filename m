Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6A8F66
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 09:29:24 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a26so36737662ejc.4
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1Z9vdi2LcoCxXWuQF2NPhBlJ1FF6/qUQ6E2WFzYPWo=;
        b=Cv2hLJMM6r2/iSvCr+BwVgcVJlHwDKPEmFXIjxyDujcbW5dhIQTnCA8klBVjz5PYr2
         H6ioVw1wjFr6CP1lLowa5HwT9k/oSQn2Ldq5Clm+3Mvh3pCdNTNSZPBDvvO73K6exquU
         rKjGBhv+h/Eifmszi8Jxz1tfLyvWR8E7GKoUHkcHtyVONZoMNt9Woul/kdt/pMDVxFlK
         H1L1nisMj8SVC8ExEN7bHT+9XR0yivm8V+RQEaCh5ZWBDP3zZvuZXlbObhGwpaPGXa8q
         LJs6Or/6u4iHgZQKzYjAkxOZirQ6qBxgs7SiE8mlpPC/aWwjtiiyoNQkSoO4pw/rl5Rt
         1H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1Z9vdi2LcoCxXWuQF2NPhBlJ1FF6/qUQ6E2WFzYPWo=;
        b=aax84XmUOLWi7WXh7gPA1YkDrfSaOm+ub35RxF0dRfAp6TNvyKPIjCDLlqq6G8/ENn
         CNojU5A13k6eXcJzj7hyS1wxT4fyPvBKB0tou0OlI5w6t6ychLG9vthJN65Li2VCvThF
         GaZHZ9q5c0vNedBRO+Poz7ht22PPlSye3Hb+qqlGLi4lf4hbmAIM2lMpzq9g9cFtrzrF
         qgyK31RueTTVWN2By1M1PiYSAAiTzvwbeh1A7hLsfFOW4vQjxRhj3BUWDHHiPUQJdv9P
         Sfd25g6D3z3GVAwUPV3vlJb3WJ7VLBp+aTfdE420ezac5w/6TGP7y+myo0drSWlei55K
         +BqA==
X-Gm-Message-State: ACrzQf1Hy9mmo4FDStgg5b9wkVEemdo3eCX+0iAPMvE72feBo1+oZyux
	x1O7ahXa7+zRVdFDOSShPNQU3V2xlqo5Mg==
X-Google-Smtp-Source: AMsMyM78qJRMrouWN4Xp86V0HeG45Pm88dmcDKib5efY1gU440U+dFC9lPfygqvB9ZWqAasmdhgbHA==
X-Received: by 2002:a17:907:320c:b0:77b:6f08:9870 with SMTP id xg12-20020a170907320c00b0077b6f089870mr21512134ejb.249.1665566962775;
        Wed, 12 Oct 2022 02:29:22 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f07e:bd7a:c3d9:59e6? ([2a02:578:8593:1200:f07e:bd7a:c3d9:59e6])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709067c0f00b00730b3bdd8d7sm917494ejo.179.2022.10.12.02.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 02:29:22 -0700 (PDT)
Message-ID: <b3346c1f-5934-4c97-e65e-c0983f9e45ae@tessares.net>
Date: Wed, 12 Oct 2022 11:29:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next v5 0/3] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 menglong8.dong@gmail.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20221007092922.13169-1-imagedong@tencent.com>
 <95cb50a4-e50c-3b02-a521-24c2d11341de@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <95cb50a4-e50c-3b02-a521-24c2d11341de@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Menglong, Mat,

On 12/10/2022 02:53, Mat Martineau wrote:
> On Fri, 7 Oct 2022, menglong8.dong@gmail.com wrote:
> 
>> From: Menglong Dong <imagedong@tencent.com>
>>
>> In the 1th patch, we do some code cleanup with replease 'sock->sk'
>> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
>> use. And in the 3th patch, we add the testing for this commit.
>>
> 
> I think v5 looks ok for the export branch - we can get more test
> coverage there and update if needed.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patch and the review!

I was going to apply it but I just noticed our public CI complained
about the new test during its second test:


 KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/6538547548127232
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/6538547548127232/summary/summary.txt


The useful bit:

----------------------- 8< -----------------------
not ok 1 test: selftest_diag.tap # exit=7
# no msk on netns creation                          [  ok  ]
# listen match for dport 10000                      [  ok  ]
# listen match for sport 10000                      [  ok  ]
# listen match for saddr and sport                  [  ok  ]
# all listen sockets                                [  ok  ]
# after MPC handshake                               [  ok  ]
# ....chk remote_key                                [  ok  ]
# ....chk no fallback                               [  ok  ]
# msk in use statistics                             [  ok  ]
# msk in use statistics                             [  ok  ]
# check fallback                                    [  ok  ]
# many msk socket present                           [  ok  ]
# msk in use statistics                             [ fail ] expected
249 found 248
# msk in use statistics                             [  ok  ]
----------------------- 8< -----------------------

Do you mind looking at that please?


Please note that the public CI is known to be slow. Here it was failing
with a debug kernel config (KASAN, KMEMLEAK, etc. see
kernel/configs/debug.config file)

If you want to reproduce it in closer conditions, you can do something
like this to build the same kernel and run diag.sh in a loop until it fails:

  $ cd [kernel source code]
  $ echo "run_loop run_selftest_one ./diag.sh" > .virtme-exec-run
  $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
      --pull always mptcp/mptcp-upstream-virtme-docker:latest \
      auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virtme-docker


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

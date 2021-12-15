Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C22173
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 09:13:22 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id r11so71542853edd.9
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 01:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=RC73buyjUwOD3zXBo8bXGTAYpU+L19bX0tC5HDFaXp4=;
        b=UGywbcK4aMnzTRWe74Go/0MH5xDQkaT7Ruf4s16DW6bxJAwRJkeG3OGrKw+W3aew4Y
         Q+26kjJMQWiZvQlJIei2JyLH4nQLntzdlVyKvdTNyb4gqTWrigHwFk4QCq8Eje1SRIZ8
         jBtXrtw0WsWTXiNVVFCFEfLlCenNdbCXSYv5fpe++ezgkTq++d8BSlvW+kNLAeKkVhPs
         nrOUTR0DN0bbgn5Ezv1ngEyxQnwNOp9AE8CSIgiCd9DAHaJgUq2D6xlam4Uguaj1poNA
         97dEe2i8zbLR5GZ9iNO15Nc1EbpQ254/cBSq6TvRvdFR+e/MSUvWqCWpRRZ0bYbbNzlV
         EM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=RC73buyjUwOD3zXBo8bXGTAYpU+L19bX0tC5HDFaXp4=;
        b=mUkQ6csPOCEgHpzb0kJNp2y6qUm485OL1VDZHUawVgufekjPvEqdPlhtTQmfSkETnN
         1shH5Ld9UB30GDJLU7Zn9ZQhkG0f1HCqDfx0w12xrLx199YtEvrMl87q2gEGRoGxJMRk
         pCOu+fC5JInZ5911tAxlTETQF6HDw2cmEFmZYd2PfWRfbNZiMbBz42R8UymTiAXEiX6P
         4prM4LhCxAMbBUVqn49NklD8O3SaPf3Hk1hbZPRjJx1NO2/YzfKoP7Oixd7vve1mbJee
         LfuVTB9RUk7En0odeZoz5w9kfcazgYs49dFDY71y8mvsYgXBvhMnI/gJZyLhtekUedNT
         0XPw==
X-Gm-Message-State: AOAM532oJBLFHaPispAqZ+C8fsShSLptovAQ1A4pL9xTG4MOgt5KrA5w
	cz8En29z+n8yKNzO3oLgzAqiKnztgIbUsA==
X-Google-Smtp-Source: ABdhPJwUwDWE9J9T/6KOtciVkS9P7cqMrgQJMtq9+ElwzkaJsZVC4z2Z8cTYofUI9UaRFWjFDhca0w==
X-Received: by 2002:a17:907:972a:: with SMTP id jg42mr10288812ejc.398.1639559600580;
        Wed, 15 Dec 2021 01:13:20 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id 13sm449832ejh.225.2021.12.15.01.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 01:13:20 -0800 (PST)
Message-ID: <f529aa39-d0a5-908f-afb3-58553505bc3d@tessares.net>
Date: Wed, 15 Dec 2021 10:13:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <b6f8d2e06bfa3b15cc7fa0ac3076cfafd7448b07.1639482622.git.pabeni@redhat.com>
 <542f3ab-d93a-4cba-3bdf-4b8b85744073@linux.intel.com>
 <aeebca24-8584-a24c-700d-b8c8776033af@tessares.net>
In-Reply-To: <aeebca24-8584-a24c-700d-b8c8776033af@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/12/2021 10:04, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> 
> On 15/12/2021 02:32, Mat Martineau wrote:
>> On Tue, 14 Dec 2021, Paolo Abeni wrote:
>>
>>> MPTCP join self-tests are a bit fragile as they reply on
>>> delays instead of events to catch-up with the expected
>>> sockets states.
>>>
>>> Replace the delay with state checking where possible and
>>> reduce the number of sleeps in the most complex scenarios.
>>>
>>> This will both reduce the tests run-time and will improve
>>> stability.
> 
> Thank you for looking at that :)
> 
>> Running this in my local VM I saw more failures with the patch than
>> without (this is a kernel with a lot of debug turned on):
>>
>> 27 remove single subflow                syn[ ok ] - synack[ ok ] - ack[
>> ok ]
>>                                         rm [fail] got 0 RM_ADDR[s]
>> expected 1 - sf    [ ok ]
>>
>> ...
>>
>> 37 flush invalid addresses              syn[ ok ] - synack[ ok ] - ack[
>> ok ]
>>                                         add[ ok ] - echo  [ ok ]
>>                                         rm [ ok ] - sf    [ ok ]
>> copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
>>  client exit code 2, server 0
>>
>>
>> Could have been an unlucky run on my machine :)
>>
>> Matthieu, does it improve behavior in your test environments?
> 
> I ran mptcp_join.sh test in a loop during the night.

I forgot to mention the public CI also had some issues:


- KVM Validation: normal:
  - Unstable: 2 failed test(s): packetdrill_add_addr selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/5809917423517696
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5809917423517696/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): selftest_diag selftest_mptcp_connect
selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/5246967470096384
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5246967470096384/summary/summary.txt

Initiator: Patchew Applier
Commits:
https://github.com/multipath-tcp/mptcp_net-next/commits/b3b8dde4c773

But it also looks like the CI was quite busy with many other tasks when
looking at results from other tests at the same time.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

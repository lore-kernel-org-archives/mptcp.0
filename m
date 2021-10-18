Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BD2C81
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 10:24:58 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id y30so51109781edi.0
        for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xQLx9m4T5c9qwI2P9d/3KMs6OPZ4cEb2AJturDLKZdc=;
        b=qd7p/49kghZSPzIcMEoBf6Zbqke2sUF1Hqxzq67MtNCqfgNuTuPFxTXNoHFzam2Ikb
         POEQvKu0eERMtvZKhuiCWWrQYytT1eTIKaVWWxXYcj+xL9HmtYbo9nntrCee31msN/JR
         J0qpNPzkBJDd/pMx/kxC/ok75X1itnZuAUyxr9a8kXZoy6Ml7aB2YXkH8h8IVbD1mmJe
         IKe3HAjW0rcKRGUVonv/9ieF3A6iaqsp+ireMdWDOjELzfDhXTHDCot4pfmtTuV4b1bS
         o6kh4ehRUVvQiQl2bNwDpOxn01rEyHHPT5/oqLwCQcJH16vI5Kkj3goX1gKK8MM74AZw
         OfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xQLx9m4T5c9qwI2P9d/3KMs6OPZ4cEb2AJturDLKZdc=;
        b=FuV/eLgfjOvzVLrxiv+VcyduDG7Kvl7lUK8NRqr4ipA2iEtk1Vm3o2BR44x34d+syq
         BLOus2vZtQ2XJCHg775RHVSi43hAV+dimbG76MTk9DyFhb7ueJGUNummmvMiiGcfhpBw
         5HQNxpqlY9QxqF2Q1iKt+daOMEepzcGebdQ+qyuY7fIcNJQhRjBH0gitUz2rHz+xSrdo
         Kt+obHDlK9CqMenbi6ZhUUFHkmtoSkUUnEIKaIkMAmF9BFi2W2pGA7NbG8TJFjSJuag3
         QpEjhQRDmT/jtu1/EaaDBqbOtU9tDDmolCy3HiAgp/+bns3tX90KX4TsDjjKWzs3G7LB
         QRGQ==
X-Gm-Message-State: AOAM533ZsppbxlrJ584jra0Xia1ALMrGHrQlHdQbXUTgX9pVXB93ACwT
	FOCL3Hdze/TfgamqHnhHpJrLsHUYkRC8IXa4MtA=
X-Google-Smtp-Source: ABdhPJyUIpn0zqUSe/S8MYoKw9QqPG6WH0b9fL69YrRP8UrKXKvZ2B3F7zr7cyC7DMC8vhjX8ewa/Q==
X-Received: by 2002:a17:906:4d08:: with SMTP id r8mr28988463eju.388.1634552696536;
        Mon, 18 Oct 2021 03:24:56 -0700 (PDT)
Received: from [10.120.18.87] ([84.17.46.26])
        by smtp.gmail.com with ESMTPSA id fx4sm8589605ejb.113.2021.10.18.03.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:24:56 -0700 (PDT)
Message-ID: <1fe3d619-370f-d5bb-6d6f-af6890f9fc43@tessares.net>
Date: Mon, 18 Oct 2021 12:24:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH v2] selftests: mptcp: more stable simult_flows tests
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
 <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 16/10/2021 02:12, Mat Martineau wrote:
> On Fri, 15 Oct 2021, Paolo Abeni wrote:
> 
>> Currently the simult_flows.sh self-tests are not very
>> stables, expecially when running on slow VM.
>>
>> The tests mesures runtime for transfers on multiple subflows
>> and check that the time is nearby the theoretical maximum.
>>
>> The current test infra introduces a bit of jitter in test
>> runtime, due to multiple explicit delays. Additionally the
>> runtime is measured by the shell script wrapper. On slow
>> VM, the script overhead is measurable and subject to relevant
>> jitter.
>>
>> One solution to make the test more stable would be adding more
>> slack to the expected time; that could possibly hide reall
>> regressions. Instead move the measurement inside the command
>> doint the transfer, and drop most unneeded sleep.

Thank you for looking at that!

It is indeed more stable: with a debug kernel and a "slow host", the
test fails almost all the time. Now I got 3 failures in X attempts, not
bad! (and I stopped after the last failure)

>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> @matttbe: could you please double check this makes simult_flows
>> tests really more stable in your testbed?
>>
>> Now the slack is really quite tight, I think we can raise it a
>> little more, without loosing the ability of catching regressions
> 
> 
> I still get occasional failures on my slow desktop VM (lots of debug
> features turned on), but a little more slack would help. Most of the
> time all cases succeed. If I see a failure, it's just one test out of
> the batch. These are each from separate runs of simult_flows.sh:
> 
> unbalanced bwidth                                           transfer
> slower than expected! runtime 4500 ms, expected 4005 ms max 4005       
> [ fail ]
> 
> 
> unbalanced bwidth with opposed, unbalanced delay            transfer
> slower than expected! runtime 4632 ms, expected 4005 ms max 4005       
> [ fail ]
> 
> 
> Curious to see Matthieu's results!


I also have issues with unbalanced bwidth tests. In a normal situation,
I'm also very closed under the expected time so maybe we can increase
the thresholds.

Here is what I have when the tests are succeeding:


> balanced bwidth                                             7404 max
7561       [ OK ]

> balanced bwidth - reverse direction                         7422 max
7561       [ OK ]

> balanced bwidth with unbalanced delay                       7428 max
7561       [ OK ]

> balanced bwidth with unbalanced delay - reverse direction   7406 max
7561       [ OK ]

> unbalanced bwidth                                           3837 max
4005       [ OK ]

> unbalanced bwidth - reverse direction                       3808 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay                     3880 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay - reverse direction 3845 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay            3881 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay - reverse
direction3834 max 4005       [ OK ]





> balanced bwidth                                             7413 max
7561       [ OK ]

> balanced bwidth - reverse direction                         [
195.535235] hrtimer: interrupt took 19400 ns

7406 max 7561       [ OK ]

> balanced bwidth with unbalanced delay                       7388 max
7561       [ OK ]

> balanced bwidth with unbalanced delay - reverse direction   7415 max
7561       [ OK ]

> unbalanced bwidth                                           3853 max
4005       [ OK ]

> unbalanced bwidth - reverse direction                       3869 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay                     3887 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay - reverse direction 3826 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay            3880 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay - reverse
direction3826 max 4005       [ OK ]





> balanced bwidth                                             7441 max
7561       [ OK ]

> balanced bwidth - reverse direction                         7439 max
7561       [ OK ]

> balanced bwidth with unbalanced delay                       7414 max
7561       [ OK ]

> balanced bwidth with unbalanced delay - reverse direction   7432 max
7561       [ OK ]

> unbalanced bwidth                                           3803 max
4005       [ OK ]

> unbalanced bwidth - reverse direction                       3810 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay                     3792 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay - reverse direction 3796 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay            3839 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay - reverse
direction3809 max 4005       [ OK ]







Now when they are failing:



> balanced bwidth                                             7397 max
7561       [ OK ]

> balanced bwidth - reverse direction                         7386 max
7561       [ OK ]

> balanced bwidth with unbalanced delay                       7401 max
7561       [ OK ]

> balanced bwidth with unbalanced delay - reverse direction   7403 max
7561       [ OK ]

> unbalanced bwidth                                           transfer
slower than expected! runtime 4039 ms, expected 4005 ms max 4005
[ fail ]

> client exit code 1, server 0

>

> netns ns3-0-BaDnIV socket stat for 10005:

> State     Recv-Q Send-Q Local Address:Port  Peer Address:Port Process

> TIME-WAIT 0      0           10.0.3.3:10005     10.0.2.1:39479
timer:(timewait,59sec,0)

>

> TIME-WAIT 0      0           10.0.3.3:10005     10.0.1.1:49984
timer:(timewait,59sec,0)

>

>

> netns ns1-0-BaDnIV socket stat for 10005:

> State Recv-Q Send-Q Local Address:Port Peer Address:PortProcess

> -rw------- 1 root root 16777216 Oct 18 09:33 /tmp/tmp.JugE78zTog

> -rw------- 1 root root 16777216 Oct 18 09:34 /tmp/tmp.SPV6oen3hT

> -rw------- 1 root root 81920 Oct 18 09:33 /tmp/tmp.7SJVlib0CM

> -rw------- 1 root root 81920 Oct 18 09:34 /tmp/tmp.QvimZ7jK8i

> unbalanced bwidth - reverse direction                       3808 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay                     3798 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay - reverse direction 3844 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay            3937 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay - reverse
direction3810 max 4005       [ OK ]





> balanced bwidth                                             7391 max
7561       [ OK ]

> balanced bwidth - reverse direction                         7380 max
7561       [ OK ]

> balanced bwidth with unbalanced delay                       7424 max
7561       [ OK ]

> balanced bwidth with unbalanced delay - reverse direction   7412 max
7561       [ OK ]

> unbalanced bwidth                                           3894 max
4005       [ OK ]

> unbalanced bwidth - reverse direction                       3884 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay                     3848 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay - reverse direction 3896 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay            transfer
slower than expected! runtime 4039 ms, expected 4005 ms max 4005
[ fail ]

> client exit code 1, server 0

>

> netns ns3-0-4o5MrN socket stat for 10009:

> State     Recv-Q Send-Q Local Address:Port  Peer Address:Port Process

> TIME-WAIT 0      0           10.0.3.3:10009     10.0.1.1:51946
timer:(timewait,59sec,0)

>

> TIME-WAIT 0      0           10.0.3.3:10009     10.0.2.1:40567
timer:(timewait,59sec,0)

>

>

> netns ns1-0-4o5MrN socket stat for 10009:

> State     Recv-Q Send-Q Local Address:Port  Peer Address:Port Process

> TIME-WAIT 0      0           10.0.1.1:51946     10.0.3.3:10009
timer:(timewait,58sec,0)

>

> -rw------- 1 root root 16777216 Oct 18 09:41 /tmp/tmp.TZc6AFBB9s

> -rw------- 1 root root 16777216 Oct 18 09:43 /tmp/tmp.fwjA2UfvqJ

> -rw------- 1 root root 81920 Oct 18 09:41 /tmp/tmp.4XRtDSnt3Z

> -rw------- 1 root root 81920 Oct 18 09:42 /tmp/tmp.nqFmtr1ZHk

> unbalanced bwidth with opposed, unbalanced delay - reverse
direction3876 max 4005       [ OK ]





> balanced bwidth                                             7415 max
7561       [ OK ]

> balanced bwidth - reverse direction                         7391 max
7561       [ OK ]

> balanced bwidth with unbalanced delay                       7436 max
7561       [ OK ]

> balanced bwidth with unbalanced delay - reverse direction   7389 max
7561       [ OK ]

> unbalanced bwidth                                           3797 max
4005       [ OK ]

> unbalanced bwidth - reverse direction                       3797 max
4005       [ OK ]

> unbalanced bwidth with unbalanced delay                     transfer
slower than expected! runtime 4324 ms, expected 4005 mstransfer slower
than expected! runtime 4421 ms, expected 4005 ms max 4005        [ fail ]

> client exit code 1, server 1

>

> netns ns3-0-CL5xtY socket stat for 10007:

> State     Recv-Q Send-Q Local Address:Port  Peer Address:Port Process

> TIME-WAIT 0      0           10.0.3.3:10007     10.0.1.1:57566
timer:(timewait,59sec,0)

>

>

> netns ns1-0-CL5xtY socket stat for 10007:

> State     Recv-Q Send-Q    Local Address:Port  Peer Address:Port Process

> TIME-WAIT 0      0              10.0.1.1:57566     10.0.3.3:10007
timer:(timewait,59sec,0)

>

> TIME-WAIT 0      0      10.0.2.1%ns1eth2:47275     10.0.3.3:10007
timer:(timewait,59sec,0)

>

> -rw------- 1 root root 16777216 Oct 18 09:56 /tmp/tmp.2Fm5JWJ2Gm

> -rw------- 1 root root 16777216 Oct 18 09:55 /tmp/tmp.myCVbJlKF1

> -rw------- 1 root root 81920 Oct 18 09:55 /tmp/tmp.GJRGytXcM1

> -rw------- 1 root root 81920 Oct 18 09:56 /tmp/tmp.WUONy22LUi

> unbalanced bwidth with unbalanced delay - reverse direction 3906 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay            3823 max
4005       [ OK ]

> unbalanced bwidth with opposed, unbalanced delay - reverse
direction3810 max 4005       [ OK ]


Please tell me if you need anything else!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

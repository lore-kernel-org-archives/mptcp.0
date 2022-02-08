Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAE2F21
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 16:24:52 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id p15so53770526ejc.7
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9QFNE89brsQZiaZxl/q6Q7wvMT8IKyyDNdM1RUdBRlA=;
        b=X0BiIPWgikTqBBsDizPaQRPXJb9rniaIGprjFhk238GzzEKWqn/nfn/TxM2C3fxjIb
         bjjgcdR11P61jJeVBF2Az4gTGmdGZKc1tpC8RSDXQLKY7B1qGfyTwNChvDiauZB4kAiJ
         vFTdy6NW5VpfDYCEmdousIaL308zXPaKJYmZn6wgu6e6ecQ7IBZ3PibfgOthUpP9nv8b
         +2jLNFFCSWWrlDlKhEMueLMP0Jt75/q/P77Mptdku/i2zV4lKf7SoP2DAqqWkoyVUuJy
         C4H1tECdwg2JIwMrHqOSBUmE08NuDH4BXj0uM2GJNR/GrjaXa5D5KDcGxlBlGrgqz61E
         AHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9QFNE89brsQZiaZxl/q6Q7wvMT8IKyyDNdM1RUdBRlA=;
        b=C8nVhnYhPb2ZttrYzXmiOWWiZ0M1t0reiPHACmeg7r/vulk5EXQOcOKYNGoqCg3Y2Z
         EwWEyprViRPVVxuA3h3oMBwuJ1pMvNS7dYq9/yZGLG9ByEUdKmkT9gaMHI9B/1sWyAjb
         jMCadnryUEOM6K023gnPEk6HC00Kzi+IlDKc32he2Td2QjGdjBzPelv+vofQBKjxSE1/
         gxk5OKNilY/qduv1L5Gb/HmgVC6SlnPNMxSe7HT3v/io7VnqYCaa3BsS8cfQlQ5NOoou
         iX5MOAEgq+GeLDah0azwH2uW7vPvHRlkkSoY0klVxW7kfssiokfNh6ikgk7eka+GkNYk
         FoOg==
X-Gm-Message-State: AOAM530lFCP0i5SIZDVLeVVsM6ZnD4z52G3lgOS79bYPIbLQLxHE0x0H
	mxT0Mfq4ASeZAOkCqEcFfyvDmw==
X-Google-Smtp-Source: ABdhPJxZ4NGrbG4+DGaoGMkRjuS/uadYaauAP0yN2vsIKjqDQnDHs/wpHqX3vaq45gWc0tjhUhloVw==
X-Received: by 2002:a17:907:7ba9:: with SMTP id ne41mr4351741ejc.4.1644337490700;
        Tue, 08 Feb 2022 08:24:50 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fb41:b0aa:bf65:8b91? ([2a02:578:8593:1200:fb41:b0aa:bf65:8b91])
        by smtp.gmail.com with ESMTPSA id i36sm2859810eda.52.2022.02.08.08.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 08:24:50 -0800 (PST)
Message-ID: <20746295-b038-b485-ea6f-4f14dc7bf1cd@tessares.net>
Date: Tue, 8 Feb 2022 17:24:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1643110285.git.geliang.tang@suse.com>
 <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
 <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
 <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
 <eb33b5d3-a6e8-55d0-a149-c045ec2ecab5@tessares.net>
 <20220207140854.GA2916@localhost>
 <63c6dc9c-fa32-cf8b-2f5d-4fc5c51447b2@tessares.net>
 <20220208154110.GA28531@localhost>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220208154110.GA28531@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 08/02/2022 16:41, Geliang Tang wrote:
> Hi Matt, Mat,
> 
> On Tue, Feb 08, 2022 at 01:26:10PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 07/02/2022 15:08, Geliang Tang wrote:
>>> On Mon, Feb 07, 2022 at 11:32:05AM +0100, Matthieu Baerts wrote:
>>>> Hi Geliang,
>>>>
>>>> On 07/02/2022 05:13, Geliang Tang wrote:
>>>>> Hi Matt,
>>>>>
>>>>> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年1月29日周六 01:04写道：
>>>>>>
>>>>>> Hi Mat, Geliang,
>>>>>>
>>>>>> On 27/01/2022 01:07, Mat Martineau wrote:
>>>>>>> On Tue, 25 Jan 2022, Geliang Tang wrote:
>>>>>>>
>>>>>>>> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
>>>>>>>> checksum failures.
>>>>>>>>
>>>>>>>
>>>>>>> This patch is working well with the inverted byte detection, thanks!
>>>>>>
>>>>>> The public CI seems quite happy with the new version, good work :)
>>>>>>
>>>>>> Here is its report:
>>>>>>
>>>>>> ====== 8< ======
>>>>>> Our CI did some validations and here is its report:
>>>>>>
>>>>>> - KVM Validation: normal:
>>>>>>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>>>>>>   - Task: https://cirrus-ci.com/task/4993794666921984
>>>>>>   - Summary:
>>>>>> https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summary/summary.txt
>>>>>>
>>>>>> - KVM Validation: debug:
>>>>>>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
>>>>>>   - Task: https://cirrus-ci.com/task/4682233209421824
>>>>>>   - Summary:
>>>>>> https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summary/summary.txt
>>>>>>
>>>>>> Initiator: Patchew Applier
>>>>>> Commits:
>>>>>> https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136372
>>>>>> ====== 8< ======
>>>>>>
>>>>>> But if you look at the logs [1], there are probably 3 last things to
>>>>>> improve:
>>>>>>
>>>>>> [1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.log
>>>>>>
>>>>>> This line is repeated 90+ times:
>>>>>>
>>>>>>   tc action pedit offset 162 out of bounds
>>>>>>
>>>>>> (we talked about this one at the last meeting with ideas on how to
>>>>>> reduce/get rid of them)
>>>>>>
>>>>>
>>>>> Dose 'tc + iptables' work for our case?
>>>>>
>>>>> Use iptables to select the packets with enough data. Then use tc to
>>>>> edit the selected packets only. (I don't know how to do it yet.)
>>>>>
>>>>> Here's a link about this:
>>>>>
>>>>> https://wiki.archlinux.org/title/advanced_traffic_control#Using_tc_+_iptables
>>>>> .
>>>>> '''
>>>>> Using tc + iptables
>>>>>
>>>>> Iptables has a method called fwmark that can be used to mark packets
>>>>> across interfaces.
>>>>>
>>>>> First, this makes packets marked with 6, to be processed by the 1:30 class
>>>>>
>>>>> # tc filter add dev eth0 protocol ip parent 1: prio 1 handle 6 fw flowid 1:30
>>>>>
>>>>> This sets that mark 6, using iptables
>>>>>
>>>>> # iptables -A PREROUTING -t mangle -i eth0 -j MARK --set-mark 6
>>>>>
>>>>> You can then use iptables normally to match packets and then mark them
>>>>> with fwmark.
>>>>> '''
>>>>
>>>> Good idea, probably simpler!
>>>>
>>>> I guess we can mark some packets in POSTROUTING and modify the egress TC
>>>> rule.
>>>>
>>>> Do you need a hand for that?
>>>>
>>>
>>> Thanks, Matt, I really need your help :)
>>
>> Sure.
>> May you try the attached patch if you don't mind?
> 
> Great! Thanks Matt. I just tested your patch, the single subflow test
> ("002 1 MP_FAIL, single subflow") works well. And very stable. The two
> issues that I mentioned in the cover letter of this series didn't happen
> when running this new selftest. So the first two squash-to patches in
> this series can be dropped.

That's nice! Thank you for having tested, I'm glad it helped!

> Mat, it looks like no need to analyse my attached pcaps any more. Thanks
> for your help.
> 
>>
>> I now have this output:
>>
>> 001 0 MP_FAIL, multiple subflows         syn[ ok ] - synack[ ok ] - ack[
>> ok ]
>>                                          sum[ ok ] - csum  [ ok ]
>>                                          ftx[ ok ] - frx   [ ok ]
>>                                          itx[ ok ] - irx   [ ok ]
> 
> But the multiple subflows test ("001 0 MP_FAIL, multiple subflows") doesn't
> work. I'll try to fix it tomorrow. I think it's easy to fix.

Yes, it looked strange to me. I guess the test should fail if 'nr_fail'
is set to 0, no?
Or probably we should no longer use 'get_nr_fail' as we expect to have
only one MP_FAIL, no?

In the IPTables rule I added, I asked to mark the first packet that is
over 150 bytes. We can change "--packet" if we want to mark the Xth one.
And "--every" if we have more packets but worst case, that's not an
issue to corrupt another one I think: on this path, either we have no
more subflow (multiple subflows case) or no more MPTCP connection (1
subflow case).

> 
> Thanks,
> -Geliang
> 
>> Created /tmp/tmp.SNhvH7ucj9 (size 512 KB) containing data sent by client
>> Created /tmp/tmp.RFEqEXi0bl (size 512 KB) containing data sent by server
>> file received by server has inverted byte at 69
>> file received by server has inverted byte at 70
>> file received by server has inverted byte at 71
>> file received by server has inverted byte at 72

We can also modify the TC command to invert only a u8 instead of a u32
to reduce the log entries here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

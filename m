Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE52F21
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 10:32:08 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id f17so11822912edd.2
        for <mptcp@lists.linux.dev>; Mon, 07 Feb 2022 02:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/92UXA6uhQdPssvccHqLkhG+EYfYtHnCSVqGZLIj06U=;
        b=hrw9jTR0NWk56xXxiM4iw2bC0xNcOXnIbIMSzz6TvnNwB9izoE2q6loF0EZ2g8wxfX
         KycD1mID8WhRvLnlgtxHbUCtVEc3l9Z8598eUxcbOC0PNfB5Nw42CcrIrvtZRTimor74
         FdYmmI2wQ+v8Xfmld+KziUJuOSFKlqx0uYYKYyJOd/ayGo2wDfTxj+JxcNLLeuRZBsrH
         WYs3og7/98doGitCkAaddSo6JM6OXQU0n6Fy98/Z9MWsNKYf2MH1eZ7P6oyrSB3tVFc8
         4MD88rpxueo9JR3gp1/xLr1gyid/zUozgq/IZH02tIQ5WXtsT7tx4Y8/+E5MoYPxYM8L
         DiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/92UXA6uhQdPssvccHqLkhG+EYfYtHnCSVqGZLIj06U=;
        b=XKzq3TRHWlJj0jPU82lgHRF2E/UR0wKWfYkNo7p/aKN3MrugkRNuCFNNpdrL5Y5mjE
         zXPJQ47cyYio9GlcQSnrwsdYrFZiK1wS+1pYH7zruYQtvDR1p+xqKSCmTOLCKLqTMJzU
         /42cB38wV+lyFkotKZgT2DL6wxUxYS9cCm4spscJVrbWzMhYkXh696qWZzYTVO/wA9Ay
         ZTADRO+G4A7RNyDOxVxQndxocdfarag3GzaYOgcuYUpPTogWbIG8Vyy5UpChgxpSTBOn
         qAMxz0qWUo5WhWI4kYkihbsfEd8gDXozKDHpCWpyhdinDSxaDljrgIkhboSLiGeqaQt2
         1Dpg==
X-Gm-Message-State: AOAM532fCXY9fNOIQXTpg26dQ3netDTEYG1eug1r8PZwH9Dl4O9poIbZ
	v4S1xgpDWnTut+544rUPq37P7g==
X-Google-Smtp-Source: ABdhPJyAsPa0j5M/AiAE7jf++SuNSZ+zWYJP6zpV1/lqcTXSaGRj73OoSIb3FDOqSWhHLddqfmeFPw==
X-Received: by 2002:a05:6402:b9c:: with SMTP id cf28mr309921edb.295.1644229926725;
        Mon, 07 Feb 2022 02:32:06 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:94a3:2519:1aae:2576? ([2a02:578:8593:1200:94a3:2519:1aae:2576])
        by smtp.gmail.com with ESMTPSA id bo9sm446555edb.29.2022.02.07.02.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 02:32:06 -0800 (PST)
Message-ID: <eb33b5d3-a6e8-55d0-a149-c045ec2ecab5@tessares.net>
Date: Mon, 7 Feb 2022 11:32:05 +0100
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
To: Geliang Tang <geliangtang@gmail.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream
 <mptcp@lists.linux.dev>, Davide Caratti <dcaratti@redhat.com>
References: <cover.1643110285.git.geliang.tang@suse.com>
 <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
 <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
 <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 07/02/2022 05:13, Geliang Tang wrote:
> Hi Matt,
> 
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年1月29日周六 01:04写道：
>>
>> Hi Mat, Geliang,
>>
>> On 27/01/2022 01:07, Mat Martineau wrote:
>>> On Tue, 25 Jan 2022, Geliang Tang wrote:
>>>
>>>> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
>>>> checksum failures.
>>>>
>>>
>>> This patch is working well with the inverted byte detection, thanks!
>>
>> The public CI seems quite happy with the new version, good work :)
>>
>> Here is its report:
>>
>> ====== 8< ======
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal:
>>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>>   - Task: https://cirrus-ci.com/task/4993794666921984
>>   - Summary:
>> https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summary/summary.txt
>>
>> - KVM Validation: debug:
>>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
>>   - Task: https://cirrus-ci.com/task/4682233209421824
>>   - Summary:
>> https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summary/summary.txt
>>
>> Initiator: Patchew Applier
>> Commits:
>> https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136372
>> ====== 8< ======
>>
>> But if you look at the logs [1], there are probably 3 last things to
>> improve:
>>
>> [1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.log
>>
>> This line is repeated 90+ times:
>>
>>   tc action pedit offset 162 out of bounds
>>
>> (we talked about this one at the last meeting with ideas on how to
>> reduce/get rid of them)
>>
> 
> Dose 'tc + iptables' work for our case?
> 
> Use iptables to select the packets with enough data. Then use tc to
> edit the selected packets only. (I don't know how to do it yet.)
> 
> Here's a link about this:
> 
> https://wiki.archlinux.org/title/advanced_traffic_control#Using_tc_+_iptables
> .
> '''
> Using tc + iptables
> 
> Iptables has a method called fwmark that can be used to mark packets
> across interfaces.
> 
> First, this makes packets marked with 6, to be processed by the 1:30 class
> 
> # tc filter add dev eth0 protocol ip parent 1: prio 1 handle 6 fw flowid 1:30
> 
> This sets that mark 6, using iptables
> 
> # iptables -A PREROUTING -t mangle -i eth0 -j MARK --set-mark 6
> 
> You can then use iptables normally to match packets and then mark them
> with fwmark.
> '''

Good idea, probably simpler!

I guess we can mark some packets in POSTROUTING and modify the egress TC
rule.

Do you need a hand for that?

>> But also this one now, repeated 40+ times with different offsets:
>>
>>   file received by server has inverted byte at 106565
>>
> 
> These inverted byte logs will not be there if we add the code to drop
> the bad data in future. (I haven't figured out how to implement this
> yet.) Right now, just let them be there.

I see. I guess later, when the code to drop the bad data in the future
will be ready, this "warning" will become an "error" we will no longer
ignore.

>> And one last thing, we can see that now we have more than 99 tests, the
>> alignement is no longer OK :)
>>
>>
>>   # 101 1 MP_FAIL, single subflow            syn[ ok ] - synack[ ok ]...
>>   #                                         sum[ ok ] - csum  [ ok ]
>>   #                                         ftx[ ok ] - frx   [ ok ]
>>   #                                         itx[ ok ] - irx   [ ok ]
>>
>> A very small detail, up to you to fix it or not ;)
>>
> 
> I'll update this in the next version.

Thanks!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

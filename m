Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4842C81
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 12:51:39 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 5so842062edw.7
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y88K2MglOH2JTNGTKEMdSmV4tGtm/nOH8qr4N5Tm2F0=;
        b=wa7CaHFy3rV0BjdWIDjtCvFpA/VWbZyN+B99C7dKbfLFMgaG9h2aUbVgsp4u++mhqV
         MX2CNR/RmvGmhJGEqQD3H74R1SE+xVtmcjpX6MwWdLAfiHFDUmUmgPpmB0axFS6cBxoD
         QCZFJJ4PEdbDuEpGCGPncUnDGWWJ1kluZFfAZvhQgee5UrmgGxNQbGiBimUUaPtL/vDc
         8yuxPP+jkKrWzJVmQKGiWTTDRN+e//TPHGXuPh/wpOWMNuuAearHJD97ekXUevlUUcNz
         gQuoPdOPzBhJ4tCnt+kYS/QjxX4TGxyu2ECgiO9ALw2ScgHmIDAJ14tWzKKLeicYyo8K
         wxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y88K2MglOH2JTNGTKEMdSmV4tGtm/nOH8qr4N5Tm2F0=;
        b=ziaU5aMwzSmz4EOuwt1eB7zpQuIVQD/G6SWYmebpwMvlcTf9cEfwgP0vHO12HtLwPG
         IoWybAJMtLqSXj+9GFiwqPvp9emVNOet07SgrpMC8tkRL2JpQkbcpVfixTPPpL84Tcc6
         l+5xjEppve0Q+pz/zPfWjaDeFZtiba+i5RgMTMBypD3gnzzL7DnkZVKRf+Ra8RsVWUz4
         FxnFLOP7Ep6tey8hCJlzd1j2/f0wm5Voh4KBz8kd0BNRkB9yhy632MlALUf7vkdSJFeN
         fzuxafqA1NHax5p2VyL1o8DydlIfpWibNNZonZ3l0sg61Wrs4d8R1i0ycjGjcNm3icfG
         xkuw==
X-Gm-Message-State: AOAM530bELR6K2cfLjKlkfR8phXH0udJV2DE3nBefi3dUzUa9vFMDaWA
	uP3c/Hr5XKTNPxNKga/KL1Xulw==
X-Google-Smtp-Source: ABdhPJxLkOeoG+sanFcP2PRLPsczCs8Og5y6eX/lZd/XTmYgQm7hX+KGL/0KlBafwrya1PAFZmphWA==
X-Received: by 2002:a50:cd96:: with SMTP id p22mr7451713edi.109.1634820694270;
        Thu, 21 Oct 2021 05:51:34 -0700 (PDT)
Received: from [10.44.1.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id he37sm1112781ejc.113.2021.10.21.05.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 05:51:33 -0700 (PDT)
Message-ID: <a025ed1d-eb63-b5df-9f38-77487f72d5e0@tessares.net>
Date: Thu, 21 Oct 2021 14:51:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>, Geliang Tang
 <geliangtang@gmail.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1634531093.git.geliang.tang@suse.com>
 <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
 <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com>
 <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
 <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com>
 <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net>
 <YXEwoTyTQxN3dcQx@dcaratti.users.ipa.redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <YXEwoTyTQxN3dcQx@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide,

On 21/10/2021 11:19, Davide Caratti wrote:
> On Wed, Oct 20, 2021 at 04:49:35PM +0200, Matthieu Baerts wrote:
>> Hi Davide,
>>
>> On 20/10/2021 13:33, Davide Caratti wrote:
>>> hi,
>>>
>>> On Wed, Oct 20, 2021 at 12:40 PM Matthieu Baerts
>>> <matthieu.baerts@tessares.net> wrote:
>>>>
>>> [...]
>>>
>>>>>
>>>>> I had a script that used TC flower and gact + pedit + csum actions to flip the 'PSH'
>>>>> bit in the TCP header, I promised myself to change it to corrupt the DSS option.
>>>
>>> FTR, that script was:
>>>
>>> # convert PSH,ACK into ACK
>>> # tc filter add dev vetha egress protocol ip prio 1000 flower ip_proto
>>> tcp tcp_flags 0x18/0xff action pedit ex munge tcp flags set 0x10 pipe
>>> csum tcp reclassify
>>> # convert ACK into PSH,ACK, 1 each 10 packets
>>> # tc filter add dev vetha egress protocol ip prio 1001 flower ip_proto
>>> tcp tcp_flags 0x10/0xff action pass random determ pipe 10 pedit ex
>>> munge tcp flags add 0x8 pipe csum tcp
>>
>> Thank you for sharing that.
>>
>> I managed to change the content of a TCP packet using:
>>
>>   $ tc -n <ns> qdisc add dev <iface> root handle 1: htb
>>
>>   $ tc -n <ns> filter add dev <iface> parent 1: protocol ip prio 1000
>> flower ip_proto tcp action pedit munge offset 148 u32 invert pipe csum tcp
>>
>> It looks like nothing happen for packets smaller than 148 bytes.
>>
>> Note that I had to add these to the config file:
>>
> 
>> CONFIG_NET_SCH_HTB=m
> 
> I assume you are using HTB because it's a classful qdisc and it's used to
> attach the flower classifier. You don't need it, just use the clsact
> qdisc (CONFIG_NET_CLS_ACT=y + CONFIG_NET_SCH_INGRESS=y), it will allow
> you inserting filters+actions even if no root qdisc is in place.
> 
> # tc qdisc add dev eth0 clsact
> # tc filter add dev eth0 egress matchall action simple sdata "hello"

Great, I don't know well this obscure tc :-)

So we should do instead:

$ tc -n <ns> qdisc add dev <iface> clsact
$ tc -n <ns> filter add dev <iface> egress \
  protocol ip prio 1000 \
  flower ip_proto tcp \
  action pedit munge offset 148 u32 invert \
  pipe csum tcp

Right?

> 
>>
>> CONFIG_NET_ACT_CSUM=m
>>
>> CONFIG_NET_ACT_GACT=m
>>
>> CONFIG_GACT_PROB=y
>>
>> CONFIG_NET_ACT_PEDIT=m
>>
>> CONFIG_NET_CLS_FLOWER=m
>>
>>
>> @Geliang: do you think you could use this command?
>>
>>>>> The problem with this approach is, we can't assume that the DSS option has a fixed
>>>>> offset from the IP header. So, the test might start corrupting other options that
>>>>> are not MPTCP.
>>>>
>>>> If we corrupt any data in TCP Options or data and update the TCP
>>>> Checksum, that's enough to corrupt the DSS. For example, we could flip
>>>> the last bit of the TCP payload (if tcp.len > 0). Would it be possible
>>>> to do this by adapting your script?
>>>
>>> it's easier if it's the first bit, then...
>>>
> [...] 
>  
>>>> And using simple solutions like "tc netem corrupt" will be detectable by
>>>> TCP csum.
>>>
>>> this can be easily workarounded using the 'csum' TC action after the
>>> netem dequeue.
>>
>> Good point! So we would need to create a tree with first "netem" then
>> "csum" action?
> 
> the problem is, netem acts *after* TC actions. But probably in your
> setup you can overcome this by making netem corrupt when xmitting, and
> install the TCP csum  at  the receiver ingress (also here clsact is
> helpful):
> 
> # ip link add name vetha type veth peer name vethb
> # tc qdisc add dev vetha root netem <...>
> # tc qdisc a dev vethb clsact
> # tc filter add dev vethb ingress protocol ip flower ip_proto tcp action csum tcp

Thank you for the explanations and the commands :-)

>> The only thing is that netem will introduce errors at random positions,
>> maybe in IP/TCP headers but it is maybe not an issue. If the TC filter
>> command is enough, it might help to produce more controlled tests.
> 
> maybe TC flower + action is even more accurate then netem: because it leaves
> you the freedom to "corrupt" only packets after the 3WHS (or only the 3WHS,
> depending on the match arguments of flower).
> You can obtain the same randomization as netem by using TC "act_gact" random
> feature ("CONFIG_GACT_PROB=y")
> 
>  # tc filter add dev vetha egress protocol ip prio 1001 flower \
>   > ip_proto tcp \
>   > tcp_flags 0x10/0xff \ <-- only the ACK BIT is set 
>   > action pass random determ pipe 10 \    <-- 1 packet every 10 goes to pedit, others go out unmodified
>   > pedit munge offset 148 u32 invert pipe csum tcp <-- corrupt the payload and recompute checksum

Good point!
I don't know if Geliang wants to have all packets transporting data that
are being corrupted or a random one out of X packets or only a specific one.

>> Indeed it looks like it is doable but if we could not add new
>> dependences, I think that would be easier for us :)
> 
> Whatever works, it's good also for me :)

:)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

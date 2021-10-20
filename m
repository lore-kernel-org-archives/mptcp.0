Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB252C80
	for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 14:50:45 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id a25so26892029edx.8
        for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8ONXdHSjtYF5owmLRl1LxcRnuAc0ijnkVkb3BmzWQfo=;
        b=brQB/nmFZYRTYJ2S/3UrQzAGIo/+2aBYM1N43z3duVDq2OeqnArNbI/9iVLXuBEedW
         Lr6I8wE1nfEbPyVSjqpjSnMnzE5XHcGkjOc1q03juL6QXT1GEwED7hXDdGnOMXJy8RMi
         spCt2DCQ0VPn3MXtUQl/1/cyDTOnfNkTyIptW6TaP/6tTO5rOFi+6PUL6Gut+/EK7d1w
         t+rUWi+wXK/tmOHb0yvmPORSooiULNlTYBqxm3Z6g90wZ6PEup4+R0CfuPVbX50Ce2xm
         M5/4cKZazzyNqcFhe/wltpQzX2cupucR26RUoYa4l/z1lp0VqfxO8l/+8Bht/Q3XE2qJ
         S4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8ONXdHSjtYF5owmLRl1LxcRnuAc0ijnkVkb3BmzWQfo=;
        b=ViQDCAev6ylwzjjx7OTdNKVXvq64GwwkPCaP4q7R8vyyaGpvU7c2sDe/UoiVFjqmKU
         vWGSc1YRdGgl/h4yFj+s1xlE4azovLAQfud1jRJkPLNS00bnlz6rxT8R9zyfiZHIJiTs
         FQZZ4VT4P4QZJW7JGLRgw5HC6psn79TyeRHBKXvrUOFAoSnfy6F7n8m9e7gnMu3YbMqS
         yaIK5+Y512uyNZ8m0DSRbLAa5NNK1OYE0Czw1htCxOsCB67EJM/+kFkF+lYthmVUFrn7
         O+AqDWHYg8p6otBu0GJmIW3Z8f7VLBnF9y93z37cVIv2IKi7mOdab5H5GDSN1Ics2blS
         82FA==
X-Gm-Message-State: AOAM530ZA9ZBXkACiWpn6t2ti92hxr3KzgtnZpALURRhe9LQDPzzb3Mk
	oBe7XnMntOpVP8x4JV6k5WDE2w==
X-Google-Smtp-Source: ABdhPJyq0wf8rkBMT9gncsTn2XrxNEMZsSqy7aPyBAQQ9bOBZWg+xOysu57lq8Rc+siwwCik1JFXsg==
X-Received: by 2002:a05:6402:1c94:: with SMTP id cy20mr581283edb.144.1634741377183;
        Wed, 20 Oct 2021 07:49:37 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id o10sm1335170edj.79.2021.10.20.07.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 07:49:36 -0700 (PDT)
Message-ID: <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net>
Date: Wed, 20 Oct 2021 16:49:35 +0200
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
To: Davide Caratti <dcaratti@redhat.com>, Geliang Tang <geliang.tang@suse.com>
Cc: Geliang Tang <geliangtang@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1634531093.git.geliang.tang@suse.com>
 <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
 <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com>
 <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
 <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide,

On 20/10/2021 13:33, Davide Caratti wrote:
> hi,
> 
> On Wed, Oct 20, 2021 at 12:40 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
> [...]
> 
>>>
>>> I had a script that used TC flower and gact + pedit + csum actions to flip the 'PSH'
>>> bit in the TCP header, I promised myself to change it to corrupt the DSS option.
> 
> FTR, that script was:
> 
> # convert PSH,ACK into ACK
> # tc filter add dev vetha egress protocol ip prio 1000 flower ip_proto
> tcp tcp_flags 0x18/0xff action pedit ex munge tcp flags set 0x10 pipe
> csum tcp reclassify
> # convert ACK into PSH,ACK, 1 each 10 packets
> # tc filter add dev vetha egress protocol ip prio 1001 flower ip_proto
> tcp tcp_flags 0x10/0xff action pass random determ pipe 10 pedit ex
> munge tcp flags add 0x8 pipe csum tcp

Thank you for sharing that.

I managed to change the content of a TCP packet using:

  $ tc -n <ns> qdisc add dev <iface> root handle 1: htb

  $ tc -n <ns> filter add dev <iface> parent 1: protocol ip prio 1000
flower ip_proto tcp action pedit munge offset 148 u32 invert pipe csum tcp

It looks like nothing happen for packets smaller than 148 bytes.

Note that I had to add these to the config file:

CONFIG_NET_SCH_HTB=m

CONFIG_NET_ACT_CSUM=m

CONFIG_NET_ACT_GACT=m

CONFIG_GACT_PROB=y

CONFIG_NET_ACT_PEDIT=m

CONFIG_NET_CLS_FLOWER=m


@Geliang: do you think you could use this command?

>>> The problem with this approach is, we can't assume that the DSS option has a fixed
>>> offset from the IP header. So, the test might start corrupting other options that
>>> are not MPTCP.
>>
>> If we corrupt any data in TCP Options or data and update the TCP
>> Checksum, that's enough to corrupt the DSS. For example, we could flip
>> the last bit of the TCP payload (if tcp.len > 0). Would it be possible
>> to do this by adapting your script?
> 
> it's easier if it's the first bit, then...
> 
>> For mptcp.org, I told someone to use netfilterqueue + scapy. He had some
>> issues but also shared a working version:
>>
>> https://github.com/multipath-tcp/mptcp/issues/420#issuecomment-825771587
>>
>> I guess we cannot depend on Python and Scapy for selftests. I don't know
>> if we can also easily depend on eBPF either :)
> 
> 'bpf' kselftests (and also tc-testing)  already depend on eBPF, so for
> linux this is a no-problem.

Yes indeed but that increases the complexity to launch selftests. I mean
you need to add a bit of dependences (and "recent" ones) for 'bpf'
selftests.
It could be optional but it still needs to be supported by our CI.

>> And using simple solutions like "tc netem corrupt" will be detectable by
>> TCP csum.
> 
> this can be easily workarounded using the 'csum' TC action after the
> netem dequeue.

Good point! So we would need to create a tree with first "netem" then
"csum" action?

The only thing is that netem will introduce errors at random positions,
maybe in IP/TCP headers but it is maybe not an issue. If the TC filter
command is enough, it might help to produce more controlled tests.

> 
>> So maybe your way is better if we can corrupt anything, e.g. using a
>> fixed offset like 120 or the last bit (if it is not an ACK). WDYT?
> 
> I redirected this question to some friends working on eBPF, and they
> told me it's doable and cool at the same time :)
> There is an eBPF program that parses the "timestamp" option [1], we
> can change it easily to corrupt the DSS and recompute the TCP checksum
> like in Matteo's RHD article.
> 
> WDYT?

Indeed it looks like it is doable but if we could not add new
dependences, I think that would be easier for us :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

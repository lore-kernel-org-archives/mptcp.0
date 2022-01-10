Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6D2C80
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 17:50:41 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id k15so56581024edk.13
        for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 09:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1eUBlXVyb6oUEkF6Xq+JkppHezlutS7ALUSEDX6Dhx8=;
        b=sb7NDVMCUxSEVw6Y/w8u27VOLmOZoXNUtdtP4BDuZqnH8EHl5uqAz71bO8Kkiga6Fe
         y8oOGZWT1/xvN1WoBOw4U7E9VmEe4EnM+ZvduxMx5+8P0m4JDpj7YH8zd0CQqwew/LgR
         bMvzr0r8TM9yPio7fxmIaoTWVHRyW7TchALL7E3ESqpHMOr164V5NXmgeTlahYALgdgA
         A1gtiAvlFaYbOE6sOc9Ux3uIjXDNkO0t44uioARqzwPLTS2fPZW9sHKUqViz/2FEvOuz
         bqisQT9dThu0wUHNackEQcZWZXqHPGDlrEfADtL9gURFe3sa6swISuSw5cXtjpxtYacQ
         gjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1eUBlXVyb6oUEkF6Xq+JkppHezlutS7ALUSEDX6Dhx8=;
        b=vjOBPjwcchkHL5s7THjD8MwA0A5QWzYdkv0fQHcWiib1fv05E61lHQ+/7Gb1TKPQBy
         KTrW0qTWpK8Uk0XBGojh02TaSfwpL7ba6B8x+B+g+f396idCGUkmjqI4xcPAp+TrNi3A
         5ll/stJo2Rt8kJcYSAah5EAE4zc8t+4aQIdZylABE2Zv2BYrIQhQWIXtqu2jFwMAxCmf
         8wuH4N6jEUT1Z8lEQzsn90lDwvo8kG0ABAnb1nt+3LYSd5yY2Rm1XiOqoDTyFvIhM2mT
         XXhJQDXpES8gZZLLgf99UbylfVRmxJqhbOyiaq9Vt+gIYdpaaXhQ+aDCzIRitZqKY5FI
         ik2g==
X-Gm-Message-State: AOAM533+ZylDhP+/cofVrKDHU8lMwPBs0PPQ055CaWoBwNE/0QhpAxPc
	6412v4S1Im5CtHEtqQDDaXS59w==
X-Google-Smtp-Source: ABdhPJwvJ/5E0csW+F0bwINCETxbL4cTSmJCZIsy55xGlcO71sEXbx6WgNmR3spAdAz3V+G/CSfNPQ==
X-Received: by 2002:aa7:ccda:: with SMTP id y26mr758542edt.218.1641837040258;
        Mon, 10 Jan 2022 09:50:40 -0800 (PST)
Received: from [10.120.18.111] ([84.17.46.9])
        by smtp.gmail.com with ESMTPSA id 21sm2672025ejx.83.2022.01.10.09.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:50:40 -0800 (PST)
Message-ID: <20ec0b92-621c-ba09-50ad-62224ce991f4@tessares.net>
Date: Mon, 10 Jan 2022 18:50:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next v8 0/8] Clarify when options can be used
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
 <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com>
 <fc3b17c5-6d28-8a38-65c8-a85ab735b9e2@tessares.net>
 <7cd39667-8b85-75e9-4c92-faed93c928e@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7cd39667-8b85-75e9-4c92-faed93c928e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2022 02:19, Mat Martineau wrote:
> On Thu, 6 Jan 2022, Matthieu Baerts wrote:
> 
>> Hi Geliang,
>>
>> On 06/01/2022 03:58, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Thank you so much for this new version. Good catch on patch 2. It
>>> works on
>>> my test and all looks good to me...
>>>
>>> Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>
>>
>> Great, thank you for having checked that!
>>
>>> ... except patch 6.
>>>
>>> I thinks we'd better to drop patch 6 ("mptcp: allow sending both
>>> ADD_ADDR
>>> and RM_ADDR"). Since ADD_ADDR suboption is too big, we had made a lot of
>>> efforts to let ADD_ADDR not to be sent with other subopthins. I
>>> thinks it's
>>> better not to let ADD_ADDR sent with others by ourselves.
>>
>> ADD_ADDR suboption can be too big in some cases but not all the time.
>> If I remember well, we decided to have a dedicated ACK to simplify the
>> code: not having the ADD_ADDR removing the DSS options in some cases but
>> not all, also simplifying packetdrill tests.
>>
>> Here, the idea is to add the RM_ADDR if asked and if there is room, just
>> like what we do in mptcp_write_options().
>>
>>> On the other hand, I'm not sure our code can deal with ADD_ADDR and
>>> RM_ADDR
>>> together correctly, it's not tested.
>>
>> Good point, we need a test validating that.
>>
> 
> Sounds like a job for packetdrill!

Yes but still, we need a netlink command to ask the kernel sending an
ADD_ADDR/RM_ADDR/MP_PRIO, one at a time.
I don't think we can have a proper test always making the kernel sending
a packet with two notifications, no?

>> I'm not even sure we can have a test because each netlink command will
>> cause the corresponding option to be sent: depending on the timing, when
>> the next packet is sent, we might have one or two options to be sent.
>>
>> If we drop patch 6, we need to replace it with a patch updating the new
>> comment at the beginning of mptcp_write_options() and not allowing
>> ADD_ADDR to be sent with RM_ADDR + MP_PRIO as we currently do.
>>
> 
> I think it would be good to drop patch 6 and updating the comment as
> Matthieu says.

I think we should also modify the code in "mptcp_write_options()" and in
"mptcp_established_options()" to reflect that.

Maybe it would simplify things to say: we can send an RM_ADDR and
MP_PRIO only with a DSS, one at a time. That we can validate (we already
do) and I don't think we will need to send in the same TCP packet an
ADD_ADDR + RM_ADDR + MP_PRIO.

That would replace a lot of "C" (can) by "P" (prefer not) in the
previous comment and reduce cases to manage.

WDYT?

> 
> I'm still seeing the file content mismatch with the "MP_FAIL, multiple
> subflows" test, which doesn't seem right. Will try to look into what's
> going on there next week.

Same here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

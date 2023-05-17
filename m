Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722864C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:41:53 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-307d20548adso274873f8f.0
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684312912; x=1686904912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/dLZEjNnFSckOwInJ/EgLYYrSrsCG8FW1iQOcUfGs8=;
        b=HjsPesSgDQG7X9CKYxKn8MyYoD0XS+phsOYDLUd55DSA+hGlXH2WTyuAUoKc7McIbK
         D/kFyF+v0jFR+yHZtLTnw4MBMEOqOncu+aoFUBHN176NRWXg5OcHydL/Jpptf6xpgW5h
         8SzgtPfVA82JBpveXYTkC+ZR6FL/2Iw8oDipAdz/1aZxVyd79wVuuXKgE91w4pFy5iOO
         C9F+yFNRyyqQe9pvRUFSLTCxIiMqBzrKgfFJ8Uepvywe0VdfwAXGMNEJwO1M6R5nAeCE
         WMtbv0DnZF7fUoPEcinWgmBtmretHpTjaXJNragRKj8auEz9M5TTwLcb0VvmUs+AACq/
         ElIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312912; x=1686904912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/dLZEjNnFSckOwInJ/EgLYYrSrsCG8FW1iQOcUfGs8=;
        b=e2UETiz8/sUGiqcYD0+wwR8wk5+WftJHefEwkEMfOOXz2gyvGSWEia5w6WkPVdyNMO
         SYg5uhlxi/iQ4z8SSSnaKz7yzhF0hAkcoAWT5vSTj2Rbw2jN85AzVaf/nY6aIaGjPPYo
         5fxtG70CgaQU3Md4tcN1aFidbSEJsD4yhiuSqVNj74M8ObhJTilJmEVpUtlP1owIJJ6X
         U9nvvM8VmR/Rx913juvOXPysdIYPymrU+GUUrBhvDjf44XIyKnrByUUD2JKo+MEpGQws
         HJjAR1gSLcnPDfquR0NSfRObu+sK10yuOcUUSt0mz9vxVtzteocVinrlSjJ3sGHZaNq+
         J+AQ==
X-Gm-Message-State: AC+VfDwZOZ5a8tj3wdDpngUqXx3sGBCe2MCS8uVzhL/7vCAbNWhujMIX
	gLP6rvsPVgwUkYvg2uuLb4jNvg==
X-Google-Smtp-Source: ACHHUZ7SXzpvf4lo+yPgSTu5hCUb+C7/i0qR/znqz2jpZo1l4/B3SdUd946Jr2kyVdmDm8Dmov4FlQ==
X-Received: by 2002:adf:e987:0:b0:306:64b7:5413 with SMTP id h7-20020adfe987000000b0030664b75413mr28670859wrm.71.1684312912004;
        Wed, 17 May 2023 01:41:52 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id r14-20020adfe68e000000b00306344eaebfsm2034669wrm.28.2023.05.17.01.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:41:51 -0700 (PDT)
Message-ID: <74e8f7c4-15bd-7404-287d-f9cd6dccbba6@tessares.net>
Date: Wed, 17 May 2023 10:41:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next 1/4] Squash to "selftests/bpf: Add bpf_first
 test"
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684297911.git.geliang.tang@suse.com>
 <5ddd82f8a26cd37805ad9fdc23d16d936ab71813.1684297911.git.geliang.tang@suse.com>
 <4aa90a22-c099-b405-7ec7-da492b282fc8@tessares.net>
 <CA+WQbwugQkGJS5fQ-bgb833M3Gt21fDzmJbi-Tu=Zx5VPeuRRw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwugQkGJS5fQ-bgb833M3Gt21fDzmJbi-Tu=Zx5VPeuRRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 17/05/2023 10:25, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年5月17日周三 15:59写道：
>> On 17/05/2023 06:32, Geliang Tang wrote:

(...)

>>> -static void sched_cleanup(void)
>>> +static void sched_cleanup(struct nstoken *nstoken)
>>>  {
>>> -     system("sysctl -qw net.mptcp.scheduler=default");
>>> -     system("ip mptcp endpoint flush");
>>> -     system("ip link del veth1");
>>> +     char cmd[64];
>>> +
>>> +     snprintf(cmd, sizeof(cmd), "ip netns exec %s sysctl -qw net.mptcp.scheduler=default",
>>> +              NS_TEST);
>>> +     system(cmd);
>>> +     snprintf(cmd, sizeof(cmd), "ip -net %s mptcp endpoint flush", NS_TEST);
>>> +     system(cmd);
>>> +     snprintf(cmd, sizeof(cmd), "ip -net %s link del veth1", NS_TEST);
>>> +     system(cmd);
>>> +
>>> +     if (nstoken)
>>> +             close_netns(nstoken);
>>> +     SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
>>
>> Is it not enough to just destroy the netns? So just the two last steps.
> 
> Sorry, I didn't get this. Could you please explain more about it. Thanks.

If you delete the netns, I guess that will remove everything associated
to it, no? So no need to change the sysctl, flush the endpoint and
remove the veth, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

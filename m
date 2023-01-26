Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3846BF
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 18:01:14 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id y1so2618949wru.2
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0Ipijf8AmrhL9KNONaCw2+cvlidclyfcQ9aC+01hIo=;
        b=wwHrYhFUpE942+zRsTHNdwRy+/99yZyXBzmLdo8itsEsEO0jXq0zLlW064BT//stY5
         dbrxT23P/FU+HRC547aokmEIueIY5G5UttmsaJP8Q4RIKS6lkjzskvkgmYn5rDi4J5Nn
         +GpbV48YhTpIX1jTyicWCMLP3kGeJxPhTmEE5G6mDA1JzXUfqyM89VEDmoexK4PTLLT0
         YXyNLr9o9lvYCQhVvObyfqkzfPc/LUR1wwAEzV3KcFNGnnnlr6rLAr28xTbvNIy/cJOW
         1TQKPtOU1qFtKDN93oARuRnWXDeo7nUhMjwy1YuHs59Ska5470hg1nOOY2BjAKWYkJ3Q
         hJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0Ipijf8AmrhL9KNONaCw2+cvlidclyfcQ9aC+01hIo=;
        b=oTsZHz/0CLOojNtRjWyFEbeo0lGPlCt555/4sZIFJVL9ZdcSnkA6WMHMREkX17jtwE
         zvm8FnCrHxgm+yuY3lGwEWIwFmXoVTMy25n1ejZxnlRYGP5xCoWZbb+4TY9QS0Y/mICx
         Y10Mm/Wkc/htZ1XfLAJHgYLD4ej7ZqTWc084RB4EkP2BydmuPmXlHUgGeHlLgR8+AwfR
         gGZXM49o1g7N4/IihoZRnPSFnf42WTrrB+tYwyoNBs5Ka00EI4m6lhed7hnfnxNEORZy
         jiiUMWDoABEmMwqd1PxmMGvPdEAWLk/evrbLStrP5GE82MB0UVn2X1LgMDT7FMoi5peU
         AQtg==
X-Gm-Message-State: AO0yUKWV4cGW/r7xn2VoIp8hQuMkykxIYBhopDRUCn79O+SW31WUV9pz
	EQOUadOUZPpn63MqHASvsLS7WOxz+pHY92/kQDk=
X-Google-Smtp-Source: AK7set+lTV/0qIRW/54MlJ30snDOB/bjuqQYmXCWyk6uIaT//NDcOK28w+BUOHifwTKMGJAog7WLVQ==
X-Received: by 2002:adf:e747:0:b0:2bf:cfc0:7416 with SMTP id c7-20020adfe747000000b002bfcfc07416mr467866wrn.29.1674756071204;
        Thu, 26 Jan 2023 10:01:11 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9734:4fc3:798b:7157? ([2a02:578:8593:1200:9734:4fc3:798b:7157])
        by smtp.gmail.com with ESMTPSA id a13-20020adfeecd000000b002bbedd60a9asm1807863wrp.77.2023.01.26.10.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:01:10 -0800 (PST)
Message-ID: <88b80d6e-06b3-7768-31fd-29eab8366895@tessares.net>
Date: Thu, 26 Jan 2023 19:01:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-next] mptcp: do not wait for bare sockets' timeout
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
 <c4d0ff16-125f-4bd3-69aa-5034a36a977d@tessares.net>
 <17e6a8783f4149cf2dd20b876ffaa27a7f35ac0b.camel@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <17e6a8783f4149cf2dd20b876ffaa27a7f35ac0b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/01/2023 18:36, Paolo Abeni wrote:
> On Thu, 2023-01-26 at 18:22 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 26/01/2023 16:44, Paolo Abeni wrote:
>>> If the peer closes all the existing subflows for a given
>>> mptcp socket and later the application closes it, the current
>>> implementation let it survive until the timewait timeout expires.
>>
>> Thank you for having looked at that and provided a solution!
>>
>>> While the above is allowed by the protocol specification it
>>> consumes resources for almost no reason and additionally
>>> causes sporadic self-tests failures.
>>
>> I guess if we are in __mptcp_close(), there is no reason to keep the
>> MPTCP socket alive if there is no more subflows: if there are new
>> subflows requests coming, they will not be accepted, right?
> 
> Correct, as both passive and active subflow creation checks
> mptcp_is_fully_established(sk), which in turn always returns false
> after close() -> msk is not in ESTABLISHED status.

Thank you for the confirmation!

Then it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

>> When the last subflow is closed without MPTCP DATA FIN, it might be good
>> to keep the MPTCP socket alive for a bit longer before closing the
>> socket to let the client joining from another network
>> (make-before-break?).
> 
> yes, and we do that. Even with no subflow alive, the msk is closed only
> _after_ the close(). Otherwise it stay happily around and the msk
> socket status is not affected at all.

I missed that part, thank you!
(and now I remembered we already discussed about that, sorry)

>> (this should be controllable from the userspace
>> but that's another topic)
>>
>>> Let's move the mptcp socket to the TCP_CLOSE state when there are
>>> no alive subflows at close time, so that the allocated resources
>>> will be freed immediately.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> --
>>> this could land either on -net or net-next, as it introduces
>>> a change of behavior that "fixes" self-tests.
>>>
>>> The fix tag would be:
>>>
>>> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
>>
>> If I understand properly, this doesn't break any 'make-before-break'
>> feature but it clean resources quicker while there was no reason to
>> wait, right? In this case it makes sense to target the -net tree.
> 
> I'm ok with the above.

Good, just applied in our tree (fixes for -net) with my RvB and the
Fixes tags:

New patches for t/upstream-net:
- fca3ab68ee5a: mptcp: do not wait for bare sockets' timeout
- Results: 03f3f3e2e0ae..c32eb8d771ff (export-net)
- Results: e34b063a59ec..302a589ae88a (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230126T175912
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230126T175912

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

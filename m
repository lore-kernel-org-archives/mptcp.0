Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44A7B
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 14:57:59 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso103962wma.1
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yvYrIblpgQxg/mQ6NjWqX7TpJJvtgrmaQJDLJIiuakY=;
        b=lfazaA+EEJKGThKY8d3mlIo1nScmfIdjyZHc2EkU5UfSzXTgDmwQgqfP38usKCH1fu
         B5mw6H1I//r8oMXlVoiCld7J1e7c0a4O0gO9nn97PgQIoveTwWWy1fZL0o7PaSoFbdpA
         0qaU4dyp/XXBgEVA8lp2EC6oZSlW7OPHobQhBj+oKoi03M913r+F3guWJKvowQjUNRB+
         TOI1l+Zb78yOboqTGLX1WAMggV7wHHWZV7cITtFKIrZkt7i38yqjOJGo7lqSKC806QfI
         sn5dZ8QVhHzGWHsDYeGcGBiV0MO7rbiOG+gkqQOMpKA+QGxKEzpFmP8bDb+ExxUmkT0E
         PLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yvYrIblpgQxg/mQ6NjWqX7TpJJvtgrmaQJDLJIiuakY=;
        b=XYDdn9oBKhT6plw1456moiR9s5rFaSSvHIfYAg474pckNcNbjZnmjVY+TnbeFdxDU3
         5M9H/nQd4aqOzOWTTgdiyAUPAimSSAucuYuabjTeKwm2TGrfZp96T/kXK0KwcCvttJY7
         jGwzLSTKsJL+eccIDq5K5Oc04JC32ChA2sjv2hFuRHmIRCCLCaCVlIGauZbjvvwNY1/d
         607uQIcmKuvzQ9povWHX+28Ry7ui1Gb87sR9+qKxljgL3KCBeBj/vWOjQdgx4iHhMrP2
         blQop0zgVAveoHhq5gtoxwZHK7AkbsCJCQq45pToS5YYxMXCIgmdMykClsbVHZKPsZFy
         RPRw==
X-Gm-Message-State: AOAM53079EmWB71HaF5oGbA5y9i+uPq3HJW88p/91pLH28IoSujoLQgL
	4fxbRVoPkCldtZEYhkr0pBFX2tw1g5uv3w==
X-Google-Smtp-Source: ABdhPJxrL0VCHA1gSc/fFSs089zM8NsDVo56qeYCaSpfRGE2TxVKUNuZVOgZtTES7BioZ3i2l0PdtQ==
X-Received: by 2002:a05:600c:3505:b0:38c:a3a8:8479 with SMTP id h5-20020a05600c350500b0038ca3a88479mr5076260wmq.4.1648652277429;
        Wed, 30 Mar 2022 07:57:57 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0038e389ab62esm2334386wms.9.2022.03.30.07.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 07:57:56 -0700 (PDT)
Message-ID: <74bc5fda-ab48-6bfa-dbae-a5783f9a327d@tessares.net>
Date: Wed, 30 Mar 2022 16:57:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v8 0/8] BPF packet scheduler
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1648537203.git.geliang.tang@suse.com>
 <bf2b415d-a5f8-907c-9a55-d8b6d2c317b6@linux.intel.com>
 <20220330141211.GA345@localhost>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220330141211.GA345@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/03/2022 16:12, Geliang Tang wrote:
> Hi Mat & Matt,
> 
> On Tue, Mar 29, 2022 at 04:13:02PM -0700, Mat Martineau wrote:
>>
>> On Tue, 29 Mar 2022, Geliang Tang wrote:
>>
>>> v8:
>>> - use global sched_list instead of pernet sched_list.
>>
>> Yes, I think this is fine. I had initially asked about pernet configuration
>> with respect to registering BPF schedulers, but the important thing is that
>> the sysctl can be set per-namespace.
>>
>>> - drop synchronize_rcu() in mptcp_unregister_scheduler().
>>> - update mptcp_init_sched and mptcp_release_sched as Mat and Florian
>>>   suggested.
>>> - fix the build break in patch 8.
>>> - depends on: "add skc_to_mptcp_sock" v14.
>>> - export/20220325T055307
>>
>> Thanks for updating. Builds and runs fine here.
>>
>> Before we add this to the export branch, have you thought about how subflow
>> data (including the backup bit and throughput/latency data used by the
>> default scheduler) can be accessed in the BPF get_subflow hook? Do you think
>> that can be cleanly added after this series, or is there anything that may
>> need to be changed in this series?
> 
> I plan to do that in the next series, BPF round-robin scheduler.
> 
> I had implemented round-robin in kernel before:
> 
> https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.geliangtang@xiaomi.com/
> 
> This time I plan to implement it using BPF.

Sounds like a good idea to exercise his new BPF packet scheduler
infrastructure, thanks!

> In order to support bpf_rr, I think we need to do two more things
> based on this series:
> 
> 1. Get the subflow data from BPF, maybe iterate over the subflows
> from mptcp_sock.

Yes, sounds good to me. What is blocking to do that?
Maybe some new BPF helpers will be needed?

> 2. Make same members of struct mptcp_sock writable in BPF, say
> last_snd, then we can set it like this:
> 
>         msk->last_snd = ssk.

I don't think this is a direction to take with BPF. I mean: not
directly. You can have helper doing that with extra verifications. How
is it done with TCP CA?

Or maybe for this specific case here with RR, you can also store the
last snd subflow in a MAP storage, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

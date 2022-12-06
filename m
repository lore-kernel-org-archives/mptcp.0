Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB927713
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 17:37:55 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id l11so21356106edb.4
        for <mptcp@lists.linux.dev>; Tue, 06 Dec 2022 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ft3RMBe0nnpLjnPp0rPVFcDo5o1kaJCQkIAYSP+I7I8=;
        b=oJAgPfWYuLoIboINBXG6f2xBTS56NBaRsiWx4ZDRmFJXwHPR+sDcXjKWTH7XkfIsBh
         Va7bgpQ8cy+LxukNx6wcwjS+z6kyfMM+D5ObOUyGvW9QplbC8Sc2BhuzQmKjLEhtieyN
         T0QUgFc/B3PoYgrOTxDsKykw9bLzib1CC7sKfi8TYhnMY2x/NkdsR7eJMkCjsg4vbrH6
         8Eepw5+epKynrGvA0Xb++wIbdc0jWCblSDFwfhtsneMpKLLqmcYVPXhlF2aUhDNJKr80
         gSQYIdT4PmuufaNOsp2FXS6Ne74opBDVCgceBqFH+BDWGu0ZFkiWGcyZiFvVhZxbw17Z
         aiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ft3RMBe0nnpLjnPp0rPVFcDo5o1kaJCQkIAYSP+I7I8=;
        b=aEvJpnaDZEIeVdYKMwWMASvPNMex2J8SDkm+pQ3yGlO2Ab8iVeuGpCihj3gcRC2hb5
         tOxPbNOxksxCBh/r9PbadeGyeDJAC53lVgr3bi4AJGkdOL6A6Uw+dpK6Ww09Vw9/bVza
         iLh7EW+7By/x7KaYPX3WaFeHff7vgCFZcYtNHy97IYeVpB7zKsyRaDS0OKq0Jko76LeU
         gN3Kimdytq0Ua4NmA8HqffIXYm4chDUNpOrBHqqV26rT7vLak3hKJ6HlW6VhqVMRP2h/
         PVOdTYRKntkRt3Co9ADFt1vqulHx/qIn8Z8qDaaFL4VsiVvyuXrekhwxEZ94se+gjfoK
         YIZg==
X-Gm-Message-State: ANoB5pki2v92odloPEJS8gh4s+wmwgCu0ONmq5bWQmDHzUn2L0IggnE9
	bHWK+svaalLQLCHGZ+5L2lVbGgHyh9UmJxIu
X-Google-Smtp-Source: AA0mqf5hvVnekP5hbP/qEH1Ayosm6hq/6Z+PCKqermeYrHH7DDY3LfEN/BycIz67n0npD/9XQIof6Q==
X-Received: by 2002:a05:6402:378c:b0:461:cdda:4004 with SMTP id et12-20020a056402378c00b00461cdda4004mr287379edb.10.1670348273804;
        Tue, 06 Dec 2022 09:37:53 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640210c400b0046c4553010fsm1240214edu.1.2022.12.06.09.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:37:53 -0800 (PST)
Message-ID: <ea3298a6-b133-cefe-7a51-a56469dd2c3d@tessares.net>
Date: Tue, 6 Dec 2022 18:37:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mptcp-net v2 1/3] mptcp: remove MPTCP 'ifdef' in TCP SYN
 cookies
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20221130094448.4119946-1-matthieu.baerts@tessares.net>
 <20221130094448.4119946-2-matthieu.baerts@tessares.net>
 <48d0aa62-276c-c23b-d49a-1d7e3a62fed5@linux.intel.com>
 <54b8bf5a-a456-c2fb-6dec-95121fe4fab5@tessares.net>
 <21087bb1-41e3-110d-e7c7-a211320d3f80@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <21087bb1-41e3-110d-e7c7-a211320d3f80@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 06/12/2022 18:20, Mat Martineau wrote:
> On Tue, 6 Dec 2022, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> On 05/12/2022 22:52, Mat Martineau wrote:
>>> On Wed, 30 Nov 2022, Matthieu Baerts wrote:
>>>
>>>> To ease the maintenance, it is often recommended to avoid having #ifdef
>>>> preprocessor conditions.
>>>>
>>>> Here the section related to CONFIG_MPTCP was quite short but the next
>>>> commit needs to add more code around. It is then cleaner to move
>>>> specific MPTCP code to functions located in net/mptcp directory.
>>>>
>>>> Now that mptcp_subflow_request_sock_ops structure can be static, it can
>>>> also be marked as "read only after init".
>>>>
>>>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>
>>> Hi Matthieu -
>>>
>>> I noticed today that there's no Fixes: tag for this commit, which the
>>> netdev CI will check for. Like you say in the commit message, this patch
>>> is a small bit of refactoring to prepare for the following patch(es) -
>>> should it share Fixes: tags with those or just let the git dependencies
>>> speak for themselves?
>>
>> I don't think we need to add a Fixes tag because as you said, it is
>> mentioned this modification is needed for the next patch. I'm sure
>> netdev maintainers will understand why it doesn't have a "Fixes" tag.
>> But I guess we can also add it (even if it is not really a fix).
>>
>> We should probably Cc 'stable' ML on the 3 patches but we never really
>> did before.
>>
>> Up to you, if you prefer, I can add it :)
>>
> 
> I think it's ok to try without it, not every patch merged to -net has one.

Sounds good to me. We will see if they ask to always have it. We can
also explicitly ask the question when sending the patches, just to be sure.

> Regarding cc: to stable, I've been trying to do that for patches we do
> want backported. We don't want that tag included when sending to
> mptcp-net on our ML as git-send-email would spam the stable list, so
> I've been adding them to the .patch files before upstreaming to netdev.
> Adding the Cc: stable tag in the export branch would probably be ok as
> long as we're careful in other cases where the patches are emailed (when
> not upstreaming).

It makes sense to add then when upstreaming them. I just added an item
in the list there:

https://github.com/multipath-tcp/mptcp_net-next/blob/scripts/utils/README.md

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

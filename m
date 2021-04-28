Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33572
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 10:52:44 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id ja3so18060358ejc.9
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tYRRuWHf9SpRUCVaVvhzH2olaUisZvuNNRBxWhKcvoA=;
        b=JlNbQMzrT32Y3EjdoQDLLo5Gt5E1mAzXMfReAtmpLExIaJfdM9Y0yqVa3PtB4dGUqF
         ZK8IudU2lkhpmqgkXINfNwCpzQLRmmOV5pzyrQtCdeyylpuwfHP/mGTKcfTsfLdjwpz7
         xDpFxWriOHi0+5nApxHCsTcCLS/BBfwjiHjDjTRefCgjbHzJOXnckkIgxHDVJTXXeZy9
         hJ7FAYmigotfWWWn1EEl4XpcYS6uOvM+4buxnPVKOjAV8YXaGGiI/3RKimLyt2boblF6
         NnMataSM+IlViEhn2RSm8mDU8avGDfa315DPN5SplciNfL3FA+IcoGk0chg9V8k8hSTH
         cR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tYRRuWHf9SpRUCVaVvhzH2olaUisZvuNNRBxWhKcvoA=;
        b=HTSdkbxX1oIah2ju1yYubjlFlARU7OMXYAqc9BFdM5mjF48JL3Rw153KkaZ57Ya6wz
         21YlrX0I3YOGDBkr/+umrAkOEOO7GgehML2WfboVg+bowhsx4nzV3HnKiTBw5CaDEFuk
         VpGA98AD1DGJO18EHSGtJlxmanSgQbZP2mY2h21JCqZEycLAtqjIy4T3W1a6uxFXJRrz
         NVt0tljeWxS7Np2TfHg8IDiG8arAYHPkadIlAAyT7+OeUK20XAw/JDzA7vsj1PgJxv1e
         g+OS/r8YsMQ17masJv302J5N4VaFqncTPvpZ0cm4ikVqTFbOFvrXDA3lDpCFfzNcEUW7
         zvWg==
X-Gm-Message-State: AOAM530T/Oy9WE/r1XB5PtIqZceaF0xAGOLutxFQYVCuq+9SVK/gqebl
	BVeMWb1cPrgD68KwZCN4mv8NlQ==
X-Google-Smtp-Source: ABdhPJxjcbb9KOcvDI6m2KCm/zFMOQEw4kee+1vkFlWpxtoNV7xbCbvFcF4iWLtsS3/DNV4+4ER6Pg==
X-Received: by 2002:a17:907:75f6:: with SMTP id jz22mr18573850ejc.504.1619607162608;
        Wed, 28 Apr 2021 03:52:42 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9a01:f17b:24ce:3558])
        by smtp.gmail.com with ESMTPSA id re26sm1726988ejb.3.2021.04.28.03.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 03:52:42 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 mptcp-next 1/4] mptcp: add sysctl
 allow_join_initial_addr_port
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>
References: <cover.1619592361.git.geliangtang@gmail.com>
 <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
 <20210428094043.GC975@breakpoint.cc>
 <be8baf91-5399-43d2-e595-f8565b353815@tessares.net>
Message-ID: <e05e68e1-4971-7daa-24bf-1d79b9ba89c1@tessares.net>
Date: Wed, 28 Apr 2021 12:52:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <be8baf91-5399-43d2-e595-f8565b353815@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 28/04/2021 12:36, Matthieu Baerts wrote:
> Hi Florian,
> 
> Thank you for this review!
> 
> On 28/04/2021 11:40, Florian Westphal wrote:
>> Geliang Tang <geliangtang@gmail.com> wrote:
>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>> index 96ba616f59bf..3b963a25d5a8 100644
>>> --- a/net/mptcp/ctrl.c
>>> +++ b/net/mptcp/ctrl.c
>>> @@ -19,6 +19,7 @@ struct mptcp_pernet {
>>>  
>>>  	int mptcp_enabled;
>>>  	unsigned int add_addr_timeout;
>>> +	int allow_join_initial_addr_port;
>>
>> u8 allow_join_initial_addr_port;
> 
> Should we do the same modifications for 'mptcp_enabled'? Switch to a u8
> with min 0 and max 1?

Even if we typically use it with 0 and 1, modifying 'mptcp_enabled'
might be seen as breaking the exposed userspace API, no? Maybe too late
to change?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

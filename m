Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ACE2F25
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 17:25:14 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id j2so55669957ejk.6
        for <mptcp@lists.linux.dev>; Tue, 01 Feb 2022 09:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=npzg8yaqlh7ZOGffsi65hv/ShAqwnULiY9Pv2ThJOwI=;
        b=nEqXnVHpalHyUzKVWgS2sie6LCX5k8jO1Wlxsct7MCIfb9z+rVOoIq/QXw+yueFs6H
         JOEVq5tqyjGLGa3QxqFbbWK8/kOyXJoJAg131lcG9PW3O+pBbV1wnEmNr5eP3NMhbCMR
         0NFDa7tKK68vunGoT4bxRLZ/FzUBEmWy+DDQkwxRSthTBW38CTgWvvAwxTTdgv8SxHY4
         RRBDBmzChFUwUzRgm0KgZY52E8MTOKvFf9BYJXHo0i2hIjVJWDY5CpsHnh/GamMS3PN7
         zHROVEyuCRGG+fyHqCreM8F/KWAU8hPakWBO79n8I2Ag9GeJjrq18gG2peP5DdOQUDJu
         zeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=npzg8yaqlh7ZOGffsi65hv/ShAqwnULiY9Pv2ThJOwI=;
        b=N0CLw8Gx21Q6jDglGfaaAJZ9kfud6TKqyv7NwnjRenD7ZeofQ0wiRedxi3oTKGa7u4
         b8je0L5QqImroEWLaz+BOovNDzgLbvvTCUfq17fazTYP+YQc5eGswkGwU0BTw8Mfpd/V
         UeRO6pRXhGVvSYKJmRNIoaEbbfhfhbcL4ckVYvjHznzwYQHvx67UQdJ6YUWtyYaldkTM
         a8JdfmfWLCdQ1UKd+EFcdaqe78tsUtZw9mpad+0JOjC4sdmlhoQumazfXmA8z5TY4ewi
         Kakevamyqe3P3mRlhDiYEYii2EP33VLZkNMLDNW2RZD+UWFknb3IoOM3DYoHBtpeILND
         bmdQ==
X-Gm-Message-State: AOAM5321QfWcwPZcn9oVPQTgqHnkWJPDznNoldDwkMRgqS1Wuvq/ufSt
	4q8DBXoSob4Lkkdm4IynDffkVWoYfAUgjw==
X-Google-Smtp-Source: ABdhPJyG3h0hqPCjH0VUYCQLdovNFWVKq9GzbMaFCpeYyu5X7Ng56ZJ8YY1bjDBSCsjYKj5pvFU1rw==
X-Received: by 2002:a17:906:58d0:: with SMTP id e16mr21713267ejs.454.1643736312726;
        Tue, 01 Feb 2022 09:25:12 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:418:c659:e03a:16b9? ([2a02:578:8593:1200:418:c659:e03a:16b9])
        by smtp.gmail.com with ESMTPSA id p2sm19575962edy.73.2022.02.01.09.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:25:12 -0800 (PST)
Message-ID: <1b10e9d2-cc63-efe9-2488-29a66ebaaaad@tessares.net>
Date: Tue, 1 Feb 2022 18:25:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v3 7/8] mptcp: attempt to add listening sockets
 for announced addrs
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
 <20220128003812.2732609-8-kishen.maloor@intel.com>
 <2a4c2a567359b839aacd3d56d8a7734af5479747.camel@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2a4c2a567359b839aacd3d56d8a7734af5479747.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo, Kishen,

On 01/02/2022 12:42, Paolo Abeni wrote:
> On Thu, 2022-01-27 at 19:38 -0500, Kishen Maloor wrote:
>> When ADD_ADDR announcements use the port associated with an
>> active subflow, this change ensures that a listening socket is bound
>> to the announced addr+port in the kernel for subsequently receiving
>> MP_JOINs. But if a listening socket for this address is already held
>> by the application then no action is taken.
>>
>> A listening socket is created (when there isn't a listener)
>> just prior to the addr advertisement. If it is desired to not create
>> a listening socket in the kernel for an address, then this can be
>> requested by including the MPTCP_PM_ADDR_FLAG_NO_LISTEN flag
>> with the address.
>>
>> When a listening socket is created, it is stored in
>> struct mptcp_pm_add_entry and released accordingly.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>> v2: fixed formatting
>> v3: added new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN to skip creating a
>> listening socket in the kernel during an ADD_ADDR request, use this flag
>> along the in-kernel PM flow for ADD_ADDR requests (Note: listening sockets
>> are always created for port-based endpoints as before), use the
>> lsk_list_find_or_create() helper
> 
> I think it's better introducing the opposite flag (e.g.
> 'MPTCP_PM_ADDR_FLAG_LISTEN') otherwise this will change the default
> behavior

Maybe it is fine to change the behaviour. Without changing the user
exposed API of course.

I mean: it all depends if we consider the fact that when the userspace
closes the listening socket to accept new "MPTCP" connections, it is not
normal (bug) to close the possibility to create new subflows → socket
controlled by the user vs socket controlled by the PM. If we do consider
this as a "bug", then that's OK to change the default behaviour, no?

I don't know if other people are sharing my view here.

For me, if an app closes the listening socket after having accepted a
new connection, it is just not to receive new "main" connections on this
socket but it is OK to accept new subflows as they are part of existing
connections (and managed by the PM).
We would then avoid people hitting issues like #203. If you hit this
issue, it is not easy to find the answer I think.

If people know they don't need/want the creation of a listening socket
only to accept new subflows, they can set the NO_LISTEN flag when adding
an address with "ip mptcp". But if the cost is minimal most of the time
because no additional listening sockets will be actually created, that's
fine to use a "NO_LISTEN" flag I think.

WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

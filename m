Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184183C0B
	for <mptcp@lists.linux.dev>; Mon,  9 Jan 2023 17:04:10 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id hw16so9893518ejc.10
        for <mptcp@lists.linux.dev>; Mon, 09 Jan 2023 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3Ud5721rtpLSCr2vWbjki7VKP1XI4oNLyasURYSICQ=;
        b=8y0GxXFIZU+4+uz8BiERtOxNbUrv2SzmiB7qtPj9k3yCQADrMmg4SQuxgLl1SeaJMx
         JfwFVNoladzzljFKjprUyimr7AnJ7tdKnDAi6bs60em66m6Kq876i8u42O1a0O+Kty1F
         +c2DXPX65ck+A2ye83PTIZg13f9PwT/qektooCcQbsmEjEK8PSA9fsgk7d7SAoY3n/99
         SRThqQdh5fQOnqs+NbQ/5mpaOoLzFbGyuXyqTnuROjUCkyOD2RhXyCM2V9Hl/gdX74Cg
         OOXxbb/EkpXymRDLqi6AokfbcNpA1XUD6L+j23a+/g8dhpyq9YXmHrdDl+BUW3ZX3H4q
         nYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3Ud5721rtpLSCr2vWbjki7VKP1XI4oNLyasURYSICQ=;
        b=DbQWTh+PDqlJdDJa+qYciyi9M2ShAUpNexW/xpKkpHWW2CQtx88PF6+Wgu3W3CRxNS
         9ikrgcdfzWM+9/Vwf0o93TH0SRm+yT5rYjo34MgWJ7wJRA2OysXFqB2JSTFWZ5sJUz+h
         9sFvT7ayahDSviR948Kuu4YbK9UI40kHjqMF7TruwJmA4cbnVH8erR57a0UJCzrLGyGw
         Xx9pIEOm+4tV+e0Rgch5kvNCiXWyD7WqnBJyc3fiUFCJMBznKhCdsSCAecDITrN8mnBy
         WJZJL3if0+ASwiAWbFvkb5rH0lqv+wsQ9RRbkc7bgwlmnxZGDMaXB7oQeW132FLUiDmR
         JlBg==
X-Gm-Message-State: AFqh2kqLWbbps1lQrGiTwlPt24iapRxd0a+ihQTnggZa3UiuggJLSZnu
	mfbQhBgqlRo/TyviLpD6sp7y9n93iNpT7Ujw
X-Google-Smtp-Source: AMrXdXsmiW/Z5NFazDPgz9ArYg2QMhCdylKlwMUVZ+wBBMqLNx4Jku7y3Xs+VOoDsxTpmFA2CDldRA==
X-Received: by 2002:a17:906:7747:b0:840:604:1da1 with SMTP id o7-20020a170906774700b0084006041da1mr53189501ejn.61.1673283848962;
        Mon, 09 Jan 2023 09:04:08 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id fd7-20020a056402388700b00483dd234ac6sm3833925edb.96.2023.01.09.09.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 09:04:08 -0800 (PST)
Message-ID: <2fc7004e-de92-4e4d-dbd0-4325cdb17189@tessares.net>
Date: Mon, 9 Jan 2023 18:04:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-net/next v5 00/12] mptcp: add support for mixed
 v4/v6
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
 <1d6a5e49-dd47-0c1a-c566-825e3da7e75b@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1d6a5e49-dd47-0c1a-c566-825e3da7e75b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 06/01/2023 02:15, Mat Martineau wrote:
> On Wed, 4 Jan 2023, Matthieu Baerts wrote:
> 
>> This is a v5 of Paolo's series with the same name but with some
>> modifications and additional patches.
>>
>> ChangeLog:
>>  - v3 -> v4:
>>    - Fix a compilation error without CONFIG_MPTCP_IPV6 in patch 4/12.
>>    - Add a title for the cleanup part in patch 9/12
>>    - Add the patch 12/12 to avoid "read" errors
>>  - v4 -> v5:
>>    - Fix typo in patch 2/12 (Mat)
>>    - More details in the commit message of patch 2/12 (Mat)
>>    - Rebased on top of the latest export branch
>>
>> This series can be split in 2 parts: the 3 first patches are for -net
>> while the rest is for net-next. Patches for net-next depends on patches
>> for -net, that's why everything is being sent together.
>>
>> Patch 1 lets the userspace PM selects the proper family to avoid
>> creating subflows with wrong source and/or destination addresses because
>> the family is not the expected one.
>>
>> Patch 2 makes sure the userspace PM doesn't allow the userspace to
>> create subflows for a family that is not allowed.
>>
>> The core MPTCP implementation is just a few bits of properly supporting
>> a mix of v4 and v6 subflows, we just need to allow specifying the
>> subflow family explicitly (patch 1) and remove artificial constraints in
>> the in-kernel PM currently enforcing no mixed subflow in place (patch
>> 4).
>>
>> Patch 5 makes sure the sk_ipv6only attribute is also propagated to
>> subflows, just in case the PM doesn't respect it.
>>
>> Some selftests have also been added for the userspace PM (patch 3) and
>> the in-kernel PM (patch 6).
>>
>> Patches 7 and 8 are just some cleanups in the userspace PM, not related
>> to the rest but I saw them when modifying the file.
>>
> 
> Patches 1-8 look good for further testing in the export (and export-net)
> branches:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> 
> 
>> Patches 9 to 12 improve the messages printed by the userspace PM,
>> especially in case of error during the validation.
>>
> 
> I have a very minor formatting comment on patch 9 (separate reply)

Thank you for the review!

I just applied these patches. I can of course modify them later if Paolo
is not OK with the modifications I did or to add Acked-by! (But I
understand Paolo probably has a huge email backlog to process, no hurry,
but at least here we can have more validations from the CI :-) )

New patches for t/upstream-net:
- 232e5ef7e4fb: mptcp: explicitly specify sock family at subflow
creation time
- 8215e56b14f2: mptcp: netlink: respect v4/v6-only sockets
- 13ce9dd3a3da: selftests: mptcp: userspace: validate v4-v6 subflows mix
- Results: 4d3787dfafff..e8000101a67b (export-net)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230109T163931


New patches for t/upstream:
- d7f79d4ba386: mptcp: let the in-kernel PM use mixed IPv4 and IPv6
addresses
- 4b28be013860: mptcp: propagate sk_ipv6only to subflows
- 371aa633fcf3: selftests: mptcp: add test-cases for mixed v4/v6 subflows
- 0e67a2df934f: mptcp: remove assigned but unused value
- 082c80d3fdbd: mptcp: userspace pm: use a single point of exit
- 621e00114ef6: selftests: mptcp: userspace: print titles
- 7c48d44f2d7d: selftests: mptcp: userspace: refactor asserts
- 543addc028f6: selftests: mptcp: userspace: print error details if any
- 4d29130d0eb7: selftests: mptcp: userspace: avoid read errors
- Results: 4ae7362cc1dc..24e3778f30ac (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230109T165807

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF22F26
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 09:42:14 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id s21so22262092ejx.12
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 01:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=gealWq20lu3GXxEGIb6qa8OEHK9eDtsxLq4zFwnujXE=;
        b=ONeVrxa8/qQLT+PLoEv0Z5SY8XcO+nQJ2uzUhTXYX0G6FrFUsYKgvqL6yFi7KN7Tur
         KGUtxQdRJ0/OjvrIycW/mE2VyBqM9rcSG100+KCuu9tpe3W9pzZ5EwrKHoZ0hHRtApCe
         wEjNDe+vdEaUKibvzw1AqrzahJukYAMx9hXXX7Vl9pGkfMl6bSh+RiA+Gw4pd0jWXPdC
         UZ1K7BWbTxxwqsgPQVDHMRAxRNVNCqzwMUs2Aqz3qhXZLYAVYwfiwwOG1l/Uow1Lht5m
         Og05zQJFCYMTS56YTKrQEc+GJFK1p3852kGv1FURod6CwPZEGKjq4wUEFOyMAXLg49Dc
         TmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gealWq20lu3GXxEGIb6qa8OEHK9eDtsxLq4zFwnujXE=;
        b=tAzAz1lff2LzDp8Ew5rxXVMtz8gxPOSnNpsBxQzQ7giRlIguEv9gk2nN3T0VUrzL4Z
         6QjXFdm1LiVGjfxSeTq8X6pPa/F0uJVX05OnMChS4zpx+lERw/lpjfMr97TezlUsRitK
         Lu6918Ya/0kijT03fGQ6ZKbIWP8akFFCji36sxQ7kbFAW8/gYICtqjX55uXdtkh3L6OW
         VRgkY/Qp5gYX/sdlR0/buJwG3K8yNmZcndKbjWGCdvnAdNpm99JqGdnFsGkfvLnXCTKQ
         w7MO63ot8f29ye+QJzJBiGSI7loDrjhHxdFl/lTbscfVbSd/U303QIxWld1pYjAv0tUG
         i3Jw==
X-Gm-Message-State: AOAM532Mgnswc04psO9vJgPdfizaqeIZa65ul2sAtF64yP+R51aIsn+E
	9oyV/EWQvEsFV1UyooOhdfogP12RTSkjDH0xspA=
X-Google-Smtp-Source: ABdhPJzv2xsMZeDys6xxnGZXIlPY+F7N+9WRHZevIKLjZo8VjYLxbRNxWoKZuCoTXStTXhY+S7eAOw==
X-Received: by 2002:a17:907:6e91:: with SMTP id sh17mr2941120ejc.534.1644313332555;
        Tue, 08 Feb 2022 01:42:12 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:ba0f:5a93:d93e:ce85? ([2a02:578:8593:1200:ba0f:5a93:d93e:ce85])
        by smtp.gmail.com with ESMTPSA id q7sm3564628eds.78.2022.02.08.01.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:42:12 -0800 (PST)
Message-ID: <cf6369f4-b6ec-1817-8ba8-7c9faf771ec5@tessares.net>
Date: Tue, 8 Feb 2022 10:42:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: simplify
 pm_nl_change_endpoint
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <3172f829eeb966f7265e4740a6e3f9bdca2fe44c.1644215857.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3172f829eeb966f7265e4740a6e3f9bdca2fe44c.1644215857.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 07/02/2022 07:38, Geliang Tang wrote:
> This patch simplified pm_nl_change_endpoint(), using id-based address
> lookups only. And dropped the fragile way of parsing 'addr' and 'id'
> from the output of pm_nl_show_endpoints().

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

- dbe081a3e5c2: selftests: mptcp: simplify pm_nl_change_endpoint
- Results: f092cd7abb9f..e98f6976dd01

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220208T094154
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

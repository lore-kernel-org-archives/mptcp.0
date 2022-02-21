Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D12568
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 09:31:06 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id gb39so31659767ejc.1
        for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=nWQUbYsaVFQh7At0QgRYnX2LVoD6nSPCoNP90nQcN8c=;
        b=taP+WOnoX7lD2tQI1hBbtzIMivDdgKJ4p83iqQD9oVcIztNTLDYpXbszhS4xROdIXY
         Jea07HhCxg3bEOZAqReNq5vNuradr1uU34Js59DEf81sVaPM4xX2H4wrqmyhAlUBiM49
         Vem0NYeWTs/XuKiVT1r4qBfMWkM4MNiRknGy1emjmwKyKc5KCa268/iHel4sr/89LhS7
         YDrcWQWbt4/ZnZd/Ehhmw7FOZ14zgXPYCeuCX1NcXCtxFvgKpCsMbtuEg2mindSMACNH
         WoFtb8MsU9EJUr+ElzlhI2mWKpmsTegsIJs4rLHbDh7DIFoshHRG4m8pV+TmpiYgiwTQ
         5yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=nWQUbYsaVFQh7At0QgRYnX2LVoD6nSPCoNP90nQcN8c=;
        b=2KKcoNNTikv+BxnPM3dpF7MDAsdoM6mVMGRwbnBiO/9RhQeIOEFgLfnt4SQk10TnxI
         OtXDnwHiKZpQXWmgCd9D5E8CJyon7gXYZCcfoC0qiOYc14qqDdQSKl2hud3l3NJSKyqX
         Qa8nlhb0FDhwyXxEQASFu9KRfuAwIuLsKyMhetJbDXc6Uv2EGfX4w/k3mlCIotJx6rLp
         IBeEw6oexPG71SWb2Hen0W9CFOwjasoAbUfJHtBKhVaX4/57Qyck2XOVVco/v91GWnIy
         weK83HJs/jD3GyLypMvG81OE7PvmRrcX020xvtrKovaPlk650ppwhXQqn2+0IlJF76GA
         iWJg==
X-Gm-Message-State: AOAM5316E7dlaW9y+Paj4Sk+5lj0zUSl1xbEmNZRcVwo7Lt70iSJ85mD
	rvUZNQb2TP/4ww7ex8nY08iaFNd+GqBWEg==
X-Google-Smtp-Source: ABdhPJw2z0NJ0MjOsizjG3Ku32Mk4Qwz0YIS4oNCAME8zMDt52GjsthaYWpwJBBxs9/FgxtN9cj4rg==
X-Received: by 2002:a17:906:2b93:b0:6cf:bb48:5a80 with SMTP id m19-20020a1709062b9300b006cfbb485a80mr14695178ejg.681.1645435864573;
        Mon, 21 Feb 2022 01:31:04 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:6601:25da:b9c7:38ca? ([2a02:578:8593:1200:6601:25da:b9c7:38ca])
        by smtp.gmail.com with ESMTPSA id i16sm1004356edu.52.2022.02.21.01.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:31:04 -0800 (PST)
Message-ID: <90badc30-bca5-d7c9-2be3-b272e7df96a2@tessares.net>
Date: Mon, 21 Feb 2022 10:30:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add 'bpf_mptcp_sock' structure
 and helper"
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <8b35b6817474d6b5ea0a3e5c8be617af6d130867.1644491001.git.geliang.tang@suse.com>
 <1f8efee6-d9db-8779-14ca-65d744b5991b@tessares.net>
 <20220221090554.GA4912@dhcp-10-157-36-190>
 <426e80c2-781e-7968-cb07-90bb4e4e10bc@tessares.net>
In-Reply-To: <426e80c2-781e-7968-cb07-90bb4e4e10bc@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2022 10:12, Matthieu Baerts wrote:
> On 21/02/2022 10:05, Geliang Tang wrote:

(...)

>> We can't drop RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, it will
>> break this userspace tests.
> 
> I don't remember what these userspace tests were doing

The idea was to be able to use the different hooks for TCP and

- have a way to identify the socket is in fact an MPTCP subflow

- be able to link this subflow with others of the same MPTCP connections

With the implementation from the export branch, it is possible to get
the msk from the ssk. From the msk, it is possible to get the token and
use it as a key in a hashmap. For some use cases, it might be needed to
retrieve other subflow sk from this msk.

To validate that, a different mark was set per subflow: all first
subflows had a mark of 1, then it was incremented for each subflow.
Also, a different TCP CC algorithm was set only on the first subflow.
Also just to check if everything was OK there.

If it is still possible to do that without RET_PTR_TO_MPTCP_SOCK_OR_NULL
but differently, that's perfectly fine and everybody is happy :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

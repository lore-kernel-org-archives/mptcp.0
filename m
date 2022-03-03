Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6077E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:28:10 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id qx21so11379867ejb.13
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 07:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ZSs49Z9RkPYjxkKDi1VUpINvaOHkCeiJ8bAYZr3oCX0=;
        b=oxDep0uxCreV/uy/bJMfB6roPMupxFf48TrlZaLqwqqImOeXIVgIsqf5dQ4+AkkkkQ
         Zy76yld55mQ826hhAHR8s6rrC0Qgw5eB2/tktm00B4m190/rBH7XAlDP56aMb3siGQ2U
         HVAL7Zw2sxYPTtZCoL6HbZCnaEoaRncX8ti1Yc1SV9iAr/09f6skX0dG6WdJBr/iOqa7
         Zz2rSicvWzQOGnrtO37l5MBSjRYM1aD1jMwNz07JdNe3TC973qedhRrEgvMK5FG/JXxR
         BHydCV8rxYo8BAItk2fcyrY78kbvMX37OCv+ZhRgPQKj1lO8muHH8rnOSVnGhyKwf0+h
         nSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZSs49Z9RkPYjxkKDi1VUpINvaOHkCeiJ8bAYZr3oCX0=;
        b=NU0FF1qMVcONz3OJuYBc/Ly/xHwvWCHhCjgLimrx5L3z/0x0XDnBodUsI8eGTgwf6/
         QI772DHr/J7hsUjHt3TsH8BoexcDAAV9oUI5oOL27xhB3MdFY10/n/dgiDmr8inXKntI
         7Z8fBSBa+rfJyKs5/fH28YfxytEZMIN3WzHSAXM9NTx/czf3zgzNQwIQcztCe6rdj0YC
         Jg1PAG1sMEY/XvFE8YQgrkSFAMY3XAqXoHyCUr7tmpvv0OFqV2brjYAYp12xgkWHHl7G
         LPVlQoPtmP2F4X6a34WnwlCk6YmjfB9jxUj9yaXsbvqTE8bkz5Cgz1Mc1C3lqs0IVvVB
         GOBg==
X-Gm-Message-State: AOAM5317R20rUaMUzwPitiR1cWqVTsHSZfxA2gx9LgvXg9M8TR6xEFU5
	ZaD29b9bbUfrCZe+oyu5ganlTysJ2jwZ1oJa
X-Google-Smtp-Source: ABdhPJx2WvnoT2weIqv30o5B+BEsSuAipZa7nT61ntc1TdaE5lf2Af8HOzv9vpQOMAphBIXpMANqIw==
X-Received: by 2002:a17:906:b1da:b0:6d6:dd9a:3a9b with SMTP id bv26-20020a170906b1da00b006d6dd9a3a9bmr12501489ejb.766.1646321288391;
        Thu, 03 Mar 2022 07:28:08 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9692:b15:c6e7:1c2e? ([2a02:578:8593:1200:9692:b15:c6e7:1c2e])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402278a00b00415b20902a6sm1065632ede.27.2022.03.03.07.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 07:28:07 -0800 (PST)
Message-ID: <2371c38b-af5a-520b-1b82-726e19717a06@tessares.net>
Date: Thu, 3 Mar 2022 16:28:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: selftests: bpf: exercise bpf_mptcp_sock(): Tests Results
Content-Language: en-GB
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <ad07af14b07078bf3162924a5c3ab69198fa68c8.1646318613.git.geliang.tang@suse.com>
 <ad1b86df-efed-4784-26e7-df914e6896b1@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ad1b86df-efed-4784-26e7-df914e6896b1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 03/03/2022 16:23, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - {"code":404,"message":
>   - "HTTP 404 Not Found"}:

It looks like there are some issues with Cirrus-CI today. I tried to
re-launch builds a few times but it didn't help:

  https://cirrus-ci.com/task/5056006051856384

Please ignore this message from MPTCP CI (validation) for the moment then.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

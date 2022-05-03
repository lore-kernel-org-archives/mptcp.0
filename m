Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F585322E
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 16:28:58 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id ba17so407396edb.5
        for <mptcp@lists.linux.dev>; Tue, 03 May 2022 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/2E9hrXEwlUTMEV9Dj2vTXTcYVRchlfALQ7catN84QM=;
        b=w1ZZKDFOnyCZ5ISS9FQxtrCxyPejKrKUyUrOgy2EP67lCbwwWYGrRkG5dL7YDSQyUW
         behjTscOz2VnzztUQ8dwyH71WcOFEljeotpPR2Zvidh/fIB99J0WUyifowYmOUw1umX3
         v3iKoKRpJuyX8il/SAtvoEdR/8ix53VO5h/bqK6cT4pWzS4QD2Srm2RmviqW5FluCOY0
         giBGgn85TFuH+nNhd+9cF7woPnAJzlv6UNdzYbW96sDQXOA7HYGXdky21OKONUODTmZx
         xtRjQ6OAarz8uS0Op/fbprmdWAeDmV1ijGPqqRxtq7Hu91abEW2BhFd7PZrRhffgxf01
         ORLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/2E9hrXEwlUTMEV9Dj2vTXTcYVRchlfALQ7catN84QM=;
        b=W5BGvOA7UiMfhCp01hmXH49ApzdPJT8t+0708WTCDmLGFcDdyKukOMZ2ZDcgkvJWXY
         xLrwAI/zA73oroqyNY/BMxORu5zHYh32ahsCDb/Jxzg+zpnxuddNUg/rce58uD2keBtI
         L78FkrE2D2tQjzSpOnSu4Fcxz8BN6BIsOhIoy+Kyqa04sFhwkKEn2W6ZbE47fOhb4gc5
         Zt2nAHRYQGP0orzaWx3Wl24Ae3RFhfJiqk1T4925LOsQw0bkJ0chio45NyC51Xz9L5bL
         zgHvJBA5Z6ZYC9tR6ytl1emszcotg372mkgK+0FneAYt9JG7tmlD6vb/4CSiecng5qoL
         NmOg==
X-Gm-Message-State: AOAM532XxNb6GYTQEldUfg3rXvP1upGiOKPnAyTc5sSdcagRlo/qYMsC
	/obrpZPH6jpMyspgjEl2xEjfariuqefXYw==
X-Google-Smtp-Source: ABdhPJyaP45giCMtcc4DMWQ2cacSfPkj9pI7j21YE8i+Mqzy2HO36MrhP9ba/wGj49IXZWghcPjf6g==
X-Received: by 2002:a05:6402:e99:b0:41d:11f2:85e0 with SMTP id h25-20020a0564020e9900b0041d11f285e0mr18371502eda.339.1651595336356;
        Tue, 03 May 2022 09:28:56 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id gv49-20020a1709072bf100b006f3ef214e35sm4701455ejc.155.2022.05.03.09.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:28:55 -0700 (PDT)
Message-ID: <00bc1734-033a-cb99-08ee-654b35a2400b@tessares.net>
Date: Tue, 3 May 2022 18:28:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v18 0/7] BPF packet scheduler
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1651412613.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1651412613.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat, Paolo,

On 01/05/2022 15:48, Geliang Tang wrote:
> v18:
>  - drop "mptcp: add last_snd write access".
>  - add mptcp_sched_data_init helper.
>  - move mptcp_sched_get_send() and mptcp_sched_get_retrans() into sched.c.

Thank you for the patches and reviews!

Now in our tree (feat. for others) with Paolo's ACK and Mat's RvB tags:

New patches for t/upstream:
- 2d934cabfc25: mptcp: add struct mptcp_sched_ops
- 467bf7c54c40: mptcp: add a new sysctl scheduler
- 9281e21f5f4d: mptcp: add sched in mptcp_sock
- 656ddb9db4e1: mptcp: add get_subflow wrappers
- be9de4168364: mptcp: add bpf_mptcp_sched_ops
- 2885b934b680: selftests: bpf: add bpf_first scheduler
- 0201204572f8: selftests: bpf: add bpf_first test
- Results: bea7cea0ffcd..9d8bf95bd8a7 (export)

And the squash-to patches:

- d8a1213416ef: "squashed" in "mptcp: add get_subflow wrappers"
- Results: 9d8bf95bd8a7..4c418cbad090 (export)

- 014d79843c44: "squashed" in "mptcp: add bpf_mptcp_sched_ops"
- Results: 4c418cbad090..aa6bec3f788f (export)

- 3b8d5a354bf6: "squashed" in "mptcp: add struct mptcp_sched_ops"
- Results: aa6bec3f788f..527315ca1901 (export)

- 92b309479c5c: "squashed" in "selftests: bpf: add bpf_first scheduler"
- Results: 527315ca1901..a800c43a02ab (export)

- 35a824bb888a: "squashed" in "selftests: bpf: add bpf_first test"
- Results: a800c43a02ab..c3f5d94e8dc4 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220503T162811
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

I didn't close it because "BPF round-robin scheduler" series also closes it.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

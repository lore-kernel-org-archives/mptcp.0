Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3DED1
	for <mptcp@lists.linux.dev>; Sat,  4 Jun 2022 10:39:49 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id er5so13034203edb.12
        for <mptcp@lists.linux.dev>; Sat, 04 Jun 2022 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=CwclFaTyCseA/vqpkVd6lNawxBzp+xdkFgT7jMN42Lo=;
        b=jFDz6ddBhemgQzpbFCBqbk1yfWoyuOFCnOZQWN/AIXyIrbPQdnrbSTmeZB9IQL7NCx
         TAVg9Ec2iQJyaatLpzxocQ2FOR74e/sr1beBNY8iGS1hW47aMXiMULP3SIzR8vwX7yYo
         /yvjdLdjMYQJ50rjJx7Omfci4t/zesBbYECIZlcz1HvPpT0zv1qTWjcV+4nr4zAY40Uw
         yEvFtk70M3labxxIUORzmsdmHtgYZ8ZmyQPDwsAsI4x6WzBnytdyDKzw/HT18r9qlKE2
         616XlK5htAYH3ospTP5dRiJSI7t/bUZKg6Uw8hiDOwwjT5DEwJ0v8doznrEVrQ6xcg2P
         fCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CwclFaTyCseA/vqpkVd6lNawxBzp+xdkFgT7jMN42Lo=;
        b=3O4UFBDQdXK/z6kmQSxIFdj/0tA4V9WvN9MZPlTCer0fPsV7o6EPEHwPK/H74DnbRP
         HSEhgiMBhhbOrn94w+UE+qJIRRMPg9rbtZngO7Qa8R54LveuBGln/4QvFtsmLbrF4+iJ
         EaW26dJcXJNN0SPlKsN9TqssKaQHxJFqJOU6KFcyi0Az/UprhIfQ0JRYWolVEjamjpGd
         yPfGCucymMDYEJvS/jCmi42I+N7slAwmAjfsW30qLxGHKswoYa+d+S29EVeH9aBbTuRW
         /PsKA6xE8epfIOfIa3ba+FjlwoE0FyM1wSPKjFW3AXFctTo0rXFNk6pf+auFgvhiVNmj
         1yrw==
X-Gm-Message-State: AOAM530tgm0/Ax5RkEC9fR/GKv65TYMJnaUxXIjrGcIL1/eYiLzdHw9r
	WbTlnfAiNUVU2E6aSKO3FHi/SLQnkDBoMkei
X-Google-Smtp-Source: ABdhPJzTD7a9pQMkGE2Bmdi8wUyOx9+gcEfZbZsojh2BiHFkCjoo+Hs6pvbaduhA0js6baAwnYSzOw==
X-Received: by 2002:a05:6402:d9:b0:42a:c890:20b5 with SMTP id i25-20020a05640200d900b0042ac89020b5mr15455118edu.101.1654339187225;
        Sat, 04 Jun 2022 03:39:47 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:af02:433b:fc8:9418? ([2a02:578:8593:1200:af02:433b:fc8:9418])
        by smtp.gmail.com with ESMTPSA id fi26-20020a170906da1a00b00707d11fd421sm3664859ejb.107.2022.06.04.03.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 03:39:46 -0700 (PDT)
Message-ID: <ebee9663-e68a-50d6-8864-6f897286f003@tessares.net>
Date: Sat, 4 Jun 2022 12:39:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next v7 00/13] BPF packet scheduler
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1654143895.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 02/06/2022 06:53, Geliang Tang wrote:
> Geliang Tang (13):
>   Squash to "mptcp: add struct mptcp_sched_ops"
>   Squash to "mptcp: add sched in mptcp_sock"
>   mptcp: add scheduled in mptcp_subflow_context
>   Squash to "mptcp: add get_subflow wrappers"
>   Squash to "mptcp: add bpf_mptcp_sched_ops"
>   bpf: Add bpf_mptcp_sched_kfunc_set
>   selftests/bpf: Add mptcp sched structs
>   Squash to "selftests/bpf: add bpf_first scheduler"
>   Squash to "selftests/bpf: add bpf_first test"
>   selftests/bpf: Add bpf_bkup scheduler
>   selftests/bpf: Add bpf_bkup test
>   selftests/bpf: Add bpf_rr scheduler
>   selftests/bpf: Add bpf_rr test

Thank you for the patches and the reviews!

- 2431156a8332: "squashed" patch 01/13 in "mptcp: add struct
mptcp_sched_ops"
- 5b4922afdc1a: tg:msg: import new commit message

- b3d4e9dd2732: "squashed" patch 02/13 in "mptcp: add sched in mptcp_sock"

- 31d67d8b3333: mptcp: add scheduled in mptcp_subflow_context
- a7bcb7a07c78: conflict in t/mptcp-add-get_subflow-wrappers

- 3e48ef252d67: "squashed" patch 04/13 in "mptcp: add get_subflow wrappers"
- 1b7fdba99880: tg:msg: import new commit message

- 50c2231c8ce0: "squashed" patch 05/13 in "mptcp: add bpf_mptcp_sched_ops"
- a5b6b12b168c: tg:msg: import new commit message

- da7c63ae4dae: bpf: Add bpf_mptcp_sched_kfunc_set
- ee9fd7d0cfc7: selftests/bpf: Add mptcp sched structs

- 4807c07b7208: "squashed" patch 08/13 in "selftests/bpf: add bpf_first
scheduler"
- e260618e476d: tg:msg: import new commit message

- a4e4bdabb97f: "squashed" patch 09/13 in "selftests/bpf: add bpf_first
test"
e98520b49d7c] tg:msg: import new commit message

- 39cea72f7d32: selftests/bpf: Add bpf_bkup scheduler
- fc3d564c3a1a: selftests/bpf: Add bpf_bkup test
- a468ad32a683: selftests/bpf: Add bpf_rr scheduler
- 98c84f06cc1d: selftests/bpf: Add bpf_rr test

- Results: 643dd3bb8650..293143ba65b0 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220604T103853
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

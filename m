Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6C258C
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 19:58:02 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id pv16so37352494ejb.0
        for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=0B0UniZgjufaFFRaiqwyY/dlTQPxPHf6pzHsnONlceY=;
        b=jwt3jgC3kikCCN+zqEJ9RyAI1zLTMKj00hiywdtr7/f9+5Cpg/qDRO3PxTJ71WxzwR
         ccgcRKQQKPF2im/Nl5KmZVcCNlCSkBE5DadgSLKPkj0hgtdLXf78glJdCxjMWfs/pa3E
         7JSX5+3MBWKM7YCIY0C12JVkvjv6sk1xkfkEhkZresOaaZNqdWIuAQa+YK+snOnQUvCt
         3Y34f+kKFC+FriujVLGvkDQV61cEUg8bChuji6CHqnWPTkgTIb+CdJRE0KqFBLRjYbhi
         PSV3VYB+KtPuGhQDu8u5hwHhqVuNiCp6Zq7k8JslTg4FrbMhyU5b8bHamk0G46Fl8lcQ
         DtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=0B0UniZgjufaFFRaiqwyY/dlTQPxPHf6pzHsnONlceY=;
        b=5Dn6lDybWMPvnr7MgLri+kGXLSuO0U2A1OMXIz/wISVXd+d1KVnkmKmg09w44H9vzK
         uehUTgMOpdBpA/wtHtNW5DrDmW5E7K23MehFxWAIy+gnbDwuD9k/IeJqLzv+KQQJSJhL
         Q0e6BKjhpzIxoC4ouYf680wjZjv8lTUjDRVxtLymwVW7xtDG/XR4z8x692rq80t6N96N
         CLGLts3TDQhC2mNXTdOs/GK3vNHQosEAmS7HVvxI6ZuOcvXleTOvG/8aZfSGNkiSf8mC
         UehTq9nKOPByMduZTZZNEU9L81XZ9APJvmLgIR0a50Lc97+ntcrP/OvfWy2dYmoo4LPk
         +mBg==
X-Gm-Message-State: AOAM530mYqx59JhsEhIipOUBhYf9pSzcTb3RGi2p9MDlO8V7iepLMUqo
	1WKqVvFJMX0/pzgxgd2lCQLiJSm8Hf1pZVRFdk4=
X-Google-Smtp-Source: ABdhPJx2rDtg2eJ95oUmrvhwh9qJYyZq4/qfAiShmhUSm4Ev21E0SQI+56kHi1wqxd7sCnHFYrJF3A==
X-Received: by 2002:a17:906:d205:b0:6d1:4446:d950 with SMTP id w5-20020a170906d20500b006d14446d950mr35070560ejz.702.1648583880448;
        Tue, 29 Mar 2022 12:58:00 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:afe0:2999:3598:5e23? ([2a02:578:8593:1200:afe0:2999:3598:5e23])
        by smtp.gmail.com with ESMTPSA id bd12-20020a056402206c00b00418c9bf71cbsm8714709edb.68.2022.03.29.12.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 12:57:59 -0700 (PDT)
Message-ID: <ba525ebe-497d-f3e1-b89d-836090c2b704@tessares.net>
Date: Tue, 29 Mar 2022 21:57:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v14 0/6] add skc_to_mptcp_sock
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1648311457.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1648311457.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 26/03/2022 17:24, Geliang Tang wrote:
> This series addresses to Alexei comments in [1].
> 
> [1]
> https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp.thefacebook.com/
> 
> v14:
>  - merge the squash-to patch for patch 1.
>  - rename progs/mptcp.c to progs/mptcp_sock.c in patch 2.
>  - split the token verifying as a new patch from patch 3.
>  - update the commit logs.

Thank you for this new version and the reviews!

Now in our tree with Mat's ACK:


New patches for t/upstream:

- f12408559134: bpf: add bpf_skc_to_mptcp_sock_proto
- 3666ef4c06e3: "squashed" patch 2/6 in "selftests: bpf: add MPTCP test
base"
- 0e2e98491bb3: selftests: bpf: test bpf_skc_to_mptcp_sock
- fc48505b75eb: selftests: bpf: verify token of struct mptcp_sock
- d74bab4b4875: selftests: bpf: verify ca_name of struct mptcp_sock
- 0b2f88af324f: selftests: bpf: verify first of struct mptcp_sock
- Results: e1bfedef8dde..d2b06f03e554 (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220329T195411
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

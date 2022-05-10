Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BEB28EF
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 14:04:57 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id m20so33162635ejj.10
        for <mptcp@lists.linux.dev>; Tue, 10 May 2022 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QKNlk5M1kXJiDsXjMo8sMP7tzCn0cTFGgNctLZORTKA=;
        b=VbJP1xh0amTllJlxrc2FYDUKC0ZpU5p0NXTWbMA7AWggECo5WsW5/XAmtr5eT8Y9C2
         FQRP/w4if2dNtnOPupR33VMqhvpn9NvNYAdPFU5Lv9ueFPb+pO0QgYh5AYzyZ6fdLujk
         D3gJnBMvDMP4HzSnyfSwg0VHSXZL6HqcqOlKvCaDVWUzOzRXk1h4++2QdBsUo7HKneDc
         chlKGwos+ohSPWV2Nf0gcJeLCpc8zgvK/4Ga+MmBjy7uw159TsyYaD0yP6LvjMCLzhYI
         WRCmA3KRv1Nb4F68NeAAfMF9Cy1fcNMyF1Oik6U7iMnbGIPVfYr9RnhIJJWk7xjog8sv
         PKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QKNlk5M1kXJiDsXjMo8sMP7tzCn0cTFGgNctLZORTKA=;
        b=szTOVVdna++UUn0kSW5mhWWHGzX7tG26zUQ4Q3DxEU+MqGPOUklytGu8ZBPuHD1Nl3
         hZ4aJ/xNPO5hgJLZR+Og67sL3ixFenOO1Zo1z05VlDlWcVspjoQyq04PMt0tICN4M4AU
         NCoApbuMvZcnvcBHCIqzC1eljOzm3OX+O3kwK0Yovc1Jq+VSzybcslWMRqaiIRddihrF
         4v37tA4m3E4cC+h0hy45AApmClC57NKH7++WswaQRT7Y+xve+r7nNMO8gxyY6WYJYX/a
         l1H1J58TN2/Ts6dF430tujvgJKcMgiJpMRjclDzXPAsFoKcGb9FoBxhSzLIv9TF70av+
         9hrw==
X-Gm-Message-State: AOAM533nUboePh5x6YVOZZcvGNpowcp9+A2XYaVjoQlW1TfQLLhtbKsY
	euOp3uGdwOsCVVxdGWtGw8wlLQ==
X-Google-Smtp-Source: ABdhPJyQvyezWOiyx5YS5TETvaTl+Kqj9AxmAUK9yGOsAEWyeOTduMgNsLCjRk+4JQGScdgTezxLiQ==
X-Received: by 2002:a17:906:9b86:b0:6f8:24e7:af7d with SMTP id dd6-20020a1709069b8600b006f824e7af7dmr16161625ejc.295.1652191493981;
        Tue, 10 May 2022 07:04:53 -0700 (PDT)
Received: from [192.168.47.124] (228-177-145-178.mobileinternet.proximus.be. [178.145.177.228])
        by smtp.gmail.com with ESMTPSA id z18-20020a05640240d200b0042617ba63a0sm7832310edb.42.2022.05.10.07.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 07:04:53 -0700 (PDT)
Message-ID: <bdd48852-cd00-c041-1b68-a436a56f8fb8@tessares.net>
Date: Tue, 10 May 2022 16:04:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Revert "mptcp: add data lock for sk timers"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
 <2ff24f02-800b-d980-9019-74f214e53c56@tessares.net>
 <38dab5e7-1193-db64-a6ca-22aba0622b49@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <38dab5e7-1193-db64-a6ca-22aba0622b49@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 10/05/2022 02:11, Mat Martineau wrote:
> On Fri, 6 May 2022, Matthieu Baerts wrote:
> 
>> Hi Paolo, Mat,
>>
>> On 05/05/2022 19:12, Paolo Abeni wrote:
>>> This reverts commit 4293248c6704b854bf816aa1967e433402bee11c.
>>>
>>> Additional locks are not needed, all the touched sections
>>> are already under mptcp socket lock protection.
>>
>> Thank you for the patch and the review!
>>
>> Now in our tree (fixes for net-next) with Mat's RvB and a Fixes tag.
>>
>> New patches for t/upstream:
>> - 2ff5e4eba944: Revert "mptcp: add data lock for sk timers"
>> - Results: bc6528b2b1d7..22856348dac5 (export)
> 
> This shows up in a different place in the export branch commit history
> than I expected:
> 
> * 1238ef9dd5ce (HEAD, tag: export/20220509T115202, mptcp-nn/export)
> DO-NOT-MERGE: mptcp: enabled by default
> * a89b2ebc4a26 DO-NOT-MERGE: mptcp: use kmalloc on kasan build
> * 8adddf50a9e9 DO-NOT-MERGE: git markup: features other trees
> * c0e05f5207ec selftests/bpf: add bpf_first test
> * 90b2072ffc21 selftests/bpf: add bpf_first scheduler
> * 2f547420d0f4 mptcp: add bpf_mptcp_sched_ops
> * cf597ecbdb4b mptcp: add get_subflow wrappers
> * 1b3d7a5f1f10 mptcp: add sched in mptcp_sock
> * e31f54bd6183 mptcp: add a new sysctl scheduler
> * 74d3c74494e6 mptcp: add struct mptcp_sched_ops
> * 416cb433f1df selftests/bpf: verify first of struct mptcp_sock
> * 57dcfb6f61ec selftests/bpf: verify ca_name of struct mptcp_sock
> * 8996b41ffcd2 selftests/bpf: verify token of struct mptcp_sock
> * f8f99d2ff6a7 selftests/bpf: test bpf_skc_to_mptcp_sock
> * 3fb057749027 selftests/bpf: add MPTCP test base
> * 1585ded1ef3d selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
> * d4fc73d43d5b bpf: add bpf_skc_to_mptcp_sock_proto
> * 581159326c14 bpf: expose is_mptcp flag to bpf_tcp_sock
> * b20a348378e2 DO-NOT-MERGE: git markup: features net-next-next
> * fa71bf0a2db6 selftests: mptcp: add MP_FAIL reset testcase
> * fddb2da3de32 DO-NOT-MERGE: git markup: features net-next
> 
> Expected to see the patch here.
> 
> * 218186cd781d mptcp: sockopt: add TCP_DEFER_ACCEPT support
> * 6d8839d159a7 DO-NOT-MERGE: git markup: fixes net-next
> *   f858740fef1e TopGit-driven merge of branches:
> |\
> | * baa752231c4d DO-NOT-MERGE: git markup: end common net net-next
> | * cad34cf702bc DO-NOT-MERGE: mptcp: add CI support
> | * d7945d0bf36f DO-NOT-MERGE: git markup: fixes net
> | * d8e908a27426 selftests: mptcp: add subflow limits test-cases
> | * 001ce634cb09 mptcp: fix subflow accounting on close
> | * ca2debea5aa8 net/sched: act_pedit: really ensure the skb is writable
> | * 945110b5a812 DO-NOT-MERGE: git markup: fixes other trees
> | * 55775678c466 x86/pm: Fix false positive kmemleak report in
> msr_build_context()
> | * 7a38d7853776 DO-NOT-MERGE: git markup: net
> * | 4f43f697b6be Revert "mptcp: add data lock for sk timers"
> 
>                  ^^^ but it's here instead
> 
> * | f57e72f418df selftests: mptcp: fix a mp_fail test warning
> * | 49161dcf2772 DO-NOT-MERGE: git markup: net-next
> * |   c908565eecf2 (mptcp-nn/net-next) Merge tag
> 'batadv-next-pullrequest-202205
> 
> 
> Matthieu, is that what you intended?

Yes, that was my initial intension: if there is an issue with a patch in
net-next, we probably don't want to wait for a sync with -net to send
the patch. So it is on top of net-next only. It is just in case we force
a sync with -net evenn if net and net-next have not been recently sync yet.

Do you prefer to have these patches on top of -net and net-next instead?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

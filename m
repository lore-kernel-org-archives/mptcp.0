Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA310E0
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 16:13:03 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so11222672wms.3
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Lqx1Swk6Ge+X8lMCTVUAQ1vD8QNWO9yTtk2o0vzrKOY=;
        b=Sf2edvGMeQCJ19///7WgoLXktoLnytjvo9n/m9fFA9K/HJdEDsNmI9QE6VrW/Zl3Ih
         vWEVxnQ5VebTxsORl6hIbbDHGehpdxFO8BnrkpkHlwgjDF3wnMe8yFnfyndC0ui1/xve
         7lMhHZ7jyKTK9+2BdsPv/4WK9xzDsUEec9f+r4UeTe4tUc/56yBdvzFo7mDeXVkT7mnI
         uF+wvC+Li5Y9eeTGWcLkXpW5ZP6mgqRURwm+6IJ3LlZtfOcEpwYqmtZBooUQeo0h33Wz
         mLs5/iZkuZIvjUL7IZFwuvpXXEthUBSVfVsO1/U50FxswqJqFcQHGdYOrLgpxQeDFuOu
         1NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lqx1Swk6Ge+X8lMCTVUAQ1vD8QNWO9yTtk2o0vzrKOY=;
        b=NzVMmYFlbJHB7uJSjV8Z7ofNmu3pVPIsaEyXeP97FrTkzyLere7L4yCnYvMZmdsK43
         FfRvVLfDv8zII5D5SHwinOzMaIL9ZAH2ykQxzqaYWSC9+cG+Y/o+qDimVpmoR/gdArFl
         e1yEFdKA8NmtPOOo/ZONieMyMDrdy9L9vrZoTqwSdbCs3411rMdVGv7eUtYht+tm1SiD
         9Ch7SUnz620dONO2meaoZnANqCwLFcmyWIbFMZncKmNY/5eQqi5l0fVkipglC+UVv+I+
         SWvg1RpBnHAxmXyvKzJXyUPerSjA5LLOT6poMUc2tPG6VhfQjKa/F6ZSh9MttOsSqrg7
         Ph2g==
X-Gm-Message-State: AOAM533BDeP0DBPc0g7Wblp8qbdY2QBdLu/dhfILaezUTc1HusfP+KYB
	PkCZHyHHxCt53NhAO+H+k2DZIRc3l8CVKgVd
X-Google-Smtp-Source: ABdhPJyUfVvXjB9CIyk9TCaMrlHmSUET7SUOJLyR2scbuag6Oy4ZvwT8mOnQw0I8H+epIz+C2Xznsw==
X-Received: by 2002:a05:600c:4994:b0:394:dcb:d66d with SMTP id h20-20020a05600c499400b003940dcbd66dmr27982575wmp.178.1652717581291;
        Mon, 16 May 2022 09:13:01 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id o17-20020adfca11000000b0020c5253d8ddsm10736913wrh.41.2022.05.16.09.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 09:13:00 -0700 (PDT)
Message-ID: <d6834a87-0555-c953-4d60-d3a493340cb3@tessares.net>
Date: Mon, 16 May 2022 18:13:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next] Revert "mptcp: add data lock for sk timers"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
 <2ff24f02-800b-d980-9019-74f214e53c56@tessares.net>
 <38dab5e7-1193-db64-a6ca-22aba0622b49@linux.intel.com>
 <bdd48852-cd00-c041-1b68-a436a56f8fb8@tessares.net>
 <7a1c3d44-2cb0-29c7-ae80-b2f9275d3130@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7a1c3d44-2cb0-29c7-ae80-b2f9275d3130@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 11/05/2022 22:40, Mat Martineau wrote:
> On Tue, 10 May 2022, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> On 10/05/2022 02:11, Mat Martineau wrote:
>>> On Fri, 6 May 2022, Matthieu Baerts wrote:
>>>
>>>> Hi Paolo, Mat,
>>>>
>>>> On 05/05/2022 19:12, Paolo Abeni wrote:
>>>>> This reverts commit 4293248c6704b854bf816aa1967e433402bee11c.
>>>>>
>>>>> Additional locks are not needed, all the touched sections
>>>>> are already under mptcp socket lock protection.
>>>>
>>>> Thank you for the patch and the review!
>>>>
>>>> Now in our tree (fixes for net-next) with Mat's RvB and a Fixes tag.
>>>>
>>>> New patches for t/upstream:
>>>> - 2ff5e4eba944: Revert "mptcp: add data lock for sk timers"
>>>> - Results: bc6528b2b1d7..22856348dac5 (export)
>>>
>>> This shows up in a different place in the export branch commit history
>>> than I expected:
>>>
>>> * 1238ef9dd5ce (HEAD, tag: export/20220509T115202, mptcp-nn/export)
>>> DO-NOT-MERGE: mptcp: enabled by default
>>> * a89b2ebc4a26 DO-NOT-MERGE: mptcp: use kmalloc on kasan build
>>> * 8adddf50a9e9 DO-NOT-MERGE: git markup: features other trees
>>> * c0e05f5207ec selftests/bpf: add bpf_first test
>>> * 90b2072ffc21 selftests/bpf: add bpf_first scheduler
>>> * 2f547420d0f4 mptcp: add bpf_mptcp_sched_ops
>>> * cf597ecbdb4b mptcp: add get_subflow wrappers
>>> * 1b3d7a5f1f10 mptcp: add sched in mptcp_sock
>>> * e31f54bd6183 mptcp: add a new sysctl scheduler
>>> * 74d3c74494e6 mptcp: add struct mptcp_sched_ops
>>> * 416cb433f1df selftests/bpf: verify first of struct mptcp_sock
>>> * 57dcfb6f61ec selftests/bpf: verify ca_name of struct mptcp_sock
>>> * 8996b41ffcd2 selftests/bpf: verify token of struct mptcp_sock
>>> * f8f99d2ff6a7 selftests/bpf: test bpf_skc_to_mptcp_sock
>>> * 3fb057749027 selftests/bpf: add MPTCP test base
>>> * 1585ded1ef3d selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
>>> * d4fc73d43d5b bpf: add bpf_skc_to_mptcp_sock_proto
>>> * 581159326c14 bpf: expose is_mptcp flag to bpf_tcp_sock
>>> * b20a348378e2 DO-NOT-MERGE: git markup: features net-next-next
>>> * fa71bf0a2db6 selftests: mptcp: add MP_FAIL reset testcase
>>> * fddb2da3de32 DO-NOT-MERGE: git markup: features net-next
>>>
>>> Expected to see the patch here.
>>>
>>> * 218186cd781d mptcp: sockopt: add TCP_DEFER_ACCEPT support
>>> * 6d8839d159a7 DO-NOT-MERGE: git markup: fixes net-next
>>> *   f858740fef1e TopGit-driven merge of branches:
>>> |\
>>> | * baa752231c4d DO-NOT-MERGE: git markup: end common net net-next
>>> | * cad34cf702bc DO-NOT-MERGE: mptcp: add CI support
>>> | * d7945d0bf36f DO-NOT-MERGE: git markup: fixes net
>>> | * d8e908a27426 selftests: mptcp: add subflow limits test-cases
>>> | * 001ce634cb09 mptcp: fix subflow accounting on close
>>> | * ca2debea5aa8 net/sched: act_pedit: really ensure the skb is writable
>>> | * 945110b5a812 DO-NOT-MERGE: git markup: fixes other trees
>>> | * 55775678c466 x86/pm: Fix false positive kmemleak report in
>>> msr_build_context()
>>> | * 7a38d7853776 DO-NOT-MERGE: git markup: net
>>> * | 4f43f697b6be Revert "mptcp: add data lock for sk timers"
>>>
>>>                  ^^^ but it's here instead
>>>
>>> * | f57e72f418df selftests: mptcp: fix a mp_fail test warning
>>> * | 49161dcf2772 DO-NOT-MERGE: git markup: net-next
>>> * |   c908565eecf2 (mptcp-nn/net-next) Merge tag
>>> 'batadv-next-pullrequest-202205
>>>
>>>
>>> Matthieu, is that what you intended?
>>
>> Yes, that was my initial intension: if there is an issue with a patch in
>> net-next, we probably don't want to wait for a sync with -net to send
>> the patch. So it is on top of net-next only. It is just in case we force
>> a sync with -net evenn if net and net-next have not been recently sync
>> yet.
>>
>> Do you prefer to have these patches on top of -net and net-next instead?
>>
> 
> That is my preference for future mptcp-next patches, yes. But you don't
> need to re-arrange these two patches in the tree.
> 
> None of the patches staged for net-next (before or after the
> topgit-driven merge) are waiting for a sync unless there's a known
> conflict with a pending patch in export-net.
> 
> When I prepare a series to send to the netdev list I often "git rebase
> --onto net-next/master <from-sha> <to-sha>" the relevant patches, and I
> don't want a merge commit in the middle of the range. It's also helpful
> to find out if there are any surprise conflicts at that stage so I can
> consider that before sending.

Fine for me, I just did the modification to put all fixes for net-next
on top of -net as well!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

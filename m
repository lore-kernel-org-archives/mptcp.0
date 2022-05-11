Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061F3208
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652301623; x=1683837623;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hZifUU1pq3mdQek+MGDwPh/2/mxgTbci9O49ff3xKzI=;
  b=ll8TpwHn99DknkziEai2z7OqwlXzd7vraEnkZloeaJkMBf3x4K8OUtRn
   SYVt/3qkE4vSD/xaYjMi+3HDTP6Ibx2Jw/xCzQv6HkS1bqASHstWjMAHp
   /aJ2SVFWiNNxbeIf/XcG1Wwhbgoi1Alkaaa8/UvvipYjJU7/Nxmcw3Imw
   AtC4RBkJVPtMwzM9UTReoJnzHLFEwFsT3DsA2hJgPRC5z1co3dFZ4lm48
   NNed/PGX6WGVH8OC2xPQKBd8EOYgTYr9PysEI0NszTO8a5MHWwnnO524G
   /oPzioJwdTwFv2r29/JBOu9dcxBZNome7n3TTZ83GEMSeJBbFW/xL8U8F
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269939894"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269939894"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 13:40:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="814629217"
Received: from rdstein-mobl.amr.corp.intel.com ([10.212.177.197])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 13:40:22 -0700
Date: Wed, 11 May 2022 13:40:15 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Revert "mptcp: add data lock for sk timers"
In-Reply-To: <bdd48852-cd00-c041-1b68-a436a56f8fb8@tessares.net>
Message-ID: <7a1c3d44-2cb0-29c7-ae80-b2f9275d3130@linux.intel.com>
References: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com> <2ff24f02-800b-d980-9019-74f214e53c56@tessares.net> <38dab5e7-1193-db64-a6ca-22aba0622b49@linux.intel.com> <bdd48852-cd00-c041-1b68-a436a56f8fb8@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1139596933-1652301622=:15525"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1139596933-1652301622=:15525
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 May 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 10/05/2022 02:11, Mat Martineau wrote:
>> On Fri, 6 May 2022, Matthieu Baerts wrote:
>>
>>> Hi Paolo, Mat,
>>>
>>> On 05/05/2022 19:12, Paolo Abeni wrote:
>>>> This reverts commit 4293248c6704b854bf816aa1967e433402bee11c.
>>>>
>>>> Additional locks are not needed, all the touched sections
>>>> are already under mptcp socket lock protection.
>>>
>>> Thank you for the patch and the review!
>>>
>>> Now in our tree (fixes for net-next) with Mat's RvB and a Fixes tag.
>>>
>>> New patches for t/upstream:
>>> - 2ff5e4eba944: Revert "mptcp: add data lock for sk timers"
>>> - Results: bc6528b2b1d7..22856348dac5 (export)
>>
>> This shows up in a different place in the export branch commit history
>> than I expected:
>>
>> * 1238ef9dd5ce (HEAD, tag: export/20220509T115202, mptcp-nn/export)
>> DO-NOT-MERGE: mptcp: enabled by default
>> * a89b2ebc4a26 DO-NOT-MERGE: mptcp: use kmalloc on kasan build
>> * 8adddf50a9e9 DO-NOT-MERGE: git markup: features other trees
>> * c0e05f5207ec selftests/bpf: add bpf_first test
>> * 90b2072ffc21 selftests/bpf: add bpf_first scheduler
>> * 2f547420d0f4 mptcp: add bpf_mptcp_sched_ops
>> * cf597ecbdb4b mptcp: add get_subflow wrappers
>> * 1b3d7a5f1f10 mptcp: add sched in mptcp_sock
>> * e31f54bd6183 mptcp: add a new sysctl scheduler
>> * 74d3c74494e6 mptcp: add struct mptcp_sched_ops
>> * 416cb433f1df selftests/bpf: verify first of struct mptcp_sock
>> * 57dcfb6f61ec selftests/bpf: verify ca_name of struct mptcp_sock
>> * 8996b41ffcd2 selftests/bpf: verify token of struct mptcp_sock
>> * f8f99d2ff6a7 selftests/bpf: test bpf_skc_to_mptcp_sock
>> * 3fb057749027 selftests/bpf: add MPTCP test base
>> * 1585ded1ef3d selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
>> * d4fc73d43d5b bpf: add bpf_skc_to_mptcp_sock_proto
>> * 581159326c14 bpf: expose is_mptcp flag to bpf_tcp_sock
>> * b20a348378e2 DO-NOT-MERGE: git markup: features net-next-next
>> * fa71bf0a2db6 selftests: mptcp: add MP_FAIL reset testcase
>> * fddb2da3de32 DO-NOT-MERGE: git markup: features net-next
>>
>> Expected to see the patch here.
>>
>> * 218186cd781d mptcp: sockopt: add TCP_DEFER_ACCEPT support
>> * 6d8839d159a7 DO-NOT-MERGE: git markup: fixes net-next
>> *   f858740fef1e TopGit-driven merge of branches:
>> |\
>> | * baa752231c4d DO-NOT-MERGE: git markup: end common net net-next
>> | * cad34cf702bc DO-NOT-MERGE: mptcp: add CI support
>> | * d7945d0bf36f DO-NOT-MERGE: git markup: fixes net
>> | * d8e908a27426 selftests: mptcp: add subflow limits test-cases
>> | * 001ce634cb09 mptcp: fix subflow accounting on close
>> | * ca2debea5aa8 net/sched: act_pedit: really ensure the skb is writable
>> | * 945110b5a812 DO-NOT-MERGE: git markup: fixes other trees
>> | * 55775678c466 x86/pm: Fix false positive kmemleak report in
>> msr_build_context()
>> | * 7a38d7853776 DO-NOT-MERGE: git markup: net
>> * | 4f43f697b6be Revert "mptcp: add data lock for sk timers"
>>
>>                  ^^^ but it's here instead
>>
>> * | f57e72f418df selftests: mptcp: fix a mp_fail test warning
>> * | 49161dcf2772 DO-NOT-MERGE: git markup: net-next
>> * |   c908565eecf2 (mptcp-nn/net-next) Merge tag
>> 'batadv-next-pullrequest-202205
>>
>>
>> Matthieu, is that what you intended?
>
> Yes, that was my initial intension: if there is an issue with a patch in
> net-next, we probably don't want to wait for a sync with -net to send
> the patch. So it is on top of net-next only. It is just in case we force
> a sync with -net evenn if net and net-next have not been recently sync yet.
>
> Do you prefer to have these patches on top of -net and net-next instead?
>

That is my preference for future mptcp-next patches, yes. But you don't 
need to re-arrange these two patches in the tree.

None of the patches staged for net-next (before or after the topgit-driven 
merge) are waiting for a sync unless there's a known conflict with a 
pending patch in export-net.

When I prepare a series to send to the netdev list I often "git rebase 
--onto net-next/master <from-sha> <to-sha>" the relevant patches, and I 
don't want a merge commit in the middle of the range. It's also helpful to 
find out if there are any surprise conflicts at that stage so I can 
consider that before sending.

--
Mat Martineau
Intel
--0-1139596933-1652301622=:15525--

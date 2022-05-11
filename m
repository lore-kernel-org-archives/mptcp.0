Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2415A7
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652230637; x=1683766637;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wC0YrCVdqH77lAqOmCn+r/bVslztb/+p6n672sMjSmU=;
  b=W4TxeVrqA/SIbZ0LJ/3g67dA90cKLVAj6e9VCa7Bl4fcX9+NnFesM2Fb
   Zx8vQAIAEpJlSU27klGeTp1CU59GTy7U2J9H3hJjn/R/ExYIlEs+DH1Ot
   wFZHSXsNWS4JUBPKCE8Wm/CkeNBOIRSKrTdU+Ui9k085l0G8yZtIxvUnh
   Zna2sKnO5wPqndMqRMsa15qfOmptJifgeT45MvvZFWi3gPE9YziXVZ5PL
   us9LZCUPVV3dKaSdbT614XwS0jojEM43aKFXYT4hQbqjyJp9j5FPfTZ4b
   bIvjy+NrjlHSKBK8kMSJjHj/Op87k5akvr3AAp/QRawT95hHouuM1yAe2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269680196"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="269680196"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:57:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="711266052"
Received: from yperng-mobl1.amr.corp.intel.com ([10.209.50.90])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:57:16 -0700
Date: Tue, 10 May 2022 17:57:15 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v13 0/3] BPF round-robin scheduler
In-Reply-To: <cover.1652107942.git.geliang.tang@suse.com>
Message-ID: <9915db1-d479-1123-a4bb-109897f634da@linux.intel.com>
References: <cover.1652107942.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 9 May 2022, Geliang Tang wrote:

> v13:
> - add !msk->last_snd check in patch 2
> - use ASSERT_OK_PTR instead of CHECK in patch 3
> - base-commit: export/20220509T115202
>

Thanks for the updates. Like the v12 review, I think we should wait until 
this is rebased on the bpf header changes before applying the patches.

- Mat

> v12:
> - init ssk from data->contexts[0], instead of msk->first.
> - cycle through all the subflows, instead of the first two.
>
> v11:
> - rename array to contexts.
> - drop number of subflows in mptcp_sched_data.
> - set unused array elements to NULL.
> - add MPTCP_SUBFLOWS_MAX check in mptcp_sched_data_init.
>
> v10:
> - init subflows array in mptcp_sched_data_init.
> - for (int i = 0; i < data->subflows; i++) is not allowed in BPF, using
>   this instead:
> 	for (int i = 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++)
> - deponds on: "BPF packet scheduler" series v18.
>
> v9:
> - add subflows array in mptcp_sched_data
> - deponds on: "BPF packet scheduler" series v17 +
>               Squash to "mptcp: add struct mptcp_sched_ops v17".
>
> v8:
> - use struct mptcp_sched_data.
> - deponds on: "BPF packet scheduler" series v14.
>
> v7:
> - rename retrans to reinject.
> - drop last_snd setting.
> - deponds on: "BPF packet scheduler" series v13.
>
> v6:
> - set call_me_again flag.
> - deponds on: "BPF packet scheduler" series v12.
>
> v5:
> - update patch 2, use temporary storage instead.
> - update patch 3, use new helpers.
> - deponds on: "BPF packet scheduler" series v11.
>
> v4:
> - add retrans argment for get_subflow()
>
> v3:
> - add last_snd write access.
> - keep msk->last_snd setting in get_subflow().
> - deponds on: "BPF packet scheduler" series v10.
>
> v2:
> - merge the squash-to patch.
> - implement bpf_mptcp_get_subflows helper, instead of
>   bpf_mptcp_get_next_subflow.
> - deponds on: "BPF packet scheduler v9".
>
> This patchset implements round-robin scheduler using BPF. Address to
> some commends for the RFC version:
>
> https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.geliangtang@xiaomi.com/
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75
>
> Geliang Tang (3):
>  mptcp: add subflows array in sched data
>  selftests/bpf: add bpf_rr scheduler
>  selftests/bpf: add bpf_rr test
>
> include/net/mptcp.h                           |  2 +
> net/mptcp/sched.c                             | 14 ++++++
> .../testing/selftests/bpf/bpf_mptcp_helpers.h |  8 ++++
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 47 +++++++++++++++++++
> 5 files changed, 109 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel

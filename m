Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3C7E
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 00:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651881981; x=1683417981;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zqr1vZ47mFV6+jfa2C/qwgtqD4g0ad5402MnFobA9oI=;
  b=TRjKp03934CFOQFsebiM412c15sBaAwlxCKnkQpd+3yQQlzTD5pIEr9z
   XcWuUkywKpIoOTWtWMaYKokIh3aoUWzLeGRPAhNSaXiim9Rd4Qv0cGGtW
   p5berB8yZtu5XMXj+JqZJlxbuhHwloV2zMIwSZEXVw5d3BUl6rrvUeyt6
   xSRAURZ6sDXOwlpLgpJYKz6cHivrOnHaa9V+aXsz/ajQF3RVPTmk1oLyi
   g4p1SgBriKd39Q7f5ZwPxuAcD3jd4bJSTUwZ3HDUQ4H3jKvOTHYMIvv1s
   soKmZl92B1k9Nm9blJVzUZDwGnEwy2V9cdfQ1L7aSUcVVN5oo1sZfrjf1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="267448822"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="267448822"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 17:06:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="550084786"
Received: from jrbond-mobl1.amr.corp.intel.com ([10.212.218.216])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 17:06:20 -0700
Date: Fri, 6 May 2022 17:06:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v12 0/3] BPF round-robin scheduler
In-Reply-To: <cover.1651724418.git.geliang.tang@suse.com>
Message-ID: <2cef2c7d-d25e-179f-2550-23cc935ad7ec@linux.intel.com>
References: <cover.1651724418.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 5 May 2022, Geliang Tang wrote:

> v12:
> - init ssk from data->contexts[0], instead of msk->first.
> - cycle through all the subflows, instead of the first two.
>

v12 looks ok for the export branch, but Andrii asked for us to use 
bpf_tcp_helpers.h instead of adding a new header file. Geliang, I think it 
would be easier to do a v13 with the header changes rather than apply v12 
and squash header changes.

- Mat

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
>  selftests: bpf: add bpf_rr scheduler
>  selftests: bpf: add bpf_rr test
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

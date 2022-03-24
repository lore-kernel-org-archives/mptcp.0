Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500B7E
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 23:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648163739; x=1679699739;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2dNtqSo1gLiXZJj5iJhc1wJ2zUIlCdGftsOLFyaHIV8=;
  b=h0v+oKSFKgiobmAynjehObcVe15GDamlNE18Ql9fkreDRBvAisu4Ntqq
   sOgxxWao2yFlBcncWeA8LgcXlnKFRr1MOGzE9pmKFefGAHHY3J7YkKG+k
   ezxWcb7nkH1MWCn1sIR3sKAd6uPxEL/zj0G+PbsCo8DaSk8MMqDmJrJ0j
   PfxBc4JVXCAUzBp98dkt+hSRfpWyQBdDAlY1f2aQuV8NTux+ywiBE9HW3
   KbuVJtCb05+a8k164y/1pLS5QsvaRSg6vkZdUKJ70cMwNbxNjihE4SPFG
   2HDkScLYjLCQQJYowtmkyN7+lTmwF7K8bI9ilz6GdDyDOdS4eo1lOZbE4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321707968"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="321707968"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:15:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="561590747"
Received: from lyang24-mobl.amr.corp.intel.com ([10.255.230.22])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:15:38 -0700
Date: Thu, 24 Mar 2022 16:15:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v5 0/8] BPF packet scheduler
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
Message-ID: <6c291a4-a0f7-88ab-9de2-b5c0d4ac3cae@linux.intel.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 24 Mar 2022, Geliang Tang wrote:

> RESEND:
> - rebased to export/20220324T054815.
> - depends on: "add skc_to_mptcp_sock" v12.
>
> v5:
> - patch 1: define per-namespace sched_list (but only used init_net
>   namespace. It is difficult to get 'net' in bpf_mptcp_sched_reg and
>   bpf_mptcp_sched_unreg. I need some suggestions here.)
> - patch 2: skip mptcp_sched_default in mptcp_unregister_scheduler.
> - patch 8: add tests into mptcp.c, instead of bpf_tcp_ca.c.
>

I ran in to a build problem because CONFIG_BPF_SYSCALL was not set in my 
.config and net/mptcp/Kconfig did not capture any BPF dependencies.

I think it would be best to allow MPTCP use without BPF enabled, so a new 
CONFIG_MPTCP_BPF_SCHEDULER config option (with dependencies on MPTCP and 
BPF_SYSCALL) would be good.


--
Mat Martineau
Intel

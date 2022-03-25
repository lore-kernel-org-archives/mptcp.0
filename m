Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C428E0
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 22:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648246731; x=1679782731;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bldDQlyIO5yP9yYOmc31wohyI2dqpp4HIVjwdJs905k=;
  b=nOC3/dUNefqtIOUdVGq3SI/oLOXIC+cZIZY1+XjElbXvT0sry9SaU+Ut
   Yzw+rZ+T99jwK2uB99C1CcVhzLQLkRkTvuyMUdJ5vPhW/qvRceqSgeGOv
   wEHo0Bas/4YN/g1LfZVEjmiu+WeYPo3tTDgiMeUt8G32/tivGpT2FZL65
   ku+BaFmTA1MCt1z1YpbbJ92pYVjrjrpxIDh/ywGuqzyiam2F7ALl4uSx3
   qVoqLxdN1tnhsWIKMRtpuoUdiXHeqwsTxbZz8cZLdndyMUC5V0OmDM+Gd
   1ZSaa390cTT/6Fj6asP0uWieM+9QQ3hjtLqA1cMLx1+aMy6vzpLr66JRb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="246213410"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="246213410"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 15:18:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="693815522"
Received: from ivbeskor-mobl1.amr.corp.intel.com ([10.209.23.71])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 15:18:49 -0700
Date: Fri, 25 Mar 2022 15:18:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v13 1/5] bpf: add
 bpf_skc_to_mptcp_sock_proto
In-Reply-To: <22e7ba644f5943834b2a979de3847ec2c88e0c00.1648202310.git.geliang.tang@suse.com>
Message-ID: <29ed4b51-fea4-c11d-30ff-d21a6023e43c@linux.intel.com>
References: <cover.1648202310.git.geliang.tang@suse.com> <22e7ba644f5943834b2a979de3847ec2c88e0c00.1648202310.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 25 Mar 2022, Geliang Tang wrote:

> This patch implemented a new bpf_func_proto bpf_skc_to_mptcp_sock_proto.
> Defined a new bpf_id BTF_SOCK_TYPE_MPTCP, implemented the helper
> bpf_skc_to_mptcp_sock, and added a new helper bpf_mptcp_sock_from_subflow
> to get struct mptcp_sock from a given subflow socket.
>
> Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/linux/bpf.h            |  9 +++++++++
> include/linux/btf_ids.h        |  3 ++-
> include/uapi/linux/bpf.h       |  7 +++++++
> net/core/filter.c              | 16 ++++++++++++++++
> net/mptcp/Makefile             |  2 ++
> net/mptcp/bpf.c                | 22 ++++++++++++++++++++++
> scripts/bpf_doc.py             |  2 ++
> tools/include/uapi/linux/bpf.h |  7 +++++++
> 8 files changed, 67 insertions(+), 1 deletion(-)
> create mode 100644 net/mptcp/bpf.c
>

...

> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index e54daceac58b..99dddf08ca73 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -10,3 +10,5 @@ obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
> mptcp_crypto_test-objs := crypto_test.o
> mptcp_token_test-objs := token_test.o
> obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
> +
> +obj-$(CONFIG_BPF_SYSCALL) += bpf.o

Ok, I see that net/ipv4/bpf_tcp_ca.c is also included based on 
CONFIG_BPF_SYSCALL, so it would probably be overkill to add a new 
CONFIG_MPTCP_BPF_SCHEDULER option. Using CONFIG_BPF_SYSCALL is fine.


I noticed that the TCP CA conditional also depends on CONFIG_BPF_JIT:

ifeq ($(CONFIG_BPF_JIT),y)
obj-$(CONFIG_BPF_SYSCALL) += bpf_tcp_ca.o
endif

Presumably this is to reduce the overhead of BPF code that's called 
frequently. Should we do the same for the MPTCP scheduler?

--
Mat Martineau
Intel

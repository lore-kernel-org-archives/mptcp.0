Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C617E
	for <mptcp@lists.linux.dev>; Mon, 25 Apr 2022 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650910317; x=1682446317;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mSQimSeit0qQYIR29FHzF1+b5hRzxzx/JMxX3mqAd+E=;
  b=Z/msD8IOsPHMHDjt1aFs7vukUsWfOHdteLNXscnYsBigX8QJpBdIDjdB
   w9435fdJ8ALf/sUlFcx4kVToIphsjroUmmSyw+dT+3VMSW5U4u9+vG4CF
   i2fU6YaAyxGGoBJjHAtPhW7U4igF60xUqils2DcvThfJCRMqbMT9+KdtL
   HFl9fPRrEE5++iUL6S4lXTHlgoW8Bwj8hL9M0QawmkJU0OiRSsbKz7FQR
   7MQO6h6ABqjAHBSdU/t3f/1tAeCxAj3L3qpK1O9C02U+rrH3RFZ3CTs1a
   OCIuNaRNOSHSFUYxVjWg/W5cfd+VX4jhrnNJzXCtjXmW9sIp3nspmvt6d
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245892581"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="245892581"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:11:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="729853515"
Received: from rderber-mobl.amr.corp.intel.com ([10.212.151.176])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 11:11:56 -0700
Date: Mon, 25 Apr 2022 11:11:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
    Geliang Tang <geliang.tang@suse.com>
cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
    andrii@kernel.org, mptcp@lists.linux.dev, 
    Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH bpf-next 2/7] bpf: add bpf_skc_to_mptcp_sock_proto
In-Reply-To: <513485c6-82ea-9cf0-1df0-3ea75935809c@iogearbox.net>
Message-ID: <73d12683-df70-b77e-5d92-d37664559148@linux.intel.com>
References: <20220420222459.307649-1-mathew.j.martineau@linux.intel.com> <20220420222459.307649-3-mathew.j.martineau@linux.intel.com> <513485c6-82ea-9cf0-1df0-3ea75935809c@iogearbox.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 25 Apr 2022, Daniel Borkmann wrote:

> On 4/21/22 12:24 AM, Mat Martineau wrote:
> [...]
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index 0a3b0fb04a3b..5b3a6f783182 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -283,4 +283,10 @@ static inline int mptcpv6_init(void) { return 0; }
>>   static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { 
>> }
>>   #endif
>>   +#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_JIT) && 
>> defined(CONFIG_BPF_SYSCALL)
>> +struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
>> +#else
>> +static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock 
>> *sk) { return NULL; }
>> +#endif
>> +
>
> Where is this relevant to JIT specifically?
>

That's carried over from the build conditions for bpf_tcp_ca.c in 
net/ipv4/Makefile:

ifeq ($(CONFIG_BPF_JIT),y)
obj-$(CONFIG_BPF_SYSCALL) += bpf_tcp_ca.o
endif

Looks like the reasoning for that (in the CA code) is the use of 
bpf_struct_ops in bpf_tcp_ca.c

While this patch series for MPTCP does not use bpf_struct_ops, and JIT is 
not necessary for bpf_mptcp_sock_from_subflow(), the upcoming MPTCP 
scheduler-in-BPF patches do use bpf_struct_ops. So that dependency found 
its way in to this series - but now that you point it out, 
bpf_mptcp_sock_from_subflow() shouldn't be limited by CONFIG_BPF_JIT and 
we can separately check for the JIT dependency for the scheduler code. 
Will fix that in v2.


--
Mat Martineau
Intel

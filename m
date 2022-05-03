Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2C160
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 00:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651536488; x=1683072488;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x3vyO6jUOS0WeeDK7rPywIaTPXgvOUFazvG99fFw6fA=;
  b=Ju7JpxDK8IGTqdOKX+LQYrM1OXtm+KbkgqaedKW+RByWAo0383J/hADT
   TDD6/Ra4iXlMFjLHUr4dDE4HBGqe5sOuI3JFDqqGgINO+d99aYJBsPt40
   rvDx8QUEYmOnwKdDVNnnlSXRgPg+Wc09FKzwIoonHG/XaOyYDIHZhYRyp
   x+ShsihbiLK1rQKY7qTc/xR7PpmJRQD7j/20FD2jf3CYQEYX+Tnztvw8q
   QEOMPgbin6HKLR1htlEddBoXj7mIXnWbR2OtnukaU+Ds0gzJWORq41Tf3
   8wGJ/boZ+8YdtlI1Uqy9MTsGwzBmNjXE1LqhYJCEHJtjwBU+BzKyxFDrG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="264952541"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="264952541"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 17:08:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="536111649"
Received: from raltenor-mobl.amr.corp.intel.com ([10.212.200.195])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 17:08:07 -0700
Date: Mon, 2 May 2022 17:08:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v18 5/7] mptcp: add bpf_mptcp_sched_ops
In-Reply-To: <6d7ce54488bd5524f750c52cf2cfd7b0ff68eb40.camel@redhat.com>
Message-ID: <cec3f67e-37f2-4128-5c7a-406be603c19@linux.intel.com>
References: <cover.1651412613.git.geliang.tang@suse.com>  <2ade81287c82a673c3e6f03d8700e8f77fcfc651.1651412613.git.geliang.tang@suse.com> <6d7ce54488bd5524f750c52cf2cfd7b0ff68eb40.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 2 May 2022, Paolo Abeni wrote:

> Hello,
>
> On Sun, 2022-05-01 at 21:48 +0800, Geliang Tang wrote:
>> This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
>> Register and unregister the bpf scheduler in .reg and .unreg.
>>
>> This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
>> net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>>  kernel/bpf/bpf_struct_ops_types.h |   4 +
>>  net/mptcp/bpf.c                   | 154 ++++++++++++++++++++++++++++++
>>  2 files changed, 158 insertions(+)
>>
>> diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
>> index 5678a9ddf817..5a6b0c0d8d3d 100644
>> --- a/kernel/bpf/bpf_struct_ops_types.h
>> +++ b/kernel/bpf/bpf_struct_ops_types.h
>> @@ -8,5 +8,9 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
>>  #ifdef CONFIG_INET
>>  #include <net/tcp.h>
>>  BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
>> +#ifdef CONFIG_MPTCP
>> +#include <net/mptcp.h>
>> +BPF_STRUCT_OPS_TYPE(mptcp_sched_ops)
>> +#endif
>>  #endif
>>  #endif
>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>> index 535602ba2582..ad770deb5a72 100644
>> --- a/net/mptcp/bpf.c
>> +++ b/net/mptcp/bpf.c
>> @@ -10,8 +10,162 @@
>>  #define pr_fmt(fmt) "MPTCP: " fmt
>>
>>  #include <linux/bpf.h>
>> +#include <linux/bpf_verifier.h>
>> +#include <linux/btf.h>
>> +#include <linux/btf_ids.h>
>>  #include "protocol.h"
>>
>> +#ifdef CONFIG_BPF_JIT
>> +extern struct bpf_struct_ops bpf_mptcp_sched_ops;
>> +extern struct btf *btf_vmlinux;
>> +static const struct btf_type *mptcp_sched_type __read_mostly;
>> +static u32 mptcp_sched_id;
>> +
>> +static u32 optional_ops[] = {
>> +	offsetof(struct mptcp_sched_ops, init),
>> +	offsetof(struct mptcp_sched_ops, release),
>> +	offsetof(struct mptcp_sched_ops, get_subflow),
>
> I think that the 'get_subflow' member should not be options. Otherwise
> the scheduler will useless, right ?!?
>
> Otherwise LGTM.
>

I agree - for this series (with the squashed get_subflow fix), looks good:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel

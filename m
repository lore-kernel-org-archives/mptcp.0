Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE710E9
	for <mptcp@lists.linux.dev>; Sat,  2 Apr 2022 00:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648860040; x=1680396040;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BNgXoZKvmclG6F2ZkYdjTlt++OatOQQMxynNHSCFl1s=;
  b=Zzv9t1m0bmUxwJVWNMVAyPv1KLmh2KZ1RrbjqNb3X5cWz8wIW7MoLO7H
   JuST0M1xAt8nplq74aE87GUKnSh+DXGMWsJIxWxi05gtW+XmeAZFmvpMO
   nZZPq3P4STrSu7CclXJetpf+K0W77W1gLKruo8QAVPWMNZf+5JhXYbrwe
   6bqu4j4DMCgx8NO9SNV5H2xDwPuW9Fv283mfQfSRyZ/MPL1jCPGR8X4wG
   N0ZBSvSNoHezfPKjC8wEmhQVuO9v5lM7LRuwu2FUdclb6yQmUoYShrTpM
   rsZCqftdAxBuOmpypzqTN9v+TRV/7JLvidLGdATi956xYgbbwzBEXsqjO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="323433440"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="323433440"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 17:40:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="504350302"
Received: from jchai-mobl1.amr.corp.intel.com ([10.252.135.241])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 17:40:39 -0700
Date: Fri, 1 Apr 2022 17:40:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 0/8] BPF packet scheduler
In-Reply-To: <20220330141211.GA345@localhost>
Message-ID: <326dd1ea-98f6-fa43-1f44-e66fadd6d9c8@linux.intel.com>
References: <cover.1648537203.git.geliang.tang@suse.com> <bf2b415d-a5f8-907c-9a55-d8b6d2c317b6@linux.intel.com> <20220330141211.GA345@localhost>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 30 Mar 2022, Geliang Tang wrote:

> Hi Mat & Matt,
>
> On Tue, Mar 29, 2022 at 04:13:02PM -0700, Mat Martineau wrote:
>>
>> On Tue, 29 Mar 2022, Geliang Tang wrote:
>>
>>> v8:
>>> - use global sched_list instead of pernet sched_list.
>>
>> Yes, I think this is fine. I had initially asked about pernet configuration
>> with respect to registering BPF schedulers, but the important thing is that
>> the sysctl can be set per-namespace.
>>
>>> - drop synchronize_rcu() in mptcp_unregister_scheduler().
>>> - update mptcp_init_sched and mptcp_release_sched as Mat and Florian
>>>   suggested.
>>> - fix the build break in patch 8.
>>> - depends on: "add skc_to_mptcp_sock" v14.
>>> - export/20220325T055307
>>
>> Thanks for updating. Builds and runs fine here.
>>
>> Before we add this to the export branch, have you thought about how subflow
>> data (including the backup bit and throughput/latency data used by the
>> default scheduler) can be accessed in the BPF get_subflow hook? Do you think
>> that can be cleanly added after this series, or is there anything that may
>> need to be changed in this series?
>
> I plan to do that in the next series, BPF round-robin scheduler.
>
> I had implemented round-robin in kernel before:
>
> https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.geliangtang@xiaomi.com/
>
> This time I plan to implement it using BPF.
>
> In order to support bpf_rr, I think we need to do two more things
> based on this series:
>
> 1. Get the subflow data from BPF, maybe iterate over the subflows
> from mptcp_sock.
>

Like we discussed in the meeting, I think a helper function that's 
callable from the BPF code could gather the necessary information from the 
subflows in a safe way.

> 2. Make same members of struct mptcp_sock writable in BPF, say
> last_snd, then we can set it like this:
>
>        msk->last_snd = ssk.

The kernel C code can record which subflow was used last based on the 
previous value returned by the scheduler, or a BPF scheduler could track 
data in a BPF map (I think - I'm not a BPF expert).

For something like last_snd to work, I think we need some way to identify 
subflows that's not the raw ssk pointer. Are there rules about pointer 
usage in BPF that we need to consider?

--
Mat Martineau
Intel

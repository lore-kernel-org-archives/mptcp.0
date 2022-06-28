Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC83FC2
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656438936; x=1687974936;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pqxN57D/3zyPJOGKPtL1DM8gygYaPEOAAL4HNhaotKk=;
  b=Sf75uzGQFAeVJaV/c/CBGp9zsBQPbYkA4EI7LRcjN/bgJ0o9zHYco3Gf
   ZbtxUqwY6fxkNwIwns9xMCkV2giBkpIxEhrt2fSgMfmXoJOzxbjL04j2R
   WBt7JeNZa7EzgGmnfD/cZId5qeSzuL27+gFgvaSy7hyHJl7pkC8q/ZL/g
   78VPzAlqTpE0IpM3f+yFtQLNb/zLaXFEF97qdKsDHKelIcrjaIsmwze1K
   LF0ZNHrmllvqlo/jbTmDlwOAZ3i9Q8AAGWcmn7YFGLGPUh/jPVJZMHxRI
   +tTyjJ+AG8JPD4/qCRk/I3guHxo0VrGeSRAdOPtiiRSbUCT5WC7PnKPe2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345804413"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="345804413"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 10:55:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="658221905"
Received: from hmok-mobl1.amr.corp.intel.com ([10.209.98.71])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 10:55:34 -0700
Date: Tue, 28 Jun 2022 10:55:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, pabeni@redhat.com
Subject: Re: [PATCH mptcp-next] Squash-to: "selftests: mptcp: tweak simult_flows
 for debug kernels"
In-Reply-To: <acfcb031-4be5-c5a2-6858-02fed78a89f3@tessares.net>
Message-ID: <edce75f6-48fc-7b40-af0-8a5410b19223@linux.intel.com>
References: <20220627214438.17887-1-mathew.j.martineau@linux.intel.com> <acfcb031-4be5-c5a2-6858-02fed78a89f3@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 28 Jun 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 27/06/2022 23:44, Mat Martineau wrote:
>> kbuild is still seeing intermittent failures in the simult_flows.sh
>> test. It uses a kernel config without kmemleak, but with other
>> performance-affecting debug options like lockdep and kasan.
>>
>> Example failures:
>> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_with_unbalanced_delay_transfer_slower_than_expected!_runtime_4339_ms_expected_4005_ms_max_4005.fail
>> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4285_ms_expected_4005_ms_max_4005.fail
>> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4346_ms_expected_4005_ms_max_4005.fail
>
> If I'm not mistaken, adding 200ms would not prevent these failures if
> you got 4346ms instead of 4005ms, right? It looks like we need to extend
> the time to something around 350ms.
>

I had thought the "slack" was calculated differently, but I think you're 
correct here. I am a little reluctant to increase the limit too far, since 
the whole point is to detect when the transfers become slower - and we 
seem to instead keep finding slower CI systems!

What do you think about this approach: make simult_flows.sh 'SKIP' when 
debug kernel features are detected, unless a "-f" flag forces it to run? 
That way we could run it with debug features where we know the system 
performance, like our CI, but not show bogus failures on random 
debug-enabled systems.


>> Adjust the debug detection to loosen the simult_flows timing constraints
>> if either kmemleak or lockdep are configured.
>
> Good idea!
> I didn't find any "safe" ways to easily check that KASAN is used.
>
> Checking dmesg doesn't seem to be a safe way for all environments.
>
> But maybe we could do this? (with '-q')
>
>  $ grep mm/kasan /sys/devices/system/cpu/hotplug/states/sys/devices
>  /system/cpu/hotplug/states:70:214: mm/kasan:online
>

How about:

grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\| prove_locking$' /proc/kallsyms

?

That detects the compiled-in features, rather than what's enabled at 
runtime, but it's simple and may be good enough.

--
Mat Martineau
Intel

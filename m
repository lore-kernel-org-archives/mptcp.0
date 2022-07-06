Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C8538F
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657127662; x=1688663662;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1NMyReduCNHcNtJtgRhccYYZb3yFNKWYiI06ObpSTYE=;
  b=MgRohjPvfRWCrKam0CrWo9Taq0vYxmI0TiBRwv+FjynNJtzi7HDrBj68
   7YaqwTTedKivMWiIbAEu0OB0u+BoeXGl50CkBY8OMeySxpcXV0ibEsrEi
   t9KV8xoriF5zlWfrvK3bJ6s5Qaoev/hRRrnyTMLzOQjeEj7s5ayHF5zhF
   ypJcG68z5oSkJVtY6V73Bp8q/AOK4//b14B1IF5rWo+xZThRxwIjHvp2d
   mGKW2f3aPlxmLsWqP5sCvUr8ncMPbN6Yi9cM3Gc/+TalqqbCC6hlt2Itb
   g0I32kulUeLLLYw4u2LDRTy011tFy9SoG8SINwLU9zRkmCh1QCebT4ZiM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="263602392"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="263602392"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:14:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="920256087"
Received: from lerosale-mobl.amr.corp.intel.com ([10.209.34.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:14:21 -0700
Date: Wed, 6 Jul 2022 10:14:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
    edumazet@google.com, fw@strlen.de, geliang.tang@suse.com, 
    matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net 0/7] mptcp: Path manager fixes for 5.19
In-Reply-To: <20220705180024.4196a2bf@kernel.org>
Message-ID: <a61724-7676-bf55-491a-9ea8599ca5a7@linux.intel.com>
References: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com> <20220705180024.4196a2bf@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 5 Jul 2022, Jakub Kicinski wrote:

> On Tue,  5 Jul 2022 14:32:10 -0700 Mat Martineau wrote:
>> The MPTCP userspace path manager is new in 5.19, and these patches fix
>> some issues in that new code.
>
> Two questions looking at patchwork checks:
>
> Is userspace_pm.sh not supposed to be included in the Makefile
> so that it's run by all the CIs that execute selftests?

Thanks for noticing that, we have a patch in process now to fix it.

>
> Is it possible to CC folks who authored patches under Fixes?
> Sorry if I already asked about this. I'm trying to work on refining
> the CC check in patchwork but I'm a little ambivalent about adding
> this one to exceptions.

Yes, I do try to do that. Note that Geliang changed his email address, so 
the check script flags his old address though he is cc'd. This is the 
recurring source of most of those red 'fail' blobs in patchwork for MPTCP 
series.

Does your script use the .mailmap file from the kernel repo? Maybe I can 
ask Geliang about adding an entry there.

(I did also forget to add my coworker Kishen to part of the series this 
time, sorry about that)

--
Mat Martineau
Intel

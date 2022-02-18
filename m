Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AE460E
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 00:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645144389; x=1676680389;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yQnHGoAd56d6AHfLMm0ipNb7ZnKvcd6ViJOl0N/EeqM=;
  b=BIunvregid/eWDcxZ6YYV/MCzyTOYbysE0drePPCOisfgmuMaq3FFDus
   rOZvhUEtAWoKMiHPxcCXva2AiVUP6bMdho0RzTfMysTcanPU3iV6AFtd8
   SGoZPQn6g9oQcXlXUd+nXcKQnGpsgITPGXU3uWJjI7tPJMt0sLWwvkFRr
   QJaueLxHLmnRJUBdsCnpFprWPL23JbloIxk9q49JtGufUPHJQEW494VNk
   EOTrTyXDUabumYI0GCQGFo4bpqjqENKNMpIdeR4hLysRnmT3nRqAmiJKs
   XJjTvX3xLFewCziuQbc6qmrBKFmfWZXlrD+U0uEd51T9Kuu2ssD74o/qJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="251211290"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="251211290"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 16:33:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="545984963"
Received: from pjayapal-mobl1.amr.corp.intel.com ([10.212.185.200])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 16:33:02 -0800
Date: Thu, 17 Feb 2022 16:33:02 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/9] Refactor mptcp_join.sh
In-Reply-To: <20220217174329.826430-1-matthieu.baerts@tessares.net>
Message-ID: <ffdf6780-5cc7-bde4-586e-eb36c7a409d@linux.intel.com>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 17 Feb 2022, Matthieu Baerts wrote:

> A few patches from the v1 have already been applied.
>
> Compared to the v1, this series comes with new patches and updated ones.
>
> Patch 1/9 was suggested by Paolo: bigger than the original one but following the
> standard way of using getopt. This is also clearer and avoid regexes.
>
> Patch 2/9: while working on patch 1/9, I was annoyed by having the tests groups
> defined multiple times. And I think it already happened to have missed the
> update of one of them :)
>
> Patch 3/9 is "safer" but also needed with the new options to execute specific
> tests.
>

Patches 1-3 look good to apply now:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> Patch 4/9 is the updated version of the previous patch 3/9 from v1: mainly
> rebased. I only added one line in the "usage()" function and use lower cases for
> only_tests variable.
>
> Patch 5/9 is new and similar to the previous patch: another way to execute a
> specific test, useful when using 'git blame'. Also help to have patch 6/9.
>

These are running fine for me, it's just the issue of 2000+ lines of churn 
and the potential (or even likely) net/net-next merge conflicts if we need 
to modify mptcp_join.sh after the 5.18 merge window. Hopefully all the 
work we're doing now to stabilize the tests means we will not have as many 
-net mptcp_join.sh changes in the next cycle, but we would still probably 
run in to some headaches. If we do apply these it would need to be right 
before net-next closes for 5.18.

Since you've put this much work into this patch it implies that you think 
the merge headaches would be worth it for the 5.18 development cycle :) 
For the way I use the test script the ability to test by number is not 
that critical - is anyone else (Paolo?) thinking you'll use this feature?


> Patch 6/9 is a handy feature when trying to find which tests had issues when
> executed on a CI or locally.
>

I like this! Highly dependent on previous patches though.

> Patch 7/9 was present in the v1. Non local variables have no longer been renamed
> + a there were a few missing 'local' keywords.
>

This seems a lot more manageable than v1, thanks.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> Patch 8/9 and 9/9 are the same as in v1 but rebased. We are still ShellCheck
> compliant.
>

These look good too:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> Matthieu Baerts (9):
>  Squash to "selftests: mptcp: join: allow running -cCi"
>  selftests: mptcp: join: define tests groups once
>  selftests: mptcp: join: reset failing links
>  selftests: mptcp: join: option to execute specific tests
>  selftests: mptcp: join: alt. to exec specific tests
>  selftests: mptcp: join: list failure at the end
>  selftests: mptcp: join: clarify local/global vars
>  selftests: mptcp: join: avoid backquotes
>  selftests: mptcp: join: make it shellcheck compliant
>
> .../testing/selftests/net/mptcp/mptcp_join.sh | 2248 +++++++++--------
> 1 file changed, 1202 insertions(+), 1046 deletions(-)
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel

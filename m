Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C610EF
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 01:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645752530; x=1677288530;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YPQC2BHSQMzvegULV2rP2YezkzxiwZA4QQ86NhT+Kz0=;
  b=TZNuP2h0EfSY+l+B6Mj70n73Or00Bmev0o73n4CgCcRUMI+7EcujpxWn
   mfJ27qguaDjQkBmywldUDlJgYxl1QGYuUAi8XV6fneWB1t5k46GvsEf8q
   1FORvjJwF5wE8HF0TICaMhjtT177LHcJJAbuLUEpvbxV2QqrlNn+cWhBf
   KmXLwzOT0vTGMNuG22ob67CtHIXkoUCbIf1BxNq83KxROBHjwE6TSG9gq
   dTnxFvep5HaFzZaD3GcCzUzkYtHlREXdM+WT0Jfchl3/9n4PjX6ZpJQrs
   Ce06ZIcAlXC45wLdy7VuLgmcyWR5VAYTx/MxcaJPe+gVqpf/J5goaPrwT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313111245"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="313111245"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:28:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="607614612"
Received: from haghighi-mobl.amr.corp.intel.com ([10.212.137.46])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:28:49 -0800
Date: Thu, 24 Feb 2022 17:28:49 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 00/12] Refactor mptcp_join.sh
In-Reply-To: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
Message-ID: <de693ebb-4db6-a624-1be1-9393c9fea0@linux.intel.com>
References: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 24 Feb 2022, Matthieu Baerts wrote:

> This fixes 3 issues introduced in v3:
>
> - patch 3/12 reworks more the original patch not to increment the counter
>  per subtest. See the commit message for more details.
>
> - patch 7/12 modifies the new 'reset' functions recently added
>
> - patch 12/12 fixes a typo reported by Geliang
>
> I also move "helper to filter TCP" patch sooner, before the clean-up.
>

Hi Matthieu -

Thanks for the update, you can add

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

to the commits that don't already have it. I looked through those just now 
and don't have more suggestions. Also runs fine in my test vm.

I'm looking at all the mptcp_join.sh patches queued up in the export... we 
might need to work together on some reordering to move the "not for 5.18" 
patches to the end of the queue.

-Mat


> Matthieu Baerts (12):
>  Squash to "selftests: mptcp: Add tests for userspace PM type"
>  Squash to "selftests: mptcp: join: allow running -cCi"
>  Squash to "selftests: mptcp: add implicit endpoint test case"
>  selftests: mptcp: join: define tests groups once
>  selftests: mptcp: join: reset failing links
>  selftests: mptcp: join: option to execute specific tests
>  selftests: mptcp: join: alt. to exec specific tests
>  selftests: mptcp: join: list failure at the end
>  selftests: mptcp: join: helper to filter TCP
>  selftests: mptcp: join: clarify local/global vars
>  selftests: mptcp: join: avoid backquotes
>  selftests: mptcp: join: make it shellcheck compliant
>
> .../testing/selftests/net/mptcp/mptcp_join.sh | 2451 +++++++++--------
> 1 file changed, 1307 insertions(+), 1144 deletions(-)
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel

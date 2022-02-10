Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109E2F20
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 00:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644452546; x=1675988546;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VAzVvWxUUCXnx7aB7vpWfISutoPJpOQ01AXXkEuk/ZI=;
  b=JT/+fvapT/b9jHD/UXoCs0pvxndRTsRfzx7vsDULFviO/31tR64W0SvN
   9nE+1yh+VvFKKfMUXO0RWu5YzkxoftyhaUf+DicXWoyGpa9xqGcYiGlXt
   YyeW2bzHTgmxn4efY4CD3eqgyqw8cTsDuORnvmAIIIus8vE29RKOm6Yq9
   te4k8sWzlSs8djrNjS8KQo+YTh0nVGm+3ddree9gASJ1FYG0g91L/2Bjg
   YPsIZ0v1h+1fMw4nnq/+vP7R8gI2GfyAnE+OhZNP7qUK3CxWS39QlXoqE
   Nun2OUNi2uTBUO18bRRE/OmLhmjwD5vLcQ7EVH+gu953U8UH5sSYldFGz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249128463"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="249128463"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:22:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="500189109"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:22:26 -0800
Date: Wed, 9 Feb 2022 16:22:25 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/9] Refactor mptcp_join.sh
In-Reply-To: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
Message-ID: <fc54b044-53bd-60ed-5aa0-6e1dc460ef8@linux.intel.com>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Feb 2022, Matthieu Baerts wrote:

> I started this series to be able to launch a specific test without
> having to modify the script to comment tests from the subgroup I didn't
> want to validate when trying to reproduce a specific issue in a loop.
> That's what we can find in patch 3/9.
>
> While at it, I:
> - fixed one issue with the options (patch 1/9)
> - stop if an option doesn't exist (patch 2/9)
> - removed unused vars (patch 4/9)
> - delay some actions to the first test not to do them if no test is
>  launched (patches 5-6/9)
>
> But after having seen all modified lines, why stopping there? So I:
> - clarify local vs global variables to avoid Bash's classical pitfall
>  (patch 7/9)
> - fixed all issues reported by ShellCheck except one (patch 8-9/9)
>
> These last 3 patches (+ patch 3/9) will create a lot of conflicts. If
> we are OK with them, probably best not to wait to long before applying
> them to avoid big rebases.

I think 1, 2, 4, 5, and 6 look good for the export branch now:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

I don't have changes to suggest for 7-9, but I think it's worth talking 
about how to manage conflicts considering the scope of those. I think it 
would make sense to send those to net-next fairly late in the development 
cycle, to avoid net/net-next conflicts if we send mptcp_join.sh fixes to 
-net.

To deal with that, I see a couple of options:

1. Keep these at the end of the topgit queue to help with that, but that 
makes it harder to send other mptcp_join.sh patches for mptcp-net or 
mptcp-next.

2. You update them out-of-tree until close to the 5.17 release

What do you think? Might be a good meeting topic too.


I have some other questions I'll ask in a patch 3 reply.


>
> For the patches that are already in review, I can fix the conflicts when
> applying them.
>
> Matthieu Baerts (9):
>  selftests: mptcp: join: allow running -cCi
>  selftests: mptcp: join: exit after printing usage
>  selftests: mptcp: join: option to execute specific tests
>  selftests: mptcp: join: remove unused vars
>  selftests: mptcp: join: create tmp files only if needed
>  selftests: mptcp: join: check for tools only if needed
>  selftests: mptcp: join: clarify local/global vars
>  selftests: mptcp: join: avoid backquotes
>  selftests: mptcp: join: make it shellcheck compliant
>
> .../testing/selftests/net/mptcp/mptcp_join.sh | 2342 +++++++++--------
> 1 file changed, 1257 insertions(+), 1085 deletions(-)
>
> -- 
> 2.34.1

--
Mat Martineau
Intel

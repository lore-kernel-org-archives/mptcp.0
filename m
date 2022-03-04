Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1E7C
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 04:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646367347; x=1677903347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LNwa19bKg6/lIBc+0UP/M190jOHaRoqihF1ei1VoFt4=;
  b=Tns77BFsKy8iamMapbqRFA8p7YRqxm1DRAdOVkzCoQ89/fvCMcrp40+Y
   6dvyF3CYXsA/jvDFxPu6qIxroCa4YSz/FBoZdlGlZ9V9izemUQadh/xqG
   XX+vZLOFI0Fr4aNHvZ6406N6p1j/NZeKAAFZtN8frRPvxM20YuMDYTu7I
   E8cGYPumQrmAH32duKZobHo0JXFsa+Ng2hmqr8Cu+4hrL7L81d5fQS6um
   urjoMVII1gXeOr6MqOaM41tlW0SgEn6Uimq1m9FfY+kktLK4mzJQz6f3J
   LG5gD1M4cju9CYP3ZOArD6aiJHIiLLLMX4+7rQN5tehsRBZXhNKTf0RYM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253620776"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="253620776"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 20:15:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="710198675"
Received: from gmconkli-mobl.amr.corp.intel.com ([10.209.72.243])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 20:15:46 -0800
Date: Thu, 3 Mar 2022 20:15:46 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Reordered MPTCP export branch
Message-ID: <5b92e547-12d6-91e0-6636-e98b3dffa27@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi Matthieu,

I pushed the reordered export branch to:

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git

Branch: mptcp-reorder-export (da80d856dc17)

'git diff' shows that the state at the head of the branch is identical to 
the export branch (rebased on net-next). I also checked out the last 
"net-next" commit and confirmed that mptcp_join.sh ran as expected.


Compared to export/20220303T054913, I did the following:

  * Rebased on net-next (which had the -net tree merged today). There was a 
minor conflict in the bpf commits that made the "Update TopGit Tree" 
action fail when I manually started it today, which I resolved.

  * Moved the userspace PM commits and the MP_FAIL / infinite fallback 
patches after all the net-next patches I expect to upstream in the next 
week. There were quite a few mptcp_join.sh conflicts to figure out.

  * However, I left "selftests: mptcp: add invert check in check_transfer" 
earlier in the patch series to reduce conflicts with the mptcp_join.sh 
refactor patches.

  * Added a "net-next-next" marker commit


--
Mat Martineau
Intel

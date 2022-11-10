Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95B1E9F8
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 23:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668122609; x=1699658609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DXf5eMO6iRwbWYmQJIa81skpLlE5bGQYMONe31ftIqw=;
  b=WeuI9xmcO6ICsUJOG2r0IWF+C12piONXAepIPUHVcUCJwVEeKjVQC/Ko
   bePgVzm4blLd5b8HJMwhAF2XFAw7NWh7VJpt6wZnkLb1tqoJWmEAEBLNF
   q5xvPByXv1nVMXkfcXPXFVeXCqeIKLIV2eKIrmT11hCIpDJcha7nt1EAx
   ZDiYzqKqXqIZBrDdLoGEwSVNJAuvhOkEjb2UmTd5BRsg0QPVizHOoIZn0
   1K3nnMjdD5IGmtSLuW0fHRI3hwKG7DglUex9UMdlAYzt2rJbTblclcA/7
   awLeYjfKJbV5IzyrVzMYpDZhEPOFC4ZddrD2WakCohD3oJx1xWfEaybee
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373594067"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="373594067"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:23:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="637367368"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="637367368"
Received: from jsandova-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.81.89])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:23:29 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/5] mptcp: Miscellaneous refactoring and small fixes
Date: Thu, 10 Nov 2022 15:23:17 -0800
Message-Id: <20221110232322.125068-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1-3 do some refactoring to more consistently handle sock casts,
and to remove some duplicate code. No functional changes.

Patch 4 corrects a variable name in a self test, but does not change
functionality since the same value gets used due to bash's 
scoping rules.

Patch 5 rewords a comment.

Geliang Tang (4):
  mptcp: use msk instead of mptcp_sk
  mptcp: change 'first' as a parameter
  mptcp: get sk from msk directly
  selftests: mptcp: use max_time instead of time

Mat Martineau (1):
  mptcp: Fix grammar in a comment

 net/mptcp/pm_userspace.c                      |  4 +--
 net/mptcp/protocol.c                          | 34 +++++++------------
 net/mptcp/sockopt.c                           |  4 +--
 net/mptcp/token.c                             |  4 +--
 .../selftests/net/mptcp/simult_flows.sh       |  4 +--
 5 files changed, 21 insertions(+), 29 deletions(-)


base-commit: c1b05105573b2cd5845921eb0d2caa26e2144a34
-- 
2.38.1


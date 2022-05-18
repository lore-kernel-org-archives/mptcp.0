Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3FD23A3
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652911491; x=1684447491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AaYAfdtSFmamX2nqp1xAEEDOlvserQ8afZnPYHX55DI=;
  b=jm+DirzQcB4q0xm9Aa9BsRzj7A7CWSb9LtFJMt45kSkzVP60HFHpd1uY
   FzSPiCNfScij5FmPO0xcdFbaP8hfkF8FjhOMe1OdutI/JjDRDQeh+wxp/
   Y56/SSZKoQPa/tEwOJGdi0U5+OImSeosto2RdTR8trWAncFAe7MRqTHfk
   /yjnsy9bYFNIFzRAgNVBIq4rL0YtPaBLSabKhva2POfh1k9SmxWzDipzW
   2xBkwoplBPR2D7iMwaq8WEEidPfyyPuAWhOrBXjTRr6nYoHWtdV0PyLeh
   KzsuLw4X8PMUvPMIP5eAU8IyTYTJGp86tVo54uzfVdmIa94rqMQOQ1paB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271865359"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="271865359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 15:04:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="598075431"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 15:04:51 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/4] mptcp: Miscellaneous fixes and a new test case
Date: Wed, 18 May 2022 15:04:42 -0700
Message-Id: <20220518220446.209750-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 3 remove helpers that were iterating over the subflow
connection list without proper locking. Iteration was not needed in
either case.

Patch 2 fixes handling of MP_FAIL timeout, checking for orphaned
subflows instead of using the MPTCP socket data lock and connection
state.

Patch 4 adds a test for MP_FAIL timeout using tc pedit to induce checksum
failures.

Geliang Tang (1):
  selftests: mptcp: add MP_FAIL reset testcase

Mat Martineau (2):
  mptcp: Check for orphaned subflow before handling MP_FAIL timer
  mptcp: Do not traverse the subflow connection list without lock

Paolo Abeni (1):
  mptcp: stop using the mptcp_has_another_subflow() helper

 net/mptcp/pm.c                                  |  9 +++------
 net/mptcp/protocol.c                            | 16 +---------------
 net/mptcp/protocol.h                            | 14 --------------
 net/mptcp/subflow.c                             | 15 +++++----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
 5 files changed, 19 insertions(+), 45 deletions(-)


base-commit: a3641ca416a3da7cbeae5bcf1fc26ba9797a1438
-- 
2.36.1


Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6552FAF
	for <mptcp@lists.linux.dev>; Fri, 27 Aug 2021 00:45:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="198108894"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="198108894"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 17:45:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="599007122"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.68.199])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 17:45:00 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com
Subject: [PATCH net-next 0/5] mptcp: Optimize received options handling
Date: Thu, 26 Aug 2021 17:44:49 -0700
Message-Id: <20210827004455.286754-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches optimize received MPTCP option handling in terms of both
storage and fewer conditionals to evaluate in common cases, and also add
a couple of cleanup patches.

Patches 1 and 5 do some cleanup in checksum option parsing and
clarification of lock handling.

Patches 2 and 3 rearrange struct mptcp_options_received to shrink it
slightly and consolidate frequently used fields in the same cache line.

Patch 4 optimizes incoming MPTCP option parsing to skip many extra
comparisons in the common case where only a DSS option is present.


Paolo Abeni (5):
  mptcp: do not set unconditionally csum_reqd on incoming opt
  mptcp: better binary layout for mptcp_options_received
  mptcp: consolidate in_opt sub-options fields in a bitmask
  mptcp: optimize the input options processing
  mptcp: make the locking tx schema more readable

 net/mptcp/options.c  | 141 +++++++++++++++++++------------------------
 net/mptcp/protocol.c |  14 +++--
 net/mptcp/protocol.h |  36 ++++++-----
 net/mptcp/subflow.c  |  40 ++++++------
 4 files changed, 112 insertions(+), 119 deletions(-)


base-commit: deecae7d96843fceebae06445b3f4bf8cceca31a
-- 
2.33.0


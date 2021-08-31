Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8472
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 17:19:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="205751462"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="205751462"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 10:19:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="690094684"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.180.246])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 10:19:32 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com
Subject: [PATCH net v2 0/2] mptcp: Prevent tcp_push() crash and selftest temp file buildup
Date: Tue, 31 Aug 2021 10:19:24 -0700
Message-Id: <20210831171926.80920-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are two fixes for the net tree, addressing separate issues.

Patch 1 addresses a divide-by-zero crash seen in syzkaller and also
reported by a user on the netdev list. This changes MPTCP code so
tcp_push() cannot be called with an invalid (0) mss_now value.

Patch 2 fixes a selftest temp file cleanup issue that consumes excessive
disk space when running repeated tests.


v2: Make suggested changes to lockdep check and indentation in patch 1


Matthieu Baerts (1):
  selftests: mptcp: clean tmp files in simult_flows

Paolo Abeni (1):
  mptcp: fix possible divide by zero

 net/mptcp/protocol.c                          | 76 +++++++++----------
 .../selftests/net/mptcp/simult_flows.sh       |  4 +-
 2 files changed, 37 insertions(+), 43 deletions(-)


base-commit: 57f780f1c43362b86fd23d20bd940e2468237716
-- 
2.33.0


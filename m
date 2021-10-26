Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34B2CA8
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 23:29:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227493934"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="227493934"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 16:29:21 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="597124825"
Received: from jdweinst-mobl2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.54.246])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 16:29:21 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	pabeni@redhat.com,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/4] mptcp: Rework fwd memory allocation and one cleanup
Date: Tue, 26 Oct 2021 16:29:12 -0700
Message-Id: <20211026232916.179450-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches from the MPTCP tree rework forward memory allocation for
MPTCP (with some supporting changes in the net core), and also clean up
an unused function parameter.


Patch 1 updates TCP code but does not change any behavior, and creates
some macros for reclaim thresholds that will be reused in the MPTCP
code.

Patch 2 adds sk_forward_alloc_get() to the networking core to support
MPTCP's forward allocation with the diag interface.

Patch 3 reworks forward memory for MPTCP.

Patch 4 removes an unused arg and has no functional changes.


Geliang Tang (1):
  mptcp: drop unused sk in mptcp_push_release

Paolo Abeni (3):
  tcp: define macros for a couple reclaim thresholds
  net: introduce sk_forward_alloc_get()
  mptcp: allocate fwd memory separately on the rx and tx path

 include/net/sock.h   |  20 +++-
 net/ipv4/af_inet.c   |   2 +-
 net/ipv4/inet_diag.c |   2 +-
 net/mptcp/protocol.c | 234 ++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  15 +--
 net/sched/em_meta.c  |   2 +-
 6 files changed, 120 insertions(+), 155 deletions(-)


base-commit: 06338ceff92510544a732380dbb2d621bd3775bf
-- 
2.33.1


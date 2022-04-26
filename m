Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05E33C3
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651010244; x=1682546244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UKn5ULvisIai/X6auQ0IUQyugeeIAu6qCezwwW+QMj4=;
  b=DrVVv9ob2RWT+/1cwY6tHWo2cCo+XOq8VTKMtgOv3ysWQlxUMFBCU8lR
   HfxYFtv34Q8Oa9h1ihPGwQpFjYSMWzWhanFPQE3244iIMIOfZeVo0NRxN
   LI/oRxAYBQ6aaVYohLKxu90jm326WlcEBBkvYh2lGp5vnS8ou6A7e8Eq8
   FQ+WoU6TzO1Xz/yO1JH4hqoQu6K7rQQcu+mzBzx+spV4O1JJvTt7ht/D0
   EKjO/IKcugrcoU1MPvJr0YvQgvQAo9tRscFigxn3B3xSWl6hUFr5rj2Pe
   KETD3GLfaXYvT/WhLXJgXTXSujLpiaulbyjzNyPY66qHpUyqWqHlwBg4w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326222708"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326222708"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532878093"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.10.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/7] mptcp: Timeout for MP_FAIL response
Date: Tue, 26 Apr 2022 14:57:10 -0700
Message-Id: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When one peer sends an infinite mapping to coordinate fallback from
MPTCP to regular TCP, the other peer is expected to send a packet with
the MPTCP MP_FAIL option to acknowledge the infinite mapping. Rather
than leave the connection in some half-fallback state, this series adds
a timeout after which the infinite mapping sender will reset the
connection.

Patch 1 adds a fallback self test.

Patches 2-5 make use of the MPTCP socket's retransmit timer to reset the
MPTCP connection if no MP_FAIL was received.

Patches 6 and 7 extends the self test to check MP_FAIL-related MIBs.

Geliang Tang (7):
  selftests: mptcp: add infinite map testcase
  mptcp: use mptcp_stop_timer
  mptcp: add data lock for sk timers
  mptcp: add MP_FAIL response support
  mptcp: reset subflow when MP_FAIL doesn't respond
  selftests: mptcp: check MP_FAIL response mibs
  selftests: mptcp: print extra msg in chk_csum_nr

 net/mptcp/pm.c                                |  18 ++-
 net/mptcp/protocol.c                          |  64 +++++++++-
 net/mptcp/protocol.h                          |   2 +
 net/mptcp/subflow.c                           |  13 ++
 tools/testing/selftests/net/mptcp/config      |   8 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 119 +++++++++++++++++-
 6 files changed, 216 insertions(+), 8 deletions(-)


base-commit: 561215482cc69d1c758944d4463b3d5d96d37bd1
-- 
2.36.0


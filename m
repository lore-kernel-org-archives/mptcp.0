Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0B3C00
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 19:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657566999; x=1689102999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t9wX0QlDLudHj5GUjPvRfRHzgwKh9jkuWBj8FrotkrE=;
  b=N7LQkII1vQn7fgpznGGoqlipImXwbCUg0X9Tqv9XcbMHpukDVTiUrFPL
   b4zvOE8FGGr4XoKt3WxO8J4l2/SnOTLwMsPH5LTy72BmvfY10dplVcyMy
   kWwmeTp5Yi+7u2zuV0sHTIhrf6iWQOe5/Qb+yYVyt/TU9H7h3WZFAmWZo
   SFyDCVy9GbiqSWE9E/w+i5ES73OJDXZn7imE0Ob2ct+wPLcW4+Vw9QN7D
   KgRA8jCjBHuLNFcKty18cyCJoO95EpenLNspX/5T7ZNh58YBkZRwDJL+o
   yoVNOD6JmQ9NXI/ZSUCelsTRnbNDlqaQ56rO/1EnG/NL/I7rZaFUNjFbf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284775352"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="284775352"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="697742708"
Received: from eedeets-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.2.111])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:37 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/5] mptcp: Support changes to initial subflow priority
Date: Mon, 11 Jul 2022 12:16:28 -0700
Message-Id: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates the in-kernel MPTCP path manager to allow changes to
subflow priority for the first subflow created for each MPTCP connection
(the one created with the MP_CAPABLE handshake).

Patches 1 and 2 do some refactoring to simplify the new functionality.

Patch 3 introduces the new feature to change the initial subflow
priority and send the MP_PRIO header on that subflow.

Patch 4 cleans up code related to tracking endpoint ids on the initial
subflow.

Patch 5 adds a selftest to confirm that subflow priorities are updated
as expected.


Paolo Abeni (5):
  mptcp: introduce and use mptcp_pm_send_ack()
  mptcp: address lookup improvements
  mptcp: allow the in kernel PM to set MPC subflow priority
  mptcp: more accurate MPC endpoint tracking
  selftests: mptcp: add MPC backup tests

 net/mptcp/pm_netlink.c                        | 129 ++++++++++--------
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  30 ++++
 4 files changed, 105 insertions(+), 58 deletions(-)


base-commit: edb2c3476db9898a63fb5d0011ecaa43ebf46c9b
-- 
2.37.0


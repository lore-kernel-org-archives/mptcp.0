Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDB7B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 22:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656542155; x=1688078155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m6ajbUP2i/fVbhjQoW6AbH2CFFOYlzVGRGdFfRWlP0I=;
  b=IFWVce8oY+XUDc410W9KI3k+na/opGsu3pZdVr024ZnGEB4VrMJzdvtm
   7wzTGT34QSXfRiCfHZZmQdknOsnbZlY739P8H4SS2qJ8w0WDrrN0q21h5
   z9ENSb7kuOaP4s3/UOPSZwjbEQelNrZ/uCvVezo58iBtiNNs5qcQlc0rr
   S9U6RHnt7pLk0goZVQUDKRCX05g5ccnL4tL+JnV2jFh98saYPAgCYuicG
   BhHyN1EMiMZn7vxpuwQVdhSFA62fW4BfTQKtsd/IzBDqM4RWub1u/3fSu
   0G37xNNB+X5JHIzJ/MR2wxsPuN9E5WcHaoZtyPkoboy59DOMg4hW22Uno
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282214123"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="282214123"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:35:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="718005995"
Received: from divyamar-mobl2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.13.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:35:54 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net v2 0/2] Locking fixes for subflow flag changes
Date: Wed, 29 Jun 2022 15:35:48 -0700
Message-Id: <20220629223550.655928-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working with Kishen on the userspace PM, the locking code in
mptcp_pm_nl_mp_prio_send_ack() caught my attention. The
release-and-reacquire of the PM lock in that function was requiring the
userspace PM code to grab that lock, even though nothing protected by
that lock was being accessed. Patch 1 addresses this.

While investigating that issue, I realized that
mptcp_pm_nl_mp_prio_send_ack() was not holding the subflow socket lock
while modifying several parts of the subflow context. Patch 2 addresses
this, and is not a drastic change since the subflow lock was being
acquired anyway in mptcp_subflow_send_ack().

v1->v2: Based on Paolo's feedback, fix MIB issue with atomic context in
patch 1 (tested with CONFIG_PREEMPT), and squash patches 2 & 3.


Mat Martineau (2):
  mptcp: Avoid acquiring PM lock for subflow priority changes
  mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags

 net/mptcp/options.c    |  2 ++
 net/mptcp/pm_netlink.c | 12 ++++++------
 net/mptcp/protocol.c   |  9 +++++++--
 net/mptcp/protocol.h   |  1 +
 4 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.36.1


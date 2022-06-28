Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298F7A
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656443057; x=1687979057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gCf3bmm3Pk0fTzuvQ8ZdYjaSwW60ysiLB9qzJPMH10Q=;
  b=hoYHZ4ijyNRlb1n4+HhiZ2q3n/Hvfs0Freec60X8cyyE7E0j7X5cz6lB
   607v/A8sq5VZNfVa0+JGfYTkiKogK7qmg3q8k+jesoJnpOQ4PgJrAil6/
   9mUOsALyXr4iExYrKKqfZdFW31/85mLDco/CAgvUZOS/ZbG0wDpBhAklI
   Ov++9UZu8phui8BOOx2tKNJKeOCg9kUkY/g6jGJ6H661+8xgnN84rf78v
   758AxTeWpvgkPUxUoHtKD5QcMTQV+r2PHqA2JawAxnL8/PgeE4vh9hYdV
   lc9R5+g4WFW+f1rHxblRpkDVpUO8Bhcpp6Ij+GWOBr1p1QSQ7k0SvlVW6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343514644"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="343514644"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:04:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="917294946"
Received: from gwbruss-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.112.228])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:04:00 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net 0/3] Locking fixes for subflow flag changes
Date: Tue, 28 Jun 2022 12:03:53 -0700
Message-Id: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
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
while modifying several parts of the subflow context. Patch 3 addresses
this, and is not a drastic change since the subflow lock was being
acquired anyway in mptcp_subflow_send_ack(). Patch 2 is a prerequisite
patch adding a __mptcp_subflow_send_ack() helper to use in patch 3 when
the subflow is already locked.

Mat Martineau (3):
  mptcp: Avoid acquiring PM lock for subflow priority changes
  mptcp: Add a variant of mptcp_subflow_send_ack() for locked subflows
  mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags

 net/mptcp/pm_netlink.c | 11 ++++++-----
 net/mptcp/protocol.c   |  9 +++++++--
 net/mptcp/protocol.h   |  1 +
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.37.0


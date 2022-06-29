Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEC7B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 22:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656543212; x=1688079212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bqTAkgqh0WVlbVhelMJLEBN7QiYcWPwpe1iBWkW+tt4=;
  b=Ho30Qwh6UMCFyu2aPsfrNTMWi/Y0DmVxHDibhzXyOZhArb24VxBrnB2o
   c0tFcNury1s402QNeVyyJ0CUmGwfqox9k5U1RHAIZP6MelgQ6ZQgAuBUK
   FTmBUr5x9VE2B7k5bRCzv3PtHZaZHlPHDZGUxEOwlyjaxQQnZiqaJp+cV
   /ui1EOO1KILGvPGUuEGSo36hdB9IgU8VerVwYAd4LeCqbusb218zbtqj3
   I0Yt8C+PPXp//Kh8GMUh2l8AvLsHRalSrRMGD92IqNYUomGCrTFMQBVPu
   JIaugT2ugpYKs1UWvKJdO8rdXLBvkDD/SlSiqoGSAqFsmG/OV3QNlZvBU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="368498781"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="368498781"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:53:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="917796272"
Received: from divyamar-mobl2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.13.211])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:53:31 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net v3 0/2] Locking fixes for subflow flag changes
Date: Wed, 29 Jun 2022 15:53:25 -0700
Message-Id: <20220629225327.657202-1-mathew.j.martineau@linux.intel.com>
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

v2->v3: Fix build error

v1->v2: Based on Paolo's feedback, fix MIB issue with atomic context in
patch 1 (tested with CONFIG_PREEMPT), and squash patches 2 & 3.


Mat Martineau (2):
  mptcp: Avoid acquiring PM lock for subflow priority changes
  mptcp: Acquire the subflow socket lock before modifying MP_PRIO flags

 net/mptcp/options.c    |  3 +++
 net/mptcp/pm_netlink.c | 13 ++++++-------
 net/mptcp/protocol.c   |  9 +++++++--
 net/mptcp/protocol.h   |  1 +
 4 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.37.0


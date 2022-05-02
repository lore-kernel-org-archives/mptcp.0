Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1B2F56
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 20:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651524764; x=1683060764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sqqmemZ/5L+jEE02qzBX7TEd2cH2QoD6+mOw1SFfd2E=;
  b=MBf20KytANhAZ0SaXnfveaXsPL41d51mF1q+Vlbaa2sAw1Wh++R6ESH/
   Yz5xW3UkeZ6F3f/H5O/gazNiFJcwPIewJUYP5K6IFvvJRgFtq9tRCcqfs
   nN3haBM60P5RUrlW4A2XcolJo3zKgKEJj9p8zGmFxlZsAtfDAa2n7U505
   mvIN3vhqpncgbu7Kv2S5yXeBQ/DHjgGmxAQulXwfj5/0+cNK1kX0YE09I
   pd2ESKLWCooKGIJGW+bru1rBxubLNifTbShQd7sBLNeeH1Imu8NDN696E
   7WdTMHL19JoJiNjhK46uQL23Q364rE1RGDsXi2l43UTAq9PrwsY43UlrO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247875179"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247875179"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="733619564"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.141.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/7] mptcp: Userspace path manager prerequisites
Date: Mon,  2 May 2022 13:52:30 -0700
Message-Id: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series builds upon the path manager mode selection changes merged
in 4994d4fa99ba ("Merge branch 'mptcp-path-manager-mode-selection'") to
further modify the path manager code in preparation for adding the new
netlink commands to announce/remove advertised addresses and
create/destroy subflows of an MPTCP connection. The third and final
patch series for the userspace path manager will implement those
commands as discussed in
https://lore.kernel.org/netdev/23ff3b49-2563-1874-fa35-3af55d3088e7@linux.intel.com/#r

Patches 1, 5, and 7 remove some internal constraints on path managers
(in general) without changing in-kernel PM behavior.

Patch 2 adds a self test to validate MPTCP address advertisement ack
behavior.

Patches 3, 4, and 6 add new attributes to existing MPTCP netlink events
and track internal state for populating those attributes.


Kishen Maloor (6):
  mptcp: bypass in-kernel PM restrictions for non-kernel PMs
  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
  mptcp: reflect remote port (not 0) in ANNOUNCED events
  mptcp: establish subflows from either end of connection
  mptcp: expose server_side attribute in MPTCP netlink events
  mptcp: allow ADD_ADDR reissuance by userspace PMs

Mat Martineau (1):
  selftests: mptcp: ADD_ADDR echo test with missing userspace daemon

 include/uapi/linux/mptcp.h                    |  1 +
 net/mptcp/options.c                           |  4 +--
 net/mptcp/pm.c                                | 21 ++++++++---
 net/mptcp/pm_netlink.c                        | 36 ++++++++++++++++---
 net/mptcp/protocol.c                          |  5 +--
 net/mptcp/protocol.h                          | 18 +++++++---
 net/mptcp/subflow.c                           |  5 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++
 8 files changed, 81 insertions(+), 20 deletions(-)


base-commit: 0decb97cb105e85be979432bfc17491df7c6d6d1
-- 
2.36.0


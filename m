Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10542F26
	for <mptcp@lists.linux.dev>; Sat,  5 Feb 2022 00:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644019424; x=1675555424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=88fpml2V3bTkfhWRV3yeGOzte+HGrWElZ3H3z2OSIYM=;
  b=Vi49I1URI/inky3+8qav/s1wiBd5Hfw8+iW0HluNkpLJq7an4jvTBC0E
   h5P8sZCc0anYirMfSpo4Wbk2PFBRvTTJdrNPY/7XIb4T1clYEKDK7tBr1
   ADWcds3DQEpsdCIJTrmGkVHxxutSrItM8S6ke781JfrVAItCQDhNgP/xZ
   GV1gYd88rZDYyK96mhm/MIbwKuszU4WdiipgK+A1bKeJT8e1pvCTSGVLt
   2F8ZfCH7GOh8oUd+L3H0dtY/wCcpEt+BGfuDFPfk97+8kF/lawf722aVW
   9HlBHgyv021u8ENUpEhhpX4V4P//G1jSRtfOs5mNFWWG09KZCcfBdvqDV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248678277"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248678277"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="770097511"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.231.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:42 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/9] mptcp: Improve set-flags command and update self tests
Date: Fri,  4 Feb 2022 16:03:28 -0800
Message-Id: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1-3 allow more flexibility in the combinations of features and
flags allowed with the MPTCP_PM_CMD_SET_FLAGS netlink command, and add
self test case coverage for the new functionality.

Patches 4-6 and 9 refactor the mptcp_join.sh self tests to allow them to
configure all of the test cases using either the pm_nl_ctl utility (part
of the mptcp self tests) or the 'ip mptcp' command (from iproute2). The
default remains to use pm_nl_ctl.

Patches 7 and 8 update the pm_netlink.sh self tests to cover the use of
endpoint ids to set endpoint flags (instead of just addresses).

Geliang Tang (9):
  mptcp: allow to use port and non-signal in set_flags
  selftests: mptcp: add the port argument for set_flags
  selftests: mptcp: add backup with port testcase
  selftests: mptcp: add ip mptcp wrappers
  selftests: mptcp: add wrapper for showing addrs
  selftests: mptcp: add wrapper for setting flags
  selftests: mptcp: add the id argument for set_flags
  selftests: mptcp: add set_flags tests in pm_netlink.sh
  selftests: mptcp: set ip_mptcp in command line

 net/mptcp/pm_netlink.c                        |  13 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 877 +++++++++++-------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  18 +
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  75 +-
 4 files changed, 595 insertions(+), 388 deletions(-)


base-commit: c531adaf884d313df2729ca94228317a52e46b83
-- 
2.35.1


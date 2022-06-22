Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2DC1869
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655921866; x=1687457866;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V+KSsvre4mbOxuw/kCbAq/IfooRtWKOszyEQaFEodFU=;
  b=Rg7LioBpXM10pICQSHBNwZ96MQbyDGPUFYM84W2fJwgGGdIlntykZD41
   s66yWPOq/T5WW1sVICKgv61n5A3O1HNtJT9nyY81yUPNZJxuZ9463OKsN
   dWFBPUYIeOySiLVMM0SYZCXcuZGLkGotsB0XxkOtVjrF/f8p+hr2MWxDT
   3ZLC7qhCD0oDn9pfHHOIaz/JqwhkzgEGorUOEqGhwuW3ixnK+dxCz9xJi
   9E/56BmkMnG227GvxxL7qEmwMaxFridIKwABUmacFedVgq5g8UBiiSi6A
   HQmPqBbjCd16V419IstumbMUm5pve8faZImiwZxE9vcoIkYo3c6o/FCkK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344490529"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="344490529"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:55:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592302695"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:55:53 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/2] mptcp: support MP_PRIO signals with userspace PMs
Date: Wed, 22 Jun 2022 13:55:45 -0400
Message-Id: <20220622175547.289717-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
to issue MP_PRIO signals for a specified address ID over a chosen
MPTCP connection. It also adds self testing support for this change.

Kishen Maloor (2):
  mptcp: netlink: issue MP_PRIO signals from userspace PMs
  selftests: mptcp: userspace PM support for MP_PRIO signals

 net/mptcp/pm_netlink.c                        | 23 ++++++++++----
 net/mptcp/pm_userspace.c                      | 30 ++++++++++++++++++
 net/mptcp/protocol.h                          |  6 +++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 ++++++++++--
 .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++++++++++++++
 5 files changed, 100 insertions(+), 9 deletions(-)


base-commit: 68fec8b7f640037e4bf224ca4e924574098f5911
--
2.31.1

Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF21366
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655945994; x=1687481994;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s7KaGia0AEx88pV6UrCzO54spR2QUWqSRNfBZvVoQ9o=;
  b=OQDZsKA3ikorDSdggbRPCYJMmakd1s7Z5TT/7YpmB5PP3hm1nmTEZcAq
   MQDfG1fnx5uJjmDi+KOULXcv70/FjjCog1QR6xjPXGhQfj9oVRFpbenuS
   7AeuAUFFWcBNyb9QSPMjUH2FO9YZ9fLy/Qz0h76papiM2yhXvToagVTSs
   +3kOlHxCm8MYFAtZOpz3d+6GCuBHXINTOc7ZpVAAs/m1mzGVpZZ4f3McP
   L2cytvjGEBWwXTCOOh7T8k074JI7+FLutIXSuiK3X+/+tS+nFjG89aOX2
   TPC9UJKT5jN115S8Cqp96yLmT1tNo8D3P7h2DVmdp8yNSfH1V92NGaR2h
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278137858"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="278137858"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:59:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="914950192"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:59:53 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/2] mptcp: support MP_PRIO signals with userspace PMs
Date: Wed, 22 Jun 2022 20:59:46 -0400
Message-Id: <20220623005948.291792-1-kishen.maloor@intel.com>
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

v2:
-userspace_pm.sh: added a sleep after issuing the MP_PRIO signal.

Kishen Maloor (2):
  mptcp: netlink: issue MP_PRIO signals from userspace PMs
  selftests: mptcp: userspace PM support for MP_PRIO signals

 net/mptcp/pm_netlink.c                        | 23 +++++++++----
 net/mptcp/pm_userspace.c                      | 30 +++++++++++++++++
 net/mptcp/protocol.h                          |  6 +++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 +++++++++--
 .../selftests/net/mptcp/userspace_pm.sh       | 32 +++++++++++++++++++
 5 files changed, 101 insertions(+), 9 deletions(-)


base-commit: 68fec8b7f640037e4bf224ca4e924574098f5911
--
2.31.1

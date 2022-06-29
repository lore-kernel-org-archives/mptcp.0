Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A637B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 01:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656466028; x=1688002028;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MZWu0ciHEVago9T+mNL6WwICfTET5fgkSNf3cOHLflk=;
  b=DuW9grmAL0mGK0+2pBBFaITcoyetm1YXKch8+0d6OkmPuSFZniB+T2LE
   8B0bs8IcmZUQ1DMtK6VIpm8hYNdBL8E0YhWLMrar05/lrBTD8y/eeObLC
   FPGtNqrE1y4UyskBo9E0gnw7hbY7OCFiRXzO6tvLMYP8zWnMAuXfkIKVg
   Y3ndhJES8p/nV8vNrnjO8mgzwga7oWIuo8B3F2j6ZJAxk7zVmCPf4hc1J
   zbauEFrVKnGGTDtAJmZpVAh/dLix1ElkjqCHIybknDyqRUBqosmR7CJUp
   dHpr0w/Rj54l55r9cBERaXqd5df6faOtOdJU3LyLB+O3QnNp/rmxS/sgt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281926307"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="281926307"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="693355083"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:27:06 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v4 0/2] mptcp: support MP_PRIO signals with userspace PMs
Date: Tue, 28 Jun 2022 21:27:00 -0400
Message-Id: <20220629012702.425574-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
to issue MP_PRIO signals over a selected (by local and remote address+port)
subflow in a MPTCP connection. It also adds self tests for this
change.

This patch series has been rebased to the series (in review) titled
"Locking fixes for subflow flag changes".

v2:
-userspace_pm.sh: added a sleep after issuing the MP_PRIO signal.

v3:
-use local and remote address+port (instead of address ID) alongwith the
connection token to select a subflow.

v4:
-fixed bug during rebase in v3.

Kishen Maloor (2):
  mptcp: netlink: issue MP_PRIO signals from userspace PMs
  selftests: mptcp: userspace PM support for MP_PRIO signals

 net/mptcp/pm_netlink.c                        | 30 ++++++--
 net/mptcp/pm_userspace.c                      | 30 ++++++++
 net/mptcp/protocol.h                          |  8 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 73 ++++++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 32 ++++++++
 5 files changed, 165 insertions(+), 8 deletions(-)

--
2.31.1

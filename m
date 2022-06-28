Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594453FFD
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 21:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656451764; x=1687987764;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=og9Ad+2q7uph5K+oLk+q1ZW45YYM5Uhj4K8RcV8aGaI=;
  b=OqG6RHxM/AFxboy/vT0YLWQ9xIsjl4DGpgdl2paIWMMRP+P9sNpnlkOT
   c/35/nAKoun9HqrqbAu2x6MI4l7qhU76/qIjnUq9wW4SkjJp9VOeX3RPm
   7lKKCpiTINRlKsV7rQ0HrOWnZpvNb2/ZVNIqjetGoaHpixQozvFMFTR4m
   zxp50/N/sdLy1Gu+SpO8PWaeB9xtGRbWMz9wql8uZUpjFTDFJiq/kTMaq
   QeI3S9AYQeD/jMSlykf7TeaNYSXXHSijdUZyhbNF7Xcs17RYDqeCbu1D2
   a+FyyG2pMLwJ3SNBZ6LVguk8dy8qdoZ4xaJW/t1/VpmHgrjjArYeI2LO+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345847044"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="345847044"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:29:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="732911202"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:29:23 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 0/2] mptcp: support MP_PRIO signals with userspace PMs
Date: Tue, 28 Jun 2022 17:29:16 -0400
Message-Id: <20220628212918.417515-1-kishen.maloor@intel.com>
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

Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD91FA1
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 02:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644977513; x=1676513513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pqnRaIFh1sSDvPWAjRsmzpIOXJT8CkRc4jB7kaQCavQ=;
  b=emQ2xnSmx5J9rzJWbUN4Vmsg6Hq/tVIYuVa7oc8DOSHv9rsm/LgUEozy
   7mdtV6p1LXxV0BGoZtaNx+w+rV8Citu97g8wttczgxuceCVpWgWgXZznS
   JFBBemIFfsp+v1//cf9RPzUbrTSd/KKxJYLBABCLkfp6akWgrp0mWcGW+
   cu0IiaUnmsaTH3dxAqqQ2b8tH+U3WcA4w9+8m1lHWKryOdRW/h15+k2Qw
   9DlI2jyxHnDiiinNRyQL5VvrEvQf47JSysG/ysnm06oJUDGkg8gUbBBzP
   w6YEG+35DpU5TYTvYS5qXjswjXyRwOwhTxOzPEIw1thn7Gs9q4TFtm2RB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313778510"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313778510"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571088814"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.9.181])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:36 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/8] mptcp: SO_SNDTIMEO and misc. cleanup
Date: Tue, 15 Feb 2022 18:11:22 -0800
Message-Id: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 adds support for the SO_SNDTIMEO socket option on MPTCP sockets.

The remaining patches are various small cleanups:

Patch 2 removes an obsolete declaration.

Patches 3 and 5 remove unnecessary function parameters.

Patch 4 removes an extra cast.

Patches 6 and 7 add some const and ro_after_init modifiers.

Patch 8 removes extra storage of TCP helpers.


Florian Westphal (2):
  mptcp: mark ops structures as ro_after_init
  mptcp: don't save tcp data_ready and write space callbacks

Geliang Tang (4):
  mptcp: add SNDTIMEO setsockopt support
  mptcp: drop unused sk in mptcp_get_options
  mptcp: drop unneeded type casts for hmac
  mptcp: drop port parameter of mptcp_pm_add_addr_signal

Matthieu Baerts (1):
  mptcp: mptcp_parse_option is no longer exported

Paolo Abeni (1):
  mptcp: constify a bunch of of helpers

 include/net/mptcp.h    |  6 ------
 net/mptcp/options.c    | 13 +++++--------
 net/mptcp/pm.c         | 11 ++++++-----
 net/mptcp/pm_netlink.c | 42 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h   | 29 +++++++++++++----------------
 net/mptcp/sockopt.c    |  2 ++
 net/mptcp/subflow.c    | 37 +++++++++++++++++--------------------
 7 files changed, 64 insertions(+), 76 deletions(-)


base-commit: 2c955856da4faec3a36df1e85b3ba3dfe230d6fd
-- 
2.35.1


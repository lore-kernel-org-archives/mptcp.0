Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB47B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651099811; x=1682635811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PLYufhWqyIwZBwlpC1Chcv6QvN9N+oO+h0YIvk+N97s=;
  b=KA2cGp2PRlHGT1j3/tTUNK5HXeOtWcOAzILdcmMDEOKmPxKRo2sqRdT5
   n/qU3rzc94IU/4Y8ITCb5z3mvILWy6jpcDaYab2SzUf17pyes/tY/l8ZE
   JCOhWfVGg5UsEo5JKkqN6SH6X8W4y2/4gN4JJK7T+R2/vFPbrluZDa2Pf
   otptghsoe5rLUOe65F/bJCJ3wKps+ufhwG+DpqG1VAm+XKLaHlHP8H6u0
   H981JGYfUxfdR2DKXbWopEmo0dIKjRJAKsHZNHkt8WvZhZFiwjTSN6rNe
   DDLr74xN5kF31lgOCDFTIiIZAv3yDBbWJSogofA5ShwxCgWlyL5xPs2cz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291252888"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="291252888"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 15:50:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="731049114"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.233.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 15:50:10 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/6] mptcp: Path manager mode selection
Date: Wed, 27 Apr 2022 15:49:56 -0700
Message-Id: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP already has an in-kernel path manager (PM) to add and remove TCP
subflows associated with a given MPTCP connection. This in-kernel PM has
been designed to handle typical server-side use cases, but is not very
flexible or configurable for client devices that may have more
complicated policies to implement.

This patch series from the MPTCP tree is the first step toward adding a
generic-netlink-based API for MPTCP path management, which a privileged
userspace daemon will be able to use to control subflow
establishment. These patches add a per-namespace sysctl to select the
default PM type (in-kernel or userspace) for new MPTCP sockets. New
self-tests confirm expected behavior when userspace PM is selected but
there is no daemon available to handle existing MPTCP PM events.

Subsequent patch series (already staged in the MPTCP tree) will add the
generic netlink path management API.


Mat Martineau (6):
  mptcp: Remove redundant assignments in path manager init
  mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
  mptcp: Bypass kernel PM when userspace PM is enabled
  mptcp: Make kernel path manager check for userspace-managed sockets
  mptcp: Add a per-namespace sysctl to set the default path manager type
  selftests: mptcp: Add tests for userspace PM type

 Documentation/networking/mptcp-sysctl.rst     | 18 +++++
 net/mptcp/ctrl.c                              | 21 ++++++
 net/mptcp/pm.c                                | 50 +++++++++-----
 net/mptcp/pm_netlink.c                        | 30 ++++-----
 net/mptcp/protocol.h                          | 16 ++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 66 +++++++++++++++++++
 6 files changed, 167 insertions(+), 34 deletions(-)


base-commit: 03fa8fc93e443e6caa485cc741328a1386c63630
-- 
2.36.0


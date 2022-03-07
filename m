Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387B38FE
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646685885; x=1678221885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IMbiK53fNOwd+yMBzMHYBEaSFj1psaAC6+WVVTXYRqQ=;
  b=bjE9JnsJDDxAAOoV3CuWTvRsZCD04q/y13wpBXqp+vm7FK5Izl4AWCRD
   zxf7HoYEeSVK4+cnn9oWFiAanODcPwfeF2RXbLG+ln1MkTwrdIVbkiUJD
   oVGOdxGnEZ0OJrHtw98DMIemqQCk9o1N66kuE+DBpHBP3qw67S2rCZSCR
   u1CdwJ5/Dh/NLp9Cv0IlbAznalf1kbnx8Z4PMiHuiQ5XIszldE3IOGIR0
   rmyxDEGFFRkK7Q8URIz5sJTVrWX85RBbdDOJ0lphxfcPeppayvGrBq5Fl
   LkHAvUbX0bh/5hjbEUT7Lvgq8DHzoipemkIx4Xy0qI5AXgKznXs40DIYN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317731782"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="317731782"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553320477"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.192.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:44 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/9] mptcp: Advertisement reliability improvement and misc. updates
Date: Mon,  7 Mar 2022 12:44:30 -0800
Message-Id: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 adds a helpful debug tracepoint for outgoing MPTCP packets.

Patch 2 is a small "magic number" refactor.

Patches 3 & 4 refactor parts of the mptcp_join.sh selftest. No change in
test coverage.

Patch 5 ensures only advertised address IDs are un-advertised.

Patches 6-8 improve handling of an edge case where endpoint IDs need to
be created on-the-fly when adding subflows. Includes selftest coverage.

Patch 9 adds validation of the fullmesh flag in a MPTCP netlink command,
which was overlooked when this flag was introduced for 5.18.


Geliang Tang (3):
  mptcp: add tracepoint in mptcp_sendmsg_frag
  mptcp: use MPTCP_SUBFLOW_NODATA
  mptcp: add fullmesh flag check for adding address

Mat Martineau (1):
  selftests: mptcp: Rename wait function

Matthieu Baerts (1):
  selftests: mptcp: join: allow running -cCi

Paolo Abeni (4):
  mptcp: more careful RM_ADDR generation
  mptcp: introduce implicit endpoints
  mptcp: strict local address ID selection
  selftests: mptcp: add implicit endpoint test case

 include/trace/events/mptcp.h                  |   4 +
 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        |  90 ++++---
 net/mptcp/protocol.c                          |   4 +
 net/mptcp/protocol.h                          |   3 +-
 net/mptcp/subflow.c                           |  75 +++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 237 ++++++++++++++----
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   7 +
 8 files changed, 321 insertions(+), 100 deletions(-)


base-commit: 57d29a2935c9aab0aaef6264bf6a58aad3859e7c
-- 
2.35.1


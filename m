Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BED5F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 23:19:52 +0000 (UTC)
IronPort-SDR: RD8fXcHEg4hfZQTfUR3F/4qyk2gIsgLwnLxLCSqrQ4mFFr0NkoOd3KzxOEi+Rtwi6/t8IMeE/M
 kJ4duLwfHqKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="277537228"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="277537228"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:19:52 -0700
IronPort-SDR: 4JS3CCvQwCj8MYHVRpD7UoySHalZIT+eMblnD3YdL5FmZ1NiSamSr+Ku9MCn9YShj8k8TGcikc
 AyVLKEvm2Row==
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="446269181"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.128.105])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:19:51 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/7] MPTCP: Miscellaneous changes
Date: Thu,  1 Apr 2021 16:19:40 -0700
Message-Id: <20210401231947.162836-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a collection of patches from the MPTCP tree:


Patches 1 and 2 add some helpful MIB counters for connection
information.

Patch 3 cleans up some unnecessary checks.

Patch 4 is a new feature, support for the MP_TCPRST option. This option
is used when resetting one subflow within a MPTCP connection, and
provides a reason code that the recipient can use when deciding how to
adapt to the lost subflow.

Patches 5-7 update the existing MPTCP selftests to improve timeout
handling and to share better information when tests fail.


Florian Westphal (1):
  mptcp: add mptcp reset option support

Matthieu Baerts (3):
  selftests: mptcp: launch mptcp_connect with timeout
  selftests: mptcp: init nstat history
  selftests: mptcp: dump more info on mpjoin errors

Paolo Abeni (3):
  mptcp: add mib for token creation fallback
  mptcp: add active MPC mibs
  mptcp: remove unneeded check on first subflow

 include/net/mptcp.h                           | 18 ++++-
 include/uapi/linux/mptcp.h                    | 11 +++
 net/ipv4/tcp_ipv4.c                           | 21 +++++-
 net/ipv6/tcp_ipv6.c                           | 14 +++-
 net/mptcp/mib.c                               |  3 +
 net/mptcp/mib.h                               |  3 +
 net/mptcp/options.c                           | 69 +++++++++++++++++--
 net/mptcp/pm_netlink.c                        | 12 ++++
 net/mptcp/protocol.c                          | 20 ++++--
 net/mptcp/protocol.h                          | 14 +++-
 net/mptcp/subflow.c                           | 34 +++++++--
 tools/testing/selftests/net/mptcp/diag.sh     | 55 +++++++++------
 .../selftests/net/mptcp/mptcp_connect.sh      | 22 ++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 ++++++++---
 .../selftests/net/mptcp/simult_flows.sh       | 13 +++-
 15 files changed, 291 insertions(+), 57 deletions(-)


base-commit: 247ca657e20460375bf3217073d6477440f48025
-- 
2.31.1


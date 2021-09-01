Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCE3FD5
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 17:16:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="279823957"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="279823957"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:15:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="645852929"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.226.118])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:15:41 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com
Subject: [PATCH net v3 0/2] mptcp: Prevent tcp_push() crash and selftest temp file buildup
Date: Wed,  1 Sep 2021 10:15:35 -0700
Message-Id: <20210901171537.121255-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are two fixes for the net tree, addressing separate issues.

Patch 1 addresses a divide-by-zero crash seen in syzkaller and also
reported by a user on the netdev list. This changes MPTCP code so
tcp_push() cannot be called with an invalid (0) mss_now value.

Patch 2 fixes a selftest temp file cleanup issue that consumes excessive
disk space when running repeated tests.


v3: Respin after net-next merge

v2: Make suggested changes to lockdep check and indentation in patch 1


Matthieu Baerts (1):
  selftests: mptcp: clean tmp files in simult_flows

Paolo Abeni (1):
  mptcp: fix possible divide by zero

 net/mptcp/protocol.c                          | 76 +++++++++----------
 .../selftests/net/mptcp/simult_flows.sh       |  4 +-
 2 files changed, 37 insertions(+), 43 deletions(-)


base-commit: 780aa1209f88fd96d40572b62df922662f2b896d
-- 
2.33.0


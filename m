Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BDF7A
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 21:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650664549; x=1682200549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=21xEP8av6DL8u+JJ2vUv8Ig2n+logWsNBtL3SHSq7eQ=;
  b=jBEtPxdc/1k4PjpbDopdqnpudoqXrS0w8kyeGuTFQts7kgHubuysBZ+i
   0MDk4eBDEb42CoetxajMqGoAykHEya4EjTPtieE6qAtnhIuITHi3F1fm8
   zFAWcmVMg4l6yhSC11/iQ5ckkvMUmWvoPZE9t46qgq9COP891S7cp5jIR
   bP+wdh7NbiKSP3FFxKFNLwq/fMskaeuCfTdotMQz6sKd0cAjlw3HOMxAO
   doJK5rQionh/XRLYY2mYnEWusXB1m8b3WnelLPr06j8CwnfmO7XkhDsHr
   El8DRYP3iTO2MtEOzWzSaKLQQD5YxLJUwLOsnP8zpk9Zfsu5A4JVQeHgF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244720725"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244720725"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="578119254"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.99.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/8] mptcp: TCP fallback for established connections
Date: Fri, 22 Apr 2022 14:55:35 -0700
Message-Id: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC 8684 allows some MPTCP connections to fall back to regular TCP when
the MPTCP DSS checksum detects middlebox interference, there is only a
single subflow, and there is no unacknowledged out-of-sequence
data. When this condition is detected, the stack sends a MPTCP DSS
option with an "infinite mapping" to signal that a fallback is
happening, and the peers will stop sending MPTCP options in their TCP
headers. The Linux MPTCP stack has not yet supported this type of
fallback, instead closing the connection when the MPTCP checksum fails.

This series adds support for fallback to regular TCP in a more limited
scenario, for only MPTCP connections that have never connected
additional subflows or transmitted out-of-sequence data. The selftests
are also updated to check new MIBs that track infinite mappings.


Geliang Tang (8):
  mptcp: don't send RST for single subflow
  mptcp: add the fallback check
  mptcp: track and update contiguous data status
  mptcp: infinite mapping sending
  mptcp: infinite mapping receiving
  mptcp: add mib for infinite map sending
  mptcp: dump infinite_map field in mptcp_dump_mpext
  selftests: mptcp: add infinite map mibs check

 include/net/mptcp.h                           |  3 +-
 include/trace/events/mptcp.h                  |  6 +-
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           |  8 ++-
 net/mptcp/pm.c                                |  6 ++
 net/mptcp/protocol.c                          | 21 +++++++
 net/mptcp/protocol.h                          | 13 +++++
 net/mptcp/subflow.c                           | 57 +++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 36 +++++++++++-
 10 files changed, 121 insertions(+), 31 deletions(-)


base-commit: c78c5a660439d4d341a03b651541fda3ebe76160
-- 
2.36.0


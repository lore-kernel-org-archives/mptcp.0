Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC822324
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CAosPmpt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RYIIO1X9EoLZ66NyFBXu+LetGtDPkVZ0Ixn+dz11F0U=;
	b=CAosPmptbj739v7O6LVS83qnjGlKm3cizkgM5gY7/NaV5tvP6ZTSVtPSJnzw5Eggc2haYC
	MlEGs1YannqqcLHbh6dKpQE3sbHbQUhAcy7wfV5p/1kxlRTL1d1+q/ZFSWMCfPHw5fonZ2
	N3Xi5VNjyhHulV9hZtY59G4inOOq4Lk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 00/15] add helpers and vars in mptcp_lib.sh
Date: Thu, 21 Dec 2023 19:31:03 +0800
Message-Id: <cover.1703158128.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v6:
 - rebased with:
 v3 fixes for CURRESTAB
 v5 dump for userspace pm

v5:
 - rebased with "userspace pm enhancements" v13

v4:
 - rebased with "userspace pm enhancements" v12

v3:
 - merge squash-to patch for v2:
 Squash to "selftests: mptcp: add mptcp_lib_ns_* helpers"
 - add a new patch:
 selftests: mptcp: simult flows: define missing vars
 - update patches:
 selftests: mptcp: export event macros in mptcp_lib
 selftests: mptcp: export cin/cout/sin/sout vars
 selftests: mptcp: netlink: fix positions of newline
 - update some commit subjects and commit logs.

v2:
 - add more patches.

Geliang Tang (15):
  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: userspace: capitalize test_name
  selftests: mptcp: userspace: print colored output
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: netlink: drop duplicate var ret
  selftests: mptcp: export ret into mptcp_lib
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: unify namespace names
  selftests: mptcp: add mptcp_lib_ns_* helpers
  selftests: mptcp: add ss mptcp support checks
  selftests: mptcp: add mptcp_lib_check_tools helper
  selftests: mptcp: add mptcp_lib_cleanup helper
  selftests: mptcp: add mptcp_lib_check_output helper

 tools/testing/selftests/net/mptcp/diag.sh     |  75 ++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  31 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 204 ++++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 264 +++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  48 +---
 .../testing/selftests/net/mptcp/pm_netlink.sh |  48 +---
 .../selftests/net/mptcp/simult_flows.sh       |  30 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 270 ++++++------------
 8 files changed, 464 insertions(+), 506 deletions(-)

-- 
2.35.3


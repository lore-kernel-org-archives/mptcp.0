Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291B12B76
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jzpl/Wok"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iA3V4jaeT7/4IiOaHsiDwp2X80tUmoJFZDGRJdPaNmE=;
	b=Jzpl/Wok4/IfYp/h+jbtyEx9d68YcYWYPkmRucZ/Ep+e8aWJveqGEOx2j5CF9hmTJEKuLR
	6KoeSSBsmboRuAlivNURWbSDThYv6WR2I2egIbENADI3OF13zyVTjTVn4xZIsYDmoFFjS/
	8Ov5D/FP+hgYH7td6VJ/Na+NTG9RqSA=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 00/33] add helpers and vars in mptcp_lib.sh
Date: Tue,  5 Dec 2023 15:00:47 +0800
Message-Id: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v5:
 - rebased with "userspace pm enhancements" v13

This series includes three parts:

Part 1: add more helpers in mptcp_lib.sh (patches 1-11)
Part 2: print colored output and test counters (patches 12-24)
Part 3: add more vars in mptcp_lib.sh (patches 25-33)

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

Geliang Tang (33):
  selftests: mptcp: add mptcp_lib_evts_* helpers
  selftests: mptcp: userspace: capitalize test_name
  selftests: mptcp: userspace: print colored output
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: unify namespace names
  selftests: mptcp: add mptcp_lib_ns_* helpers
  selftests: mptcp: add ss mptcp support checks
  selftests: mptcp: add mptcp_lib_check_tools helper
  selftests: mptcp: diag: print colored output
  selftests: mptcp: connect: print colored output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: sockopt: print colored output
  selftests: mptcp: simult flows: print colored output
  selftests: mptcp: connect: add PORT instead of TEST_COUNT
  selftests: mptcp: connect: print out test counter
  selftests: mptcp: rename test_cnt to TEST_COUNT
  selftests: mptcp: diag: print out test counter
  selftests: mptcp: simult flows: print out test counter
  selftests: mptcp: sockopt: print out test counter
  selftests: mptcp: netlink: print out test counter
  selftests: mptcp: userspace: print out test counter
  selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
  selftests: mptcp: simult flows: define missing vars
  selftests: mptcp: export cin/cout/sin/sout vars
  selftests: mptcp: join: change capture/checksum as bool
  selftests: mptcp: export capture/checksum vars
  selftests: mptcp: diag: change timeout_poll to 30
  selftests: mptcp: export timeout_test to mptcp_lib
  selftests: mptcp: use KSFT_SKIP instead ksft_skip
  selftests: mptcp: use KSFT_PASS and KSFT_FAIL

 tools/testing/selftests/net/mptcp/diag.sh     |  89 +++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 115 +++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 202 ++++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 244 ++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  98 +++----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  25 +-
 .../selftests/net/mptcp/simult_flows.sh       |  54 +---
 .../selftests/net/mptcp/userspace_pm.sh       | 272 ++++++------------
 8 files changed, 529 insertions(+), 570 deletions(-)

-- 
2.35.3


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C85B5A9
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940610; cv=none; b=B7VFWqixJt+bMdXhm3qy7AtxxIREM2qXLQx8bBFi37PR3pol9LZkb80Zl3cjCJ72IdPnll/3wleLEW6rGHzQEf3B97PqEHbPNeMytld66DvF/lE0oRfk+euUUUtrxUS1Z5aLIOaHENzoUdYlVBwsxzJ1bkdIjqikQ/Z51VPE0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940610; c=relaxed/simple;
	bh=nDGATeu6Rt14B4qixlECkVDBCycdcHjyoGVugBDFjxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6U/HPs3WZ3Sbxi+CRImf6gE4Yw/04vUQXUoU6/Abq2Y09OAVrEWoFojUbrALlsAze6zgiaoNp1w2YsHPzgD/KsDTjp10JhM2+MRALz6J8JK+F9AALKKyMKxK90HSISG+9eQgFUcxjQNxXKFu494/cvrlEAFK+V49MbK+cU1Npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGT7lnv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGT7lnv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F74C433F1;
	Mon, 26 Feb 2024 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940609;
	bh=nDGATeu6Rt14B4qixlECkVDBCycdcHjyoGVugBDFjxg=;
	h=From:To:Cc:Subject:Date:From;
	b=tGT7lnv+GlWRTJ49U34AQp60pHvZyL/bobfdHg999Zrs3j5UVL9He8fTFRHT5Pq56
	 RTIyyLD+qzEDgpU8mBm0VKWIWm6FH2exxpbn1lpLfUbw/sTtEt4exBBS4NBrVJT0nG
	 fZxM0k0OIVSmC5tn4nWJDbv8XJJcGuA94qxCZRaJruHFbJd0tKEHnv4H8VyQKBsjeT
	 9T4u0b3VJgNJ2Bm2KY5oP34GXYq/cmRrE3Pb85DupVVw7ulxUDoteb0e5GeO7/HkiP
	 MeOFUjYQUG+knXOIofgzVFWmtEyjcMofjdzy1Egd3Jq07G5ypUSxvLMYp1aaavrOyg
	 5CPaKu+ZH2pRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 00/12] add helpers and vars in mptcp_lib.sh, part 3
Date: Mon, 26 Feb 2024 17:43:11 +0800
Message-Id: <cover.1708939962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - don't use mptcp_lib_print_test_counter in mptcp_join.sh, it breaks
   skip_test().

v4:
 - set test_cnt to 0, use ++counter in mptcp_lib_print_test_counter() to
   fix the following mismatched test counters:

# 012 userspace pm server fullmesh
#       syn                                 [ OK ]
#       synack                              [ OK ]
#       ack                                 [ OK ]
#       add                                 [ OK ]
#       echo                                [FAIL] got 1 ADD_ADDR echo[s] expected 2
# Server ns stats
# TcpPassiveOpens                 5                  0.0
# TcpInSegs                       25                 0.0
... ...
#
# 1 failure(s) has(ve) been detected:
#       - 13: userspace pm server fullmesh

v3:
 - fix shellcheck errors in v2

v2:
 - fix shellcheck errors in v1
 - print test results with counters

Geliang Tang (12):
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: connect: fix misaligned OK/FAIL
  selftests: mptcp: print test results with colors
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: connect: print out ping tests info
  selftests: mptcp: print test results with counters
  selftests: mptcp: move test_fail out of check_expected_one
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL

 tools/testing/selftests/net/mptcp/diag.sh     |  20 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |  85 ++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  67 ++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  94 +++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  11 +-
 .../selftests/net/mptcp/simult_flows.sh       |  15 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 210 +++++++-----------
 8 files changed, 295 insertions(+), 241 deletions(-)

-- 
2.40.1


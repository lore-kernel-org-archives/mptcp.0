Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259AEBA22
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459594; cv=none; b=KvNbYNjb62HwnkMO70fF8mGR6iy8D2URmz8lVMWE2xQ0OjpExgcBkvCjmk5oxSOUbHVODZU3ZoxEJPwcLcwDl9mqKRbtIzcu8gKUoODswC/mYaQ2qP84jKtmesm0mGI4rIicX0MbV4no9/2NhL29NS+dlO4i25vo8A1HSZiMVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459594; c=relaxed/simple;
	bh=13m+ecc5x0ycfwdqVA/VzMHdnRxqgETe4+bGYgIYT2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9nUdbxNW2SEdQ0aeVGL58sljb/FrH0TyoUl+37jd3PpNOLpv58an4uL+ea1iz4CpkhHoo158EqJmtOHNAsUY3P3LLwX2Dc2mL8s07eWkotvno+bRLaNtgENxLekZbm7Ah8wNhBws0qWqj87ZWCN7JTuRIzfwcK/Y6Zmf91BmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUpFg8+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUpFg8+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F22FC433C7;
	Sun,  3 Mar 2024 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709459593;
	bh=13m+ecc5x0ycfwdqVA/VzMHdnRxqgETe4+bGYgIYT2w=;
	h=From:To:Cc:Subject:Date:From;
	b=bUpFg8+U4mi82uhX8V4Z1TcSpRZvGGqXit/GhTAp8rXxluJRT71uDp07L8v/BG2Lo
	 jfcoeiVmKO9ris2rN0S8HLCAQTjtGzTLZAICuLSX66mfqe2/tJrjU7WCreMRsgwiLt
	 Ymcf+y0zuejk4zgXlkiCaImc1yh625E4Y7RBApi+RjFXKgYYR8cEzWYIb/5mn9ZShB
	 flmkBrQiGPyJJ1cyW/niw5jAgbjjl+7FCW6e+XaLQadJFVw4aGPxhy2WxRqjNQb0Ps
	 W2TCgXNYoLIqZB659vkEvFwA+4xroBgiL1XzGqH+kIYcBDmj80NJOgI+RwYK6j72TV
	 PpcN4Ew+nplSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 0/8] add helpers and vars in mptcp_lib.sh, part 3
Date: Sun,  3 Mar 2024 17:52:20 +0800
Message-Id: <cover.1709459360.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v10:
 - split two more patches (#4 and #5) from #6 and #7
 - update commit logs

v9:
 - move print_larger_title from patch 5 to patch 2
 - move MPTCP_LIB_TEST_FORMAT to a more suitable location in patch 4 and
   patch 5

v8:
 - address every comment from Matt in v7.

v7:
 - address every comment from Matt in v6.

v6:
 - only include the first 7 patches in v5
 - add mptcp_lib_pr_* helpers
 - add print_title helpers
 - align the output of simult_flows.sh

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

Geliang Tang (8):
  selftests: mptcp: print all error messages to stdout
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: connect: fix misaligned output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: export TEST_COUNTER variable
  selftests: mptcp: print counters in print_title
  selftests: mptcp: print test results with counters
  selftests: mptcp: print test results with colors

 tools/testing/selftests/net/mptcp/diag.sh     | 19 ++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 76 ++++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 45 ++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 33 ++++----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  5 +-
 .../selftests/net/mptcp/simult_flows.sh       | 14 ++--
 .../selftests/net/mptcp/userspace_pm.sh       | 22 ++----
 8 files changed, 131 insertions(+), 111 deletions(-)

-- 
2.40.1


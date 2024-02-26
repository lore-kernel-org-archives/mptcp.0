Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750F1C69E
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935484; cv=none; b=HDANja240dzYep9QyGmpTjNSTdxd/0UOeyK/gDfQBacLTYqS+xS9jpW2lj43BbVqZpnGXckod0j8ip/1dWosUpq7ao88WJ9R21eIel5PKghPKIUh9Dw7/0+Lr3A0fSvQqaTq6KMWZ7Vn+Jm/STo6fEq46VImL1wogOw23YtUvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935484; c=relaxed/simple;
	bh=5KvmlcFSpSB9OFqCW8ZkQyisDrjQozvlXrCNztcZH8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FNTEAGSEKnfXm7u9mppu7MXBXCnHB+zEe2aYHlweJ6sYWzZawfZCTV5GVTG1V4uhV8E36vjD4B60Hb9IqDkuJvFSsdYzLRfgq7oXVyhV88dLs/STIjv90EbIi1pr/s1Xx/iH3SrFlKB2Xege6dYsnsE2F6ACjxn5UnGBHxLvcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtWXTX/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtWXTX/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B9BC433F1;
	Mon, 26 Feb 2024 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708935484;
	bh=5KvmlcFSpSB9OFqCW8ZkQyisDrjQozvlXrCNztcZH8w=;
	h=From:To:Cc:Subject:Date:From;
	b=CtWXTX/b5IPOMF9yNSXUQehfM510XDBhX5h+fqTghFACpT4t2Btpc/yaChRr4p/YR
	 BhG7VsNVFjP32CnxZXySGSaIAHcFmcx5XUSzEJqKBnsBpCpXCYNDTVNcvhvMNUyAXP
	 iKe0qV8XGtiDOISS1vtPA+c1o6RXce1aKbWWlKnDqQuxWZVqhGt2o+Xyh+gX3FE6Ms
	 eKU4qdkbWXX5Z/fN7Egx3iGRfJ50i1IrKvsE9JfzcQyq2sUSIDa8e4TyL7DoQSxq/n
	 zy1y6BdjqO3hcglIhrHw6+6clBKuXS0plYBRhxPIha0kuzQnUy3ytRW89I8rceATeK
	 BsRvQoz5morrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 00/13] add helpers and vars in mptcp_lib.sh, part 3
Date: Mon, 26 Feb 2024 16:17:45 +0800
Message-Id: <cover.1708935196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
# 	- 13: userspace pm server fullmesh

v3:
 - fix shellcheck errors in v2

v2:
 - fix shellcheck errors in v1
 - print test results with counters

Geliang Tang (13):
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: connect: fix misaligned OK/FAIL
  selftests: mptcp: print test results with colors
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: connect: print out ping tests info
  selftests: mptcp: add mptcp_lib_print_test_counter
  selftests: mptcp: print test results with counters
  selftests: mptcp: move test_fail out of check_expected_one
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL

 tools/testing/selftests/net/mptcp/diag.sh     |  20 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |  85 ++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  72 +++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  95 +++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  11 +-
 .../selftests/net/mptcp/simult_flows.sh       |  15 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 210 +++++++-----------
 8 files changed, 298 insertions(+), 244 deletions(-)

-- 
2.40.1


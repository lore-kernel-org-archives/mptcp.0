Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790762814
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200278; cv=none; b=gIeEFzYFAM6F/afiy9gNK+5lhg/pRmWLJJJa9ogm3UdURFLYVsPi/ZKgMKhA8vTvOCNlmeZyv4oKuLXGo3ACAK8rc4NgXDpqTEPlyubT8t2mRUvNzhHYrU2fD2JcfxrS2NEQRqnc93Q+T9Ypz85KZLXNwolhG7uUcxbw7HmQZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200278; c=relaxed/simple;
	bh=COnuB2AtIAExrCC3D0Y611JO9WIYpeGfGsvRkFKgMUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QoHDT/NItUSq5cIu7sBouOHfZSz1OV5umLDIDk6AsghEMe1Z+sWtPzmbti6hhs0rhcpXupptx8iInmgqlbcbrMEnpfiLqTskow/TbuGL8IcW+Ho40e2QJKAOzerepbZgy8GCPQnaPf0yUyNb/yTFodY0ytBH9ZYyJn4TSyCXXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZEb7Ab8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZEb7Ab8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18296C433C7;
	Thu, 29 Feb 2024 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200278;
	bh=COnuB2AtIAExrCC3D0Y611JO9WIYpeGfGsvRkFKgMUM=;
	h=From:To:Cc:Subject:Date:From;
	b=pZEb7Ab8WtK2qp+CHE1txMXOe43it70s2vlNVczJc5G2HaYwfjOpBcGSf4fpEfrS7
	 m1T6KX8ETqJ03vcejFOPxgN1uQMFiAek1uIci3iz+/rVT9sYjKI9FBMDotdzGSjkMd
	 vBv5nsMM6O3Jok8MJDpz1mINw6lj7kdHZswKrzNujqoHvoo1WybgK7jcRCZyONvxZ4
	 QmJxTw+mrXe4T6ir7oNaMbo/mdjg1J8OtfaDwwJkeeGJHRPgrJuo6RUfBc856CSCHh
	 fauyy3r2YSOqnBINNdOuIZAmSqOIb5n/K1zSP/Vzvs3hr8L1NLuT270PZNKLh73Ghp
	 aKLTSJVMlJ2Rw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/8] add helpers and vars in mptcp_lib.sh, part 3
Date: Thu, 29 Feb 2024 17:51:03 +0800
Message-Id: <cover.1709200070.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  selftests: mptcp: diag: return KSFT_FAIL not test_cnt
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: connect: fix misaligned output
  selftests: mptcp: simult_flows: fix misaligned output
  selftests: mptcp: sockopt: unify ipv4/ipv6 as v4/v6
  selftests: mptcp: add test counter helpers
  selftests: mptcp: print test results with counters
  selftests: mptcp: print test results with colors

 tools/testing/selftests/net/mptcp/diag.sh     | 25 +++----
 .../selftests/net/mptcp/mptcp_connect.sh      | 74 ++++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 57 +++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 37 +++++-----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  5 +-
 .../selftests/net/mptcp/simult_flows.sh       | 20 +++--
 .../selftests/net/mptcp/userspace_pm.sh       | 21 ++----
 8 files changed, 149 insertions(+), 112 deletions(-)

-- 
2.40.1


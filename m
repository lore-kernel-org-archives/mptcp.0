Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FAA50
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689265; cv=none; b=cMXr0Rx/H1UgB2tVbaCFPPNav+oHymLwtR05vFvDbTVgF4bHV3Xmrn9j6BZaDiPTZzJf+iUWtC7fzh7o+Kjegcaqbg7IRKG3iYR7V3yGFSCQbBc2Lx9zIQTrNg7+KR7ufCBf1iWysxzQgIeRfH0pBhygVpREmzkc+IR7jftEFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689265; c=relaxed/simple;
	bh=XBFC/LMHE6RYwT0xRkaJitiWkWjfqBfx0V5RTmV40e8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j8B+Q/xRUEaE/mMPHQRlQv9pPyGn/5JHnj0tXGRYMv0qx4jTBBYHExTZHZoJ10ndr6kAokWrPCr4F8wgtWCLmc2wSA/3jQOV9O6S9gwR63PvKqCERB2MxsxRosPydnRGQZW6tijiSy2a98/urHMMJPPyXYPXFsUBWB93R3zOEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpkwfClO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpkwfClO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1CEC433F1;
	Wed,  6 Mar 2024 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689264;
	bh=XBFC/LMHE6RYwT0xRkaJitiWkWjfqBfx0V5RTmV40e8=;
	h=From:To:Cc:Subject:Date:From;
	b=fpkwfClOQKO6QohVBvh+t7nj7RzjimXCxw9IiRJe/k3+yw9tHFqrgdgYNIeGRcuZL
	 0VxN7XfXfvuOx6a8WzEyd8S5aaS5jmR0+yAYOpebKtvrn2qwmnGz1mcPymSmELPIbm
	 X2Y2rNW1G6XYfdkya2L4iurtwJ4Aeh2MIzNV1ffw4nP9i/wdZxi2m6VVgr6SAPipSB
	 qrjZKTNQ2st+vk/hR1uZcmqFtEYzurrQs+aMeBMUG4panrIuBY5pOsIErv/zRe32gP
	 AL5y33MoodM0jcDyVBRAq/GbLLZzMbdX8b7Ikot3uKb0wHyKEBkYl6fRnFZJMEdK/6
	 46dpV6YNFhWXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 0/9] add helpers and vars in mptcp_lib.sh, part 3
Date: Wed,  6 Mar 2024 09:40:50 +0800
Message-Id: <cover.1709688778.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v13:
 - fix the shellcheck error reported by CI in patch 8
 - rebased

v12:
 - patch 1 Drop one more 1>&2, and update commit log
 - patch 2 use port_base=10000 instead of PORT=0
 - patch 4 fix the TAP output
 - patch 8 a new patch
 - patch 9 drop _printf in userspace_pm.sh

v11:
 - fix the shellcheck error in v10

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

Geliang Tang (9):
  selftests: mptcp: print all error messages to stdout
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: connect: fix misaligned output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: export TEST_COUNTER variable
  selftests: mptcp: add print_title in mptcp_lib
  selftests: mptcp: print test results with counters
  selftests: mptcp: connect: use += operator to append strings
  selftests: mptcp: print test results with colors

 tools/testing/selftests/net/mptcp/diag.sh     |  19 ++-
 .../selftests/net/mptcp/mptcp_connect.sh      | 123 ++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  28 ++--
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  42 +++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  44 ++++---
 .../testing/selftests/net/mptcp/pm_netlink.sh |   5 +-
 .../selftests/net/mptcp/simult_flows.sh       |  14 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  28 ++--
 8 files changed, 163 insertions(+), 140 deletions(-)

-- 
2.40.1


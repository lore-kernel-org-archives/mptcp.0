Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817210A1B
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616134; cv=none; b=GIwoafrlmXfaXLs3YFKptcYxjcWbmSTXJHUv3XkEVC6oP8qPgak933VriRHmPtNIbbavOhUKJaU9nZljj/kbgWaylg0Dg0mnOdkNl/sMJlRsygs8S8PX9ZDQudfOdSzKsQgS+3eXPSO6aMo+6JjFPZulVza7kmX7SNUZLBnXmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616134; c=relaxed/simple;
	bh=0RsSFiaL28CaFSkl+i/B1oUBGDi2dDwTCo4KVg1jyEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uxLinKPWyLz9Rr72rJ9F6WeYvCZGAXQJueJ01lPKtAF/hvP9QI1b94W3EEf/JSPpNX8KuVyQNzPn+T5GoG+z+0PkhMrmZ2/F4q14sLOu5TjqmXCsnh76oO8HpwD2b8KFsKSJqZZEqjN3IbtVUT9LrcfpJg4ysEbUQd2GNrTNSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHKtu38G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHKtu38G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D70C433C7;
	Tue,  5 Mar 2024 05:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616133;
	bh=0RsSFiaL28CaFSkl+i/B1oUBGDi2dDwTCo4KVg1jyEg=;
	h=From:To:Cc:Subject:Date:From;
	b=vHKtu38GwqI+2UhB+XHGb6SKzTH0tn8UjWxTz2TSLxSk/ChSZN94WQia6rNJkRpkQ
	 UAW+dq9waRmEW5excv6zr009ZEtjF4GtatybEek2/fyZB1+SCYQ7/uMgpUVLMmY8cG
	 RR3V5IChm8PUN+EZiuZ2osCeYjk8O9Tk7GNAAnL742LoO24tz66F05DkkMr6TQcZrH
	 0v4NiGkVBFGs12wcFdxei7J8xvo4A1au+VYiPga2NccVtHqzgeSCGxPBEnUWsEMvg0
	 XlQmBG6UnopyUbH7I0go0an5ehxHppL/5jzkp43+PziUOk2Ajt8WpgEb8FeN3XG1t2
	 60ElOUAG64r3A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 0/9] add helpers and vars in mptcp_lib.sh, part 3
Date: Tue,  5 Mar 2024 13:21:58 +0800
Message-Id: <cover.1709615883.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  45 +++++--
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  44 ++++---
 .../testing/selftests/net/mptcp/pm_netlink.sh |   5 +-
 .../selftests/net/mptcp/simult_flows.sh       |  14 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  28 ++--
 8 files changed, 164 insertions(+), 142 deletions(-)

-- 
2.40.1


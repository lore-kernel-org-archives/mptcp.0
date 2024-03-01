Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD467E7A
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275623; cv=none; b=AgQCY0S8MEYAebTHCS27Otsw9rjGgxvpyMyedNDOKjkeuQfHgV3xA9SqEu9gi1CmvV4V5fG/V7lvKEXz3XQf3RKavVOLGqLxnxhaYApffJGeDeZI/a+6bewCFhH6jjculdDQD3I/A1WB4niN2MAVO13QpCHzTAyzJAW83Gdv8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275623; c=relaxed/simple;
	bh=iac4A8u391yaOCw9eReJdJFjYyVEByfTm0Ayex6kDH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXuR4ielkavlRbSrMx60LlqAcyGxUhNUDb1r0VjU69g993oSxxyv8AY0FjOalZW5FZ0rMMSQ8HzTUyqCIpl1YJhQzimmB2MvXV4estPLvkRDEOkPBWRKsnbLLPBUY5f4sy0gdWixi/jzBYC08wLqwnYdv9JMCLv/9lJ5cUiKX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+dv6+cK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+dv6+cK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA22CC433C7;
	Fri,  1 Mar 2024 06:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709275622;
	bh=iac4A8u391yaOCw9eReJdJFjYyVEByfTm0Ayex6kDH8=;
	h=From:To:Cc:Subject:Date:From;
	b=c+dv6+cKKYFmaAOlJRFhGOSAHRMzW1mP0aU0eON2zwIYrJfjxcwWOxJ2lIB2ODJTY
	 CSGC9NCo0ZvM8ibq6AgZGSix52EcbWS3jgULyTkKCpdUx5PXcTsGuLMxDyjf9WA2cH
	 Si7b9iNXcrnhVVUKXK7eb1z7hnpdpTbdihqrqG+BZ205DMx2HOhe+mqxiWPdNTiyN1
	 PAwKQGQ20qKeeZdYVmuDck8BdZfzk/2rt7wyFZmFbIOCuz5vIKoQm9SCnu+RkWKnoa
	 LkFgK7m7yH4xlRoQW7wbLP8b9fIknfF+Iaor0xi2ThQ6BFy6CXc5KSwciJ57MIkp0M
	 UgIFO4FBmHIkA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 0/6] add helpers and vars in mptcp_lib.sh, part 3
Date: Fri,  1 Mar 2024 14:46:30 +0800
Message-Id: <cover.1709275290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (6):
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: connect: fix misaligned output
  selftests: mptcp: print all error messages to stdout
  selftests: mptcp: add test counter helpers
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


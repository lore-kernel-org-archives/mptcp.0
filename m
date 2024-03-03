Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B8C8DD
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709466782; cv=none; b=CMdkhvP7iGG+R7DMMaXHjL9p48af5HEo0J87IMXOpLjbUVD6ObVV+pkHomQzQ2uKn19PLA1omqBA1Z4C5oJW4xyOUzbAVYaXvL1cNbwgY8LULv1r8lNarqh0YL8uaXB3mU1IkXsCOG12LiwGoeLP6CVfTcrSdwUrJnzCrXHD6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709466782; c=relaxed/simple;
	bh=/tRB7NiXbnLprvVs1gig554LtXR5GmlZlZtOedeAzI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eJn8SG1hof0DHWmHZfcshNgptqq8Ylo03gfvzCLJvkRXAowJ5pBy0kOC80PrQUGZ9H9wZ7gJMYvmJaC4nYeD7JnaUOv6s3pavZuHRTBG/QuZAXmMbRyhdTyOgNIfWd7p1H7PLkkCYGLjq2Sz43rdIS3jzSHPcz1hgVddZqzZMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ninwwfbB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ninwwfbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C70C433F1;
	Sun,  3 Mar 2024 11:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709466782;
	bh=/tRB7NiXbnLprvVs1gig554LtXR5GmlZlZtOedeAzI0=;
	h=From:To:Cc:Subject:Date:From;
	b=ninwwfbBkaAa/mcrea0uWxzSZd0sT4+K0jTGKbr+kgbigm2XYpUz3uDGHG8PB7LMg
	 2iBu7m586EbA8dEONxJTeuTfjfmJPJqct/QKOT6mUIEEE0T87qxzpvhTpPBG7gjaan
	 8SXGvlRt4RO1eR76HpeS9nti3Zw7EOA4S37wisMXoJ/dlNT1aaiH7uY1effO26dsKM
	 K2dVATQyegG02rRzCUQOQX9mtsL++g0dRrxIorhHIppxy7rCm2/3emH5ni90dOeQMJ
	 JeAs5mvckMXspkDoIyc1JUNxgyKGRpg0uDuglTABo8UfImE3Hzn9yd+ot8F88tywfo
	 AUzbwYdnuxSqA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 0/8] add helpers and vars in mptcp_lib.sh, part 3
Date: Sun,  3 Mar 2024 19:52:49 +0800
Message-Id: <cover.1709466624.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (8):
  selftests: mptcp: print all error messages to stdout
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: connect: fix misaligned output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: export TEST_COUNTER variable
  selftests: mptcp: add print_title in mptcp_lib
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


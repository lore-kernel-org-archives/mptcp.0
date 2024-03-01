Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387282AEEE
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273890; cv=none; b=aLr8CzZCRfeYhgc3tPA3w1mzFmk1Pl0HA0MoVAz9fjgZeH5P9hWaRfMFJZlXGJ+ucD8kjaPT4QV2FbBebdxnhk5WS0G0cv5c+2gV4PXrPAaJQmg+ZW+jphaJ0q4EU/8XUaoj0Xk4dVZXpl3Gx01Qk0JKIS7m+yzFSkS5y45BJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273890; c=relaxed/simple;
	bh=5rQHPOoxMBykUEY16OEjj8EVS0zvkqZE2hCiK3w9csQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mk+TIBorUXZwaoWdZT226Q3EiHe6mq1PJfrhYNw5oIL4vMMxuGhqmr9CVrXU/igGBPffGVIs/B2woe+cQJqxkk7+YyMWUXWrjkS+4AUpzxwzgCSnbQbL/s/TbHNzbOGTHmhLWtzutpyLag5lc+w1JciQoyPMvT01LPsKM6sUbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3VHHtyG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3VHHtyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078F3C433F1;
	Fri,  1 Mar 2024 06:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709273889;
	bh=5rQHPOoxMBykUEY16OEjj8EVS0zvkqZE2hCiK3w9csQ=;
	h=From:To:Cc:Subject:Date:From;
	b=G3VHHtyGkPGpv6aoGaoH4OUxDguS1njzWbFZDzS5uHeWd+/1AeAWMI3R46EXhTAja
	 jED13adygqXaIdGSd3ZMLIQIzy43+dkUmGLjXrrr2pGKwnPkFohwTHWNq0cZV2kqGu
	 GKLeSzg761Om+YDLbh5N4B9YzAby9PFXu0E4njXAPKYYztqzxlOEqDBzaE38V50YNA
	 oCkBP7X//IYr9xdPXHeRKTtlR9/IN66E6TxXR9Mwbi3LKPcv2+gX3gYM+mMjBPBR9i
	 JSh2tniroPT6SPs0eelmQDsxYGyQNSQWn8ucMhbcQjye3ER2VJooiWoiWC2QeuHjRc
	 XVo7F5WqJyYdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 0/6] add helpers and vars in mptcp_lib.sh, part 3
Date: Fri,  1 Mar 2024 14:17:59 +0800
Message-Id: <cover.1709273774.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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


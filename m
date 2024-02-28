Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9C24B2C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106235; cv=none; b=t3TB10pdkIrCgPKBUBq2ZaluEMuiKWWn2ftM4jV0hIvxsTifu6x7GofvKol47d+OX8JhfxPHVo9vuCfrySsoTcP9f9bO/NF3AzKm8gx/ZV/vBjR7i4LipkisoeTwhCOfL8WkhvDvmmUBGJcgHhMd1Bnh1Y0qhGVV9kcIh0OxzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106235; c=relaxed/simple;
	bh=sUCKJpobx/KUoHkl7B6QZVrslccOgRbuyjpE6rtWc5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H2QoJiNIsOAOUlJf/AH3wuyIPzeKBtvn4hJwLPxgQJ908dMRpsjy4Kkd6YWc4mbJrvH+B+czzPaowIwHlYYVr2y1JMUlJ5YaRkz4Tjt3mm8cm3Sgys/qxhx54i1hrCkhGW8jWqY0qwRw5vHaOCtj+6Zgb82eo1bFTI+ZMzWwUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0q9H4uQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0q9H4uQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B5CC433F1;
	Wed, 28 Feb 2024 07:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106234;
	bh=sUCKJpobx/KUoHkl7B6QZVrslccOgRbuyjpE6rtWc5M=;
	h=From:To:Cc:Subject:Date:From;
	b=A0q9H4uQ3ejjEjmZrpQp6pv8GdRIPEQ8FxoKT74yu+oT6nzr35VwxRiCyhk/NWztk
	 tW4KwMG8Ub/jQ+iMFfsO+e488Rr3ERryzQrNmzUfAIyqhpMwkLS998RPBLuClnWc+V
	 sEYKaweU7GG9uZ+uosOlJ2S/tavkj0HHAUKL7WydyDMQBfWkG73WPI0qRKpGvqHD47
	 JuebV4Kbbi9963G3jw7TVBAesKP5Fdqsj2FH4wVu5XMXNstnQnMrongxK+2VG8/UzE
	 Ye+DHEy2fwRUS3j+Qgr4MrJHJn92hd6oz2lcxqnuRD+eTVsKIyV6CyJXYATFYGUQIg
	 egmA22tDWVDSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/9] add helpers and vars in mptcp_lib.sh, part 3
Date: Wed, 28 Feb 2024 15:43:38 +0800
Message-Id: <cover.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  selftests: mptcp: add mptcp_lib_pr_ok/skip/fail/info
  selftests: mptcp: print test results with colors
  selftests: mptcp: connect: fix misaligned output
  selftests: mptcp: simult_flows: fix misaligned output
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: connect: print out ping tests info
  selftests: mptcp: add more print_title helpers
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: print test results with counters

 tools/testing/selftests/net/mptcp/diag.sh     | 25 +++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 78 +++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  6 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 52 ++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 37 ++++++---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 12 ++-
 .../selftests/net/mptcp/simult_flows.sh       | 20 +++--
 .../selftests/net/mptcp/userspace_pm.sh       | 16 ++--
 8 files changed, 161 insertions(+), 85 deletions(-)

-- 
2.40.1


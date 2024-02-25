Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110CBE55F
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708852401; cv=none; b=r9BqzBLVSvWWpx3D19FvXM+4RvmqwcTxFbRFzEHX2B/Meu1//aIzH2t2wNqIzwjyNxI1nZbsq3Mdd/3hXujgNhzQcoRa7cJ+Z+O86Lj6EWHxuGdhVuD1UM8kB83Zouudn1M9SZtmpTks3P3GqqMSzXQ725mI+je2uuXmxeKMWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708852401; c=relaxed/simple;
	bh=W+GTD/zBgknNpUJHvTluaMhdSZ4nD+NSqKlqm3aDfpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KMXNlUwdVb1IbidyDDZLzqGohMfyvcJquRKZut93FYMmtFcoFvjDSgT9x42F+szsEwHgwzg9sA8V5nnc2jVAvc30WGWNMtl6FMOYUP62HJbifrRocU/ImE0OMBnplB0lEoEfM0zHQpAZKvBjRUmqgNaHDsGz5OSxVAP1oiMOG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZJFTGu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZJFTGu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C18C433C7;
	Sun, 25 Feb 2024 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708852400;
	bh=W+GTD/zBgknNpUJHvTluaMhdSZ4nD+NSqKlqm3aDfpw=;
	h=From:To:Cc:Subject:Date:From;
	b=sZJFTGu7tXIxQDVvfhSIDdFSRnVxY7/GODoM6oOacUt8n9ZQwoVhOQhK1AlEUM/4m
	 qYwYOFj+O+iPZj1UJw6+26XN7eeKeqgvfSTeuiYZIdQ2hmyEoSXjyzbHk+MH5v54HS
	 6ghTHE/nfrwvH8lG05xajOXQeWjNofSH+tvWZiUVJ0pirVtS1i5YLGpM4DxdPStjl2
	 8Z050cGVytZQOzu3sIpxB5DRFy14XCnuG1nW7tpuRws2G+aKin8ZzH2A88j4J0v2II
	 Y9U6iAHhqy5vO9cZz2nsH8ff3KhPdr2kt+HFfxA6UY/DYeeAB9lsUWGduMVIHNKD++
	 hUec4nyMBp4mQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 00/13] add helpers and vars in mptcp_lib.sh, part 3
Date: Sun, 25 Feb 2024 17:12:21 +0800
Message-Id: <cover.1708852208.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

 tools/testing/selftests/net/mptcp/diag.sh     |  18 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |  86 ++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  73 +++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  95 +++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  33 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  10 +-
 .../selftests/net/mptcp/simult_flows.sh       |  13 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 210 +++++++-----------
 8 files changed, 294 insertions(+), 244 deletions(-)

-- 
2.40.1


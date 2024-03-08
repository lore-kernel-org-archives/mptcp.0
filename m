Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6901E4A4
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877465; cv=none; b=d3mTSKAEhHCcXWfIyVU8Vy+Hj41XqvwZoIaeJ0LEMjrKqcK56gHnZjE7yEYJzJzT4kOHluRLjlVK07yEBfASywcUeylM8dHObx8niO2GnYab8B3abtVEZFIl1nZnMtof2ZC+NT3NzATbhySnXOQ/HRfBOHCyXHBm/nkpTRb60Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877465; c=relaxed/simple;
	bh=SiGATKsbSR3dcZ3SiXB9B4mWnAPCY8eI+xAW4I9uTnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BBUIV71rGGiDxKtlcHlVbUj2mIfqJvJlIMFnEjgaPYZrRnNY0U4UWjAHyL1ryq4EaiPgVm7ih3FxEgsilNkPG0ELvawhhqkGA3q3qzuklndaVRNC6Um1rUA+uQaeIrNhP7UQM1PIU+UciTRDc59OikDW3RjIgin/6ZLO+JRh0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRyGmGE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRyGmGE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BB3C433F1;
	Fri,  8 Mar 2024 05:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877465;
	bh=SiGATKsbSR3dcZ3SiXB9B4mWnAPCY8eI+xAW4I9uTnU=;
	h=From:To:Cc:Subject:Date:From;
	b=VRyGmGE19VBEbzs1wBC8ilnfJ2y2DQEGTb8tNhCZm5wQ4/Hf6BuRB45tDgaWT8I/p
	 CCJlxK8g1qQ2p8zqlYLqnEvlyZVd3a+OIA74uePYGg9pwcqOsM0wKll1Fi6NJSn2o+
	 IjTl9Dhd4GhdFLlyI9eQk9Vhi56Jod6HePez/OtqlpOfduH1VShmizYilZjv+tisfF
	 0DD6tLfEDasONn3Gz/xbNgANbG46SElyTIuHFv0Xz+nG/mllVYEDvnca453HNPlIiP
	 6iR2s5Z8lECYumh469e+epoEEIEYeBjrz1um//IBA4ClaMr6D0t14WQcxMKAbAN4fx
	 XxfIVl9c/utyg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/7] add helpers and vars in mptcp_lib.sh, part 4
Date: Fri,  8 Mar 2024 13:57:33 +0800
Message-Id: <cover.1709876991.git.tanggeliang@kylinos.cn>
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
 - add new patches #1 & #3
 - #2 drop the tab in
"\tExpected value for '${var}': '${!exp}', got '${!var}'.", this breaks
the alignments.
 - drop 'rc' in patch #2 & #4
 - use declare in #5
 - drop 
extra_srv_args+=" $extra_args"
extra_cl_args+=" $extra_args"
   in #7

v1:
 MPTCP events related patches and two cleanups.

Geliang Tang (7):
  selftests: mptcp: call test_fail without argument
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: print_test out of verify_listener_events
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: declare event macros in mptcp_lib
  selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL
  selftests: mptcp: join: use += operator to append strings

 .../selftests/net/mptcp/mptcp_connect.sh      | 18 ++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 92 +++++++------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 67 ++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  4 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  8 +-
 .../selftests/net/mptcp/simult_flows.sh       |  4 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 92 +++++--------------
 7 files changed, 143 insertions(+), 142 deletions(-)

-- 
2.40.1


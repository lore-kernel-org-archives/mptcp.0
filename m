Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57527CCF2
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519337; cv=none; b=XFcYdDbc7INgREnZ/Y78hayEsgR09NXGEvdBp6ObC5QbMbx51SyY5VUYMJEnjzzJ6ic8vJDpDdsI1ttTen2SiV9Dr+PUe2sMv6GJDtGiRnJl9IO+u9ikjpOvrXitum1jlmv7IVTjOPlWX8gBDfaAkxxz5kN5FUtjzEiIabx/aVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519337; c=relaxed/simple;
	bh=YP619uoPdFqrL1xDwUUmU2zSIN5YKjfpgIip1hXDzyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN2kczabcJnQk7PnmgEhl/EdM6EIyRyTD1LuUEnXCEFXoV1uZANFZVe+VoSGCnGI5DhZuymI2+Tsqc6FoA0DTZ3OFeGKS3vbX2ZRa3WcZyy4aC8C6Wh4v21KYQOtAFGRtjM+u0yFUZaRvZkpCbffYS6exju2tX8Anoj/Tc9T2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAE9hs4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAE9hs4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EC7C4CEF7;
	Sun,  4 Jan 2026 09:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519337;
	bh=YP619uoPdFqrL1xDwUUmU2zSIN5YKjfpgIip1hXDzyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAE9hs4f0V6INr/+wkQor0nJEG1b3bj5T8zqebqGLz7YZdMRDcNdDoTmez8g8/aD0
	 9ZTM0Cj8gq+0fZDtB1A1oxuDEBZhy+vuGbmtqtWhBfw8KLID0rFCXl0elEJH6X9b1Q
	 i/TnBGwJWEjKdL5ZB91X4e0dUjR82n3FOO7FY6vUeiJCFtGNSzPqka4fb9rmLU+8cb
	 wIra5DECGVm8ab5+GyQWtuwkOsZF5/iInEiyWQkoCWsoz7HBiNdegBuIfFwVqnycms
	 CJW0xs98enj7OIj+vFqkv/5BIyodflnKIc1irzF1PS7PFT0PYFA3y4Rk/zhIeplesq
	 kNzXqoVO9A1cg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 10/10] selftests: mptcp: join: add mptcp tls tests
Date: Sun,  4 Jan 2026 17:35:11 +0800
Message-ID: <6f4bd896b6ecd35613bd5c41b9f6d208bf403386.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two MPTCP TLS tests have been added to mptcp_join.sh. The command
'./mptcp_join.sh -c' can be used to run the tests.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..18bd29ac5b24 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,4 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_TLS=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b2e6e548f796..f4cf7b5e2388 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -63,6 +63,7 @@ unset fastclose
 unset fullmesh
 unset speed
 unset bind_addr
+unset tls
 unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
@@ -974,6 +975,7 @@ do_transfer()
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
 	local bind_addr=${bind_addr:-"::"}
+	local tls=${tls:-"::"}
 	local listener_in="${sin}"
 	local connector_in="${cin}"
 	port=$(get_port)
@@ -995,6 +997,10 @@ do_transfer()
 		extra_args="-r ${speed}"
 	fi
 
+	if [ -n "${tls}" ]; then
+		extra_args="$extra_args -o TLS"
+	fi
+
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
@@ -4306,6 +4312,31 @@ endpoint_tests()
 	fi
 }
 
+tls_tests()
+{
+	# multiple subflows, tls tests
+	if reset "multiple subflows, tls tests"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		tls=1 run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 2 2 2
+	fi
+
+	# multiple subflows, signal, tls tests
+	if reset "multiple subflows, signal, tls tests"; then
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
+		pm_nl_set_limits $ns2 1 3
+		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
+		tls=1 run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 3 3 3
+		chk_add_nr 1 1
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -4356,6 +4387,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	c@tls_tests
 )
 
 all_tests_args=""
-- 
2.51.0


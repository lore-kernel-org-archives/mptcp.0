Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F51EF19
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764766; cv=none; b=WQWndux/OSuzTb0jc705eFx5NLVm+q7xR/PGaD2mlQWyy714T+nlXRtvxTPl7sx0l3eZcQuyOGFmg3PVbwPxe8ZC+GlIjKKQV0Kvv5M/RhiA1heZft8/CKgd9Qi/5W08rQgOp2D9UPpa7LZeLXEqlGaM1ojM99lPXtc/q0d0Pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764766; c=relaxed/simple;
	bh=9V93nvgUtKhxEzCISXyyuABjVBtSH/H0zPedOnGgnRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xc6VEBURtozsAfm2ARPgGa2DCaFKFiQWo0yheG+qhBTWJ2O8TJCBRHXjS0TXY1PXj9EERpNeuPFs8ou0kbMeeaT6Si1xqKKzf9nnsq7WmBBH2UkDRflApKad+7xRKDGTfMBt7ODABdENKbZ1oZ5hhExqAfXfv3Zy3S53QqZB7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4U7NrAM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4U7NrAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEC9C43390;
	Thu,  1 Feb 2024 05:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764766;
	bh=9V93nvgUtKhxEzCISXyyuABjVBtSH/H0zPedOnGgnRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4U7NrAMlfRl6XT7VImCZFlzehFLw+8HOn6RSQZ6uy8oxOmRSkJfbgCfeMVozKVM1
	 XvWKojvx1kqz3Gcdh0fsvoPjfyrJYyH8KmsXSKrXTC+5gK3LeRpupD/u7jE3k5Th/0
	 KvtJe5mtwcKL+DITmPLoa35d8xvbEgFb7rI6V0TAU6tqA53yJ20fXlMcO93QQvBZvy
	 Yn4ZOA2/FoPhsYhwnF8zx95FvMDmIgQ0EKGDV9KIephToD2rZgL9smcxPmV1ArYxy8
	 j1X5ibr14RlD44S0Q6k8LkgesxZ28wpy8k+9eeyAm75K4verJnTPl01wp9jGsTDRTT
	 yurjBlHimpOxA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 10/15] selftests: mptcp: dump userspace addrs list
Date: Thu,  1 Feb 2024 13:19:00 +0800
Message-Id: <abdd1d9176380337f343ccdf4e57252d75562298.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds two new tests for userspace pm dump address and subflow.
Use userspace_pm_add_addr() and userspace_pm_add_sf() to add an address
and a suflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d471cd4a9904..4ed0796410b9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3586,6 +3586,50 @@ userspace_tests()
 		kill_events_pids
 		mptcp_lib_kill_wait $tests_pid
 	fi
+
+	# userspace pm dump address
+	if reset_with_events "userspace pm dump address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		local dump="id 10 flags signal 10.0.2.1"
+		check_output "userspace_pm_dump $ns1" \
+			     "$dump" "      dump addrs signal"
+		kill_events_pids
+		wait $tests_pid
+	fi
+
+	# userspace pm dump subflow
+	if reset_with_events "userspace pm dump subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		local dump="id 20 flags subflow 10.0.3.2"
+		check_output "userspace_pm_dump $ns2" \
+			     "$dump" "      dump addrs subflow"
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.40.1


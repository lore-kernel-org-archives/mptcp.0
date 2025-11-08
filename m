Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B92135AD
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611687; cv=none; b=a4F8cUGKZy6B63+e2ha0E7/UQ0dYXM0pW6pYK6BDdjYZz1drAg96aEEanVxVjQ285kIXv/pQ257VGH3bZhxyPRGTTSFUlEbupbUzGb8CRzHIM0R3fmmchYpJ0MdZJ+TM34Qm2PsuIG/g+mEM0cSmf51cjBc7mOSRCWCQ37LM6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611687; c=relaxed/simple;
	bh=TOdRrlYJ7Ib2vzkw0+qNc47LTLLRfyL5PMSixDW2NnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OfGK41Cy7OOuBgJCUqM0XytbD7N5jlOElHMpwIIyZM2k6+iVAeWGw6P4kR749/Vl8b+FVfjydq7qBul0GC9fMVg0wejtl8v9oDsps+hRJYC25nVhb6Cg5TyDigr+xwgZs3ak0yHTi1xPmbAMfCiQ7Sa+XT9iXn4YKY6JOvnJmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssdTAMI/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssdTAMI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F067CC2BC86;
	Sat,  8 Nov 2025 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762611687;
	bh=TOdRrlYJ7Ib2vzkw0+qNc47LTLLRfyL5PMSixDW2NnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ssdTAMI/k6sKUMrvsa38c/SX++vWFcajEu7XiAjhJkgG0pEAWubOlNOQ5gcwRk6I3
	 daHMoJqCTJHkEaN8aYZs/dKUnWuI/N7Z4pZIHsyPA8PHYpTA9XHKrKv5+GXHWUooKI
	 KOVOQdtUmyHAyavsR+TKAKD2mXHRHoFV/0MNsoO4U8sx9PjFgWBW7tpc3J3ebIS474
	 001D2pjhhyBfCYNdZsh6XPUZ5G+6PUm+2FZxkFQyMj2f8YLdikuQa2bu3/7zgo2rpZ
	 7+x0923Y5lfpDzW0jVTOyC29+mREKe3tG1TTZzbwxc/HTUdl+48FchqNsNml9Kh+pB
	 E5dqDPYHUNFVA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 08 Nov 2025 15:20:27 +0100
Subject: [PATCH mptcp-next 1/4] selftests: mptcp: join: properly kill
 background tasks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-slft-timeout-stats-v1-1-c2234d277318@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
In-Reply-To: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4413; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TOdRrlYJ7Ib2vzkw0+qNc47LTLLRfyL5PMSixDW2NnU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL5Ax8ef9/Vn5UQGVPL/JLdhTugbNO3qaXxEw/rb0hlW
 driq23dUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBHeFYwMd2rkEmcbPv8uea3o
 xJdPGs3id91lpP0+XzhWwyC89a1tGsM/hU1hSmVfprAcCIydVf00eemkee8lmM9nVXj/lDKoVlj
 ECQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'run_tests' function is executed in the background, but killing its
associated PID would not kill the children tasks running in the
background.

To properly kill all background tasks, 'kill -- -PID' could be used, but
this requires kill from procps-ng. Instead, all children tasks are
listed using 'ps', and 'kill' is called with all PIDs of this group.

Fixes: 31ee4ad86afd ("selftests: mptcp: join: stop transfer when check is done (part 1)")
Fixes: 04b57c9e096a ("selftests: mptcp: join: stop transfer when check is done (part 2)")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6afcf6ad2788..8be8bfa71946 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3995,7 +3995,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -4023,7 +4023,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm create id 0 subflow
@@ -4044,7 +4044,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm remove initial subflow
@@ -4068,7 +4068,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	# userspace pm send RM_ADDR for ID 0
@@ -4094,7 +4094,7 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 1 1
 		kill_events_pids
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 }
 
@@ -4124,7 +4124,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
@@ -4179,7 +4179,7 @@ endpoint_tests()
 			chk_mptcp_info subflows 3 subflows 3
 		done
 
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
@@ -4253,7 +4253,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
 		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
@@ -4301,7 +4301,7 @@ endpoint_tests()
 		wait_mpj $ns2
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		mptcp_lib_kill_wait $tests_pid
+		mptcp_lib_kill_group_wait $tests_pid
 
 		join_syn_tx=3 join_connect_err=1 \
 			chk_join_nr 2 2 2
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ce6c92826be7..91ec75ddcb96 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -359,6 +359,27 @@ mptcp_lib_kill_wait() {
 	wait "${1}" 2>/dev/null
 }
 
+# $1: PID
+mptcp_lib_pid_list_children() {
+	local curr="${1}"
+	# evoke 'ps' only once
+	local pids="${2:-"$(ps o pid,ppid)"}"
+
+	echo "${curr}"
+
+	local pid
+	for pid in $(echo "${pids}" | awk "\$2 == ${curr} { print \$1 }"); do
+		mptcp_lib_pid_list_children "${pid}" "${pids}"
+	done
+}
+
+# $1: PID
+mptcp_lib_kill_group_wait() {
+	# Some users might not have procps-ng: cannot use "kill -- -PID"
+	mptcp_lib_pid_list_children "${1}" | xargs -r kill &>/dev/null
+	wait "${1}" 2>/dev/null
+}
+
 # $1: IP address
 mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]

-- 
2.51.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE51946C
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910865; cv=none; b=gKXbX+Nh7NlxL70iGyv3G2eDj72SZ0ayHXJcZwQUILGwjAUI4N13NKrgbsubzXVBa6i2o0YxsITcb/AWRm349lk5plZDUKNrKfTzKtlQHcOM+l+0oSh0U6Ai6MqV0wurt2Gr/4TWoTW1SpDvjs+P/TUfkBScVQhZww5vNJkFlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910865; c=relaxed/simple;
	bh=cqN9Kjh0SMspUabkfXpdFluEf200wIs7Ec5YJpV9ebY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9wHaWhL3BbIiBv3xoEcS+aJ9GeRoiSaqU+4xJMoblGp9+aZjU1rDJsPeZ5DgZLbE2PgMl44JpkE7b3peW1QVL+kzOjwVLwQtFGF0SRQrdCk+rnesYHAvU7RI/ZTwhLj1aSBIGgF60HPEEDajcXeT9zNoVXKukqIp0VRPNc5tII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bouSVeRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bouSVeRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54754C433C7;
	Wed, 14 Feb 2024 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910865;
	bh=cqN9Kjh0SMspUabkfXpdFluEf200wIs7Ec5YJpV9ebY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bouSVeRcguO+DaUB52FyAWWsIyxAzcw9ZVc6Zw5XdBxSBCYWcQ0MgVP33otyRN7lu
	 CxQdm8XR5o6tepS6aI4qoKxKmdwpqiXMFCbD9/ZI/2Sp6m7O9mRIqekWionsolfh7X
	 G9TyRrX5UK7PB+dvetnqyjbky7vmGPlAvtR9k7NSUG39gQ39BErDGQQOoq2ZTYbvtz
	 iPUTuXv3BtN22DZGPlC3OSDsEDbTafss/WnZx/d2ylTtYJI0IWAKuQtrkVHKvTmSDf
	 HuW6btF+hCACQGPS2exrCYgWpFfNDCWc69zsbsX2iLGzn7QYyug4PebbBzh52rbSxK
	 /ofmCT9rkgLmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 10/15] selftests: mptcp: dump userspace addrs list
Date: Wed, 14 Feb 2024 19:40:01 +0800
Message-Id: <2acb96d2ed25df7fce8bfc0241dc920678510542.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
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
index dcb146c426dd..5f12bd1de383 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3585,6 +3585,50 @@ userspace_tests()
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23B179B2
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069360; cv=none; b=N7MZSyI4q1BKswJClO0c3j9J49GcRT1uRLu27XbI6kJb4Byllo1dq/eqLulf+ALLqVxhgPSY7lLAQgooSnTMaEDVONC32Tl/inypZ7jUHgO8klmL7Matvtiz357d7pMMvPXig5+n5SA1OQsHs+Ub9592MzK7e3eJv58Hze3s4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069360; c=relaxed/simple;
	bh=z7UK3bIDS7fhuJsL4dODzujacM4xESfge8nGWxUA124=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ot2ju3HEKy9RY5K+ZiPLr+StoY0vzZtL6Ta+e6BCXbIE5W6rLpeeqkGPTAoaqt0CYoth20Urw1xWJNlfb4Xmsbwg3vxksNIozh9xy5j4RRD/VK4H4qnlWqxWF8/4NWFFcOWhT05T45FwPXq16wWp2PXyobMb9lO2w7vGCZWcF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRFIV34E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRFIV34E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D99C43390;
	Fri, 16 Feb 2024 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069360;
	bh=z7UK3bIDS7fhuJsL4dODzujacM4xESfge8nGWxUA124=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRFIV34EX1KXe8cIXeuEwBDtWA0X5pf4DjDUlh+mQ0vws9ghUGX0thAgvsV0QoYNM
	 MrXllRO81IYZECx9vxaJxV4+AaffTINRPr0n2lfyC6KyaeCCagOIgCREo8eet0gIoe
	 4wVZKmj9YjNff9Vp99qrWvnCHmV5uuxM1a9P2Y6HKdL86g9k1UZzTEhdJ26FkNQxiJ
	 gNCbLdTYsTH/p0l1hfAi/OJTkRCrUQ8m6HBlxYz2FxRobO06sW9UPQ25y2PrdKUYJH
	 MeWBtgF1Z2MkMKros0WB3GLk8vJfcoQRnGkPJS64hVG9TyQPqpy7BxIJMBwVSEhma4
	 wvK3U17Jw1XOw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 09/14] selftests: mptcp: dump userspace addrs list
Date: Fri, 16 Feb 2024 15:42:11 +0800
Message-Id: <2ec5777c29d4e6e005c015db60432ef4ba734ed0.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_dump() to dump addresses
for the userspace PM. Use this helper to check whether an ID 0 subflow
is listed in the output of dump command after creating an ID 0 subflow
in "userspace pm create id 0 subflow" test. Dump userspace PM addresses
list in "userspace pm add & remove address" test and in "userspace pm
create destroy subflow" test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6f7e83f61707..fb9b3ee9fee0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3350,6 +3350,18 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+# $1: ns
+userspace_pm_dump()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl dump token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3465,10 +3477,24 @@ userspace_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_subflows_total 3 3
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+			check_output "userspace_pm_dump $ns1" \
+				     $'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' \
+				     "      dump addrs signal"
+		fi
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+			check_output "userspace_pm_dump $ns1" \
+				     "id 20 flags signal 10.0.3.1" \
+				     "      dump addrs after rm_addr 10"
+		fi
 		userspace_pm_rm_addr $ns1 20
 		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+			check_output "userspace_pm_dump $ns1" \
+				     "" "      dump addrs after rm_addr 20"
+		fi
 		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3489,8 +3515,18 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+			check_output "userspace_pm_dump $ns2" \
+				     "id 20 flags subflow 10.0.3.2" \
+				     "      dump addrs subflow"
+		fi
 		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+			check_output "userspace_pm_dump $ns2" \
+				     "" \
+				     "      dump addrs after rm_addr 20"
+		fi
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3510,6 +3546,11 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+			check_output "userspace_pm_dump $ns2" \
+				     "id 0 flags subflow 10.0.3.2" \
+				     "      dump addrs id 0 subflow"
+		fi
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.40.1


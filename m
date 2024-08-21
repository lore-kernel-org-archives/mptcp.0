Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4A192D69
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239717; cv=none; b=Y7xp3JEHkNGBtiqntRdc88RJzKmeZNQgzSxLZOesca+ZE6Z5F2EssznY5zR4n2+lkaK4u2RvaTUiU9a2qgG0F0kknvaBuOs2a0UFIR3DG3PxNESAsg9EogKFlhaEiMdr1d4Oz6rR4jv8qcrVyZgvzpUcBh6KMtRPjscsvo/UQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239717; c=relaxed/simple;
	bh=V+sMyuwmSAeQV47EFr7LRLHTvTQMgU7Gh0ocdMGm55w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4hyIKsdMDPaCg8SS7P1ZPGSzD8WabKNhX5Ywu8nfgJREvjPyx4/v32h6qVnY/XRMWddHISVoUZcuOkyGK3f7rh/gA4AKxhLsdCYBBS4gEC41IcVDu75+UtOcb5HvwuzFHjVOH9Y6te71h8mtGB75FPCdYSBV9xeTqVHmBSKj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f59H5H+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f59H5H+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0527AC32782;
	Wed, 21 Aug 2024 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724239717;
	bh=V+sMyuwmSAeQV47EFr7LRLHTvTQMgU7Gh0ocdMGm55w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f59H5H+4dXUXjxxmIdf42SUfii+nmoKI6vr6d/vCsTaO6TRR2reM97F6XRNac3mmD
	 zTc2WcG/Wgwa/zPIwJvYT5xRpe18HjGzDNSeuqnSYesH7DI50qz14SUAcDbnjT29VE
	 eN//kqIlHZUrmpx46BL5DtmOl7PuOJmnjqqrIVxw/q5shlaORN9ORtNe5qoxNwh4FU
	 Zuuzzmo5/cAPwvc5vgKh7ZeqHBAEn5MVOPNiQpmMPd2p5kllTGhfeOmk/x7RvLp0Tp
	 17DGS1D/mbjCAPqrG57tU9oxgsblQBszh3/sLnLSR+GTVILFEYOrby2aBDqg89AYLS
	 WQc1MFfX46VlA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 21 Aug 2024 13:28:32 +0200
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: reset the last TS before
 the first test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-mptcp-ksft-time-v1-3-c4ea94f41244@kernel.org>
References: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
In-Reply-To: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3865; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V+sMyuwmSAeQV47EFr7LRLHTvTQMgU7Gh0ocdMGm55w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmxc9h2uCpAcjTGyqJ+NsePczcqrAq+e4rzqx7y
 RembWOIDwOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsXPYQAKCRD2t4JPQmmg
 c83cD/oDc8/D3KUOkz8KJiM362XSy4m1Jy3BiPaeDUwXwellYIGFNU+d1t66kjq/IuqquIUe3NF
 hStyWWhFVJujUFDaVNxa0ffVlqlbbAfycI7YATu9810lZDkV+k/4BcMj6egqGnMnJjfXWkAqtVQ
 CV/gwLOqXP0JvD2/QDEl9SxjKISGWzWT85UMjB9zsYCAImGOn+d4Z2LAemz8rlX+ZuNv5ReFTBA
 WGqR7aqc0qwo6MfoyGQrgEpwmRZ1zWetakqYYw5gYx3moLySD1u8aok/nNg0/wKXmLR4n53YbmY
 UuK5Is3c61zMITQ7FKk0m/AGEntjJBA5Gn2hT0fuchqOPj0MbrRWwsJ52Vl2K1K2Udxy5WB6cJj
 azvXYliJF+YqS4jwzaQnEg+MC3FlbDfweebZBvJgyJ5zcNPPJM0PHQo7ZUUXOKITCpMXPQaMLAf
 +eM13Lkq0lH1TQMntb7bybZWYEhQLZXiAzJoPYDFcG9YetMygGcYFbMiO3WrgPunzhgfZeiDQr+
 OSyVgdy8WdYoiAvZWMn89s/wRLrNtRp80HTSaHGczgCPRIkmbkF+dccf9SaD/wQ8BIzMwXo0l0Y
 IXwUaNMlOlB4u6QnBNC+Be1a1q2maqLPG+Xn5HcFROtGxNvIKeQZkI2ruTyBhMFYFtBb2yhWQ2v
 Tw15PHKfEyDhgjw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Just to slightly improve the precision of the duration of the first
test.

In mptcp_join.sh, the last append_prev_results is now done as soon as
the last test is over: this will add the last result in the list, and
get a more precise time for this last test.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 2 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 6 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f61e2f5870ea..49d90c4dbc01 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -847,6 +847,8 @@ stop_if_error()
 make_file "$cin" "client"
 make_file "$sin" "server"
 
+mptcp_lib_subtests_last_ts_reset
+
 check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dc089bba113f..24d74054b0c1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3868,9 +3868,11 @@ if [ ${#tests[@]} -eq 0 ]; then
 	tests=("${all_tests_names[@]}")
 fi
 
+mptcp_lib_subtests_last_ts_reset
 for subtests in "${tests[@]}"; do
 	"${subtests}"
 done
+append_prev_results
 
 if [ ${ret} -ne 0 ]; then
 	echo
@@ -3881,7 +3883,6 @@ if [ ${ret} -ne 0 ]; then
 	echo
 fi
 
-append_prev_results
 mptcp_lib_result_print_all_tap
 
 exit $ret
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 68899a303a1a..5e8d5b83e2d0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -349,6 +349,7 @@ init
 make_file "$cin" "client" 1
 make_file "$sin" "server" 1
 trap cleanup EXIT
+mptcp_lib_subtests_last_ts_reset
 
 run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2757378b1b13..2e6648a2b2c0 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -137,6 +137,8 @@ check()
 	fi
 }
 
+mptcp_lib_subtests_last_ts_reset
+
 check "show_endpoints" "" "defaults addr list"
 
 default_limits="$(get_limits)"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index f74e1c3c126d..8fa77c8e9b65 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -286,6 +286,7 @@ while getopts "bcdhi" option;do
 done
 
 setup
+mptcp_lib_subtests_last_ts_reset
 run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9cb05978269d..3651f73451cf 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -150,6 +150,7 @@ mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
 server_evts=$(mktemp)
 mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
 sleep 0.5
+mptcp_lib_subtests_last_ts_reset
 
 print_title "Init"
 print_test "Created network namespaces ns1, ns2"

-- 
2.45.2


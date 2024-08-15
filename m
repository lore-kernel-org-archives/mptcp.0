Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461514D457
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754772; cv=none; b=BdtXStWgvDf3w+nF7eDLEDoyhdH5esH2d2VugoLd4IQV2ZlIKHBycJsqv3al1PXQwBs6UGqiFKYlwkZjeEWHMErXE8ZQuj+Du1DoYLupD5s2gE+v9e1UjTsCxfjmaXXKI+LIId0TmtohUopfCEvAbbWXrrGh06DmVe6meIdO4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754772; c=relaxed/simple;
	bh=+K0nEDS5SwqXT+ETWiABF70t+aDxdxw0WkoSLjPHsn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBvCS0qJ7SrKh15EuSb8y6Nz3M0xRJSQW3SMzy9X5kMh4/Gu6/c2+fSG7KD/AmyTwAgq14jNjRdZ9MKJG6Gz5Gpd6+DpbUyzW77PjR7sZep3X/tQ9DDqBEZQaPgsy2zzuAe81XFg59ND30yCFq/NESHVJDiwuVpkND/5CJMzCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmVfVR2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmVfVR2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B66C4AF0B;
	Thu, 15 Aug 2024 20:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754772;
	bh=+K0nEDS5SwqXT+ETWiABF70t+aDxdxw0WkoSLjPHsn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qmVfVR2u+MTFlZbxxlWlkg4wrZcvh4p9Loi3Q1xjpkMXXv/77eAvFyfZTrUoIg9Lc
	 Va2YoJWG54Bu++i53exnmlYAewTr5xVMpgM8MFil27L5FmLPlMeR1Z8q4TWSb+EI/5
	 84kXwmJChnXtjGoXfsD5hMYE7dEr/UGRZpVI8Pnlir9UKpyitWhwfIj3EXqi4FIs1W
	 b6ERVM8Psy8LWkVipZFgvkS1PTKX1xMhz9A7IwXwL9vnZlFmIrZD6LZ2TFyMmdKfiW
	 IxihEUR9567BM7RDdoDA6f9t9SjKXkkoztLb5LmAm0HG05SoBkDuo3CA6Fw93OzreI
	 zKeN2NHCWFhEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:49 +0200
Subject: [PATCH mptcp-net 08/10] selftests: mptcp: join: validate event
 numbers
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-8-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5773; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+K0nEDS5SwqXT+ETWiABF70t+aDxdxw0WkoSLjPHsn4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJrdkd8Wx0FVg4c58VwaXFxm8996vrhqlkR
 L6HjRaV5VuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c7rrEACuXdzzJ0TzVLQEyaapwnnUg6ApZUN3XIGgDuBx2GvqzPuQNQ5FXExm+oiZSVma745qut2
 RX75SPFFWD/Wj2sQho0TmyqcSsN+i4gmUXtSBJOrt8NGY+y+E2hSkL4dyG2gF70NxaglNscE/3P
 X61JeqsSSBD8H68CtXbajQboAD3Ws+pGc2T173waEAWGBpABrp4+17LJGYx26W5OYVILqhdB9LG
 eXhe12tuvdmuhpAgP8wdCrMWcyDJc3L3IxWN0VyumV2t6oOHF/jwWIea3M7iP8MSGy4Z+Ha4xIc
 pGJzpCSe0k0aMcBwr1l7J8VDD8dM7run7tPgUfch0pQaJDUu6fU48e+a6Bd9iJ5KZtNXI1kaUu2
 j9R8mvas+/9ddQTy7V3aDbMEpFZhO322Vb9OeAPRO3QusoZ0XJ3q76Tfwyc1eeNMngQiTo2Ucn9
 uxadLtafrIhf2ZuEypJUGr+PjfjK00Fg2eSoqI4HCktxJyhIcBPTfhByqeuj/bWxmxYvZDXQc8k
 uwJLz8RaVxNXxHiX/HMeaPhGcwbSuLiv+l/QQTaw83zIlkgiFob+RU63FCypti7Xm3yk+NdVEmX
 hC4j0n2bRfPUNaJ481uSR1hElXFSv4XF3RRWLXVWGaRniZJGC1kHLTqoi0AIvZwt82IYNrjiGCj
 L63jFLzDoWEsJ6g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit:
the number of MPTCP events are checked to make sure there are no
duplicated or unexpected ones.

A new helper has been introduced to easily check these events. The
missing events have been added to the lib.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 74 ++++++++++++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  4 ++
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index af722227b9cd..9e064c518fb8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -446,12 +446,17 @@ reset_with_fail()
 	fi
 }
 
+start_events()
+{
+	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
+	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
+}
+
 reset_with_events()
 {
 	reset "${1}" || return 1
 
-	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
-	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
+	start_events
 }
 
 reset_with_tcp_filter()
@@ -3406,6 +3411,36 @@ userspace_pm_chk_get_addr()
 	fi
 }
 
+# $1: ns ; $2: event type ; $3: count
+chk_evt_nr()
+{
+	local ns=${1}
+	local evt_name="${2}"
+	local exp="${3}"
+
+	local evts="${evts_ns1}"
+	local evt="${!evt_name}"
+	local count
+
+	evt_name="${evt_name:16}" # without MPTCP_LIB_EVENT_
+	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
+
+	print_check "event ${ns} ${evt_name} (${exp})"
+
+	if [[ "${evt_name}" = "LISTENER_"* ]] &&
+	   ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		print_skip "event not supported"
+		return
+	fi
+
+	count=$(grep -cw "type:${evt}" "${evts}")
+	if [ "${count}" != "${exp}" ]; then
+		fail_test "got ${count} events, expected ${exp}"
+	else
+		print_ok
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3648,6 +3683,7 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
@@ -3706,13 +3742,29 @@ endpoint_tests()
 
 		mptcp_lib_kill_wait $tests_pid
 
+		kill_events_pids
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 3
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 4 # one has been closed before estab
+
 		join_syn_tx=6 \
 			chk_join_nr 5 5 5
 		chk_rm_nr 3 3
 	fi
 
 	# remove and re-add
-	if reset "delete re-add signal" &&
+	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
@@ -3753,6 +3805,22 @@ endpoint_tests()
 		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
+		kill_events_pids
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 2
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+
 		join_connect_err=1 \
 			chk_join_nr 4 4 4
 		chk_add_nr 5 5
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 438280e68434..4578a331041e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -12,10 +12,14 @@ readonly KSFT_SKIP=4
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 # These variables are used in some selftests, read-only
+declare -rx MPTCP_LIB_EVENT_CREATED=1           # MPTCP_EVENT_CREATED
+declare -rx MPTCP_LIB_EVENT_ESTABLISHED=2       # MPTCP_EVENT_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_CLOSED=3            # MPTCP_EVENT_CLOSED
 declare -rx MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
 declare -rx MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
 declare -rx MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
 declare -rx MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
+declare -rx MPTCP_LIB_EVENT_SUB_PRIORITY=13     # MPTCP_EVENT_SUB_PRIORITY
 declare -rx MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
 declare -rx MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
 

-- 
2.45.2


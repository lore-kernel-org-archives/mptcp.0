Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643B817
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806139; cv=none; b=TdwWW1P6z1/QsKxxuH/velgcJxHAtf/wkyfGXQ1RmjNuOI+/J3iE8xDhgq/sdVQ709cqM16aIYlkbv/EX2YS+QnuSUfnYYm5UI+v4OqNPnATyt/81dcCkkYzEm6KSlbIeQmULdYiEF3Ms4uc0TDv7EW4nHtzd/ykD6Q7Ogxoofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806139; c=relaxed/simple;
	bh=Gsv8saBvVoXQjvt4mfoKiWBdgMPE/cnw10fq5Td6f7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OMGAQijXy3DCNorwLckPNqftYhxsydlxpZ7iWOKzYb7j8LU4DVAwBGa+cCnxHQ6Jpv7UuBI0dkgFlJ6rnEUDmorSZaOcrRvW6piX8lBOF2fEwftJJpn40dO3ESM8twg1f50E/eFd6jzZ6fRBYUb2op1fSrZ3J6mIxLz7O/3IZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXA6AinZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXA6AinZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E8BC32782;
	Fri, 16 Aug 2024 11:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806139;
	bh=Gsv8saBvVoXQjvt4mfoKiWBdgMPE/cnw10fq5Td6f7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PXA6AinZhCabRcvWFa7ublcAFaYLhx1ExsAeNiagtkXOJ6IOejn/Fs/VJKAlB3oy9
	 LjrJdAwr82d5yLKNPZ4ZquZIJVTj+3aDttt9OCodUQCh9V2LDa8oZTEJRQXD48yFNt
	 Bme4ol7Tl3+lFdetuQTq/HHyD5BRKsA5gSs5vV1zNSOhpVQfbQX7f2KN5kVo2AjNSX
	 7tCmzI87ZIkakGrl384Zm94itg91eBRospZ/zR2dDEpBrQiTCqSFPbfFRGVbJQFIfP
	 mM27+3Q9RsixFzLofaLKW+wdBp9icq2FlttuyAiD2fnDpyZuJDHz4w69FxUHFsOVsB
	 t4jJzJPNAXE2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:02:04 +0200
Subject: [PATCH mptcp-net v2 10/12] selftests: mptcp: join: validate event
 numbers
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-10-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5800; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Gsv8saBvVoXQjvt4mfoKiWBdgMPE/cnw10fq5Td6f7g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGuI6n6HmsdROE4qJ/8epKNJdBIXcrg0ld5T
 3PSu6SY/TmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c8XBEADnO9VQ6HEUPvagu2zKrp7MKRMy3L4P69n8jo1fFIkW2G+P1QERMPCHCqJK3q+JD+yWZ2s
 35a++t7ptDPjtwwBP2dwX6/QSOTr7neniLC1vGi8ph7N3HozreDRNnxoeMF0G8gthucOF75mrbO
 FxLZZyRcCoXdjPY7BtpCAu+nc3dKFfC8LqK6mOYys2czzOC9o1E5PdGz53iZV04h8q6VtMxPVTh
 tu2N9iChMTC3qTrGu30v3OTxeapoUm2nS6+gjgbJQt3NfyT4loyKGQjwS47X4OLJmR80ioMf2Mu
 tKC8+7/AB9xc04kxorz/komjmwGdh4J76/wv6N4LN8DnNJsq+dPu/LSG05HWR3x4fAlTQ8EQ+L+
 O6upeunsSC1B1+ulke03F5HlpkNz4y7ekXPYBgn6hOn7GQUkVqEomJtHMYnQJ7/VWMCTIC7Er7+
 F05x1vVWXMnwVObb7G8hNyif4IXLi35MmzJiWsjPGLF/AO/upx65aEG0qXq3tVgNTq3bj94a9L7
 I+EoO1bgWNLH7ptujzGuT4d6qkVvxjOJ+c0RFkVSSUub88SADJmDZkRmmy7DkDug0NgrKSWJGlK
 XD1RJE4S2TXqK9UUK0Y4aPIHoo832j+MAfiWsmdfqYUampPTivXYvXG1XEIAz+teumc0x+XLPYQ
 zCIRoTBdxpuX1lA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" and "delete re-add signal" to
validate the previous commit: the number of MPTCP events are checked to
make sure there are no duplicated or unexpected ones.

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
index 7867a6ab0646..56557a7e488a 100755
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
@@ -3699,13 +3735,29 @@ endpoint_tests()
 
 		mptcp_lib_kill_wait $tests_pid
 
+		kill_events_pids
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 4
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 5 # one has been closed before estab
+
 		join_syn_tx=7 \
 			chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
 
 	# remove and re-add
-	if reset "delete re-add signal" &&
+	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
@@ -3746,6 +3798,22 @@ endpoint_tests()
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


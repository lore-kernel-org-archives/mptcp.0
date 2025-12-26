Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B81DFDB8
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731239; cv=none; b=dQk61POCU8oiIJp4wjVJIud+Lpybdw8cJTLmUpkvgHdnwfpcJgF+hA5paJVw9DqwiIoYn0VppXvwmHSVb60IiMOyUhlN7t2K6K+5uF7GP0QWQOtThPIeZEAs2Qwtop4PcCzELhLE7TWOOw3s/+UqnMWcuiw6MZxRC+10UDzv4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731239; c=relaxed/simple;
	bh=MCi1y25SPS8z7Y88JLvAm1fEInEpa/6tsyMqcR4lLAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzJDfzC5ZCo0zSjrDyAlkpaHOuY/FYbZ9Ixl4gMYP++3p8mnYFSIcGJH60j4eET0ThHjh6e+hZREJpsD05GYw+6ZR9Z60PxEU8+RQ0Uz7hdv+toP+1MgVZrjmLeEO2zoHkXAsmDL1jRFkGRgqqC1AZEtV1pslCXkYptueXqEPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb5nfXi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb5nfXi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3139C4CEF7;
	Fri, 26 Dec 2025 06:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731239;
	bh=MCi1y25SPS8z7Y88JLvAm1fEInEpa/6tsyMqcR4lLAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wb5nfXi6rNku5QsAlZIQB3frEb0LUkmu2A6tQcnHIRJkTdfcBcIGyJOq9I4PAA+d2
	 uxgjYt0iIAyJOfLq2i6lhbhPSKrf6xwnpIIlU1cXBgkHWJX6p1EO23uULvNtLfTpnP
	 WRK4FraHnIqzdYoUJrh6V2nacuQUouQibzkjGHDHlIX8d9M8IGKeioLRuXNUp/G4eP
	 hYXXcrLl4ARYd7+IwzBJ0NYnJJ9VRLaeZMyTDg8zsSajcbQdAiNUPeEXxcQ038AWXU
	 oyitFZX0Kd6DwRQgIGg46VvZepYFCPmjjk91sqSaHVFz3+I00Djy6YrjYTLbLbFTYy
	 8Kvwg1Ew6sEIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:16 +0100
Subject: [PATCH mptcp-next 02/11] selftests: mptcp: check no dup close
 events after error
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-2-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3443; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MCi1y25SPS8z7Y88JLvAm1fEInEpa/6tsyMqcR4lLAU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dG9/svEz+bFF5LPrhM6zwqfOOJrXNh/9dEot+p1aQ
 PrUOXuUO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy2YmRoSee7fyc7VbBgWFe
 nRovFza1pz7/N7vkN+/hrGzt29Mz/zH8D99frmA2u8GnMd1Jd7b0Uzmmy7MFwgJLtBYorN4VaHO
 TDQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the previous commit: subflow closed events are re-sent
with less info when the initial subflow is disconnected after an error
and each time a subflow is closed after that.

In this new test, the userspace PM is involved because that's how it was
discovered, but it is not specific to it. The initial subflow is
terminated with a RESET, and that will cause the subflow disconnect.
Then, a new subflow is initiated, but also got rejected, which cause a
second subflow closed event, but not a third one.

While at it, in case of failure to get the expected amount of events,
the events are printed.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 49 +++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b2e6e548f796..468ffb97293b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3872,11 +3872,32 @@ chk_evt_nr()
 	count=$(grep -cw "type:${evt}" "${evts}")
 	if [ "${count}" != "${exp}" ]; then
 		fail_test "got ${count} events, expected ${exp}"
+		cat "${evts}"
 	else
 		print_ok
 	fi
 }
 
+# $1: ns ; $2: event type ; $3: expected count
+wait_event()
+{
+	local ns="${1}"
+	local evt_name="${2}"
+	local exp="${3}"
+
+	local evt="${!evt_name}"
+	local evts="${evts_ns1}"
+	local count
+
+	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
+
+	for _ in $(seq 100); do
+		count=$(grep -cw "type:${evt}" "${evts}")
+		[ "${count}" -ge "${exp}" ] && break
+		sleep 0.1
+	done
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -4085,6 +4106,34 @@ userspace_tests()
 		kill_events_pids
 		mptcp_lib_kill_group_wait $tests_pid
 	fi
+
+	# userspace pm no duplicated spurious close events after an error
+	if reset_with_events "userspace pm no dup close events after error" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 2
+		{ timeout_test=120 test_linkfail=128 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+
+		# force quick loss
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&
+		   ip netns exec "${ns2}" ${iptables} -A INPUT -d "10.0.1.2" -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			wait_event ns1 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			chk_subflows_total 1 1
+			userspace_pm_add_sf $ns2 10.0.1.2 0
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		fi
+		kill_events_pids
+		mptcp_lib_kill_group_wait $tests_pid
+	fi
 }
 
 endpoint_tests()

-- 
2.51.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B427877D
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455490; cv=none; b=puDJHw3/AaLVvwagTNFqm689U1lQ4UhSkqwtjLwBreymZo1zh8ISfmnP5yNJ+j3QbZdsSbUSrBLj+WTMZsnuM8qSttad2C3m71G0nt8xki87SUFlSmBbyD0IV5xzfFVEFcfatotbKwb5+5+/zMWQcn3hsbvSMSJ5q0DjS6dbhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455490; c=relaxed/simple;
	bh=mXlPyAoL3j847lYhCnxVMCVgmzpubksaIta4qTjSs/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xx48SNWh0T4L0ZQl4Srf3IdgWKfQOAKnjRTPc+kflPsgGyGU8+7B5r+iMH4PJQ46oQwp9iRyUrUf2orJDOLZ9D0X7/4AW32DA4mrBILAHlN3FJFed2psSjSxFLP/4TKzMSPZ9ZAvg34NhreJFdWN1DS6zxrfLIijGMMzGRCsXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuLHbGLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuLHbGLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFFDC2BC86;
	Mon, 26 Jan 2026 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455490;
	bh=mXlPyAoL3j847lYhCnxVMCVgmzpubksaIta4qTjSs/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IuLHbGLlMkwNgQpviHhk1xdWJlHEEpaycxegzipZO9dZ77rKhf75/ALtlnq3H/++e
	 4N+TekGZhOlIBKxFsLMCidR6WGAuvcHMmovls1wrbga3bRfWc8V7XhuH1/aicFMk/3
	 sHImABmUvr2Ada6YRDAvULZ48tPcf3/zBatC2B395qlr01TLxKfWxvIt25RsVm8F7D
	 vbApUje4aMTJXDY/+WTepuRz9Dq01IYoAYN6LbQpIbRr2Yru+xL7z5AJ1QJ3WGe/kE
	 +i1ZlkkFucOoVuQXDm8SjHTvMSla8Mnnu7DzLe3yRxMaLaqPGMuXg+bY+yWCGK36mW
	 /SyREHwiMjwwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:39 +0100
Subject: [PATCH mptcp-net v2 02/11] selftests: mptcp: check no dup close
 events after error
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-2-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3531; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mXlPyAoL3j847lYhCnxVMCVgmzpubksaIta4qTjSs/E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL91fdrdmxUP1nqV8Yk9tfiXfJOU23X8jnmKik3Qidx
 By/htmko5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLLPjL8DzzxPPGV9b/H92vk
 HoRs4JqbN7/kk05ie07j/92mH2sr3jD8jzLK+ciXec1zvZHZupIvn9bNXqw7u7zE74rdha8pKfu
 l+AE=
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
v2: avoid too long lines with iptables commands (Geliang)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f1a0d812e642..35ff769f440f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3871,11 +3871,32 @@ chk_evt_nr()
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
@@ -4084,6 +4105,36 @@ userspace_tests()
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
+		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&
+		   ip netns exec "${ns2}" ${iptables} -A INPUT -d "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
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


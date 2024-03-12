Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934310E3
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206643; cv=none; b=qlYMNFmo+aPCgfKiDM4BGdU0kXk13KvU3iFqxKKC52HLC5190OD3JdV6cvP6DsV/nz03hLT59h62cI2PpshxjwJVBdB5QkMlS1V0F54QlC5NCsYpel1+fBXJD86Ar3YM5bBwmPGVjm+xWhzvWXSFiffOp8Fz6w7aso/+MyQC7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206643; c=relaxed/simple;
	bh=5BniMrTVpPjmM99YHY3A4p7JS0tMCbqh4vWyZtvt9Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BLjl6Mb0RCitBG5j7y0fyjzVTtJkMT3AKquXsLw/s+B87SHF9eBXx3Mf8YplnJWXPhQ/gn5EO4CDwDClTOb5KLTE7eojaHRAG0UlaSdi/XNU4AU3zvBeiyzb9ODjM/d/k68N88Cu1kp/IMk+E8Vsqer7ZofoIhSirLENcRXwNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvLIrILS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvLIrILS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E151C433C7;
	Tue, 12 Mar 2024 01:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710206643;
	bh=5BniMrTVpPjmM99YHY3A4p7JS0tMCbqh4vWyZtvt9Nk=;
	h=From:To:Cc:Subject:Date:From;
	b=uvLIrILS6oo6Dgka01H3kc5F9tYy9L5C2yS2qZ2bJ/3ckgspkrZBcfx/1QYI9obCg
	 J7Sh8kXIxlzx+px8ZnBA/gIAUG+RrOS5hmz6Arht6W4ubxIBhq0g/RIlVZ1U/EuY/6
	 zcLQQaaLRn5zlRg6UiMF+c5VJ3UbLU/HC7/NZaIYyM3dsyj8gdIZum3UomwqWvPx3B
	 f2kcOpNfjK4eZZtcmMvD4MLw10R+JyC1VTm59vzGYyXVa+a38a+kmJVqNujSUx4zue
	 2KxTl2+cqYhs20+3bSj7UdeC6nJrmc8pezIVjXu1jEja27yB+OOsLk4V38RxeN1mu7
	 +oq5LE864fSXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests: mptcp: iperf mptcp tests
Date: Tue, 12 Mar 2024 09:23:57 +0800
Message-Id: <8f95589ded2c77edbc5086a808703c63b4641e60.1710206580.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCPv1 protocol support has been added in iperf3 recently. This patch
add some tests for iperf3 to demonstrate the advantages of MPTCP over
TCP in latency or packet loss situations.

Note:

Does 'delay 1' in below command mean 'delay 1ms'? I'm not sure.
> tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 1

Should this test be put in a standalone test script or just like in this
patch, as a subtest of mptcp_join.sh?

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 54 ++++++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  6 +++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1052b85d8170..f2279bfa27c3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -141,7 +141,7 @@ init() {
 
 	mptcp_lib_check_mptcp
 	mptcp_lib_check_kallsyms
-	mptcp_lib_check_tools ip ss "${iptables}" "${ip6tables}"
+	mptcp_lib_check_tools ip ss "${iptables}" "${ip6tables}" iperf
 
 	sin=$(mktemp)
 	sout=$(mktemp)
@@ -3570,6 +3570,57 @@ endpoint_tests()
 	fi
 }
 
+iperf_tests()
+{
+	if reset "iperf tcp test, delay 1"; then
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 1
+		ip netns exec $ns1 iperf3 -s &
+		local tests_pid=$!
+		sleep 1
+		ip netns exec $ns2 iperf3 -c 10.0.1.1
+		mptcp_lib_kill_wait $tests_pid
+		chk_join_nr 0 0 0
+	fi
+
+	if reset "iperf mptcp test, delay 1"; then
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 1
+		pm_nl_set_limits $ns1 8 8
+		pm_nl_set_limits $ns2 8 8
+		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		ip netns exec $ns1 iperf3 -m -s &
+		local tests_pid=$!
+		sleep 1
+		ip netns exec $ns2 iperf3 -m -c 10.0.1.1
+		mptcp_lib_kill_wait $tests_pid
+		chk_join_nr 2 2 2
+	fi
+
+	if reset "iperf tcp test, loss 1%"; then
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit loss 1%
+		ip netns exec $ns1 iperf3 -s &
+		local tests_pid=$!
+		sleep 1
+		ip netns exec $ns2 iperf3 -c 10.0.1.1
+		mptcp_lib_kill_wait $tests_pid
+		chk_join_nr 0 0 0
+	fi
+
+	if reset "iperf mptcp test, loss %1"; then
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit loss 1%
+		pm_nl_set_limits $ns1 8 8
+		pm_nl_set_limits $ns2 8 8
+		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		ip netns exec $ns1 iperf3 -m -s &
+		local tests_pid=$!
+		sleep 1
+		ip netns exec $ns2 iperf3 -m -c 10.0.1.1
+		mptcp_lib_kill_wait $tests_pid
+		chk_join_nr 2 2 2
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -3618,6 +3669,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	t@iperf_tests
 )
 
 all_tests_args=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d395692fac0d..8def187c1ef7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -402,6 +402,12 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
+		"iperf"*)
+			if ! iperf3 -h | grep -q multipath; then
+				mptcp_lib_pr_skip "iperf tool does not support MPTCP"
+				exit ${KSFT_SKIP}
+			fi
+			;;
 		*)
 			mptcp_lib_pr_fail "Internal error: unsupported tool: ${tool}"
 			exit ${KSFT_FAIL}
-- 
2.40.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8C24B2C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106250; cv=none; b=nGw76wllZJ4a7UgqDuUPcraXfDvYbG2x+nejvsvxVO4qO0bMr5rTaGy0kVo2F6YnRknmaoSYjcDQNQxaKp6VGgGJUTAkyPNNUyz4EsKBdpFitqsbNTpnn6TEJK9PMBU+WD7E1HNyKbRUo2an+20jI+GBbk2uervNKna60c5XDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106250; c=relaxed/simple;
	bh=Nyyw0JXGy/o1xReAK4b0V7+aueACWfCuZObQeeRFy74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIII5RZjVWMAWmY4p/HdJVPE8lpJcLPdor9dNeuR75SQgNPrAKLPj1lrfsESCjFAMNTUosv7ZTBlXG7QUAMj/nhLJMolS5/DInHjGb5q2mpH+0ghkx/NaZpLfUmktMaXZgf54F19BKoVVP7jJlfKGpriwaWJnR0sAjfcylFO8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpOzM7SB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpOzM7SB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79909C433C7;
	Wed, 28 Feb 2024 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106250;
	bh=Nyyw0JXGy/o1xReAK4b0V7+aueACWfCuZObQeeRFy74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpOzM7SBvgIdUaIiOrZs75vZkNKnpCKlMgzZuii+VIZeVTlTSgOpPlO7KKKxtyLv4
	 OCSnVsQOBZ2s8ZvulFLjFCVJ0V2sNez8JDdmwyMOtmZ0NJBbrk3J23r3hR7I+YlINp
	 ZrbB9hKYNOvPLvPCOEEbsc+yTXjp8WXZmj7cHZB2CjYPco3/vLDvn7gxu+lk03eGAQ
	 P0MrQoNklBtFpwXAxVyWmnYzkJ4lzjAjM1m4/sNXJj3AqkCBBhcnFepsO8bRrVBBPO
	 cWTi1H0qcgF8/2Pb2KMQtiBhDK9XSo1ENRz203wyywGH9QI/q34baWVGL6VJejdJ5Q
	 /asOXXSem1bog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 9/9] selftests: mptcp: print test results with counters
Date: Wed, 28 Feb 2024 15:43:47 +0800
Message-Id: <111be8b3feb6b8410abe43468fe00d28a131c36b.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709105922.git.tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_lib_print_title() to print out
test counter in each test result and increase the counter. Use
this helper to print out test counters for every tests in diag.sh,
mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh,
and userspace_pm.sh.

Each output looks like:

diag.sh
 01 no msk on netns creation                          [  OK  ]
 02 listen match for dport 10000                      [  OK  ]
 03 listen match for sport 10000                      [  OK  ]
 04 listen match for saddr and sport                  [  OK  ]
 05 all listen sockets                                [  OK  ]

mptcp_connect.sh
 01 New MPTCP socket can be blocked via sysctl                      [ OK ]
 INFO: validating network environment with pings
 02 ping tests                                                      [ OK ]
 INFO: Using loss of 0.16% delay 25 ms reorder .. with delay 6ms on ns3eth4
 03 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP  (duration 116ms) [ OK ]
 04 ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP    (duration  33ms) [ OK ]
 05 ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP  (duration  25ms) [ OK ]
 06 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP  (duration 128ms) [ OK ]
 07 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP    (duration  31ms) [ OK ]

mptcp_sockopt.sh
 01 transfer ipv4                                                [ OK ]
 02 mark ipv4                                                    [ OK ]
 03 transfer ipv6                                                [ OK ]
 04 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 05 sockopt v4                                                   [ OK ]
 06 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 07 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 08 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 09 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 10 TCP_INQ: -6 -r tcp                                           [ OK ]

pm_netlink.sh
 01 defaults addr list                        [ OK ]
 02 simple add/get addr                       [ OK ]
 03 dump addrs                                [ OK ]
 04 simple del addr                           [ OK ]
 05 dump addrs after del                      [ OK ]
 06 duplicate addr                            [ OK ]
 07 id addr increment                         [ OK ]
 08 hard addr limit                           [ OK ]
 09 above hard addr limit                     [ OK ]

simult_flows.sh
 01 balanced bwidth                          7411 max 8456       [ OK ]
 02 balanced bwidth - reverse direction      7380 max 8456       [ OK ]
 03 balanced bwidth with unbalanced delay    7434 max 8456       [ OK ]

userspace_pm.sh
 INFO: Init
 01 Created network namespaces ns1, ns2                       [ OK ]
 INFO: Make connections
 02 Established IPv4 MPTCP Connection ns2 => ns1              [ OK ]
 03 Established IPv6 MPTCP Connection ns2 => ns1              [ OK ]
 INFO: Announce tests
 04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token             [ OK ]
 05 ADD_ADDR id:14 10.0.2.2 (ns2) => ns1, reuse port          [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 6 ++----
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ++--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 8 ++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 4 +++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 4 +++-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 5 ++---
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 3 ++-
 7 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index dd9c5bf7a415..2a9c36320f84 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -9,7 +9,7 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-test_cnt=1
+test_cnt=0
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -47,7 +47,7 @@ get_msk_inuse()
 
 print_title()
 {
-	printf "%-50s" "${@}"
+	mptcp_lib_print_title test_cnt "%-50s" "${@}"
 }
 
 __chk_nr()
@@ -74,7 +74,6 @@ __chk_nr()
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
 }
 
 __chk_msk_nr()
@@ -132,7 +131,6 @@ wait_msk_nr()
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 818625b5e605..e9b0b8059efb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -131,6 +131,7 @@ ns2=""
 ns3=""
 ns4=""
 
+#shellcheck disable=SC2034 # TEST_COUNT is used by mptcp_lib.sh
 TEST_COUNT=0
 TEST_GROUP=""
 
@@ -253,7 +254,7 @@ print_title()
 	local msg="${1}"
 	local nr_blank="${2-50}"
 
-	printf "%-${nr_blank}s" "${msg}"
+	mptcp_lib_print_title TEST_COUNT "%-${nr_blank}s" "${msg}"
 }
 
 check_mptcp_disabled()
@@ -325,7 +326,6 @@ do_transfer()
 
 	local port
 	port=$((10000+PORT++))
-	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 58fe4dad9d9d..4f6bbf5711b1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -437,3 +437,11 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+mptcp_lib_print_title() {
+	declare -n counter="${1}"
+	local fmt="${2}"
+	local msg="${3}"
+
+	printf "%02u ${fmt}" "$((++counter))" "${msg}"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c2aeb722a97e..3c381fe90230 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -17,6 +17,8 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
+#shellcheck disable=SC2034 # test_cnt is used by mptcp_lib.sh
+test_cnt=0
 
 ns1=""
 ns2=""
@@ -115,7 +117,7 @@ not 0 - not all expected packets marked" 1>&2
 
 print_title()
 {
-	printf "%-50s" "${@}"
+	mptcp_lib_print_title test_cnt "%-50s" "${@}"
 }
 
 do_transfer()
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index e6b8e3db7788..d714f0befb2e 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -9,6 +9,8 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ret=0
+#shellcheck disable=SC2034 # test_cnt is used by mptcp_lib.sh
+test_cnt=0
 
 usage() {
 	echo "Usage: $0 [ -h ]"
@@ -48,7 +50,7 @@ mptcp_lib_ns_init ns1
 
 print_title()
 {
-	printf "%-50s" "${@}"
+	mptcp_lib_print_title test_cnt "%-50s" "${@}"
 }
 
 check()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 4aa0f95ae11f..1aba050c4d18 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,7 +14,7 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
+test_cnt=0
 ret=0
 bail=0
 slack=50
@@ -127,7 +127,6 @@ do_transfer()
 	local max_time=$3
 	local port
 	port=$((10000+test_cnt))
-	test_cnt=$((test_cnt+1))
 
 	:> "$cout"
 	:> "$sout"
@@ -207,7 +206,7 @@ do_transfer()
 
 print_title()
 {
-	printf "%-55s" "${@}"
+	mptcp_lib_print_title test_cnt "%-55s" "${@}"
 }
 
 run_test()
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 5f32ac451596..236b8aa727c4 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -53,6 +53,7 @@ server_addr_id=${RANDOM:0:2}
 ns1=""
 ns2=""
 ret=0
+test_cnt=0
 test_name=""
 
 _printf() {
@@ -69,7 +70,7 @@ print_test()
 {
 	test_name="${1}"
 
-	_printf "%-68s" "${test_name}"
+	mptcp_lib_print_title test_cnt "%-68s" "${test_name}"
 }
 
 test_pass()
-- 
2.40.1


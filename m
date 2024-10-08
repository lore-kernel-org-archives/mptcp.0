Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC41E04B3
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401742; cv=none; b=TyCMAyLNCK9W7lXT/9nnUVWXyheQgPnTpiJZtksh9PIPoI8BJImHoMsqOCfD/4+cC9jlcB6J86PLFsLpzhPdDa4vvToTXizQy+D93F4t4eyBvUvyr+PVnk0c/t7CqhZwxE6lLri2PiOfO7WCUe/4iRcGb2U0Ra76r1HFQJwhXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401742; c=relaxed/simple;
	bh=QDVEK6f/a0QWZeV8OL0OPS1L1BV2lSBuqsXL7W1FIKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UL6DijyazsSJP9+zcim0mJX2JmTUzBHhokpyuOHz0Sx4KKp6JbCTSyUNYw54m++AAJS6XAgwzibtXlAicY7jk6+ephBJmKm/zLWBC1Sc2+MWiLL0qiMpGEaMTZ5IcRFGPE5t9s3zouWYUUqATZ2QX+8YGKaLXprrnt4CJnC39Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flKn82Jd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flKn82Jd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE980C4CED4;
	Tue,  8 Oct 2024 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728401741;
	bh=QDVEK6f/a0QWZeV8OL0OPS1L1BV2lSBuqsXL7W1FIKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=flKn82Jd1sY8kgoGE8YeIfXMQqjrRox/wZPciOSMhtSF1iaJKY1f0Zio4V4CLUsve
	 8mUM2ZMEQCQ8w4zhsJMe73Dly2ugCxAIH9o3uioSUib6HIAD4i2usbPobZLkIRyD3F
	 6hGFm4P+sSSzPM3OqbJsI79BJtzXMx24vk/S+Xul+MSTdTown7nzlmwYmYmGWi1+iy
	 3WAaymdaCrgVgm4A5Nd8rUivW1gW32xdwLbpEQ/xJezGFr2D6eF21nXtPkX8RF/g8o
	 wGBtE+v3EQxyScnSCENEemd6JAeDUktWb/SSTzf9tMruYMnqScANwOTaReOunKkrUp
	 YckhsvTaniMcA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Oct 2024 17:35:24 +0200
Subject: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: add test-case for
 MPC attempt towards signl ep
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-mpc-hs-port-v3-2-cec1363f0353@kernel.org>
References: <20241008-mpc-hs-port-v3-0-cec1363f0353@kernel.org>
In-Reply-To: <20241008-mpc-hs-port-v3-0-cec1363f0353@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Cong Wang <cong.wang@bytedance.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5231; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fijrEaVyiORbB6ITUB0XKzktTFa2CynDZifwgxvmQTw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnBVFJqfFVwa+dduOaM1DOOaby5TdXayQsCGRR4
 SvBrlNYTbqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZwVRSQAKCRD2t4JPQmmg
 c7suEACrznKp7UI5kakQo1UDtC7V6wxL5FTnLVrf9S6fAU1yp/D3HQc5/bxcSRodoMpr3ymPjBG
 mdzmiewV+NK6kpFdfiDtrydpMfLuCeb6u2j1RYOfE48yCOUezbOA3+DOAEc92BDsSYyw7m1wB3s
 u+sCFWnmMrN7WNAam6VeKucRlkFQSGxIC3x6xWDR+nySobX+PTWsFZwsAgY5l60VD9Ud4jRil8u
 0EtBHeFMXB145NEM+K0MXxU4ZC/+RcwyQRrcqnsi1dH4XAoFs9Ha4+xssoLQVe1zfEVjdrsNkSm
 U8zOy7rlP+De+iiXbrXLVxnMSxiYhgaPJQeaFFvuwBzJcGMXH6fNRzAXifxdMLhUHrOy+LIQAHs
 +s0+xyOBj+AnG9DkVG+afpfxzjdQwEOW5IS4mSGSNbNIVQju3l5bg8PsXf0Kw12vq1FmCj68Vlx
 tRSqWYJG5GjUgSGIgaF7hP8TsrgerZTzXGlx4BD4DdAfSbZ345nyjnPAXRVwgyBe03Bham90hnL
 zgcep3oA6K9hrLStNw+HB29wPeR1RYy9m6ajUIA8z5mVzMRGFsspBPffVkTEovOf58bs2A88sC0
 0Lo9KL9intdlZTc7VCXwnTrq6gS7a4hhNK0xiza4fk+M0HHrwa6NmBas8PiaGzlR41GezlSiLdM
 2COr+TV2Lllmahg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Explicitly verify that MPC connection attempts towards a port-based
signal endpoint fail with a reset.

Note that this new test is a bit different from the other ones, not
using 'run_tests'. It is then needed to add the capture capability, and
the picking the right port which have been extracted into three new
helpers. The info about the capture can also be printed from a single
point, which simplifies the exit paths in do_transfer().

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 117 +++++++++++++++++-------
 1 file changed, 86 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e8d0a01b4144264615d92b953a69ebd934ce468e..c07e2bd3a315aac9c422fed85c3196ec46e060f7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -23,6 +23,7 @@ tmpfile=""
 cout=""
 err=""
 capout=""
+cappid=""
 ns1=""
 ns2=""
 iptables="iptables"
@@ -887,6 +888,44 @@ check_cestab()
 	fi
 }
 
+cond_start_capture()
+{
+	local ns="$1"
+
+	:> "$capout"
+
+	if $capture; then
+		local capuser capfile
+		if [ -z $SUDO_USER ]; then
+			capuser=""
+		else
+			capuser="-Z $SUDO_USER"
+		fi
+
+		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "$ns")
+
+		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
+		ip netns exec "$ns" tcpdump -i any -s 65535 -B 32768 $capuser -w "$capfile" > "$capout" 2>&1 &
+		cappid=$!
+
+		sleep 1
+	fi
+}
+
+cond_stop_capture()
+{
+	if $capture; then
+		sleep 1
+		kill $cappid
+		cat "$capout"
+	fi
+}
+
+get_port()
+{
+	echo "$((10000 + MPTCP_LIB_TEST_COUNTER - 1))"
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -894,33 +933,17 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
+	local port
 
-	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
-	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
+	port=$(get_port)
 
 	:> "$cout"
 	:> "$sout"
-	:> "$capout"
 
-	if $capture; then
-		local capuser
-		if [ -z $SUDO_USER ] ; then
-			capuser=""
-		else
-			capuser="-Z $SUDO_USER"
-		fi
-
-		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
-
-		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
-		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
-		cappid=$!
-
-		sleep 1
-	fi
+	cond_start_capture ${listener_ns}
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat -n
@@ -1007,10 +1030,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if $capture; then
-	    sleep 1
-	    kill $cappid
-	fi
+	cond_stop_capture
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
@@ -1026,7 +1046,6 @@ do_transfer()
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 		cat /tmp/${connector_ns}.out
 
-		cat "$capout"
 		return 1
 	fi
 
@@ -1043,13 +1062,7 @@ do_transfer()
 	fi
 	rets=$?
 
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-		cat "$capout"
-		return 0
-	fi
-
-	cat "$capout"
-	return 1
+	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
 
 make_file()
@@ -2873,6 +2886,32 @@ verify_listener_events()
 	fail_test
 }
 
+chk_mpc_endp_attempt()
+{
+	local retl=$1
+	local attempts=$2
+
+	print_check "Connect"
+
+	if [ ${retl} = 124 ]; then
+		fail_test "timeout on connect"
+	elif [ ${retl} = 0 ]; then
+		fail_test "unexpected successful connect"
+	else
+		print_ok
+
+		print_check "Attempts"
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPCapableEndpAttempt")
+		if [ -z "$count" ]; then
+			print_skip
+		elif [ "$count" != "$attempts" ]; then
+			fail_test "got ${count} MPC attempt[s] on port-based endpoint, expected ${attempts}"
+		else
+			print_ok
+		fi
+	fi
+}
+
 add_addr_ports_tests()
 {
 	# signal address with port
@@ -2963,6 +3002,22 @@ add_addr_ports_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2 2
 	fi
+
+	if reset "port-based signal endpoint must not accept mpc"; then
+		local port retl count
+		port=$(get_port)
+
+		cond_start_capture ${ns1}
+		pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
+		mptcp_lib_wait_local_port_listen ${ns1} ${port}
+
+		timeout 1 ip netns exec ${ns2} \
+			./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP 10.0.2.1 >/dev/null 2>&1
+		retl=$?
+		cond_stop_capture
+
+		chk_mpc_endp_attempt ${retl} 1
+	fi
 }
 
 syncookies_tests()

-- 
2.45.2


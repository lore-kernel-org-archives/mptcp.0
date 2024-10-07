Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD51DE2C6
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325639; cv=none; b=otsaZxgwKmDpQPyDT8dd6IVZVsaZ52DnDA28vyfgcTdBLnKxCXL+KSrLjSHNztfh4fvhPcEValJJJrm0/9BGNPAfV6SbFinBCK/ASrzywnUZOhEGuuwS2yCMo9MJgTI8xio/SPgYkzbyl7KcYwlNjlLs4s0awfCweEtzj7so2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325639; c=relaxed/simple;
	bh=MUf/4hcFBsZXZ/x8IXkBH0b/c2lqTEgXYYcLA2J9qzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxYWWRhkBc8lH3sb2zSuEaoBP7bx9aEk/aEg50aU4M3OpY019Ai6a79Ex0Kc4CqY5EBaUoPFuNX8+a4sg4TN4ajPGphNc7CPtYSp4jJWFTYFwOqNgYGG3biFCmmVAklrc+r33+y0vVrHpEfGWSnIn6byg4NQXyaHX6lNLKvuGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgjRqWL3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgjRqWL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAB4C4CEC7;
	Mon,  7 Oct 2024 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325638;
	bh=MUf/4hcFBsZXZ/x8IXkBH0b/c2lqTEgXYYcLA2J9qzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pgjRqWL3HQVb/SB/fV+v6+arKhR/17Hm7EfqfD6gI93RYLI+VFWqPtsr2G4007dNN
	 LvPmxFcOyze2VqfGJlNcxUgJQaH4aezvK4hLqYPo37B9iqwTeh8/NR57dvQF6S6AFC
	 03QmDxTDnscDXEaW9BwlgWoR0BwaZpgmvpo+LoBTzx6/Sr2LfkQuDbuy30hBOFMdPK
	 RvIDIF/o9BBLTaij1xk302pq8VcFeZV2pqAblj27Xvj+Vha1+waNb2cmFnvwKlkojb
	 9yz1T4w7SSyCz2X+RmUhnDBI26EKyEslW0ebdFn499oB9eO1qpUYS1bPG7XYX+DfjZ
	 knfoG868DE25Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 07 Oct 2024 20:22:21 +0200
Subject: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: add test-case for
 MPC attempt towards signl ep
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-mpc-hs-port-v2-2-0c9e7827bd0f@kernel.org>
References: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
In-Reply-To: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4142; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Hne65RIBJX56/9b6We3WkAeR4Tfzom8dvoUnIm9akgs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnBCgCp0BwTJpEZPgB0JantH3AVezw7SKy1Amas
 x+mCmKOZmSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZwQoAgAKCRD2t4JPQmmg
 c5wiD/4pg4qjl6cFX/fD6rx4vV10IPnoXsYhO92roJKEKAxCWyfLt8jVTaPv1ys5INwg5n7I2/5
 jcv2DTvJDzW5Wo0XB+pEKi1fo1esuN0Cw9pZPXLNyBw96YdULwC3zFer+eSREKgtuAd9qvTd/z/
 goWhBw2Aw1UyU/FNy+UubimRE+dXzCz89y1j7tVmTLWOLAXj5N840Dobb3xbnEZB3E102VJu53B
 ss8U2Hq6IaYwicp2gVPgt6p0KNYJQoD/S1jrntmTjCROPQsvKSmTk29y4hl2H3aL4Q+2itgle58
 Q6ALv6yw3iBq5gscuTJfsyt/2CsHfhsV3hbD0SS27LTKLS2epS8mKagqpqeWaNTnvIV/6TSYE3d
 c46fF/rXYN7LccUPwjetPRYXC7C9hsD8MyK4ke84vdtCXolADwOgHlTmslPZhYlhHiL33KoZ2wD
 cRMj/Qfg3HYwdnMON2mHRylwzdo77PraHp8L71Z+66cklc0xKTuLOVGAJV/k2teAiLNEcaO5Nfw
 eK6KUTadklvNW0GDPnOmlDknazZlijkjTJTTAmq8+2zcUlBigp8xopaICWQUbNaP4kohPfA4f9m
 TDpUrvk5kfhC3G+qQ30/BInMZ1mGbGEjxmqAId1ZiFfbavLtL5yAxQMCyRHOu9TYta3vFb5F1+R
 sB/0DNG77NjF7uw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Explicitly verify that MPC connection attempts towards a port-based
signal endpoint fail with a reset.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 110 +++++++++++++++++++-----
 1 file changed, 87 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e8d0a01b4144264615d92b953a69ebd934ce468e..518b81004df9d0e4568b88782836798e197f1427 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -41,6 +41,7 @@ evts_ns2_pid=0
 last_test_failed=0
 last_test_skipped=0
 last_test_ignored=1
+cappid=""
 
 declare -A all_tests
 declare -a only_tests_ids
@@ -887,6 +888,43 @@ check_cestab()
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
@@ -895,32 +933,16 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 
-	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
-	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
+	local port
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
@@ -1007,10 +1029,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if $capture; then
-	    sleep 1
-	    kill $cappid
-	fi
+	cond_stop_capture
 
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
@@ -2873,6 +2892,32 @@ verify_listener_events()
 	fail_test
 }
 
+chk_mpc_endp_attempt()
+{
+	local ret=$1
+	local attempts=$2
+
+	print_check "Connect"
+
+	if [ ${ret} = 124 ]; then
+		fail_test "timeout on connect"
+	elif [ ${ret} = 0 ]; then
+		fail_test "unexpected successful connect"
+	else
+		print_ok
+
+		print_check "Attempts"
+		count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPCapableEndpAttempt")
+		if [ -z "$count" ]; then
+			print_skip
+		elif [ "$count" != "$attempts" ]; then
+			fail_test "got ${count} MPC attempt[s] on port-based endpoint, expected $attempts"
+		else
+			print_ok
+		fi
+	fi
+}
+
 add_addr_ports_tests()
 {
 	# signal address with port
@@ -2963,6 +3008,25 @@ add_addr_ports_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2 2
 	fi
+
+	if reset "port-based signal endpoint must not accept mpc"; then
+		local port ret count
+		port=$(get_port)
+
+		cond_start_capture ${ns1}
+
+		pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
+		mptcp_lib_wait_local_port_listen ${ns1} ${port}
+
+		timeout 1 ip netns exec ${ns2} \
+			./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP 10.0.2.1 >/dev/null 2>&1
+		ret=$?
+
+		cond_stop_capture
+		cat "$capout"
+
+		chk_mpc_endp_attempt ${ret} 1
+	fi
 }
 
 syncookies_tests()

-- 
2.45.2


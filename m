Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F48387363
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811112; cv=none; b=g/X3UD9E/9xQ1N1uNYxLNyKBzxcFKCF/YV4or7f8FnzxO9nH0j8IGqtbahj3GZ7nG2yu/j8PnoQccH7XqDRWXvqqVR5aSz8Sq3KRdfiokJUdHm4uQZfk+8TNfGzY57Ztc52J7K3Anh1Zz+pblGYTqMA7OY2RRdaYsh7sQf8u8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811112; c=relaxed/simple;
	bh=d0UY7a2QtaLH6rv5/j48uKfAucjgumrU//UG7C/Ypm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rCWtO3nHkwEw7oqBCu+mjQ1kJAg1gLBFcoNdNRDLZ3m/bck3K8enHqE5KA2QDvUb0++PNWcsb1edtrQ/GhFMIjL69a1xL7pmP91dks5ISi1GAcEF5gxoU7ZKi6ldBDf8mGnXPG5sGPbuug1Ox3TXO2NLFS8qEW9IFxXm1WYi/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX/7WpZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX/7WpZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF20C2BCB3;
	Fri, 15 May 2026 02:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778811111;
	bh=d0UY7a2QtaLH6rv5/j48uKfAucjgumrU//UG7C/Ypm0=;
	h=From:Date:Subject:To:Cc:From;
	b=aX/7WpZT5Emheg29nXEKUCzZeGkgxN2EXyn5Ub+L9bcjfLvMcPqT8cS8Uz38WClfT
	 FuUPoEwviahQ3dLhZi9E6QAexHATfZDpZ7qxzTdA1qoPeuAPvjohbnWCFA+O/R3WZZ
	 mpDZjpPC7Xhvx0su0cgHdpG11nXyjBzYhCxIGwqpny97O5a+aij+aTUVwBULwyr6Sm
	 eM+3FOCXvtLnyIqUJM9QTLM8x06ttSoNOC8/FCfeEEK5+KHS8J814WoH2a/KlkCZXC
	 xlpL65cnb3IjjT8ybzWCqsEpWuFz9MrFXFQLecrBup82keUw1vtbC0yTxr3iKJMIbg
	 yBAumWPC8sIfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 May 2026 04:11:28 +0200
Subject: [PATCH mptcp-net] selftests: mptcp: drop nanoseconds width
 specifier
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-mptcp-sft-uutils-0-8-0-v1-1-4801c8e16485@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7UAaiQSvIi7ScaIjGkMmEaH07
 o3t4i8en/dmUC7CCudhhsJfUfmkDuNhAHqEdGeUW2ewxp6MGx2+c6WMGiu2VuWlaND3Gc9HsuR
 CDB66nAtH+W3hC+xO4grX/dI2PZnqPwzLsgLsFik4hQAAAA==
X-Change-ID: 20260515-mptcp-sft-uutils-0-8-0-08e3c2c5afa8
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3286; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=d0UY7a2QtaLH6rv5/j48uKfAucjgumrU//UG7C/Ypm0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBoDixnhTgihtFxMBBWQv5x9c0kP/hZl33u+60
 mevjNw+1H+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagaA4gAKCRD2t4JPQmmg
 c6vrD/9uq3/XN6mJ5+GYCtZug8nF6UB5wCcCShKWb4Kf0aZGWDP1rl87F7RN6vR17njFFXxGJop
 qnkdBuu33Uxynk+bERz1kWHFEJiaiZoW6coUqm4vPCdkXOZW3w+57uaLFP+YDgfmyc4cEwK0H10
 kpZ1PeXqdDc6cW2eXAnCGxD624EuahWkL1Jx+n9mwtUMXD2i24OXMXgW2PcP19GzmL048DcqH2P
 uByUbshQmjYiqccMe+jFgv8trspQSzEfm6VAl/WuccUkNDbV19JdP/Gv8Bm5kE6eyiDMQ3oOatk
 sllj5DqERm40gs71NbkSYc98sjkuNB1w/2aLNwlRU6lFy/rla0PjtDKDG7IhrcovQ4j0crpI9vk
 Ab2njK+6MQ9Ak0CV7v8GZ5Wrr8ui+LxsSdsDki4BRhnySEZdWAi3JOMr8ub4O8wHsLM5XZCGyjH
 Z2QTiPu2iYlyF80xDFj1wqu1FURgOKPeHD7VH79k/db4ZJmL3OqnGjVSf4kShCS5Wp6/RzaWo5Q
 iX4LRWmp5EuKRJJTd1mZD4ZQvGJXr0Pg5n/Hr0gcsomY3+rXB1AO3NVLS+aHX0RczlB2zB62edi
 jFWEDM2YQLYqr/gloN7XjQGfs+HEjvPAcJY4reeKyn+zA+pRY686OkvbUDLlwwKDVXvBPceyFWd
 ZIq+zIyDmbCnHhg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Using the format specifier +%s%3N with GNU date is honoured, and only
prints 3 digits of the nanoseconds portion of the seconds since epoch,
which corresponds to the milliseconds.

The uutils implementation of date currently does not honour this, and
always prints all 9 digits. This is a known issue [1], but can be worked
around by adapting this test to use nanoseconds instead of microseconds,
and then divide it by 1e6.

This fix is similar to what has been done on systemd side [2].

Link: https://github.com/uutils/coreutils/issues/11658 [1]
Link: https://github.com/systemd/systemd/pull/41627
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a6447f7a31fe..d158678fa6ab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -401,7 +401,7 @@ do_transfer()
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
 	local start
-	start=$(date +%s%3N)
+	start=$(date +%s%N)
 	ip netns exec ${connector_ns} \
 		./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 			$extra_args $connect_addr < "$cin" > "$cout" &
@@ -423,7 +423,7 @@ do_transfer()
 	fi
 
 	local stop
-	stop=$(date +%s%3N)
+	stop=$(date +%s%N)
 
 	if $capture; then
 		sleep 1
@@ -439,7 +439,7 @@ do_transfer()
 	fi
 
 	local duration
-	duration=$((stop-start))
+	duration=$(((stop-start) / 1000000))
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [ ${timeout_pid} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 989a5975dcea..9d3efbfb3015 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -236,7 +236,7 @@ mptcp_lib_kversion_ge() {
 }
 
 mptcp_lib_subtests_last_ts_reset() {
-	MPTCP_LIB_SUBTESTS_LAST_TS_MS="$(date +%s%3N)"
+	MPTCP_LIB_SUBTESTS_LAST_TS_MS="$(date +%s%N)"
 }
 mptcp_lib_subtests_last_ts_reset
 
@@ -255,7 +255,7 @@ __mptcp_lib_result_check_duplicated() {
 __mptcp_lib_result_add() {
 	local result="${1}"
 	local time="time="
-	local ts_prev_ms
+	local ts_prev_ns
 	shift
 
 	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
@@ -265,9 +265,9 @@ __mptcp_lib_result_add() {
 	# not to add two '#'
 	[[ "${*}" != *"#"* ]] && time="# ${time}"
 
-	ts_prev_ms="${MPTCP_LIB_SUBTESTS_LAST_TS_MS}"
+	ts_prev_ns="${MPTCP_LIB_SUBTESTS_LAST_TS_MS}"
 	mptcp_lib_subtests_last_ts_reset
-	time+="$((MPTCP_LIB_SUBTESTS_LAST_TS_MS - ts_prev_ms))ms"
+	time+="$(((MPTCP_LIB_SUBTESTS_LAST_TS_MS - ts_prev_ns) / 1000000))ms"
 
 	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*} ${time}")
 }

---
base-commit: 5964bb11dac34466d64d9d939e8498db9f576f6c
change-id: 20260515-mptcp-sft-uutils-0-8-0-08e3c2c5afa8

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


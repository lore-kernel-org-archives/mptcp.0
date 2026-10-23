Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747205;
	b=vQ6V/ekF5iMfmU5XTF0lrhnXpJrTIinh2nndhGxoZcqlpBqSiPM35ceIb4lcB8sSzePG
	 ajVLwm6nP62nS+sjxo2hnPlOVGuXnaXHEFqz0nvMtvOWrsUSgOCtJ6XO9Cyh0ASeiHpjg
	 NfqzSGn/2kchQ4GFT6OlKb+m2b7VpgUnQm8vKAhFB6gQ3vVIrqPnwR5FOYpYaor19Eg74
	 UFUubRjTDIOcFwLwHPNkqWT3C6/EmysXs87y46+nVHKJpnjxaiGRGdodFTax7Dh8z77ec
	 YqXXRMOOGZQJm0H0G4xkscdJAyhvVwxAkLuRpLdYOVcWNjiNR4sc+6dCxjwnhZmATRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TWwloY9pWFDxOLaYsI6WRieVmnDInp7PpLH1go7U6kA=;
	b=iyIiccMt8sTaBswTLWHAt//TMACQMQYjEs6F3SfGODDt2xRPJUchcKY20A3L9Ht+0pzb
	 ntXEX6CdlnSa54DBLlhrx+5J4M5chzXHFecHRjytc7LfnOhKmUHqLAdRXc5QtINdIPd4B
	 AGXnGwOni+Rjj/obvYffqN0PCBJk69t3/SU7rv0u3TBZrrKn+iD5z4h7srYmYr6/1hReA
	 m21XdNB3CnnSU3exAKqbeyVP/vvmMKzTXysqK1f05BnAjo4JJcHUKFB2+W2qtognkDusw
	 cK35UlvBEl73SdwKEZYdJzgONaJs7nnaB00e1Kw5axwXNiNoJOO61yq+9YJD8yQGb/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8KrMh8k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDC606A31B
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8KrMh8k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD62E1F031E0;
	Fri, 23 Oct 2026 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747204;
	bh=TWwloY9pWFDxOLaYsI6WRieVmnDInp7PpLH1go7U6kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8KrMh8kQDEzRKmlcZ5RqSrcK8sFkQftA7efP13vUP/5J2LaRtQCBO3SaoMd8zShN
	 bJlfwJffj3SYMSTXqL0nAWrsytNvnQL9CbroudzAEqg3ducXCc4BPLnPb+qJia/yft
	 rSpqNtxqJfDuViYmG4c9XzCrTo8FzCBTh6or7yOAUmz6azaqz5qOxJ6tY7FhM6PXn2
	 bewertuhUdNQJZqTTDRZNCF9WxkjzJxUMdZ0nLBt/+jt0wuPYk4U7BthtIBnSXt/AF
	 EvFvI9z1u4H91mwQoAjXCSZaRgcn4syWxoF1G5fS3Fgd4gYbXIRzYpkAO2FkDu3GHf
	 1sIz6b0gSt+pg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: add mptcp nbd tests
Date: Fri, 23 Oct 2026 17:19:56 +0800
Message-ID: <8cd8c351da081aa504f4bf25d3cdaf64613070d9.1792746800.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792746800.git.tanggeliang@kylinos.cn>
References: <cover.1792746800.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_nbd.sh to verify NBD (Network Block Device) works correctly
over both TCP and MPTCP.

Both ns1 and ns2 have 4 virtual network interfaces, each limited to
1000 Mbit/s (125 MB/s). When running NBD over TCP, fio tests show
read/write bandwidth of about 110 MiB/s:

 # ./mptcp_nbd.sh tcp
 Negotiation: ..size = 256MB
 Connected /dev/nbd0
 connected

 fio-3.41
 ... ...
 Run status group 0 (all jobs):
    READ: bw=112MiB/s (117MB/s), 112MiB/s-112MiB/s (117MB/s-117MB/s), \
		io=1119MiB (1173MB), run=10002-10002msec
 ... ...
 Run status group 0 (all jobs):
   WRITE: bw=113MiB/s (118MB/s), 113MiB/s-113MiB/s (118MB/s-118MB/s), \
		io=1129MiB (1184MB), run=10002-10002msec

With simple MPTCP configuration and running MPTCP NBD, we can achieve
about 400 MiB/s read/write bandwidth:

 # ./mptcp_nbd.sh mptcp
 INFO: nbd-server lacks native MPTCP, using mptcpize
 INFO: nbd-client lacks native MPTCP, using mptcpize
 Negotiation: ..size = 256MB
 Connected /dev/nbd0
 connected

 fio-3.41
 ... ...
 Run status group 0 (all jobs):
    READ: bw=406MiB/s (426MB/s), 406MiB/s-406MiB/s (426MB/s-426MB/s), \
		io=4063MiB (4261MB), run=10001-10001msec
 ... ...
 Run status group 0 (all jobs):
   WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), \
		io=3758MiB (3940MB), run=10001-10001msec

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  13 +
 .../testing/selftests/net/mptcp/mptcp_nbd.sh  | 309 ++++++++++++++++++
 4 files changed, 324 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nbd.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..2c8b12866f81 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS := \
 	mptcp_connect_sendfile.sh \
 	mptcp_connect_splice.sh \
 	mptcp_join.sh \
+	mptcp_nbd.sh \
 	mptcp_sockopt.sh \
 	pm_netlink.sh \
 	simult_flows.sh \
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 6a96cfbbc461..f6f266211bee 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_BLK_DEV_NBD=y
 CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_IP_ADVANCED_ROUTER=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index e1c8c6fd8820..aee7a73d9772 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -541,6 +541,19 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
+		"nbd")
+			if ! command -v nbd-client &> /dev/null || \
+			   ! command -v nbd-server &> /dev/null; then
+				mptcp_lib_pr_skip "nbd tools not found"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		"fio")
+			if ! fio -h &> /dev/null; then
+				mptcp_lib_pr_skip "fio tool not found"
+				exit ${KSFT_SKIP}
+			fi
+			;;
 		*)
 			mptcp_lib_pr_fail "Internal error: unsupported tool: ${tool}"
 			exit ${KSFT_FAIL}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_nbd.sh b/tools/testing/selftests/net/mptcp/mptcp_nbd.sh
new file mode 100755
index 000000000000..935dea5738aa
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_nbd.sh
@@ -0,0 +1,309 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/mptcp_lib.sh"
+
+ret=0
+trtype="${1:-mptcp}"
+ns1=""
+ns2=""
+port=$((RANDOM % 10000 + 20000))
+temp_file=""
+server_pid=""
+
+export trtype port
+export temp_file server_pid
+
+usage()
+{
+	cat << EOF
+
+Usage:
+
+	$(basename "$0") [trtype]
+
+	trtype   Transport type (tcp|mptcp) - default: mptcp
+
+EOF
+exit ${KSFT_FAIL}
+}
+
+validate_params()
+{
+	if [[ ! "${trtype}" =~ ^(tcp|mptcp)$ ]]; then
+		echo "Invalid trtype ${trtype}. Must be tcp or mptcp"
+		usage
+	fi
+}
+
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317,SC2329
+cleanup()
+{
+	# Disconnect nbd device in ns2
+	ip netns exec "$ns2" nbd-client -d /dev/nbd0 2>/dev/null || true
+
+	sleep 1
+
+	# Kill nbd-server in ns1
+	if [ -n "${server_pid}" ]; then
+		ip netns exec "$ns1" kill "${server_pid}" 2>/dev/null || true
+	fi
+	ip netns exec "$ns1" pkill -9 -f nbd-server 2>/dev/null || true
+
+	# Clean up temp files
+	if [ -n "${temp_file}" ]; then
+		ip netns exec "$ns1" rm -f "${temp_file}" 2>/dev/null || true
+	fi
+
+	mptcp_lib_ns_exit "$ns1" "$ns2"
+
+	unset -v trtype port
+	unset -v temp_file server_pid
+}
+
+init()
+{
+	mptcp_lib_ns_init ns1 ns2
+
+	ip netns exec "$ns1" sysctl -qw net.ipv4.tcp_reflect_tos=1
+
+	# ns1		ns2
+	# 10.1.1.1	10.1.1.2
+	# 10.1.2.1	10.1.2.2
+	# 10.1.3.1	10.1.3.2
+	# 10.1.4.1	10.1.4.2
+	for i in {1..4}; do
+		ip link add ns1eth"$i" netns "$ns1" type veth peer \
+			name ns2eth"$i" netns "$ns2"
+		ip -net "$ns1" addr add 10.1."$i".1/24 dev ns1eth"$i"
+		ip -net "$ns1" link set ns1eth"$i" up
+		ip -net "$ns2" addr add 10.1."$i".2/24 dev ns2eth"$i"
+		ip -net "$ns2" link set ns2eth"$i" up
+		ip -net "$ns2" route add default via 10.1."$i".1 \
+			dev ns2eth"$i" metric 10"$i"
+
+		# Rate limit to 1000mbit
+		tc -n "$ns1" qdisc add dev ns1eth"$i" root netem rate 1000mbit
+		tc -n "$ns2" qdisc add dev ns2eth"$i" root netem rate 1000mbit
+	done
+
+	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.1.1 flags signal
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.2.1 flags signal
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.3.1 flags signal
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.4.1 flags signal
+
+	mptcp_lib_pm_nl_set_limits "${ns2}" 8 8
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.1.2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.2.2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.3.2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.4.2 flags subflow
+}
+
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+run_server()
+{
+	local conf_file="/tmp/nbd-server.conf"
+
+	# Create backing file
+	temp_file="/tmp/nbd_backing.raw"
+	dd if=/dev/zero of="${temp_file}" bs=1M count=0 seek=256 2>/dev/null
+
+	# Detect MPTCP support: native config or mptcpize fallback
+	local use_mptcpize=""
+	local mptcp_opt=""
+	if [ "${trtype}" = "mptcp" ]; then
+		if ! grep -q '"mptcp"' /usr/bin/nbd-server 2>/dev/null && \
+		   ! nbd-server --help 2>&1 | grep -qi mptcp; then
+			if command -v mptcpize &> /dev/null; then
+				use_mptcpize="mptcpize run -d"
+				echo "INFO: nbd-server lacks native MPTCP," \
+					"using mptcpize"
+			else
+				echo "ERROR: no MPTCP support in nbd-server"
+				return 1
+			fi
+		else
+			mptcp_opt="mptcp = true"
+			echo "INFO: nbd-server has native MPTCP support"
+		fi
+	fi
+
+	cat > "${conf_file}" << CONF
+[generic]
+	port = ${port}
+	listenaddr = 0.0.0.0
+	${mptcp_opt}
+
+[test]
+	exportname = ${temp_file}
+CONF
+
+	# Use -n (nodaemon) and background manually for better control
+	${use_mptcpize} nbd-server -C "${conf_file}" -n > /dev/null 2>&1 &
+	server_pid=$!
+
+	sleep 2
+
+	# Verify server is running
+	if ! kill -0 "${server_pid}" 2>/dev/null; then
+		echo "nbd-server failed to start"
+		return 1
+	fi
+}
+
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+run_client()
+{
+	local extra_args=()
+	local nbd_dev="/dev/nbd0"
+	local server_addr="10.1.1.1"
+
+	local use_mptcpize=""
+	if [ "${trtype}" = "mptcp" ]; then
+		if nbd-client 2>&1 | grep -qE "\-M|\-\-mptcp"; then
+			extra_args+=("-M")
+			echo "INFO: nbd-client has native MPTCP support (-M)"
+		elif command -v mptcpize &> /dev/null; then
+			use_mptcpize="mptcpize run -d"
+			echo "INFO: nbd-client lacks native MPTCP," \
+				"using mptcpize"
+		else
+			echo "ERROR: no MPTCP support in nbd-client"
+			return 1
+		fi
+	fi
+
+	# Options before positional args: -N name host port device
+	if ! ${use_mptcpize} nbd-client -N test "${extra_args[@]}" \
+			"${server_addr}" "${port}" "${nbd_dev}"; then
+		echo "Failed to connect ${nbd_dev} to ${server_addr}"
+		return 1
+	fi
+
+	sleep 1
+
+	# Verify connection
+	if ! nbd-client -c /dev/nbd0; then
+		echo "nbd-client check failed"
+		return 1
+	fi
+
+	return 0
+}
+
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+run_io_test()
+{
+	local nbd_dev="/dev/nbd0"
+
+	# dd write test
+	if ! dd if=/dev/urandom of="${nbd_dev}" bs=4k count=1000 \
+			conv=fdatasync 2>/dev/null; then
+		echo "dd write failed"
+		return 1
+	fi
+
+	# dd read test
+	if ! dd if="${nbd_dev}" of=/dev/null bs=4k count=1000 2>/dev/null; then
+		echo "dd read failed"
+		return 1
+	fi
+
+	# fio random read test
+	if ! fio --name=randread --direct=1 --ioengine=libaio \
+		 --blocksize=4k --runtime=10 --time_based \
+		 --rw=randread --numjobs=1 --iodepth=32 \
+		 --group_reporting --size=128M \
+		 --filename="${nbd_dev}"; then
+		echo "fio randread failed"
+		return 1
+	fi
+
+	# fio random write test
+	if ! fio --name=randwrite --direct=1 --ioengine=libaio \
+		 --blocksize=4k --runtime=10 --time_based \
+		 --rw=randwrite --numjobs=1 --iodepth=32 \
+		 --group_reporting --size=128M \
+		 --filename="${nbd_dev}"; then
+		echo "fio randwrite failed"
+		return 1
+	fi
+
+	# Verify MPTCP subflows if trtype is mptcp
+	if [ "${trtype}" = "mptcp" ]; then
+		local sf_total sf_max tcp_conns is_fallback
+		sf_total=$(ss -Mia | grep -oP "subflows_total:\K[0-9]+" | \
+			head -1)
+		sf_max=$(ss -Mia | grep -oP "subflows_max:\K[0-9]+" | head -1)
+		tcp_conns=$(ss -tia | grep -c "tcp-ulp-mptcp" || true)
+		is_fallback=$(ss -Mia | grep -c "fallback" || true)
+		if [ "${is_fallback}" -gt 0 ]; then
+			echo "FAIL: MPTCP fell back to TCP!" \
+				"subflows_total:${sf_total}" \
+				"tcp_subflows:${tcp_conns}"
+		elif [ -n "${sf_total}" ]; then
+			echo "PASS: MPTCP subflows_total:${sf_total}" \
+				"subflows_max:${sf_max}" \
+				"tcp_subflows:${tcp_conns}"
+		else
+			echo "WARNING: No MPTCP subflows info found"
+		fi
+	fi
+
+	return 0
+}
+
+mptcp_lib_check_tools nbd fio
+validate_params
+
+trap cleanup EXIT
+
+init
+
+run_test()
+{
+	if ! ip netns exec "$ns1" bash <<- EOF
+		$(declare -f run_server)
+		export trtype port
+		run_server
+		exit \$?
+	EOF
+	then
+		ret="${KSFT_FAIL}"
+		return
+	fi
+
+	# Get server pid for cleanup
+	server_pid=$(ip netns exec "$ns1" pgrep -f "nbd-server" | head -1)
+
+	sleep 1
+
+	if ! ip netns exec "$ns2" bash <<- EOF
+		$(declare -f run_client run_io_test)
+		export trtype port
+		run_client || exit 1
+		run_io_test || exit 1
+		exit \$?
+	EOF
+	then
+		ret="${KSFT_FAIL}"
+	fi
+
+	sleep 1
+}
+
+run_test "$@"
+
+if [ "${ret}" -eq 0 ]; then
+	mptcp_lib_result_pass "nbd over ${trtype} test"
+else
+	mptcp_lib_result_fail "nbd over ${trtype} test"
+fi
+
+mptcp_lib_result_print_all_tap
+exit "$ret"
-- 
2.55.0


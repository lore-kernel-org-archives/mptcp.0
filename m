Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010944;
	b=AUNUFoiVoZje9HVwzbE/wbxJdfUTEHfha/SShnGzoKC5emy9yPmxCge6mAX0co5b+bi3
	 VgljC+81CPgFOtADvcnqQSkokNs73yedNBmHnjfiFtVV2VwaYykrn/DAYwg4o2abGPQMx
	 nmMCFHzMMxdwars4JtV8HeZHErtjBSjPGehoCHINxnuzwsPQnmn3R76Og9TGAQnlMiWeK
	 NYcdhRgIsMSSiJWbsuhsUmGkjg15KwowYzLFLy76V5ZJdn6BIfWMhHayqhjP6Tu8KEN7Y
	 m+SnR0moaEof+L8Qkp/nqylt2YbBb94UEKr9SciS5hMj0IyM67EEbAczLu0eZj/Lzgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010944;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AwedCw9HauZAg9E7H5gCp0Hty7nvYJAYUbyT0DPW7q8=;
	b=Dw8RuMUk3IEuJaPhyEaaga/5HP5KMAEit2Lxxp6rpNXKL2JdvEjakpOeQdMr+hxjpw9n
	 gxOBx4cFvAoGQpFPdSdr69gJKq+JUK77hZePj/igA7+aUfnZNy1mC9u+S4dzTEqdf1ccD
	 ts3BGNnmGBTb6YExMf90NO6wWRWtDOYOkjpZZ9D5UjOh9ESetE3RUixaIUQcDShtWcl5R
	 oJBmle6P05ikqt2sGb1XUtLeP+WJD6ALVh/5Z5iOP10w/w7cA9EvntLv73TEZdrbN0qB6
	 GdAsYLdLHdIR7P0CHfawQYVYryZNPxEM7x2fCof9gILRI31mf/ZESM9zn28mZKFNrRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ctrl5r55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F5606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ctrl5r55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAED01F031E1;
	Mon, 26 Oct 2026 10:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010944;
	bh=AwedCw9HauZAg9E7H5gCp0Hty7nvYJAYUbyT0DPW7q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ctrl5r55k2uvteKAfaMAltjlLJjj/pqwXGCCu7LIc/DVScUhM7cZBPK8IJOIJtM5b
	 llry93iuuSjB4VLOFGMkaQtYkay5IR+lumf4bQYYVUN3mwU67Dl4WbJMHO1znra+Et
	 qPaZDivW8POjmIsH7Ug6bRGJL2PhTiIxmAWzcRK7EQLrkD0V0FuQA0csrrncFRz/K4
	 NtDTRDS7nGrqPdCpIq7V7uSPdau+R6xZbID/a0epDZSXYqfT87kxzAyk7tG4dpQrzI
	 TBhp2uf52W5e7HRSqq9ygSA8W31NxgdpeYNUi5alvP93g0ISETLx6K3hIieBQj/1Lg
	 lt0p9vstPFRrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/4] selftests: mptcp: add mptcp nbd tests
Date: Mon, 26 Oct 2026 18:35:28 +0800
Message-ID: <14de6d44e34c880f684ce171784dc04407e8958c.1793010744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793010744.git.tanggeliang@kylinos.cn>
References: <cover.1793010744.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/mptcp_nbd.sh  | 373 ++++++++++++++++++
 4 files changed, 388 insertions(+)
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
index 000000000000..29998be71a98
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_nbd.sh
@@ -0,0 +1,373 @@
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
+conf_file=""
+pid_file=""
+server_pid=""
+
+export trtype port
+export temp_file conf_file pid_file server_pid
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
+		ip netns exec "$ns1" kill -9 "${server_pid}" 2>/dev/null || true
+	fi
+
+	# Clean up temp files
+	if [ -n "${temp_file}" ]; then
+		ip netns exec "$ns1" rm -f "${temp_file}" 2>/dev/null || true
+	fi
+	if [ -n "${conf_file}" ]; then
+		ip netns exec "$ns1" rm -f "${conf_file}" 2>/dev/null || true
+	fi
+	if [ -n "${pid_file}" ]; then
+		ip netns exec "$ns1" rm -f "${pid_file}" 2>/dev/null || true
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
+
+	# Create temp files using mktemp for security
+	temp_file=$(mktemp /tmp/nbd_backing_XXXXXX.raw)
+	conf_file=$(mktemp /tmp/nbd_server_XXXXXX.conf)
+	pid_file=$(mktemp /tmp/nbd_server_XXXXXX.pid)
+}
+
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+run_server()
+{
+	# Create backing file
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
+	# Write PID to file for parent process to read
+	echo "${server_pid}" > "${pid_file}"
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
+	local test_data
+	local read_data
+
+	# Create temp files for data integrity test
+	test_data=$(mktemp /tmp/nbd_test_XXXXXX.bin)
+	read_data=$(mktemp /tmp/nbd_read_XXXXXX.bin)
+
+	# Data integrity test: write and verify
+	dd if=/dev/urandom of="${test_data}" bs=1M count=10 2>/dev/null
+	if ! dd if="${test_data}" of="${nbd_dev}" bs=1M \
+			conv=fdatasync 2>/dev/null; then
+		echo "dd write failed"
+		rm -f "${test_data}" "${read_data}"
+		return 1
+	fi
+
+	if ! dd if="${nbd_dev}" of="${read_data}" bs=1M count=10 \
+			2>/dev/null; then
+		echo "dd read failed"
+		rm -f "${test_data}" "${read_data}"
+		return 1
+	fi
+
+	if ! cmp -s "${test_data}" "${read_data}"; then
+		echo "FAIL: Data integrity check failed"
+		rm -f "${test_data}" "${read_data}"
+		return 1
+	fi
+	echo "PASS: Data integrity verified"
+	rm -f "${test_data}" "${read_data}"
+
+	# dd write test (larger, for performance measurement)
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
+			return 1
+		elif [ -n "${sf_total}" ]; then
+			echo "PASS: MPTCP subflows_total:${sf_total}" \
+				"subflows_max:${sf_max}" \
+				"tcp_subflows:${tcp_conns}"
+		else
+			echo "FAIL: No MPTCP subflows info found"
+			return 1
+		fi
+	fi
+
+	return 0
+}
+
+# Check MPTCP support in kernel
+mptcp_lib_check_mptcp
+
+# Check for required tools
+mptcp_lib_check_tools ip tc ss nbd fio
+
+# Check for /dev/nbd0
+if [ ! -b /dev/nbd0 ]; then
+	mptcp_lib_pr_skip "/dev/nbd0 not found"
+	exit ${KSFT_SKIP}
+fi
+
+validate_params
+
+# Check for mptcpize if using MPTCP transport
+if [ "${trtype}" = "mptcp" ]; then
+	if ! command -v mptcpize &> /dev/null; then
+		mptcp_lib_pr_skip "mptcpize tool not found"
+		exit ${KSFT_SKIP}
+	fi
+fi
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
+	# Get server pid for cleanup from file
+	server_pid=$(ip netns exec "$ns1" cat "${pid_file}" 2>/dev/null)
+	server_pid="${server_pid:-}"
+
+	# Wait for server to be ready instead of fixed sleep
+	mptcp_lib_wait_local_port_listen "$ns1" "$port"
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792881770;
	b=hDLfm6tv2v6Ua13JN6ppisGw1s7zYxlO4o3aeX5scp0jOlWLyzzAjFh160g3bPDgtXNL
	 MRqT+DnFKkV/R54oxCAvK5hMggTkk4j7Uwk+I0/kkgS/1y2yzAh8Twx1iWtbW2F0Iqrt3
	 fAlktoJvCE+hU+zj+kROcP4gt2+JCBaNNV8XW8cD7m0ZWMFGLI0dyx4CnIzKRhLBV2Eqb
	 BDYN9dnh9BFCsvcZ/cf0peowcqJKrnnV91F82ENL/Re6vdiUn/nIJIgNjmQYStI37ZgJ/
	 cytbpwagHmJE8hHFP97uQrL8auqT3qt9t2oEtwdD0FfoEX50+ij7evzO+BvliZ7bPzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792881770;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LWL+/6isqHipeu+HL+cCMKCQcVse842+6eWk5dIJQdY=;
	b=ve57/QnxYWngXg+52ui/59UfFy8WcakyzvkTXBmQ7HtRVfRDziClxR9TC4pt/pypyVZr
	 NsOv4BvbcEHM7Fk3OtcbTOHL4FhAD2a9n6eSKM3hgW/NcXdYE7Y9JPu9fAcHJ/or0TEey
	 gwcIj04d9YTrs9JoL84V4MK72YTMO3bcMC+t1XSkqeljyMXP0oH6mGZT3wx6eR6BiVDMd
	 6i1n/A41h+DM6MD09DWGtIcNl5PbOC9qhSDKT+8OuE3wUw3uPcv8phE1qs6nn261eX8bK
	 0hdaoZYvXwB5FsGlnk2kYny7u0aRff3YeRXp5NW8PcIXX67XPoVS+PFHsnI+9+N5enw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7AKR1KL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF2606A31D
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7AKR1KL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B79F1F01828;
	Sat, 24 Oct 2026 22:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792881769;
	bh=LWL+/6isqHipeu+HL+cCMKCQcVse842+6eWk5dIJQdY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L7AKR1KL9TXVGognQfjhA1e6LRT9aCs39OQgVOFdz+zCxr9m3CogHy3ozCrZtwrYJ
	 25YfH2ucA3JxRxGTbEh6SSH7UbfdvSMKBzRppgqe4HrINcHVYLHgzwBOcEk9vOoEsD
	 XfcLQ+AVgpiRHk2ObqYBq0NG43tNUuJLSrAOeQbSuCicL55Iiecm1ETDiGTVcSBYyB
	 29CYfLveAU+/C1S/aQXyXCumuKrhgg+V8q5kcdOTQwy4L5F0RJWiQSnvtHhgC2t1nH
	 6M7oq9TjASzGIErCRrbf/j7iB0GeMdR4NiFnEmDTbQBzH6b7ZguT9oGaPd0CMkyHlG
	 Q3fEC7XYwFMQA==
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: add mptcp nbd tests
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 22:42:48 +0000
Message-ID: <179288176882.3132.11870431209419877537@kernel.org>
In-Reply-To: =?utf-8?q?=3C8cd8c351da081aa504f4bf25d3cdaf64613070d9=2E1792746?=
 =?utf-8?q?800=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C8cd8c351da081aa504f4bf25d3cdaf64613070d9=2E17927468?=
 =?utf-8?q?00=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 8 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In mptcp mode the MPTCP check in run_io_test()
  (tools/testing/selftests/net/mptcp/mptcp_nbd.sh) can never fail the…
- [Medium] The default mptcp mode depends on the external `mptcpize`
  tool.
- [Medium] cleanup() and run_test() act on host-global resources as if
  the test's network namespaces isolated them.
- [Medium] run_io_test() never checks the data that goes through NBD,
  even though the commit says the test verifies that NBD "works…
- [Medium] mptcp_nbd.sh skips the environment checks that every other
  MPTCP selftest performs: - It does not call mptcp_lib_check_mptcp.
- [Medium] Each run leaves /tmp/nbd_backing.raw and /tmp/nbd-server.conf
  on the host, and the 'Clean up temp files' code in cleanup() can never…
- [Medium] run_server() uses the fixed, predictable paths /tmp/nbd-
  server.conf and /tmp/nbd_backing.raw in the shared, world-writable…
- [Medium] Server and client startup are ordered with fixed sleeps
  instead of a readiness check.

--

selftests: mptcp: add mptcp nbd tests

This adds mptcp_nbd.sh. The script runs NBD over TCP or MPTCP between two
network namespaces connected by four rate-limited veth links, and
exercises the device with dd and fio. It also adds nbd and fio tool
checks to mptcp_lib.sh and enables CONFIG_BLK_DEV_NBD in the selftest
config.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_nbd.sh b/tools/testing/selftests/net/mptcp/mptcp_nbd.sh
> new file mode 100755
> index 0000000000000..935dea5738aa1
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/mptcp_nbd.sh
> @@ -0,0 +1,309 @@

[ ... ]

> +cleanup()
> +{
> +	# Disconnect nbd device in ns2
> +	ip netns exec "$ns2" nbd-client -d /dev/nbd0 2>/dev/null || true
> +
> +	sleep 1
> +
> +	# Kill nbd-server in ns1
> +	if [ -n "${server_pid}" ]; then
> +		ip netns exec "$ns1" kill "${server_pid}" 2>/dev/null || true
> +	fi
> +	ip netns exec "$ns1" pkill -9 -f nbd-server 2>/dev/null || true

[Severity: Medium]
Can this cleanup affect NBD users outside the test? ip netns exec only
switches the network and mount namespaces. There is no PID namespace,
and NBD devices are global to the host.

The "trap cleanup EXIT" line is installed before init() and before any
NBD setup, so cleanup() always runs nbd-client -d /dev/nbd0. That covers
early failures, nbd-server start failures, and the case where the client
connect failed because /dev/nbd0 was already in use.

In that last case, wouldn't this disconnect a device the test never
owned, such as a mounted filesystem, a VM disk, an NBD root, or a
concurrent test run?

The pkill -9 -f nbd-server line also sends SIGKILL to every process on the
host whose command line contains nbd-server.

Also, the server_pid=$! set in run_server() only exists in the child
bash. run_test() therefore looks the PID up again with a host-wide search:

	server_pid=$(ip netns exec "$ns1" pgrep -f "nbd-server" | head -1)

Could that return the PID of an unrelated nbd-server, which cleanup()
then sends SIGTERM to?

> +
> +	# Clean up temp files
> +	if [ -n "${temp_file}" ]; then
> +		ip netns exec "$ns1" rm -f "${temp_file}" 2>/dev/null || true
> +	fi

[Severity: Medium]
Can this rm ever run? run_test() runs run_server() in a child bash through
the ip netns exec "$ns1" bash heredoc, so this assignment never reaches
the parent shell:

	temp_file="/tmp/nbd_backing.raw"

The top-level export temp_file only passes values from parent to child.
In the parent, temp_file stays empty, so the [ -n "${temp_file}" ] check
is always false.

conf_file (/tmp/nbd-server.conf) is a local in run_server(), and nothing
removes it either.

Doesn't every run leave both files in /tmp? The backing file holds the
dd data plus up to 128MB of fio randwrite data, and on a tmpfs /tmp that
memory stays in use after the test ends.

The early "no MPTCP support" return in run_server() also leaves the
backing file behind, because dd has already created it.

[ ... ]

> +run_server()
> +{
> +	local conf_file="/tmp/nbd-server.conf"
> +
> +	# Create backing file
> +	temp_file="/tmp/nbd_backing.raw"
> +	dd if=/dev/zero of="${temp_file}" bs=1M count=0 seek=256 2>/dev/null

[Severity: Medium]
Is it safe to use fixed, predictable paths in the shared /tmp here?
ip netns exec does not provide a private /tmp, and there is no mktemp,
O_EXCL or symlink protection.

Two instances running at the same time would overwrite each other's
config and backing file.

The script runs as root. A local unprivileged user could create
/tmp/nbd_backing.raw beforehand as a symlink to any file or block device.
Then:

- the dd above opens it with O_CREAT|O_WRONLY and follows the link
- nbd-server runs as root with no user/group in the config, so it exports
  the resolved target
- the dd and fio randwrite in run_io_test() write random data over its
  first ~128MB

If /tmp/nbd-server.conf is instead created in advance as a file the user
can write, cat > keeps its owner and mode. The user could then rewrite
exportname before nbd-server reads it.

Only fs.protected_symlinks and fs.protected_regular block this. Both
default to 0 in the kernel, although many distros enable them.

The other scripts in this directory create their temporary files with
$(mktemp). Could this script do the same?

> +
> +	# Detect MPTCP support: native config or mptcpize fallback
> +	local use_mptcpize=""
> +	local mptcp_opt=""
> +	if [ "${trtype}" = "mptcp" ]; then
> +		if ! grep -q '"mptcp"' /usr/bin/nbd-server 2>/dev/null && \
> +		   ! nbd-server --help 2>&1 | grep -qi mptcp; then
> +			if command -v mptcpize &> /dev/null; then
> +				use_mptcpize="mptcpize run -d"
> +				echo "INFO: nbd-server lacks native MPTCP," \
> +					"using mptcpize"
> +			else
> +				echo "ERROR: no MPTCP support in nbd-server"
> +				return 1
> +			fi

[Severity: Medium]
Should a missing mptcpize give KSFT_SKIP rather than a failure?

nbd-server and nbd-client have no native MPTCP support yet. The "nbd:
allow MPTCP sockets" commit says "Future patches will add -M (--mptcp)
options". So the default mptcp mode depends on mptcpize, which ships
separately in mptcpd.

The up-front mptcp_lib_check_tools nbd fio call does not check for
mptcpize. On a host with nbd and fio installed but no mptcpize:

- this branch returns 1
- the ns1 bash exits 1
- run_test() sets ret="${KSFT_FAIL}"

run_client() follows the same pattern with "ERROR: no MPTCP support in
nbd-client".

[ ... ]

> +	# Use -n (nodaemon) and background manually for better control
> +	${use_mptcpize} nbd-server -C "${conf_file}" -n > /dev/null 2>&1 &
> +	server_pid=$!
> +
> +	sleep 2
> +
> +	# Verify server is running
> +	if ! kill -0 "${server_pid}" 2>/dev/null; then
> +		echo "nbd-server failed to start"
> +		return 1
> +	fi

[Severity: Medium]
Could this race with nbd-server reaching listen()? kill -0 only checks
that the process exists. run_test() then waits a fixed sleep 1 before
nbd-client connects to 10.1.1.1:${port}.

On slow CI machines (debug or KASAN kernels, mptcpize LD_PRELOAD
startup), the connect could get ECONNREFUSED. run_client() would then
return 1 and the test would report KSFT_FAIL.

mptcp_lib.sh already provides mptcp_lib_wait_local_port_listen(), which
the other MPTCP tests use. Could it replace the fixed sleeps here?

[ ... ]

> +run_io_test()
> +{
> +	local nbd_dev="/dev/nbd0"
> +
> +	# dd write test
> +	if ! dd if=/dev/urandom of="${nbd_dev}" bs=4k count=1000 \
> +			conv=fdatasync 2>/dev/null; then
> +		echo "dd write failed"
> +		return 1
> +	fi
> +
> +	# dd read test
> +	if ! dd if="${nbd_dev}" of=/dev/null bs=4k count=1000 2>/dev/null; then
> +		echo "dd read failed"
> +		return 1
> +	fi

[Severity: Medium]
Does this check that the data comes back intact through NBD? The commit
message says the test verifies that NBD "works correctly" over MPTCP.
However, the random data from /dev/urandom is never saved, and the
read-back goes to /dev/null without any comparison.

The fio randread and randwrite jobs below also run without --verify.
Only exit statuses are checked. Corruption, reordering or loss on the
NBD-over-MPTCP path, for example during reinjection across the 4
subflows, would still pass unless the block layer returns an I/O error.

Other tests here, such as mptcp_connect.sh and simult_flows.sh, compare
the transferred data with mptcp_lib_check_transfer(). Could this test do
something similar?

[ ... ]

> +	# Verify MPTCP subflows if trtype is mptcp
> +	if [ "${trtype}" = "mptcp" ]; then
> +		local sf_total sf_max tcp_conns is_fallback
> +		sf_total=$(ss -Mia | grep -oP "subflows_total:\K[0-9]+" | \
> +			head -1)
> +		sf_max=$(ss -Mia | grep -oP "subflows_max:\K[0-9]+" | head -1)
> +		tcp_conns=$(ss -tia | grep -c "tcp-ulp-mptcp" || true)
> +		is_fallback=$(ss -Mia | grep -c "fallback" || true)
> +		if [ "${is_fallback}" -gt 0 ]; then
> +			echo "FAIL: MPTCP fell back to TCP!" \
> +				"subflows_total:${sf_total}" \
> +				"tcp_subflows:${tcp_conns}"
> +		elif [ -n "${sf_total}" ]; then
> +			echo "PASS: MPTCP subflows_total:${sf_total}" \
> +				"subflows_max:${sf_max}" \
> +				"tcp_subflows:${tcp_conns}"
> +		else
> +			echo "WARNING: No MPTCP subflows info found"
> +		fi
> +	fi
> +
> +	return 0
> +}

[Severity: Medium]
Can this check ever fail the test? All three branches print a message and
then reach return 0. run_test() only sets ret to KSFT_FAIL when the ns2
bash exits non-zero.

If ss -Mia reports a fallback, the script prints "FAIL: MPTCP fell back
to TCP!" but still reports "nbd over mptcp test" as passed.

If no MPTCP socket is found, the else branch also returns 0. This can
happen when the mptcpize LD_PRELOAD had no effect and nbd_get_socket()
received a plain TCP socket. It can also happen when ss lacks MPTCP
support, since the script never calls mptcp_lib_check_tools ss.

The elif branch only checks that subflows_total is non-empty. In
mptcp_diag_fill_info():

	info->mptcpi_subflows_total = info->mptcpi_extra_subflows +
		__mptcp_has_initial_subflow(msk);

So a connection with only the initial subflow also passes, even when none
of the extra subflows configured in init() were created.

In each of these cases, doesn't mptcp mode show nothing more than tcp
mode? In particular, it never confirms that nbd_get_socket() took the
msk_is_mptcp() branch.

> +
> +mptcp_lib_check_tools nbd fio
> +validate_params

[Severity: Medium]
Should this also call mptcp_lib_check_mptcp, and request the ip, tc and
ss tool checks?

diag.sh, mptcp_connect.sh, mptcp_join.sh, mptcp_sockopt.sh,
pm_netlink.sh, simult_flows.sh and userspace_pm.sh all call
mptcp_lib_check_mptcp, which skips when /proc/sys/net/mptcp/enabled is
missing. This script uses ip, tc ... netem and ss -Mia without checking
that they are available.

On a kernel without MPTCP, the sysctl in mptcp_lib_ns_init() and the
mptcp_lib_pm_nl_* helpers fail without being checked. The mptcp run then
either fails or gives a meaningless pass, instead of KSFT_SKIP.

The script also does not check whether the kernel's nbd driver accepts
MPTCP sockets. Kernels without "nbd: allow MPTCP sockets" (for example
stable kernels running newer selftests) reject the socket in
nbd_get_socket() with -EINVAL. The test would then report a failure
instead of a skip.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792746800.git.tanggeliang%40kylinos.cn

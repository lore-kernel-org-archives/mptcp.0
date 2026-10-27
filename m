Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144791;
	b=uqRFUjmUYgPdKbCHFnmmnWG19sJbq8OKtWIAd5ML9mL/XVKBA3kBDzLDCZDn3aPLyvtK
	 Ll+rWG1ricvzwtStByagBt4qSQGeBbZYLrTzjwuQLqCPg9Xp1bvkiMK7IiotFe7+QUN2W
	 0EMWN0AaTsTbGoSipBPPwgkUiBuK4YI9JwInqXI3MUCaQmff+DkDbRhiMA32kIJYjIazq
	 HoScuOvm+R+jELS9xHwRp/H973pEFPUcPxREnHol74cazKXTXmtLtho36rR0VQ554qJtz
	 TUL7dVVIImZ5RSpKA5LJ9PPPP/je/WckaIbcqKGXzKixlgBZvx/k8XeO3xlE1d6WUMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144791;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SpHJGKrmgMBr+FNHqmd7GrR2K+i9xqV2HKx37GAbjf4=;
	b=Mg28scbOqcETj/5Yi/BJaHE/csr6CSr93Hs7v5YAla0VEGVY0tTlohxflXOkElda1fKZ
	 NA0Efqg1goloZ22nqZBtubLADyp+2M3SF6JnpuPBFpPo19V9WqMoUA6m0gwrlFzoS0lBp
	 FVYdsTuPQYSbgE/IkpC3Gx89SfDzSZVRz8UfsuQcrt/WmQakaJvMfhdc7NRUvBG+AWByA
	 MqJ2T80U5y02L1WXarvhE8EJovWzu8Cy+lV83xZRSi6K7ClsyKOT+RnobsJMPtMpnC9oV
	 7bSRsGY/BimeHhVcFXEx37hihASvWuZSubNqpfrc/UCsI6bSnX+rCdejIWUrSW5nLRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCjTw2Vo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F9F606A321
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCjTw2Vo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC941F01828;
	Tue, 27 Oct 2026 23:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144790;
	bh=SpHJGKrmgMBr+FNHqmd7GrR2K+i9xqV2HKx37GAbjf4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RCjTw2VoT83zhywj7wRZ9PRZJGEtDZ/O2xa4Cw2/YZmU5V8Vc1lQ4OvWcF29Mp2Bm
	 Fi0xY2GOji/d/P+5wYSQh+SyLFzgLWiO22fxwOpQ0PAXA3NFJKNGzO09uP7Jf4AKy2
	 DpfdEBxrNTQ/spNPC3sPYHRtCt+0DeYAjwYPf7Zx/m2IEnM4nGTW+SqWg+Y3aPX8c5
	 HFtaQh27Muah/U7pRyzpfq8167nc/o7YTfYDUtZueyE0x8K3DrjL071NHPQGC4VrIX
	 nRjcQalRceLc5ierNbdzuuWDAJRm7mP9Z5JzXtKblux23YVCHfNVTEmJvBuJakGJxk
	 ggPNipvvPkJBQ==
Subject: Re: [PATCH mptcp-next v2 4/4] selftests: mptcp: add mptcp nbd tests
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 23:46:29 +0000
Message-ID: <179314478980.3132.5548180204560974411@kernel.org>
In-Reply-To: =?utf-8?q?=3C14de6d44e34c880f684ce171784dc04407e8958c=2E1793010?=
 =?utf-8?q?744=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C14de6d44e34c880f684ce171784dc04407e8958c=2E17930107?=
 =?utf-8?q?44=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In tools/testing/selftests/net/mptcp/mptcp_nbd.sh, the EXIT trap
  cleanup() always runs `ip netns exec "$ns2" nbd-client -d /dev/nbd0`…
- [Medium] The MPTCP check in run_io_test() passes as long as
  `subflows_total` is present in `ss -Mia` output (`elif [ -n…
- [Low] In run_io_test(), the 'data integrity' check writes 10 MiB to
  /dev/nbd0 with buffered dd plus conv=fdatasync, then reads it back…
- [Low] The native-MPTCP handling does not fit together.
- [Low] run_io_test() creates two temp files in the host's /tmp (`mktemp
  /tmp/nbd_test_XXXXXX.bin` and `/tmp/nbd_read_XXXXXX.bin`, about 10 MiB…
- [Low] cleanup() sends `kill` and then immediately, without checking,
  `kill -9` to server_pid.

--

selftests: mptcp: add mptcp nbd tests

This commit adds mptcp_nbd.sh. The script sets up two namespaces joined by
four rate-limited veth pairs and exports a 256MB file with nbd-server. It
connects /dev/nbd0 with nbd-client over TCP or MPTCP and runs dd and fio
I/O tests. It also adds nbd and fio cases to mptcp_lib_check_tools() and
enables CONFIG_BLK_DEV_NBD in the selftest config.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_nbd.sh b/tools/testing/selftests/net/mptcp/mptcp_nbd.sh
> new file mode 100755
> index 0000000000000..29998be71a982
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/mptcp_nbd.sh

[ ... ]

> +# This function is used in the cleanup trap
> +#shellcheck disable=SC2317,SC2329
> +cleanup()
> +{
> +	# Disconnect nbd device in ns2
> +	ip netns exec "$ns2" nbd-client -d /dev/nbd0 2>/dev/null || true

[Severity: High]
Can this disconnect an nbd0 that this test never connected?

cleanup() runs from the EXIT trap. The trap is installed before init(),
run_server() and run_client(), so cleanup() runs on every failure path.
Before that point, the script only checks that the device node exists:

	if [ ! -b /dev/nbd0 ]; then
		mptcp_lib_pr_skip "/dev/nbd0 not found"
		exit ${KSFT_SKIP}
	fi
	...
	trap cleanup EXIT

NBD devices are global, not per-netns. The genl family sets .netnsok = 1,
and nbd_genl_disconnect() only does this check:

drivers/block/nbd.c:nbd_genl_disconnect() {
    ...
	if (!netlink_capable(skb, CAP_SYS_ADMIN))
		return -EPERM;
    ...
}

The NBD_DISCONNECT ioctl also only needs CAP_SYS_ADMIN. So running
nbd-client -d inside ns2 gives no isolation from the host.

If the host is already using /dev/nbd0 (a mounted filesystem, a VM disk,
root on NBD), the connect in run_client() fails in nbd_genl_connect():

drivers/block/nbd.c:nbd_genl_connect() {
    ...
		pr_err("nbd%d already in use\n", index);
		return -EBUSY;
    ...
}

The test then reports FAIL instead of SKIP. After that, the EXIT trap
disconnects the host's live nbd0 connection.

Two concurrent runs hit the same path, for example mptcp_nbd.sh tcp and
mptcp_nbd.sh mptcp. The second run fails to connect, and its cleanup()
disconnects the first run's device in the middle of dd or fio I/O.

Could the script skip when /dev/nbd0 is already in use, and have cleanup()
disconnect only if this run's connect succeeded?

> +
> +	sleep 1
> +
> +	# Kill nbd-server in ns1
> +	if [ -n "${server_pid}" ]; then
> +		ip netns exec "$ns1" kill "${server_pid}" 2>/dev/null || true
> +		ip netns exec "$ns1" kill -9 "${server_pid}" 2>/dev/null || true

[Severity: Low]
Can these kill calls signal an unrelated process?

server_pid comes from run_server(). That function starts nbd-server in the
background from a short-lived ns1 bash and saves $! to pid_file:

	${use_mptcpize} nbd-server -C "${conf_file}" -n > /dev/null 2>&1 &
	server_pid=$!

Nothing checks that this PID still belongs to nbd-server when cleanup()
runs. ip netns exec does not create a PID namespace, so this is a host PID.

Suppose nbd-server exits early (crash, bind failure, an mptcpize problem),
gets reaped, and its PID is reused before cleanup() runs. Then the SIGTERM
and the immediate SIGKILL go to another process, sent as root. This needs
the PID to be reused within a few seconds, so it is unlikely.

[ ... ]

> +# This function is invoked indirectly
> +#shellcheck disable=SC2317,SC2329
> +run_io_test()
> +{
> +	local nbd_dev="/dev/nbd0"
> +	local test_data
> +	local read_data
> +
> +	# Create temp files for data integrity test
> +	test_data=$(mktemp /tmp/nbd_test_XXXXXX.bin)
> +	read_data=$(mktemp /tmp/nbd_read_XXXXXX.bin)

[Severity: Low]
Are these two files left in /tmp if the run is interrupted?

The file names exist only as locals in the ns2 bash child that run_test()
starts. The normal return paths remove them. However, the child has no
trap, and the parent's cleanup() only knows about temp_file, conf_file and
pid_file.

If the child is killed during the dd or cmp steps (SIGINT or SIGTERM), both
files stay in /tmp. Each one is about 10 MiB.

> +
> +	# Data integrity test: write and verify
> +	dd if=/dev/urandom of="${test_data}" bs=1M count=10 2>/dev/null
> +	if ! dd if="${test_data}" of="${nbd_dev}" bs=1M \
> +			conv=fdatasync 2>/dev/null; then
> +		echo "dd write failed"
> +		rm -f "${test_data}" "${read_data}"
> +		return 1
> +	fi
> +
> +	if ! dd if="${nbd_dev}" of="${read_data}" bs=1M count=10 \
> +			2>/dev/null; then

[Severity: Low]
Does this read-back always go over the network?

Both dd calls are buffered. conv=fdatasync writes the dirty pages back, but
the pages stay in the bdev page cache. blkdev_read_iter() serves buffered
reads through filemap_read(). The cache is dropped only when the last
opener closes the device:

block/bdev.c:blkdev_put_whole() {
	if (atomic_dec_and_test(&bdev->bd_openers))
		blkdev_flush_mapping(bdev);
    ...
}

Something else may hold /dev/nbd0 open, such as an ioctl-mode nbd-client
child waiting in NBD_DO_IT, or a udev probe. In that case the read-back can
come from the page cache instead of from nbd-server. "PASS: Data integrity
verified" then says nothing about the network receive path.

With the default netlink-mode nbd-client, nothing else holds the device
open. So whether this happens depends on the setup.

The fio randread and randwrite jobs use --direct=1 but not --verify, so
they do not check the data either.

Would iflag=direct on the read-back, or blockdev --flushbufs before it,
make this check reliable?

Also, a later comment in this function reads:

	# dd write test (larger, for performance measurement)

That write is bs=4k count=1000, about 4 MB, which is smaller than the
10 MiB integrity write. Its output is also discarded, so nothing is
measured.

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
> +			return 1
> +		elif [ -n "${sf_total}" ]; then
> +			echo "PASS: MPTCP subflows_total:${sf_total}" \
> +				"subflows_max:${sf_max}" \
> +				"tcp_subflows:${tcp_conns}"
> +		else
> +			echo "FAIL: No MPTCP subflows info found"
> +			return 1
> +		fi

[Severity: Medium]
Would this check catch a regression where no extra subflows are created?

The PASS branch only needs sf_total to be non-empty.
mptcp_diag_fill_info() includes the initial subflow in the count:

net/mptcp/sockopt.c:mptcp_diag_fill_info() {
    ...
	info->mptcpi_subflows_total = info->mptcpi_extra_subflows +
		__mptcp_has_initial_subflow(msk);
    ...
}

So any MPTCP connection that did not fall back reports at least 1.

init() configures 4 signal endpoints and 4 subflow endpoints with 8/8
limits. If no extra subflow is ever created (ADD_ADDR ignored, MP_JOIN
failing, limits not applied), this still prints PASS with
subflows_total:1.

The opposite case also goes wrong. If ss supports -M but does not print
subflows_total, sf_total is empty and the test reports "FAIL: No MPTCP
subflows info found". That is an iproute2 version problem reported as a
test failure.

chk_subflows_total() in mptcp_join.sh already handles this case:

	# if subflows_total counter is supported, use it:
	if [ -n "$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info)" ]; then

Could this check compare against the expected number of subflows, and skip
or use another check when the counter is not available?

[ ... ]

> +# Check for mptcpize if using MPTCP transport
> +if [ "${trtype}" = "mptcp" ]; then
> +	if ! command -v mptcpize &> /dev/null; then
> +		mptcp_lib_pr_skip "mptcpize tool not found"
> +		exit ${KSFT_SKIP}
> +	fi
> +fi

[Severity: Low]
Does this top-level check leave the error branches in run_server() and
run_client() unreachable?

When run_server() and run_client() run, mptcpize is always present. So
these branches can never be taken:

	echo "ERROR: no MPTCP support in nbd-server"
	return 1
	...
	echo "ERROR: no MPTCP support in nbd-client"
	return 1

A system whose nbd-server and nbd-client support MPTCP natively, but that
has no mptcpize installed, is also skipped. The native path would work
there.

The server detection in run_server() also looks unreliable:

	if ! grep -q '"mptcp"' /usr/bin/nbd-server 2>/dev/null && \
	   ! nbd-server --help 2>&1 | grep -qi mptcp; then

The binary path is hard-coded. mptcp_lib_check_tools() finds the tool
through PATH with command -v instead.

The pattern also includes the double quotes, which a compiled string
literal normally does not contain. In practice, detection relies on
nbd-server --help alone.

When native support is detected, "mptcp = true" goes into the config file.
Nothing checks that this nbd-server version accepts that key.

Could the mptcpize requirement apply only when native support is not
detected?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793010744.git.tanggeliang%40kylinos.cn

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017969;
	b=uLsle8mB0Uh53ej0t9VYUGlrKDvUX9UaWBKJnQ+KrVOUHXkNKgHwLpxshOKdjTHDVfy7
	 v94ZlUAByaABugDUxnNdlf6yJhKS9fHuWXYqN+2DG8aFnkI/RqiQhrTKAghA1REJLbSx1
	 VGTIQv0GkTlWcFsdLXGA7bOtv9XLZCgSTkM/Qjhf39S23NAEoWblEEDfEuyz173qJv++D
	 ueiVcZcK3HN9uDlNaQ74ulDVigKZhGSVw8QpqsUZageMoid8//JTCa9IRTfTkoIvu+3ZY
	 ha/3gE4mVzrLY/YJtBfHdb1xVtmzKS/JRKNSL/hQ9zkcWw1R7+BDB5i9BXVbB/6cf1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hdv17Hx71ICeo2r0zQSe1ccgbSy1iu7tTVL8HRmNSBY=;
	b=Zy/KpS2oe+USlKuyrxvoeQVUCCmrGZ4Eq8qpHiqzcZ9l0PH+29tffa1MPcClx+OxTmy8
	 +LD1AURV/CEGTUpqNzOILTMkGdzxcuRDIhBScKS1Ut3lXuRfkGqC7x0QENhoR8nhJcby1
	 kUiT/f9e5W5XZqfLXn0dnzvtiCi3zCHbmwAea9SLf5rcln9uAey10gwXSY9YJLwc76WHn
	 UEGDmh9FtLSK1ZI0mcGd9JxYq4+saIISAZwzjX5Nuv4HX65myWg5PCMsSE+8prJQ1RZkn
	 +DyV/7b7kMlpZUMkymUkLrhJUlWP9pc1vJs9iRfPfnMlrp7ALpC5yp6xLOGlYcW/LrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beRSpiEW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E405606A322
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beRSpiEW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE6F1F01825;
	Mon, 26 Oct 2026 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793017969;
	bh=Hdv17Hx71ICeo2r0zQSe1ccgbSy1iu7tTVL8HRmNSBY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=beRSpiEWNnpwpdvg1TMedVKy0Ji+ffRnrvZoaWetR1QseWUbMSG02LsyHVoCZnewS
	 uARt4U1QmuERYt6qtF30uaB6Oeb3BrKmvYm8fsqsBT+/FEvH54zUTun0iz73Dpz8fo
	 x4XYTZzH/cxpj3K/HfbG08x4sp6Sl/dRo88PRSpel7iZustqP526ByWR1C8Q6eCm2N
	 CpTMH1f+R31jnk7AolJ1PI1lu0D9kESSPhvjIThU/vIvJx1TFtTSpvybjjQ5jzrfiB
	 IKBEoBKrVA9BuCwftAndvg8lXU+SK2bAXGS8nbU2BSpWLn3N5LGA2lAKpcAcngL4l1
	 xEuW/vvOcgEsw==
Message-ID: <sashiko-outbox-185214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 4/4] selftests: mptcp: add mptcp nbd tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <14de6d44e34c880f684ce171784dc04407e8958c.1793010744.git.tanggeliang@kylinos.cn>
References: <cover.1793010744.git.tanggeliang@kylinos.cn>
 <14de6d44e34c880f684ce171784dc04407e8958c.1793010744.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:32:48 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests: mptcp: broken native MPTCP and mptcpize checks in mpt=
cp_nbd.sh
- [Medium] selftests: mptcp: weak and non-portable subflow check in run_io_=
test()
- [Medium] selftests: mptcp: mptcp_nbd.sh disconnects active host /dev/nbd0=
 in cleanup()
--

commit 7951aabe0d1917726a0a08d246614408762a837e
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: add mptcp nbd tests

This commit adds mptcp_nbd.sh to test NBD over TCP and MPTCP using four
rate-limited virtual interfaces between two network namespaces, verifying
data integrity with dd/cmp and measuring I/O with fio.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_nbd.sh b/tools/testi=
ng/selftests/net/mptcp/mptcp_nbd.sh
> new file mode 100755
> index 0000000000000..29998be71a982
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/mptcp_nbd.sh

[ ... ]

> +# This function is used in the cleanup trap
> +#shellcheck disable=3DSC2317,SC2329
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
> +		ip netns exec "$ns1" kill -9 "${server_pid}" 2>/dev/null || true
> +	fi
> +
> +	# Clean up temp files
> +	if [ -n "${temp_file}" ]; then
> +		ip netns exec "$ns1" rm -f "${temp_file}" 2>/dev/null || true
> +	fi
> +	if [ -n "${conf_file}" ]; then
> +		ip netns exec "$ns1" rm -f "${conf_file}" 2>/dev/null || true
> +	fi
> +	if [ -n "${pid_file}" ]; then
> +		ip netns exec "$ns1" rm -f "${pid_file}" 2>/dev/null || true
> +	fi
> +
> +	mptcp_lib_ns_exit "$ns1" "$ns2"
> +
> +	unset -v trtype port
> +	unset -v temp_file server_pid
> +}

[Severity: Medium]
Can cleanup() disconnect an active /dev/nbd0 device on the host if /dev/nbd0
was already in use before the test started?

Before registering the cleanup trap, the script only checks whether
/dev/nbd0 is a block device node:

	# Check for /dev/nbd0
	if [ ! -b /dev/nbd0 ]; then
		mptcp_lib_pr_skip "/dev/nbd0 not found"
		exit ${KSFT_SKIP}
	fi

Because NBD devices in drivers/block/nbd.c are global across network
namespaces (nbd_index_idr is global and nbd_genl_family sets .netnsok =3D 1=
),
if /dev/nbd0 is already connected on the host, run_client() will fail to
attach it (or run_server() may fail earlier) and cleanup() will still execu=
te
nbd-client -d /dev/nbd0, disconnecting the host's active block device. Shou=
ld
the script check whether /dev/nbd0 is already connected via nbd-client -c
/dev/nbd0 before setting up the trap, or only disconnect /dev/nbd0 if
run_client() actually connected it?

Also, in run_io_test(), two 10 MiB temporary files are created inside the
child subshell:

	test_data=3D$(mktemp /tmp/nbd_test_XXXXXX.bin)
	read_data=3D$(mktemp /tmp/nbd_read_XXXXXX.bin)

If the test is interrupted or killed by a timeout during dd or cmp, will
test_data and read_data be leaked in /tmp since they are not tracked by
cleanup()? And in cleanup(), since temp_file, conf_file, and pid_file are
created on the host filesystem in init(), is ip netns exec "$ns1" needed to
remove them?

[ ... ]

> +run_server()
> +{
> +	# Create backing file
> +	dd if=3D/dev/zero of=3D"${temp_file}" bs=3D1M count=3D0 seek=3D256 2>/d=
ev/null
> +
> +	# Detect MPTCP support: native config or mptcpize fallback
> +	local use_mptcpize=3D""
> +	local mptcp_opt=3D""
> +	if [ "${trtype}" =3D "mptcp" ]; then
> +		if ! grep -q '"mptcp"' /usr/bin/nbd-server 2>/dev/null && \
> +		   ! nbd-server --help 2>&1 | grep -qi mptcp; then
> +			if command -v mptcpize &> /dev/null; then
> +				use_mptcpize=3D"mptcpize run -d"
> +				echo "INFO: nbd-server lacks native MPTCP," \
> +					"using mptcpize"
> +			else
> +				echo "ERROR: no MPTCP support in nbd-server"
> +				return 1
> +			fi
> +		else
> +			mptcp_opt=3D"mptcp =3D true"
> +			echo "INFO: nbd-server has native MPTCP support"
> +		fi
> +	fi

[ ... ]

> +run_client()
> +{
> +	local extra_args=3D()
> +	local nbd_dev=3D"/dev/nbd0"
> +	local server_addr=3D"10.1.1.1"
> +
> +	local use_mptcpize=3D""
> +	if [ "${trtype}" =3D "mptcp" ]; then
> +		if nbd-client 2>&1 | grep -qE "\-M|\-\-mptcp"; then
> +			extra_args+=3D("-M")
> +			echo "INFO: nbd-client has native MPTCP support (-M)"
> +		elif command -v mptcpize &> /dev/null; then
> +			use_mptcpize=3D"mptcpize run -d"
> +			echo "INFO: nbd-client lacks native MPTCP," \
> +				"using mptcpize"
> +		else
> +			echo "ERROR: no MPTCP support in nbd-client"
> +			return 1
> +		fi
> +	fi

[Severity: Medium]
Does the native MPTCP detection in run_server() and run_client() work as
intended when the top-level script unconditionally skips if mptcpize is
missing?

Later in the script, before run_test() is called, there is an unconditional
check for mptcpize:

	# Check for mptcpize if using MPTCP transport
	if [ "${trtype}" =3D "mptcp" ]; then
		if ! command -v mptcpize &> /dev/null; then
			mptcp_lib_pr_skip "mptcpize tool not found"
			exit ${KSFT_SKIP}
		fi
	fi

Because that check exits with KSFT_SKIP whenever mptcpize is not installed,
systems where nbd-server and nbd-client have native MPTCP support will still
skip the test if mptcpize is absent, and the else branches in run_server()
and run_client() can never be reached.

In addition, in run_server():

	if ! grep -q '"mptcp"' /usr/bin/nbd-server 2>/dev/null && \
	   ! nbd-server --help 2>&1 | grep -qi mptcp; then

Can grep -q '"mptcp"' /usr/bin/nbd-server ever match a compiled ELF binary?
In a compiled C binary, string literals in .rodata do not include the
surrounding C source double quotes, and /usr/bin/nbd-server is also
hardcoded rather than resolved via command -v nbd-server (for example when
installed in /usr/sbin). Since mptcp =3D true is a configuration file direc=
tive
rather than a command-line option printed by nbd-server --help, won't
run_server() always fall back to mptcpize even when nbd-server supports
native MPTCP?

[ ... ]

> +	# Verify MPTCP subflows if trtype is mptcp
> +	if [ "${trtype}" =3D "mptcp" ]; then
> +		local sf_total sf_max tcp_conns is_fallback
> +		sf_total=3D$(ss -Mia | grep -oP "subflows_total:\K[0-9]+" | \
> +			head -1)
> +		sf_max=3D$(ss -Mia | grep -oP "subflows_max:\K[0-9]+" | head -1)
> +		tcp_conns=3D$(ss -tia | grep -c "tcp-ulp-mptcp" || true)
> +		is_fallback=3D$(ss -Mia | grep -c "fallback" || true)
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
> +	fi

[Severity: Medium]
In run_io_test(), is checking [ -n "${sf_total}" ] sufficient to verify that
the additional MPTCP subflows were established?

In net/mptcp/sockopt.c:mptcp_diag_fill_info():

	info->mptcpi_subflows_total =3D info->mptcpi_extra_subflows +
		__mptcp_has_initial_subflow(msk);

Even if all extra subflows fail to establish across the four interfaces
configured in init(), subflows_total is still 1 for the initial subflow, so
elif [ -n "${sf_total}" ] will pass with only a single subflow.

Also, on systems where ss supports MPTCP but predates the subflows_total
field, sf_total will be empty and this check will fail with "No MPTCP
subflows info found" even though tcp_conns was computed right above. Could
this use mptcp_lib_get_info_value() instead of grep -oP, fall back to
tcp_conns when subflows_total is unavailable (similar to chk_subflows_total=
()
in mptcp_join.sh), and verify that multiple subflows were actually created?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793010744.gi=
t.tanggeliang@kylinos.cn?part=3D4

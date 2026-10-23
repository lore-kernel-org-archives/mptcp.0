Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748221;
	b=wBq2slJ2mNJhzPfMQNFgaRdCWdaay9vPg3eTvZuxoxSh1lmrmsNozM9j6Rm8EeAu0/9Q
	 qIRweqInB5hcNNm9OmMydoTcTjnId2e+qzz1qVVvwbQi1aGQnX+5OcorLsAhR6/i+sDRM
	 Z/lU4V/yHGToMF3wCsry6Y4BDbDzDUSHdqhZq9L7uXIrIr5QUiOcOmhi3iwHSjXqhyu3M
	 BhA1z4LtKEAl1PI8ybn8SoiugOWqcDTLpdUZWk+Ig8NrXQaXeT+rq9GfIHQ7u+ImKUIyv
	 TwN/YTtA0iX2RjcmiBnCbp7D+LBESXsIbZD8k/pagsGVYorMmMpVXMbZwmfjfXkfihQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fYDzX1G5sxHlA9gvNJTqMWLAOkNzEaPJRClqSmY+kAY=;
	b=xbAXFhgiVO6DUe9a6KNAfq2jDXJE88zfNIhlsPPlBMhqtAA2T1W0g6+yh3IFRm2F7lQD
	 bXvs5B9A9fMPLV3ZUeoGUimVaDJ5ME+Aw5r8D1hAGOr5HUo+Er1dNOJGKte1xVYqaPySt
	 mo1TuwHsH28ERPFg2AkRuqbCJ2NbIx9ildfn0mKp52ZX35c/0z086JM2RhIMDUWT1X6M8
	 5+kU8dB+xoyYsM3G6W5hxiKH3oxdg8TELCt0TF33+gyBeL2Rz2wp4irBDbRxfnZVhknHO
	 PA9NGenVccsK3SGQdQZJmQEHq5hztjv58DCZrA3dZtjrAz3g91sgSRTfJnR+cRniDdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD8y2MRB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9F606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD8y2MRB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540261F01825;
	Fri, 23 Oct 2026 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748220;
	bh=fYDzX1G5sxHlA9gvNJTqMWLAOkNzEaPJRClqSmY+kAY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KD8y2MRBFQK57ZX/3Dd51HQtCAhSEb7+hmkyK5DbiFUNL55VMikj+ll9FBl6/syep
	 R0GNPvNVWjtxlh8e3npqgWZULZml6UGomOL6/s6QXi8pZGWFX3Z6UDDLQ4asuGDyjC
	 wpUEh3AwzixlkvUdFjB8Azoyswy/m83LOcpdPOqMlAY6dY0d7+DTcRTUVUCFFaEbXR
	 U3wLtJcwp82+6P7OAkWUw1FAs8pR9P07RdeILEyDbdptRdvnJ6XxqMEoTIvVWpGtzC
	 2uOJtj8ZH2kPpPtwSZuNA8SlkLJp0A02ICgo+nqVGzKV7pYZ0IjcTqix6G67Uz3j1b
	 9tRfA450zlZqQ==
Message-ID: <sashiko-outbox-182608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: add mptcp nbd tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <8cd8c351da081aa504f4bf25d3cdaf64613070d9.1792746800.git.tanggeliang@kylinos.cn>
References: <cover.1792746800.git.tanggeliang@kylinos.cn>
 <8cd8c351da081aa504f4bf25d3cdaf64613070d9.1792746800.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 09:36:59 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] selftests: mptcp: run_io_test() returns 0 on fallback or missing=
 subflows
- [Medium] selftests: mptcp: missing prerequisite checks cause failure inst=
ead of skip
- [Medium] selftests: mptcp: temp files leaked in cleanup() due to subshell=
 assignment
- [Medium] selftests: mptcp: host-wide pkill/pgrep and /dev/nbd0 clobber in=
 cleanup()
--

commit 3361c31ea4cfbf255e2c3ce5c5e70d2193d46dd4
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: add mptcp nbd tests

This commit adds the mptcp_nbd.sh selftest to verify Network Block Device
(NBD) functionality and throughput over both TCP and MPTCP across multiple
virtual network interfaces.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_nbd.sh b/tools/testi=
ng/selftests/net/mptcp/mptcp_nbd.sh
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
Since ip netns exec only switches the network namespace while sharing the
host PID namespace, won't running pkill -9 -f nbd-server in cleanup() kill
all nbd-server processes across the entire host system, and won't pgrep -f
"nbd-server" in run_test() match unrelated host processes as well?

Also, /dev/nbd0 is a host-global block device that is not isolated by
network namespaces. Could run_client(), run_io_test(), and cleanup()
clobber or disconnect /dev/nbd0 if it is already in use on the host?

> +
> +	# Clean up temp files
> +	if [ -n "${temp_file}" ]; then
> +		ip netns exec "$ns1" rm -f "${temp_file}" 2>/dev/null || true
> +	fi

[Severity: Medium]
Does cleanup() leak /tmp/nbd_backing.raw and /tmp/nbd-server.conf on every
run?

In run_test(), run_server() is executed inside a child bash process:

	if ! ip netns exec "$ns1" bash <<- EOF
		$(declare -f run_server)
		export trtype port
		run_server
		exit \$?
	EOF

Because temp_file=3D"/tmp/nbd_backing.raw" is assigned inside that child
process, temp_file in the parent shell remains empty when the EXIT trap
invokes cleanup(). In addition, conf_file=3D"/tmp/nbd-server.conf" is a loc=
al
variable in run_server() with no removal in cleanup(), and both use
hardcoded /tmp paths instead of mktemp.

[ ... ]
> +run_server()
> +{
> +	local conf_file=3D"/tmp/nbd-server.conf"
> +
> +	# Create backing file
> +	temp_file=3D"/tmp/nbd_backing.raw"
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

[Severity: Medium]
Should the test skip with KSFT_SKIP instead of failing with KSFT_FAIL when
optional prerequisites are unavailable?

In run_server() and run_client(), if trtype is mptcp and neither native
MPTCP support in nbd-server/nbd-client nor mptcpize is installed, returning
1 causes run_test() to set ret=3D${KSFT_FAIL}. Also, run_server() hardcodes
/usr/bin/nbd-server rather than using command -v nbd-server.

Similarly, at the top level of mptcp_nbd.sh:

mptcp_lib_check_tools nbd fio
validate_params

if MPTCP is not supported by the kernel (checked via mptcp_lib_check_mptcp
in other mptcp selftests), ip/tc/ss are missing, or /dev/nbd0 is not
present (for example when CONFIG_BLK_DEV_NBD is disabled or the nbd module
is not loaded), the script will fail instead of skipping.

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
In run_io_test(), when is_fallback is greater than 0 or sf_total is empty,
the function prints a FAIL or WARNING message but still falls through to
return 0, and the elif branch only checks that sf_total is non-empty rather
than verifying that multiple subflows were created. Doesn't this cause
mptcp_nbd.sh to report KSFT_PASS even when MPTCP falls back to TCP or fails
to establish subflows?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792746800.gi=
t.tanggeliang@kylinos.cn?part=3D2

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683284;
	b=bJD8NuKLmWMCcwlJASY5NJr3Xg8JNGXJgrXNFKAFjAOs3SBq/hrQo9EDWEaRraCHtCyM
	 QZ/K4bYBil7n0YodBOSfj7fDhmiLhOrwxFyrCnExhs/QvQIKUKiQMCQC62LDOQX07CJl0
	 HyTh1MxB0tOMyAj4CQW9E7SnZyClb2na7ANOypURqDaagb+b4JJ9v52LaSaNEs6DDKRdW
	 /GMe1Qj8C5Fmv47l6slFBkSm7TwUkSDs8az+JyotAK1aMzVGhMZH8uMPGVZOFXDZtwgwC
	 VMHoQ83nm1Wcx5weGKaNNXo7gNAOn1lqJdlDcLhR+5ORCH4KAW4xfe4aAQYKeIX1OBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QaE/BxgyedfodD53OGQMiB5pNvai5+qgWcgZL6RC/F8=;
	b=JuRYHGeKnKIlsbBNhWrEyAQJkMrqotqcsY8LTpWSMqD04PLm+6pjju/sg4Wro92A/B1n
	 KekwYgoEqtumSYQmorEKl2W00VREzWHjnLI2efXS06GB4eVRo0t+gVm917+Yxi2oI4ZCc
	 Fm1HdpwEaXDkIMPTlves8gtS2S7BwwAnwjv6TSGqjzx87hVTTLluWlMQh+jVIbjmi+7eI
	 SrmLiP7PkBLfmJl6OUm+3RFyE74McXtFkNoVR2YGLyePZfukXzbAQWKn+Ql5EeGsHE4Ti
	 NCfqsueJ8YnIMh/AAr4ObhG9rUhwDlhPbFKx6jp5yLzPwFfzbZl01jt9FDwCTIJyLMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTaMSSCc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE9606A323
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTaMSSCc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687EF1F01825;
	Thu, 22 Oct 2026 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683283;
	bh=QaE/BxgyedfodD53OGQMiB5pNvai5+qgWcgZL6RC/F8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VTaMSSCcmntQM1izbXzN5rTWXEXZRonlCFVeMismXfHm5BcwiSJf6T8idQI13FBGJ
	 Pil5s8C/dJNqh4kJm0TPfGRP/XDsXKdJo9q0/uXE8j1/+VLAgy7wtm0NXq7hyrY4l1
	 JbJjCLK5y7whNL6aB7G+Ss4w4lssrkGPkHYXUlzGT/PnGvxlgJl07aavZl1BQyWo5k
	 1Shw5r2+yq+c55S8s0/4NnX1KY2Ky8d15XeXQkW6wYubftgRgwyeIM6GnFVhRfcELA
	 HuYiH7NfzLO5lGbE3b9mxiNGieWm/9Tf37+UiINujUnSsSz9C8wyAR09B/r/qgvuAn
	 4LyN3jY1xLP2Q==
Message-ID: <sashiko-outbox-181711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v8 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261022151130.2285198-7-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
 <20261022151130.2285198-7-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:34:43 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: mptcp: blocking FIFO stdin stalls server in copyfd_io=
_poll()
--

commit a6a2fc5110d407a3c76cad8c29bab3f867efa20e
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

selftests: mptcp: join: validate subflow retry after link failure

This commit adds two selftests in mptcp_join.sh to validate subflow retries
after packet drops using netfilter rules. The first test verifies that
additional and initial subflows reconnect after silent packet drops, and the
second test verifies closing the client connection while a subflow is being
re-created.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..58a48f50ba152 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
[ ... ]
> @@ -1038,7 +1039,9 @@ do_transfer()
>  	fi
> =20
>  	extra_srv_args=3D"$extra_args $extra_srv_args"
> -	if [ "$test_linkfail" -gt 1 ];then
> +	if [ -n "${server_in}" ]; then
> +		listener_in=3D"${server_in}"
> +	elif [ "$test_linkfail" -gt 1 ]; then
>  		listener_in=3D"${sinfail}"
>  	fi
>  	ip netns exec ${listener_ns} \
[ ... ]
> @@ -2585,6 +2769,69 @@ link_failure_tests()
[ ... ]
> +	# close the connection while a subflow is being re-created
> +	if reset_with_events "subflow retry, close while connecting" &&
> +	   continue_if has_subflow_retries && init_nft_filter; then
> +		sf_retry_init
> +		# The server sends nothing, but does not close its side: the
> +		# client has nothing to read, and the connection stays
> +		# established.
> +		local srv_in srv_in_pid
> +		srv_in=3D$(mktemp -u)
> +		mkfifo "${srv_in}"
> +		sleep 600 > "${srv_in}" &
> +		srv_in_pid=3D$!
> +		{ timeout_test=3D600 test_linkfail=3D131072 server_in=3D"${srv_in}" \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null

[Severity: Medium]
Does redirecting the server's stdin from the srv_in FIFO cause the server
mptcp_connect process to block in read() and stop draining incoming data fr=
om
the client?

In link_failure_tests() -> run_tests() -> do_transfer(), the server is star=
ted
in poll mode (-j / CFG_MODE_POLL) with stdin redirected from listener_in
(srv_in), while sleep 600 holds the write end of the FIFO open without writ=
ing
any bytes.

In tools/testing/selftests/net/mptcp/mptcp_connect.c:copyfd_io_poll(), only
peerfd is set to non-blocking mode and passed to poll(), while infd (stdin)
remains blocking:

	set_nonblock(peerfd, true);

	for (;;) {
		...
		switch (poll(&fds, 1, poll_timeout)) {
		...
		}

		if (fds.revents & POLLIN) {
			...
		}

		if (fds.revents & POLLOUT) {
			if (winfo->len =3D=3D 0) {
				winfo->off =3D 0;
				winfo->len =3D read(infd, winfo->buf, sizeof(winfo->buf));
			}

Because peerfd has POLLOUT set on the first poll() iteration after accept(),
the server calls read(infd, ...) on the FIFO and blocks for 600 seconds. As=
 a
result, the server never returns to poll() and never reads from peerfd agai=
n.

Once the client fills the initial ~64 KB receive window, the server adverti=
ses
a zero receive window and stops acknowledging new data. If wait_counter_inc
for MPTcpExtMPJoinAckRx and nft_drop_from 10.0.3.2 run after that initial
window has been sent and acknowledged, subflow 10.0.3.2 has no unacknowledg=
ed
data in flight (and zero-window probes are only sent on the initial subflow
10.0.1.2), so subflow 10.0.3.2 never times out or gets re-created, causing
wait_counter_inc on MPTcpExtMPJoinSynTx to time out.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022151130.2285=
198-1-anilkaushikwireless@gmail.com?part=3D6

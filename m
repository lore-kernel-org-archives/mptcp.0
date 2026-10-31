Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487466;
	b=VdMBLwyCzMn+Z/K7+27dIxHpIMfqtFY7Ok6sd0i5E03AbyHEDswXhuOa+jVLHv5hYBbM
	 FioViaJDVB7WS0qXyHomYgMq5DxUWzdoRHpW0CcpY515UgSgUmxvyncfEQTt4BWhCuhQJ
	 XshGFjjKRQ3Jstc2DT1mkVI92R4dmhTm+FS1aDIcdGSDIXLY3jmc43n7w//WbNNcT1j/J
	 zFfRjgicS2Ge3uYYuzyn8nkJMztyAebbJqHQ0h2evjUwKNrU6uw5RwpJWrj20sI0peaon
	 C19O5XlfwVLHozN8+yvqn2zBkXUK5PTqPSefpsHnOTEXYvhibkuQzhcckQ//gULudDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487466;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qhK4fezfutoflmq5zz9sWDQdqn3S5Ji+u28wBu5HVcY=;
	b=qYKOoOy9YlMBqEBWzJPDgLT1iRr/fT1SDRVqUyYfwsMWNIDTfBpSIBhWAMHIWcDSWmQh
	 p6+zJC2s3UOYvjhUVqlMCQ1WRPEnrxubdJNLapIrXDmShlO+72tkT0uzm2rGQxgOyt/P6
	 llvKTnY+G3JqL2W4AwOQAc8cGyPeGKJ0yOGBA06wz86lA9o5fCyvDGH83aLPDGLix1nzl
	 ICPk+0xyFAoxMY+p7eFNmopahz8iOs1ttF2DmZUZZ1LQzF760Uv//rwoYUjzB4p8S6Z9z
	 p8yA+bhUM0kpsgLpQX/lhzv1waLjsXDI7K/HTFhtPLS5VgPxTwl+mqcZ+7obDkz4Sbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xq0uVcuy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD990606A31C
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xq0uVcuy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434C01F00919;
	Sat, 31 Oct 2026 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793487465;
	bh=qhK4fezfutoflmq5zz9sWDQdqn3S5Ji+u28wBu5HVcY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xq0uVcuyAqJaDd1tDg6YhT8ZfvwiADn6mHhEVqEIMk47oeydRh/UWZcWS09UEOisS
	 SdyfDc/E03/DlDH3FWAKpCj1X7naSgNDW2M6FSqg3dG/eAH74GU0GRtmgV6nHMEiWq
	 TwiWz1YuOkSn7lmkxVqA+sRsjwJ2JRLe1jQpsAqMiAtOA3Zu7P87iFKBed5wLvx0Ab
	 noX80lAL8r51s8+OU+2axbHJIOX/ySLtk+sxlGAc5Pe2nfDV29NEHVpfemq8lJzF6F
	 vvNvnuIng8jOPkDyBBpknCjpNqlMX8KNMDSFr58KAAJrBUykOKdpHiNVYfCb0vWy8e
	 X5DZiQX1TeB8g==
Message-ID: <sashiko-outbox-192213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 8/8] selftests: bpf: mptcp: test a
 scheduler reinjecting on an idle subflow
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-8-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
 <20261031-mptcp-sched-opp-retrans-v2-8-e9c4a30f6841@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 22:57:44 +0000
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
- [Low] selftests/bpf: multi-line comments in test_reinject() and bpf_reinj=
ect_get_retrans() violate BPF comment style
--

commit 85b159ecf48bf639151eb32d4b50cba4bfb3a107
Author: Abdul Wasey <w453y.me@gmail.com>

selftests: bpf: mptcp: test a scheduler reinjecting on an idle subflow

This commit adds a bpf mptcp scheduler selftest (bpf_reinject) that sends
new data only on the first subflow and reinjects up to 64 KB on another
subflow when get_retrans is invoked for an idle subflow.

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index 4302c16cb6bb4..723f42b458270 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
[ ... ]
> @@ -821,6 +822,27 @@ static void test_burst(void)
>  	mptcp_bpf_burst__destroy(skel);
>  }
> =20
> +/* New data only goes on the first subflow, so the second one only carri=
es
> + * what the scheduler asks the core to reinject when it goes idle.
> + */
> +static void test_reinject(void)
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_reinject.c b/too=
ls/testing/selftests/bpf/progs/mptcp_bpf_reinject.c
> new file mode 100644
> index 0000000000000..3e315c7ead67c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_reinject.c
> @@ -0,0 +1,70 @@
[ ... ]
> +/* On an MPTCP RTO, resend on the first subflow. When the core asks beca=
use
> + * a subflow is idle, resend up to 64 KB of what the first subflow holds=
 on
> + * another one, so the second address only carries reinjected data.
> + */
> +SEC("struct_ops")
> +int BPF_PROG(bpf_reinject_get_retrans, struct mptcp_sock *msk)

[Severity: Low]
This isn't a bug, but the new multi-line comments above test_reinject() in
tools/testing/selftests/bpf/prog_tests/mptcp.c and above
bpf_reinject_get_retrans() in
tools/testing/selftests/bpf/progs/mptcp_bpf_reinject.c place comment text on
the same line as the opening /* delimiter. Could these be formatted with the
opening /* on its own line to match the bpf coding style?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-mptcp-sche=
d-opp-retrans-v2-0-e9c4a30f6841@kernel.org?part=3D8

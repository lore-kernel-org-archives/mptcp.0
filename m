Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293328F3
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715435433; cv=none; b=KZ+eZu5lvmnAgabW85ML1lfueZwdSQr5Ac/LF6yFO5XBkSfo9cyiIj33GZwv0zCsSLz/oV6sdqph+Cmb5j7PuPZfUshT2PUQ5pFt+FJ9qEDfVvbj+O5oov5Dl42U4pe9QZRBZGXkTaqxAeEGfX4wRsthx9yuSbJMi7T/cwduE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715435433; c=relaxed/simple;
	bh=GXgFT2fqXijUGrN0G5/+pwVX0Epmqhy0KusOYyIw5zI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hidsYlFi06FXF3erutNwYJ2l+pacfsPCe8sYMePo0R4DVHFey5St9aUhEpaJGR0ZGi/n2C1h1oytahOjL1O4WuhARqZ/AlZXeeTeCT5OlSqauIA6VdvqcxTvNnyWMFO33zXdLIf07J38AAF1xZBCDA21V+AmHV8JHxAnOt+uPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0/5LF5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0/5LF5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE7CC2BBFC;
	Sat, 11 May 2024 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715435433;
	bh=GXgFT2fqXijUGrN0G5/+pwVX0Epmqhy0KusOYyIw5zI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=e0/5LF5O5Dxtti5URQjY+zDuqnc0OaPff6evKnXD4wM2EkJMyIQpZWo4qq0iWlBNh
	 XFKzfdJSRCRSFAg61jfIBtpJ7BULXoyhbheBXDY0Z1DdO5wgNcUYD5QQn3tLo4/TRP
	 1CiWXIGba2MQuW3BjPvBYK4cHiSc5CKHMt669Kc5PcVMJXTvysJJE8AMZi+fh6qRQK
	 IkpuEL/EQVTtOnc5si5E//yy/ncL3rQajihtJ289ObP8gwBXErYI6MS+wHikdPacWQ
	 0IjJ0u/UBiSLxVHZgnbaBcLGp52LeA/4T20sMBUNWfRlLrwfGdEtF19MXyB/sbVYzP
	 MwWlsBoj7xwQQ==
Date: Sat, 11 May 2024 15:50:29 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Message-ID: <45e113c1-7c33-4380-b85c-56dcb9048a73@kernel.org>
In-Reply-To: <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn>
References: <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow
 subtest"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <45e113c1-7c33-4380-b85c-56dcb9048a73@kernel.org>

Hi Geliang,

Thank you for this fix!

11 May 2024 12:42:08 Geliang Tang <geliang@kernel.org>:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Add pm_nl_ctl.
> Use SYS_NOFAIL in _ss_search().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> tools/testing/selftests/bpf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> tools/testing/selftests/bpf/pm_nl_ctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> tools/testing/selftests/bpf/prog_tests/mptcp.c | 15 ++++-----------
> 3 files changed, 6 insertions(+), 12 deletions(-)
> create mode 120000 tools/testing/selftests/bpf/pm_nl_ctl.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b90c718218ae..bd2e3b138a5c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -131,7 +131,7 @@ TEST_GEN_PROGS_EXTENDED =3D test_sock_addr test_skb_c=
group_id_user \
> =C2=A0=C2=A0=C2=A0 flow_dissector_load test_flow_dissector test_tcp_check=
_syncookie_user \
> =C2=A0=C2=A0=C2=A0 test_lirc_mode2_user xdping test_cpp runqslower bench =
bpf_testmod.ko \
> =C2=A0=C2=A0=C2=A0 xskxceiver xdp_redirect_multi xdp_synproxy veristat xd=
p_hw_metadata \
> -=C2=A0=C2=A0 xdp_features bpf_test_no_cfi.ko
> +=C2=A0=C2=A0 xdp_features bpf_test_no_cfi.ko pm_nl_ctl
>
> TEST_GEN_FILES +=3D liburandom_read.so urandom_read sign-file uprobe_mult=
i
>
> diff --git a/tools/testing/selftests/bpf/pm_nl_ctl.c b/tools/testing/self=
tests/bpf/pm_nl_ctl.c
> new file mode 120000
> index 000000000000..5a08c255b278
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/pm_nl_ctl.c

Best to prefix it with "mptcp_": clearer and it will be linked to MPTCP in =
the maintainers file.

> @@ -0,0 +1 @@
> +../net/mptcp/pm_nl_ctl.c
> \ No newline at end of file
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index 793b4b9c2bd2..9c6d1e4f6f35 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -362,7 +362,8 @@ static int endpoint_init(char *flags)
> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST)=
;
> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TE=
ST, ADDR_2);
> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST)=
;
> -=C2=A0=C2=A0 SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, A=
DDR_2, flags);
> +=C2=A0=C2=A0 if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TE=
ST, ADDR_2, flags))

It is maybe better to only use mptcp_pm_nl_ctl here: to maintain one way he=
re, our CI will do the same as what the BPF one will do, and we avoid error=
s printed in stderr if "ip mptcp" is not supported.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SYS(fail, "ip netns exec %s ./pm_nl=
_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
>
> =C2=A0=C2=A0=C2=A0 return 0;
> fail:
> @@ -371,16 +372,8 @@ static int endpoint_init(char *flags)
>
> static int _ss_search(char *src, char *dst, char *port, char *keyword)
> {
> -=C2=A0=C2=A0 char cmd[128];
> -=C2=A0=C2=A0 int n;
> -
> -=C2=A0=C2=A0 n =3D snprintf(cmd, sizeof(cmd),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ip n=
etns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NS_TE=
ST, src, dst, port, PORT_1, keyword);
> -=C2=A0=C2=A0 if (n < 0 || n >=3D sizeof(cmd))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> -
> -=C2=A0=C2=A0 return system(cmd);
> +=C2=A0=C2=A0 return SYS_NOFAIL("ip netns exec %s ss -Menita src %s dst %=
s %s %d | grep -q '%s'",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 NS_TEST, src, dst, port, PORT_1, keyword);

If "ip mptcp" is not supported, I guess "ss -M" will not be supported as we=
ll, no?

Do we need -M here for these tests?

Cheers,
Matt

> }
>
> static int ss_search(char *src, char *keyword)
> --
> 2.43.0


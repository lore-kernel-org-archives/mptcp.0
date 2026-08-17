Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5913E5A19
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967123; cv=none; b=MRuycsLvoe1UwTM72kj7qyicwcl0xbaZ4FJwdh26sgX11ZsUINCE3ldObDUEeELbfx8tESVJVdSBrV9PmXA39e6v667IA3e5UBLtVV0ib33OBGIItYYpnd+B5m3lgm9nj9fzHIaBAb54USUo7O6cuhZwAmzS/jVIFyYCQQI8Ri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967123; c=relaxed/simple;
	bh=lUCyGG7z3S9IjET3VkRVTkTc3ko97dgHdHGULowAWGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=op0UcPEUVrfPqtPTdHsIoMqDQ3Wtp+tNuIH3xRFXB6lG/SUoSp0WayNqfamDT5bIjzyYdNw8t8WyqGR4FJkZm2cWLUIsAFaCQIZDauMyJozvL5vIK/wbGEg/IPEnSpiHF3J5el88RCZgie03ax8GI1k+IaZmS25Qd90G7hz8BIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aliPADVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aliPADVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E7F1F000E9;
	Mon, 17 Aug 2026 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786967119;
	bh=ViXHda6MnmFJJ7QmDf0XEc00rlKObFiExe9J/iU942g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aliPADVNcXcjNyVLZEcAvyAMwB2qJA5TNb4Ztb+A+VnHD6tO05z3Tsq/OmJ6J/bBi
	 OtqCeW/Plf1xrrMO96WsQpAeoH+VQaf/m3A+t+8hNQg3PWqX2KPiVtPwMjEz43f7Ax
	 wuYCPdpcQqjq64aw4Cb6O0myk15XLiGqJvj2nYAlAxNZm5TwLAVRAnOvz1szdrJSVC
	 mjwXI+ZFdPNiDCQhcy6Zxhxm0mqEpO90PXIrDiEyQrhQcvApQIQuYa0wxG7lUJPknL
	 2G1B7pg+A9qHKz0WGNJV6DK9v2BKg+uH2x6+KnhPwMCeBh5z9CwhrpobUhlpgxm5oi
	 E+9FuzU6rNcrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v4] mptcp: bpf: don't expose
 bpf_skc_to_mptcp_sock() to tracing progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260817113202.1832692-1-kalpan.jani@mpiricsoftware.com>
References: <20260817113202.1832692-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 11:45:18 +0000
Message-Id: <20260817114519.24E7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch attempts to fix a Use-After-Free / NULL pointer dere=
ference in `bpf_skc_to_mptcp_sock()` by restricting its use to BPF hooks th=
at hold the subflow lock (e.g., `sock_ops`, `cg_sockopt`), thereby removing=
 it from `tracing_prog_func_proto()`. However, the fix is fundamentally inc=
omplete for two reasons. First, the helper remains exported via `bpf_sk_bas=
e_func_proto()`, which serves as the default for numerous datapath hooks in=
cluding XDP (`xdp_func_proto()`) and TC (`tc_cls_act_func_proto()`). Second=
, even in locked hooks like `sock_ops`, a BPF program can perform a lockles=
s socket lookup (e.g., via `bpf_sk_lookup_tcp()`) and pass the resulting un=
locked socket to the helper. Since the helper accepts any `ARG_PTR_TO_SOCK_=
COMMON` regardless of whether it is the context socket, and the lockless re=
ad hardening from v3 was dropped in this patch, this allows the exact same =
lockless Use-After-Free or NULL pointer dereference on `mptcp_subflow_ctx(s=
k)->conn` during socket fallback, initialization, or teardown.
--

--- Patch [1]: [PATCH mptcp-net v4] mptcp: bpf: don't expose bpf_skc_to_mpt=
cp_sock() to tracing progs ---
commit 5acf7057a22cd1b7a4c59432f2d0744627b03558
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: bpf: don't expose bpf_skc_to_mptcp_sock() to tracing progs

The patch drops bpf_skc_to_mptcp_sock() from tracing_prog_func_proto() to
prevent lockless access to mptcp_subflow_ctx(sk)->conn during subflow
fallback, init, and teardown.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 75495a5c35079..ad4b8d04b190a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1745,8 +1745,6 @@ tracing_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
>  		return &bpf_skc_to_udp6_sock_proto;
>  	case BPF_FUNC_skc_to_unix_sock:
>  		return &bpf_skc_to_unix_sock_proto;
> -	case BPF_FUNC_skc_to_mptcp_sock:
> -		return &bpf_skc_to_mptcp_sock_proto;

[Severity: Critical]
This is a pre-existing issue, but does removing this helper from tracing
programs completely prevent the lockless dereference regression?

The helper remains exported via bpf_sk_base_func_proto() in net/core/filter=
.c,
which makes it available to datapath hooks like XDP and TC that do not hold
the subflow lock.

Additionally, even in hooks that do hold the subflow lock for the context
socket (like sock_ops), a BPF program can perform a lockless socket lookup
(e.g., using bpf_sk_lookup_tcp()) and pass that unlocked socket to the help=
er.

Since the lockless read hardening was dropped from v3 of this patch, the
underlying helper in net/mptcp/bpf.c:bpf_mptcp_sock_from_subflow() still
performs:

    if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
        return mptcp_sk(mptcp_subflow_ctx(sk)->conn);

Could this still allow a use-after-free or NULL pointer dereference on
mptcp_subflow_ctx(sk)->conn when an unlocked socket is passed during socket
fallback, initialization, or teardown?

>  	case BPF_FUNC_sk_storage_get:
>  		return &bpf_sk_storage_get_tracing_proto;
>  	case BPF_FUNC_sk_storage_delete:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817113202.1832=
692-1-kalpan.jani@mpiricsoftware.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FD3AB47E
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055736; cv=none; b=U+eCwWEIIv5JXKa740Tua32ywUQwea/UWzaQnfKwNbDDZvcLcJwbjoCoGjxvhfr/k1I0uWlKhGjpp4MiI8jeuZzxr2x4sJWCfa5CQR1XJ0YDLASoQZYEfscu7fc2Vk5BqawxPkaMqDI3WbZPWTAH+V7xyOOWnHn0OIgy1tsL6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055736; c=relaxed/simple;
	bh=hQTpwSs7FGjVYL9+/nEhuQplCF/TFue2PAcnMRbrc/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u0LDrkCtYKRrJJ12w1bKVSoKxQ2cNMU/Mja/R4QkSL5xN+AR+Yh4pg3yKrNj1NqVUSCZ/871JRdvq5HtP+yBYQ0e53QZU4UzazyzTPP3bdDo+JAvAU3zCd4xol9ur6K0T3x2hTPj6aKUlGGEr/Z51bHVxJeqDLTlNww67fO9Wfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAOGod7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAOGod7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F392C1F000E9;
	Tue, 18 Aug 2026 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787055735;
	bh=Hzeu1mVGlYE+/TSnw21PVU76p/+u5C0w/udifeAFnKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PAOGod7MOPoVhaZDnBAXMpxKcHmWejuVE9cNqtAp5ZORoWgkXtxXXyul1+aQg+o/R
	 lT2pYClq9+onxnGrp1kOMNsvVLpJRZVKixl4G48rqEnQqUCDDZWiCrjfYMjChj2glX
	 s6o5zNXokjTaN1paV81VTtU8UgiePu6JET2QRR1GvSNRhCZH150mXFhLl907iKglMs
	 uKdNL+4rQyf5WqDAcO7Vwp+TJd1/WxyA8/Jki+plBEwZw2Q+bKaflrrQSskY/dBton
	 kbUpvdQ/PkS46b+d+8DBGbU4QPjoGlRHJ2/RQ0rRUvvMmXKM2ebR/dh/S3BBwKpEjZ
	 7CO5uBblM34kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v5] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818120437.3949686-1-kalpan.jani@mpiricsoftware.com>
References: <20260818120437.3949686-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 12:22:14 +0000
Message-Id: <20260818122214.F392C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] UAPI Breakage: Unnecessary removal of BPF helper `bpf_skc_to_mpt=
cp_sock` from tracing programs.
--

--- Patch [1]: [PATCH mptcp-net v5] mptcp: bpf: fix NULL deref and UAF in b=
pf_mptcp_sock_from_subflow() ---
commit 38297906a34000d9bfada12a688129bcb90092ca
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()

This patch fixes several race conditions and use-after-free bugs in
bpf_mptcp_sock_from_subflow() when accessed locklessly. It introduces RCU
dereferencing, acquire/release semantics, and delays parent socket freeing
via an RCU grace period. Additionally, it removes the helper from tracing
programs.

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

[Severity: Medium]
Does removing this BPF helper break ABI backward compatibility for existing
userspace tracing tools?

The commit message states "Tracing stays removed since nothing needs it
there", but out-of-tree tracing scripts or tools might already rely on
BPF_FUNC_skc_to_mptcp_sock being available to tracing programs.

Since the underlying lockless read was properly fixed to be safe via RCU,
acquire/release semantics, and SOCK_RCU_FREE, can this helper be preserved
for tracing programs? If sleepable tracing hooks were the primary concern,
could this be restricted via a prog->sleepable check instead of removing
the helper entirely?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818120437.3949=
686-1-kalpan.jani@mpiricsoftware.com?part=3D1

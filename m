Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54B21255A
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829477; cv=none; b=XTrt5gE4XcuZ874js0fUlvTsbC/B1SBh1X8lM+WMFWaHB9VizQz/VHXz3hWM6TeemC48qmKhEuhEFD5U7Qu4jOV5cXUjAlLGUrWMruuIo1QWKiiUxcc5SB+IgPNDnrq3+IiZSVCwiL+/iqfLXbqokov/OLgiTCqS2HWOwofCUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829477; c=relaxed/simple;
	bh=WXjp70UctJqlShUQZ/fQ/uLFNUQHUFWZ/dksC0YXAjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QcM7vl4ci62a3qgkxlwjjbNtbjidt1G6JzaIyH7pQeCMNwxWxhsvSoIFmJhfTl+7DH4bMVt8XPUFu63IgIcLy2gLq8o4+R8Tpo0Lw9T2VJxCHadCUk6wbcbdekfvk/IrG+MqnJSUY4ff5cLHVHK2fWptQVOxSSwXKsGgL386ITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGoaSAUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGoaSAUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8791F000E9;
	Thu, 27 Aug 2026 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787829471;
	bh=6jRLbQopzv7adKsNQ7JPC96UVWbBGC6MEbTeLrJlBAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WGoaSAUAJ8qxStUl9julayGsObLoZl35UvD18Q4gUrghMcpGwqlis3Qz7wzC5E9dB
	 /8UPiYg69MBs0p/B++PgqwnAHwLEvm+jgjluV8+1Eq0ZlpYfCG6v2rzJ63P9LNkMiA
	 4jsmnCJjxtpMWzLzcCD5DFXZ+eHKslzzxrwT2m1TaiNYmTjf044JTsGeFLDSJwqvFU
	 XjyMVtjwX3IyHkkeCCZoE/55iaFl4B9twP6v2ds8D17k1r3VNREgAcJ3RgZROZkPDz
	 JaqRVWuMSycygFkElhKXWntbAEJMvy1GJPr5A4lErPtRR+7DbwB/16/YFWcBC7Evuy
	 bz1Lqwh3A2GBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v9 11/11] Squash to "selftests/bpf: Add
 bpf_burst scheduler & test"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <056ee1d2d313b38d6dfa20d44517ddeed34a63db.1787827525.git.tanggeliang@kylinos.cn>
References: <cover.1787827525.git.tanggeliang@kylinos.cn>
 <056ee1d2d313b38d6dfa20d44517ddeed34a63db.1787827525.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 11:17:50 +0000
Message-Id: <20260827111751.4A8791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Reading a 64-bit atomic variable directly via READ_ONCE() from a=
 BPF program causes load tearing on 32-bit architectures.
--

commit a7fdecf17f713344ff1f523b442eda6174e11cd2
Author: Geliang Tang <geliang@kernel.org>

    Squash to "selftests/bpf: Add bpf_burst scheduler & test"

This commit modifies the BPF burst scheduler test to safely read the newly
converted atomic64_t field msk->snd_nxt using READ_ONCE() on its .counter
member within the BPF context.

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_burst.c
> index 3d512b0efe6f7..a391f6563a618 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
> @@ -108,7 +108,8 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *m=
sk)
>  	if (!subflow || !bpf_sk_stream_memory_free(subflow))
>  		return -1;
> =20
> -	burst =3D min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
> +	burst =3D min(MPTCP_SEND_BURST_SIZE,
> +		    mptcp_wnd_end(msk) - READ_ONCE(msk->snd_nxt.counter));

[Severity: Medium]
Will this cause load tearing on 32-bit architectures?

When the kernel concurrently updates msk->snd_nxt using atomic64_set(), on
32-bit architectures (e.g. ARM32, i386) configured with CONFIG_GENERIC_ATOM=
IC64,
atomic64_t operations are protected by hashed spinlocks. The BPF JIT will
translate the 64-bit load of READ_ONCE(msk->snd_nxt.counter) into two separ=
ate,
unsynchronized 32-bit memory loads.

If the BPF program executes these memory loads while the kernel is writing =
to
the counter, it could observe a torn read, leading to an incorrect burst si=
ze
calculation that breaks the MPTCP bpf_burst scheduler logic.

>  	ssk =3D mptcp_subflow_tcp_sock(subflow);
>  	wmem =3D ssk->sk_wmem_queued;
>  	if (!burst)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787827525.gi=
t.tanggeliang@kylinos.cn?part=3D11

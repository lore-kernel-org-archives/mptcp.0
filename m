Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6C3793BA
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408826; cv=none; b=h+PCc3CncmZoyxl/cA5bHf5ltr6E0Q/Rt+hf1ZwUTu0RcpBBSFbP8zdW8tEIUOeC0iVl5cnM0DYjNweP3ne56eUDAFBTBGe6oAGGgZmd5ZBR5xKwe3ezK0N39sXauswcpjH4ZxQGfQaSdUxfEn5pXILdMfflqNTDCLSk+BRc6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408826; c=relaxed/simple;
	bh=6aBj19mNBkByx0kHXg49+hLsFIUPrHdJ0Oft0goElD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mup0bVSIt7YvazdCYtzFaHqbAxP/UdqgtEjW5Q25pTjU7UHb6K4NGT0g8qJIAWMzECuVFo/+o1JCheT6OtgnYTF17jCIeLxx5p03s1WP0J0iA1VuEGaHUTOTni7fo6or9ZFxAHN/Dw8i1WpGT7sEhrRivxtUbQScMAbXWOhgE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuvDl7xR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuvDl7xR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8801F000FF;
	Mon, 14 Sep 2026 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789408824;
	bh=4QvkFbUeJOGQlax4PqJqroqEBituaE24us6fjJTu9/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuvDl7xRqcgJn18lgjYVR+d/bYiBnSe5+GNpFtiNpRirVSfebFfb8yXawyylO4OFo
	 6ACEoIp6Il15B1gF7iycO/nXTmMNfLAl0xsay1UrfXxYQ+MVA0HrtmKZzlOgDVEqdb
	 isfrXqjMuuiUZq5ODvuCFF+QBASftfAPMweVQflslW9kB55HBvvZcvcSm/31KKQ4Em
	 xaQK19k3wJkvD5Cxsn2s0H3SWZRvSFAze55wS58VoUSvqDEIVgmptiqhIdau8ki5No
	 mn2tvQ55B07QhVoijiSFJIRhEfLtFk26sQw8DtAo0aKxOxuAENILeG8doJ/ITZFtOE
	 QAw8KshXRQQCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: capture on client
 side for test 020
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260914-mptcp-sft-join-cap-ns2-v1-1-2f48e4c5f9eb@kernel.org>
References: <20260914-mptcp-sft-join-cap-ns2-v1-1-2f48e4c5f9eb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:00:24 +0000
Message-Id: <20260914180024.BC8801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Nested calls to `cond_start_capture` overwrite the global `cappi=
d` variable, causing a `tcpdump` process and its network namespace to leak.
--

commit 80defebd011f8ed71f8eb594afa6362cc8789eb8
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

selftests: mptcp: join: capture on client side for test 020

The test "signal address, TCP-only listener on client" is particular, so
a capture on the client side is added to help understand what happens in
case of issues.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index b16e24418e737..690188b01a29d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2413,7 +2413,10 @@ signal_address_tests()
>  		extra_bind=3D$!
>  		mptcp_lib_wait_local_port_listen "$ns2" "$port"
> =20
> +		# there will be traffic on the client side only: MPJ to loopback
> +		cond_start_capture ${ns2}
>  		run_tests $ns1 $ns2 10.0.1.1

[Severity: Medium]
Will this leak a tcpdump process by overwriting the global cappid variable?

In cond_start_capture(), cappid is set as a single global variable:

	ip netns exec "$ns" tcpdump -i any -s 128 -B 32768 $capuser -w "$capfile" =
> "$capout" 2>&1 &
	cappid=3D$!

Here, cond_start_capture is called for ns2, but run_tests() -> do_transfer()
also unconditionally calls cond_start_capture again for listener_ns:

	cond_start_capture ${listener_ns}

This second call overwrites the global cappid. When the inner cond_stop_cap=
ture
and the outer cond_stop_capture are called, they attempt to kill the same i=
nner
process, leaving the first tcpdump process to run indefinitely in the
background.

> +		cond_stop_capture
>  		join_synack_no_mpjoin=3D1 join_syn_tx=3D1 \
>  			chk_join_nr 0 0 0
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-mptcp-sft-=
join-cap-ns2-v1-1-2f48e4c5f9eb@kernel.org?part=3D1

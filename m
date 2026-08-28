Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1433F1047;
	Fri, 28 Aug 2026 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787961321; cv=none; b=G+RDRJneOhIjSJFG1VYS3tfP8Kp13vBfQye2gnsSwkjV3YpdPP1AqPja/Krf/T8Ls/nz0pYpHSMlfb4//hv5e7vhZshBnmcPJJrM0IV3chPnKyuYl1WDazMKtuf2RYzA/gsYo2OZNnwWvXpE40lE4o7REaWoPmgVdMh80hzdiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787961321; c=relaxed/simple;
	bh=NJThH3EjYMUijdCxzUrekDYRd2bDguzSPLL+/WhIPLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PJ/X07n3sDdaNNj/7NA+YWxl98d4hC7BddUQSPx348nhwB9OPUOKXS9dDYxWvJnmIbdtA7EFMIQAJBKj2CRyG1gNOP7GeP+uYeOmSfGpl/mjScT4p3EjLVCZdyIne5T9KrnimGY2O0iykstNjc/eDRf0Q2Ss5ArTFDUqMvarFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL+ENEYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL+ENEYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC1B1F000E9;
	Fri, 28 Aug 2026 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787961319;
	bh=s+Z28pWap+J0/DcFF7PQXh9tMY0c2jRlQj+pNlU/oIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EL+ENEYQVqmJcci5xLVJ0d2eCR0f9N0Sr14u3QZEuQNvWA4Ur0pVLnndNrg/s7Vis
	 EUfktrhBtY4WPZEvLqf9RqlR0ND34h4jzmjW4ciFOeMpOpLL1O3rN20wJLA1r3k54n
	 rV+h7aFE1Y/rrzBoMOXvMWRxoi10I5wISxLIuqtWEb8G6gkS64XA8jGObpFn/+kUoY
	 Q8I9XoxKLJ6GnIqVn1NIr3hD/+f5ZFNYIyEH5x1hOPtQbv8LH8bI/ErPnFsb706+iw
	 3HvmHO9W0quIMxEY9Xip2ZtR4tcO28VpnlKpaYLGIf9YfzDAdgwWTy31Hf9eu3KbxC
	 LZg6GQIqukATw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] tcp: fix use-after-free in
 do_tcp_getsockopt(TCP_CONGESTION)
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>
Cc: mptcp@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com>
References: <cover.1787870710.git.blbllhy@gmail.com>
 <d3f97f1acbf0010898148be6e6406e4b8b4a5c84.1787870710.git.blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:55:18 +0000
Message-Id: <20260828235519.3FC1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF getsockopt helper can race with user-space getsockopt(TCP_SAVE=
D_SYN) causing a use-after-free on tp->saved_syn.
--

commit aaf314b305f9bf7c88d6539be45ea64300819450
Author: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>

tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)

This commit fixes a use-after-free in do_tcp_getsockopt() for TCP_CONGESTION
by holding rcu_read_lock() while reading the congestion control name. It al=
so
annotates icsk_ca_ops updates with WRITE_ONCE() to address KCSAN data-races.

Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.com/

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b6949..55ca74f6029fa 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4576,16 +4576,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>  		val =3D !inet_csk_in_pingpong_mode(sk);
>  		break;
> =20
> -	case TCP_CONGESTION:
> +	case TCP_CONGESTION: {
> +		char ca_name[TCP_CA_NAME_MAX] =3D {};
> +
>  		if (copy_from_sockptr(&len, optlen, sizeof(int)))
>  			return -EFAULT;
>  		len =3D min_t(unsigned int, len, TCP_CA_NAME_MAX);
>  		if (copy_to_sockptr(optlen, &len, sizeof(int)))
>  			return -EFAULT;
> -		if (copy_to_sockptr(optval, icsk->icsk_ca_ops->name, len))
> +
> +		rcu_read_lock();
> +		memcpy(ca_name, READ_ONCE(icsk->icsk_ca_ops)->name,
> +		       sizeof(ca_name));
> +		rcu_read_unlock();
> +
> +		if (copy_to_sockptr(optval, ca_name, len))
>  			return -EFAULT;
>  		return 0;
> -
> +	}
>  	case TCP_ULP:
>  		if (copy_from_sockptr(&len, optlen, sizeof(int)))
>  			return -EFAULT;

[Severity: High]
This is a pre-existing issue, but while reviewing this TCP getsockopt
fix, I noticed another potential use-after-free regression in the BPF
getsockopt helper.

In net/core/filter.c:sol_tcp_sockopt():

	if (getopt) {
		if (optname =3D=3D TCP_SAVED_SYN) {
			struct tcp_sock *tp =3D tcp_sk(sk);

			if (!tp->saved_syn ||
			    *optlen > tcp_saved_syn_len(tp->saved_syn))
				return -EINVAL;
			memcpy(optval, tp->saved_syn->data, *optlen);

Since BPF iterators run without holding the socket lock, can this
locklessly read tp->saved_syn and call memcpy() on its data?

If a concurrent user-space thread calls getsockopt(TCP_SAVED_SYN) on the
same socket, it acquires sockopt_lock_sock(sk) and frees the memory via
kfree(tp->saved_syn) inside tcp_saved_syn_free().

Will the BPF program's memcpy() then dereference the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787870710.gi=
t.blbllhy@gmail.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832C367B84
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296483; cv=none; b=gXmreQRb87pFPnbRrTqAc0NuJDUAnztv7QDlcsrsqYkBYK8Tf8V43Hr/OQytNEFl1riNVoclQBmnLiT2u/ZBgzG1bh7uVRvlVZ2trFJRpf5adYv50YT6Gsr9es6NdsGuEjIcuD5A8wzn7BNus/dRBLN/MP6y2txGBaIxXV/6hkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296483; c=relaxed/simple;
	bh=R+tJtRK99NE7v6j5Tgmmy7CwN3sEfdzw/rL7nn8AR+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iuQMYH9J7mJ87dDwY3far1nQvyuS5vy//kVkzMxTzkWdwA54meChVFM7yxi1sacT0heKXt6FOqMQ9mJuNKaM3sGYAS7yMcJTV5p9TjM5Xd3ZOdJAARXkYdMRsW0eM+FEBnw4sPwYkGbJzWV4k6V/b+MpOl8hZlQCFRyp2llJOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma9SFchP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma9SFchP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D811F000FF;
	Sun, 13 Sep 2026 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789296482;
	bh=CxHZk6qmqoguI2IB6Fp3Wb08HAbvTigHsFZJeU2PuCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ma9SFchPMs3UV0xY1vu8Cd30kzEeMsWpE/3JFq8ZeU67M6n0Jnh0VKIz7lDe6A+fG
	 ldjBBQXXWXkDXUeIQ+j+/BMHeTE03IUsNEjRjTXYXQt/WqFO+uXZYLHEILMUOIJhGT
	 cQSpy0VLK1lx9Qyz/bXZWYjBotve9E4N9zJUHccWYN8qgZ3xtnxD/FkwB7j4kvSXU0
	 SBXX6uKUOqO9l8r2hzOWN9U8q3Q58GsXlP2fn97PJZt1o8RlwHkgrswAfQO93vLHZa
	 F1a6jfgENg7mpjBjVZzldChG125l1NUIQZU+l2u0RcvIFUuz5GItW3rU0ksaPIXmsE
	 anvQeg9mgWO3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 15/16] mptcp: add sk_select_reuseport BPF
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <fdea25aa5bdb8c4a03b5b84a0a593cea93063e9f.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <fdea25aa5bdb8c4a03b5b84a0a593cea93063e9f.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:48:01 +0000
Message-Id: <20260913104802.43D811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Registering `mptcp_sk_select_reuseport` for `SOCK_OPS` program=
s causes context type confusion, leading to arbitrary memory dereferences.
- [High] The helper `bpf_mptcp_sk_select_reuseport` blindly casts a socket =
retrieved from a BPF map to an `mptcp_sock` without validating its protocol=
 type, leading to an out-of-bounds read and kernel panic.
--

commit bd581565353c0c8e12fc690ee324023efbe0b30c
Author: Geliang Tang <geliang@kernel.org>
Date:   Sun Sep 13 10:14:54 2026 +0000

    mptcp: add sk_select_reuseport BPF helper

This commit adds an MPTCP-aware variant of the bpf_sk_select_reuseport
helper. It extracts the core selection logic into sk_select_reuseport_lookup
and registers the new helper for both sock_ops and sk_reuseport BPF program=
s.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0b4fec5a8848a..f1415ff42a514 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8857,6 +8858,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const=
 struct bpf_prog *prog)
>  #if IS_ENABLED(CONFIG_MPTCP)
>  	case BPF_FUNC_mptcp_sock_map_update:
>  		return &mptcp_sock_map_update_proto;
> +	case BPF_FUNC_mptcp_sk_select_reuseport:
> +		return &mptcp_sk_select_reuseport_proto;

[Severity: Critical]
Is it safe to expose this helper to sock_ops programs?

The verifier will validate the first argument against the sock_ops context
type (struct bpf_sock_ops_kern *), but the helper implementation expects a
struct sk_reuseport_kern *.

>  #endif
>  	case BPF_FUNC_get_socket_cookie:
>  		return &bpf_get_socket_cookie_sock_ops_proto;

[ ... ]

> @@ -11738,15 +11741,14 @@ struct sock *bpf_run_sk_reuseport(struct sock_r=
euseport *reuse, struct sock *sk,
>  		return ERR_PTR(-ECONNREFUSED);
>  }
> =20
> -BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
> -	   struct bpf_map *, map, void *, key, u32, flags)
> +int sk_select_reuseport_lookup(struct sk_reuseport_kern *reuse_kern,
> +			       struct sock *selected_sk,
> +			       struct bpf_map *map)
>  {
>  	bool is_sockarray =3D map->map_type =3D=3D BPF_MAP_TYPE_REUSEPORT_SOCKA=
RRAY;

[Severity: Critical]
Could the type confusion mentioned above lead to an arbitrary memory read
inside this function?

When called from a sock_ops program via mptcp_sk_select_reuseport,
reuse_kern actually points to a struct bpf_sock_ops_kern. Later in this
function, the code dereferences reuse_kern->sk to check the protocol.
In bpf_sock_ops_kern, the offset corresponding to the sk field points
to the args array, which means an arbitrary or user-influenced value is
treated as a struct sock pointer and dereferenced.

>  	struct sock_reuseport *reuse;
> -	struct sock *selected_sk;
>  	int err;

[ ... ]

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index f6fd610f70778..fe10c5ed28f03 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -511,3 +511,25 @@ BPF_CALL_4(mptcp_sock_map_update, struct bpf_sock_op=
s_kern *, sops,
>  	return sock_map_update_common(map, *(u32 *)key, sk, flags);
>  }
>  EXPORT_SYMBOL_GPL(mptcp_sock_map_update);
> +
> +BPF_CALL_4(mptcp_sk_select_reuseport, struct sk_reuseport_kern *, reuse_=
kern,
> +	   struct bpf_map *, map, void *, key, u32, flags)
> +{
> +	struct sock *sk, *selected_sk;
> +
> +	sk =3D map->ops->map_lookup_elem(map, key);
> +	if (!sk)
> +		return -ENOENT;
> +
> +	selected_sk =3D READ_ONCE(mptcp_sk(sk)->first);

[Severity: High]
Does this helper safely handle non-MPTCP sockets?

Since a normal TCP socket can be inserted into maps like sockmap, sockhash,
or reuseport_sockarray, a BPF program could look it up and pass it here.
Because there is no protocol check before casting, this blindly casts the
tcp_sock to an mptcp_sock.

The first subflow pointer is located at a large offset in mptcp_sock that
exceeds the bounds of tcp_sock, which could result in an out-of-bounds
memory read and a kernel panic. Should there be a validation check before
this cast?

> +	if (!selected_sk) {
> +		if (sk_is_refcounted(sk))
> +			sock_put(sk);
> +		return -ENOENT;
> +	}
> +
> +	if (sk_is_refcounted(sk))
> +		sock_put(sk);
> +	return sk_select_reuseport_lookup(reuse_kern, selected_sk, map);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D15

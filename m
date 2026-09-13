Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3AE3E715E
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295330; cv=none; b=iOFEADAT9+Re5w9eT7BsEqFZ8UMExcvAIA802EqkazeIaVgBOII6qhg+947FmUCPqB50VPXvsWiCWA9lGXQu+pPJGbXo/zDRAxf+rvOdtp3ojOBul5U1+G1c9iTDziQkgbv4rT9GuKUTP6UluxWH14PrQA/Ce0Dw4e94uAKXdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295330; c=relaxed/simple;
	bh=Lyqwc3s4hWzK0yu5rECfNjIYA6bEwlG/NmVzDqPOcIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4VmyIbA+NHTVuBWWFfl9NrZbrpTBnuESkYrTJPkWOCM1A/SKNNCUUtb7J4tq04Tybzjlr/sAKNtYH6+ZFFuDW59kIHoKKyD74+Dp90AhoGhPvTZBXjzB49W08aT4i8T7rcGb2kEH2cHygIFTcvAT+nqd2Q2AhIgdM5Qm9c8N6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFddnJsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFddnJsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952271F000FF;
	Sun, 13 Sep 2026 10:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789295318;
	bh=VuQ0LVJMnKTlSLIIG2DvlMX5akz244cGGiSk4HU/0Oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iFddnJscMNyzufJzXb0Ue10wH9sm0O1vSr1oG8dXHiFUGpYLNDxWCAZ/T3RSjHPDf
	 DYhf1+2a2Ys7rCH5mL8tQafAOmPwhBBh+Ye20oUCt1RTAPZ90Ami+CxJ19XFac3+bz
	 aPzL3QWEMsF06sWchWdkDbMevg/Txd8Y9LMpnepYFtjdUyhR98RidU/36kY6L2hh1/
	 VOyDr2NZj1ZZKjlcS3nzfRFBOdTee6jZLJLIuX7XcTFl3J5sk8AvYmTbypHVYuoDkw
	 dtB5KV7SjlPQd6EJuzGxriVI1TBJqGc4ry+SFntuxrLizUdiYTqM56mv4YYmSYucpe
	 MEQa0lL+QrruQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 10/16] bpf: export and generalize
 tcp_bpf_ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <2470bdd0b43b4b4530edd7d0448e0e92bd8e578f.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <2470bdd0b43b4b4530edd7d0448e0e92bd8e578f.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:28:38 +0000
Message-Id: <20260913102838.952271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Calling `sk->sk_prot->ioctl(sk, cmd, karg)` from within `tcp_b=
pf_ioctl` unconditionally causes an infinite recursive loop, leading to ker=
nel stack exhaustion and a panic (DoS).
- [Critical] Dereferencing `sk->sk_socket->ops->peek_len` unconditionally c=
rashes on MPTCP sockets because their protocol operations do not implement =
the `.peek_len` callback.
--

commit 2a70238c7c665c1d078c38019a80c54ba0029da5
Author: Geliang Tang <geliang@kernel.org>

bpf: export and generalize tcp_bpf_ioctl

This commit exports tcp_bpf_ioctl() and generalizes it to use
protocol-specific operations instead of hard-coded TCP functions. It also
wires this generalized ioctl handler into the MPTCP BPF protocol structures
so that SIOCINQ returns correct results accounting for data in the psock
ingress queue.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index e006131696e96..8aed3c309b0dc 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
[ ... ]
> @@ -331,15 +331,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	return copied;
>  }
> =20
> -static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> +int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>  {
>  	struct sk_psock *psock;
>  	bool slow;
> =20
>  	if (cmd !=3D SIOCINQ)
> -		return tcp_ioctl(sk, cmd, karg);
> +		return sk->sk_prot->ioctl(sk, cmd, karg);

[Severity: Critical]
Does this cause an infinite recursive loop regression?

When a socket is attached to a BPF sockmap, its protocol operations
structure is replaced by a BPF-specific protocol structure. Since this patch
assigns .ioctl =3D tcp_bpf_ioctl in those structures, sk->sk_prot->ioctl wi=
ll
resolve right back to tcp_bpf_ioctl itself, exhausting the kernel stack and
leading to a system panic.

> =20
> -	/* works similar as tcp_ioctl */
> +	/* works similar as sk_prot->ioctl */
>  	if (sk->sk_state =3D=3D TCP_LISTEN)
>  		return -EINVAL;
> =20
> @@ -347,7 +347,7 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, in=
t *karg)
>  	psock =3D sk_psock_get(sk);
>  	if (unlikely(!psock)) {
>  		unlock_sock_fast(sk, slow);
> -		return tcp_ioctl(sk, cmd, karg);
> +		return sk->sk_prot->ioctl(sk, cmd, karg);

[Severity: Critical]
Will this fallback path also trigger the same infinite recursion regression
as above?

>  	}
>  	*karg =3D sk_psock_get_msg_len_nolock(psock);
>  	/* Without a verdict program, ingress data is never diverted to
> @@ -357,7 +357,7 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, in=
t *karg)
>  	 */
>  	if (!READ_ONCE(psock->progs.stream_verdict) &&
>  	    !READ_ONCE(psock->progs.skb_verdict))
> -		*karg +=3D tcp_inq(sk);
> +		*karg +=3D sk->sk_socket->ops->peek_len(sk->sk_socket);

[Severity: Critical]
Will this cause a NULL pointer dereference regression for MPTCP sockets?

While TCP's socket operations define a .peek_len callback, MPTCP's socket
operations do not implement it, leaving the function pointer initialized to
NULL. Dereferencing it unconditionally here will crash when SIOCINQ is
invoked on an MPTCP socket attached to a BPF sockmap.

>  	sk_psock_put(sk, psock);
>  	unlock_sock_fast(sk, slow);
> =20
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 7ecafbf51fa05..f6fd610f70778 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -398,6 +398,7 @@ static void mptcp_bpf_rebuild_protos(struct proto pro=
t[MPTCP_BPF_NUM_CFGS],
>  	prot[MPTCP_BPF_BASE].close		=3D sock_map_close;
>  	prot[MPTCP_BPF_BASE].recvmsg		=3D mptcp_bpf_recvmsg;
>  	prot[MPTCP_BPF_BASE].sock_is_readable	=3D sk_msg_is_readable;
> +	prot[MPTCP_BPF_BASE].ioctl		=3D tcp_bpf_ioctl;

[Severity: Critical]
Since tcp_bpf_ioctl is wired into the MPTCP BPF protocol structure here,
does this expose MPTCP sockets to the NULL pointer dereference mentioned
above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D10

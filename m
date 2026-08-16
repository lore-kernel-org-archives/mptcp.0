Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F73A1686
	for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786842995; cv=none; b=hKHI0zyH8wkamjqD8k1GK+88TXPi6mk1FPwsiOD3ZAWQpeRAc0qD9GdLzi2KfcO9UN8cMAtHfC3p+YrOpF+MSlIWQR/GndWX0vrrlB2JWD1CKKd7JQWlqHEXto6l3DZNZMSe1/181yiV50ZfsJYrEroqXK0vOT61+bLchiLyCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786842995; c=relaxed/simple;
	bh=kMSADCFHfefzc2UkBgUKFQD09y4XWULYVdnLfgUD7zg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQQPqgbV+X+j1lzA3jZQ5rMzrzSNIlBKtvl7nHF7diFXlX6HfimyEjOaIK/RB/LmptD+vOton7sOwALbpMdolG6L15deWQPiaIcsOT6GeUaainhXxZIh0H7oF+j/8zuDNdZS0OzKWovE1XMPRpR+4pXQIRLfxSs0kyMdIvkBSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyZZtBPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyZZtBPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31A41F000E9;
	Sun, 16 Aug 2026 01:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842994;
	bh=T1Ys28QsUOEilbFW7OcCQyEAXbllW8CrGb4ps+2rUM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyZZtBPEkA+IYRo0aKpjrRZHXi+xktetXnzIiTUaQ+XtAcnmQhLcpNkTZsToK/tAZ
	 vfBimOe4yWPz1tonpH9ufrBhLA5xp4MSS/abur32oB+fEP5jRxiFQF29bYTRI6jiYk
	 S5BPFtPGJhh4Qr8pqlrJm849Wj9qdoqHndBnwud7l/IqdPPKoTTSv6iZf7a2HkYL4D
	 JJXcJ/tLRxM4T8sSJbVVLC8Ut776SVrLc5077spfZnt6RP5qqR8pVGH3MM7Z31+2G8
	 iW4Z8zQtuowTmtcgVkeuptMsYJLvpdBzinJl65guSfvQKYOe8XtN5UrcbGJz+PZ+FV
	 bgwe+TP4tuSbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] nvme-tcp: unify sockopt with do_sock_setsockopt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <97e667df6c3755d1f9e2e709dfa1dc64903317e1.1786841319.git.tanggeliang@kylinos.cn>
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
 <97e667df6c3755d1f9e2e709dfa1dc64903317e1.1786841319.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 01:16:33 +0000
Message-Id: <20260816011633.D31A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Routing internal kernel socket configuration through user-facing d=
o_sock_setsockopt() ignores return values and subjects critical NVMe settin=
gs to userspace BPF hooks.
--

--- Patch [2]: [PATCH v3 2/4] nvme-tcp: unify sockopt with do_sock_setsocko=
pt ---
commit 2f6cd2b103bf52f5964e62f02552a246d7faa461
Author: Geliang Tang <geliang@kernel.org>

nvme-tcp: unify sockopt with do_sock_setsockopt

This patch consolidates socket option settings in nvme-tcp by utilizing
the generic do_sock_setsockopt() helper. It converts several direct socket
configuration calls to this unified mechanism.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ce03a0ea4ded7..3bc41a4735d94 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1774,6 +1774,47 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nc=
trl,
>  	return ret;
>  }
> =20
> +static void nvme_tcp_sock_no_linger(struct sock *sk)
> +{
> +	struct linger ling =3D { .l_onoff =3D 1, .l_linger =3D 0 };
> +
> +	do_sock_setsockopt(sk->sk_socket, false, SOL_SOCKET, SO_LINGER,
> +			   KERNEL_SOCKPTR(&ling), sizeof(ling));
> +}

[Severity: High]
Does routing internal socket configuration through do_sock_setsockopt() exp=
ose
these settings to userspace BPF hooks and LSMs?

Since the kernel socket inherits the calling process's cgroup, a=20
BPF_CGROUP_SETSOCKOPT hook or LSM rule could intercept and deny the=20
operation. Because the return value is ignored here, would this silently=20
fail to apply SO_LINGER?

[ ... ]

> +static void nvme_tcp_sock_set_nodelay(struct sock *sk)
> +{
> +	int val =3D 1;
> +
> +	do_sock_setsockopt(sk->sk_socket, false, SOL_TCP, TCP_NODELAY,
> +			   KERNEL_SOCKPTR(&val), sizeof(val));
> +}

[Severity: High]
If do_sock_setsockopt() is intercepted or fails, this also ignores the retu=
rn
value. Could this leave Nagle's algorithm enabled on a storage protocol,
leading to severe performance regressions?

[ ... ]

> @@ -1819,24 +1860,24 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl =
*nctrl, int qid,
>  #endif
> =20
>  	/* Single syn retry */
> -	tcp_sock_set_syncnt(queue->sock->sk, 1);
> +	nvme_tcp_sock_set_syncnt(queue->sock->sk, 1);
> =20
>  	/* Set TCP no delay */
> -	tcp_sock_set_nodelay(queue->sock->sk);
> +	nvme_tcp_sock_set_nodelay(queue->sock->sk);

[Severity: High]
Executing these wrappers in sequence without checking for errors means that
failures are silently ignored. Can this result in an incorrectly configured
socket being used for NVMe over TCP connections?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786841319.gi=
t.tanggeliang@kylinos.cn?part=3D2

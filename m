Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573971;
	b=oEu7LxlWq82iHvYbAjml7eebLml03XammYbT+cev5i2YKjxe2a7G//sPQhIdm6e2MnIK
	 rFPStQhWmJBkVyidS9xNvk5ATvNrkELTaDnMI8PNtA2DqUCFdSaeMHToycTOfZm2k4FFL
	 L4E1ce11SBoFYI2TIjuZIpxb+WULSkn6aAV5uQi0K9+CJ7wbFuLV1NhJXNix4qSCdt/yd
	 YNqyz6n3r8n8R2qNcO6e2HV+7MnDLv0jMDEaxr3CX7n5LBZWXyDYMHbVDaMOd31YTpB6x
	 lrgxHx/L3LVEUBAh+nhST98IN7MyN5Jn9qNP4G2xs2M5LeIQ6sIRD2kxHUBnVuB9Q4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573971;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hg5UuArqUwlzGOA9EKouCGoyxeHzpU0gmKObp6zGFSk=;
	b=Ty2hS5KhabLgVsaQB7t+pnxTFLwV+udoW7WtReZ+XVzMg8NlTBad9FV4QpB7qLnDb15f
	 m5hKMBrkffo61cNqJt8nNqqR9DRUIPOmjQNwnLrCn+Q2VKaZ82KGANkGeS8HWO+0g8dhq
	 Yf11ZEkfuYsH25RA66b1pOd/13sLPcLWVy1arm+Rzr/w8HrppVQGf3PLufSMh/+PkGyeY
	 y3lYv5ZUOtIvbNetsBtj1d+fdB8tmq9pW8jE7781Tt2an80wHSxJgOwpaEjyLU3D4dJgY
	 ixy4jCT4lZFe5WB+mkHeMxFh/ek5vGB9V8lAW5c+o5BMWeTuj+1qoV6zB9lJfa0h5qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCKRJzyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5B606A32D
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCKRJzyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D351F000C4;
	Fri, 13 Nov 2026 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573970;
	bh=Hg5UuArqUwlzGOA9EKouCGoyxeHzpU0gmKObp6zGFSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCKRJzyDS7rFA0ljfEHW/RBIEGMB2MZ7LIGq0to9Fqks+aNHI+13YRGbd3uDI4yMh
	 VVuQoiQ0JyL5/9tduJABKipcWrWFJ37abKfPhSbISi59AwUw2BbvCozId7qr0fp8Wb
	 s6ZEMFjy++ILk+l/9q6BIZ6aacl9XomCxaXc8iUKDdDWfGMSOfVopqEo5hlApxZDhG
	 mTa27QKMPzJiRgpjKtCuj1GH1mIN45bJvYtqvxvH9trVLd+mdgI+zSe8wGpSayGleC
	 IIpeGI0GtrlyApbEBQUpR6Iy3zoxCIhwT3ShCxuwSxeXA5M+7shY2jkoEABdmXPn1a
	 FgbyVzB34aFvQ==
Message-ID: <sashiko-outbox-212783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: mptcp: take token lookup references with
 acquire ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Nan" <2122295973@qq.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <tencent_28A2BD1631FE531992E91753BA6419FFC506@qq.com>
References: <20261112124547.193812-1-2122295973@qq.com>
 <tencent_28A2BD1631FE531992E91753BA6419FFC506@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 12:46:09 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] net: mptcp: Fixes trailer cites commit predating token.c
  lockless lookups
--

commit 5447c2a648739689de81e739dc020bec5eb37b64
Author: Hang Nan <2122295973@qq.com>

> net: mptcp: take token lookup references with acquire ordering
>
> mptcp_token_get_sock() validates the token and the network namespace,
> takes a reference on the socket and then validates them again.  The
> second validation only rejects a socket that is being torn down if it is
> ordered after the reference acquisition: mptcp_token_destroy() unlinks
> the socket and does WRITE_ONCE(msk->token, 0), so a reader that observes
> the token before the acquisition can return a socket whose token has
> already been cleared.
>
> refcount_inc_not_zero() does not provide acquire ordering since the
> refcount_t consolidation in fb041bb7c0a9, which removed the ordering
> that the previous atomic_add_unless() based implementation gave.  On
> weakly ordered CPUs the loads of msk->token and sock_net(sk) can
> therefore be reordered before the refcount increment, defeating the
> re-validation.
>
> The same pattern was fixed for the IPv4 and IPv6 established lookups,
> inet_twsk_purge() and bpf_sk_assign() in 5b5d8f351dd9.  The iterator
> below has the same shape and is converted as well.
>
> No behaviour change on strongly ordered architectures; this only
> restores the ordering the second validation relies on.
>
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of re=
fcount_t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hang Nan <2122295973@qq.com>

[Severity: Low]
fb041bb7c0a9 ("locking/refcount: Consolidate implementations of
refcount_t") predates net/mptcp/token.c and its lockless RCU token
lookups.  Should the Fixes tags point to the commits that introduced the
lockless refcount_inc_not_zero() lookups in mptcp_token_get_sock() and
mptcp_token_iter_next() instead?

  Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
  Fixes: 96d890daad05 ("mptcp: add msk interations helper")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_28A2BD1631F=
E531992E91753BA6419FFC506@qq.com?part=3D1

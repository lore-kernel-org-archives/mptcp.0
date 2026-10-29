Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312528;
	b=1gNnEFaEcdeV8gWOAuwJb2rdT5kRRQhnP5tcjRJlMb1s3IwR4ZiQghlxUS32VH1eqYlj
	 7HBmP5QNzJtmuE9H55u1GUYfDrc2T0VBVBeZKov0JXhZHrAiVaWIFUuLTjkDE5x1FPVhA
	 F7SVPJNtJDRY5buDcCHYDqJ1v2MPgnaF3QO5m145qscNDM0t4knq8E04gCwmJZ/ivzh8P
	 aOm2MYu6ZJutXqWvW0YNdpc5hkNAm3h8C2S65slB40bkDMsdoLaqR2vHVa/OrstN85+JF
	 /Qo/6ieNB4my2QKesHchOaFP1JT82FPN078Xp7hAjisN8UUA+myA9DJNquOYITtFV+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZBL11904ha2XuVcxUCXDdozPUIRl2y6/Tu1B29481qQ=;
	b=2ZJblJRneFQboUU3S4x77IxCFyxy2f2Z6u07UnAXwO74jsLCCDPslmAn2ZFEedb2JXuc
	 qYe/IOkaeVT5wCY/fSiziDmFoELF0wc/2hMUuKGUxUvLYmdUFWfy+lBVYJXdGplT8b/+t
	 rI8R8A80tmq1dEsXJv+FYmVZ0Ogr8ypXZ2hM3B9ITCGpprNsks9EP7InM1UGFm7+RMYeL
	 pVEWx9lzH1Wh/MM8G0JGUThcG0VYbUyhj6NMVtN9C9KJLW5hSBzR9c9udcKiRBbpaTkAY
	 ykj4EVMoQ8WbKy4ZwTX5exZtZuU+C+Hx5cFiCG5UuuY2l1/8ToijXNGAjolLoI07kYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvGLK0mG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC7606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VvGLK0mG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1A21F01824;
	Thu, 29 Oct 2026 22:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312527;
	bh=ZBL11904ha2XuVcxUCXDdozPUIRl2y6/Tu1B29481qQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VvGLK0mGw34QwCMlxRI/hMxfHkO107ngTnVoaUpUVumUmgiPnvo23aL/fjUVY5NtP
	 /6LOM+mxhphNaWOIV1FF00xh7sYObzG7LyEQOwOvsSgQom0c1giBopyxYS+GsGBQbh
	 TneIX+nWbr+VCeD1rA7SMHiUnoV2OtoxEBEI+5xx7HcdtBChyo1rmUNfVDytR285pp
	 OFhqA6xhpDZqp9uDzLwAbSEN/gNIHeBmfKbakoFBhhg3SKmp6UzPVxGUqDwf/wNT00
	 jL6WjnglsUqMF6JBBToAIBYqfISjcvAnof+fj5hhLRjwyHRbGhSIfQENUk5bfDctCM
	 gFo/r2HarmSkQ==
Message-ID: <sashiko-outbox-190073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v4 6/8] mptcp: pm: userspace: don't dump
 initial ID0
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-6-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
 <20261029-mptcp-pm-userspace-id0-case-v4-6-555066fa4292@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:22:06 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mptcp: pm: userspace: is_init_id0() skips re-added ID 0 without =
port
--

commit 06caddae470be561eadf1499e52b7564e7ab99b8
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: pm: userspace: don't dump initial ID0

This patch skips the initial ID 0 address entry in
mptcp_userspace_pm_dump_addr() by checking is_init_id0(entry) so that it is
not dumped when the connection is first created, while intending to allow it
to be dumped if removed and re-added later.

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 0f6400bc3bf8e..282d7f57c32ab 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -637,7 +637,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  	lock_sock(sk);
>  	spin_lock_bh(&msk->pm.lock);
>  	mptcp_for_each_userspace_pm_addr(msk, entry) {
> -		if (test_bit(entry->addr.id, bitmap->map))
> +		if (is_init_id0(entry) || test_bit(entry->addr.id, bitmap->map))
>  			continue;

[Severity: Medium]
Does is_init_id0(entry) also skip a re-added ID 0 address when userspace do=
es
not specify an explicit local port?

In net/mptcp/pm_userspace.c, is_init_id0() checks:

static bool is_init_id0(struct mptcp_pm_addr_entry *entry)
{
	return entry->addr.id =3D=3D 0 && entry->addr.port =3D=3D 0;
}

When the initial ID 0 entry is removed via mptcp_pm_nl_remove_doit() or
mptcp_pm_nl_subflow_destroy_doit(), and later re-added with a new subflow v=
ia
mptcp_pm_nl_subflow_create_doit() (or announced via
mptcp_pm_nl_announce_doit()) without the optional MPTCP_PM_ADDR_ATTR_PORT
attribute on the local address, mptcp_pm_parse_entry() leaves
entry.addr.port =3D=3D 0:

net/mptcp/pm_userspace.c:mptcp_pm_nl_subflow_create_doit() {
	...
	err =3D mptcp_pm_parse_entry(laddr, info, true, &entry);
	...
	entry.flags |=3D MPTCP_PM_ADDR_FLAG_SUBFLOW;
	...
	err =3D mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
	...
	local.addr =3D entry.addr;
	local.flags =3D entry.flags;
	local.ifindex =3D entry.ifindex;
	...
	err =3D __mptcp_subflow_connect(sk, &local, &addr_r);
}

Because mptcp_userspace_pm_append_new_local_addr() stores the entry before
__mptcp_subflow_connect() runs on a stack copy, the entry in
msk->pm.userspace_pm_local_addr_list retains entry->addr.id =3D=3D 0 and
entry->addr.port =3D=3D 0.

When mptcp_userspace_pm_dump_addr() subsequently iterates over the list,
wouldn't is_init_id0(entry) return true for this re-added ID 0 entry and sk=
ip
it during the dump, contrary to the commit description?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-mptcp-pm-u=
serspace-id0-case-v4-0-555066fa4292@kernel.org?part=3D6

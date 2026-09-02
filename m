Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30C499F08
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353676; cv=none; b=rLJV5gES3dOMTixcFgh4N2jvQ5FF6usPJvvDK2qZHL4ZAOvckmRUAZ52m8Zd8DiQF1dvGskfdmn7/w4y0v0NUXX+uU1PMnC9D4q5Uudr/gqZucFwMUlxEsWuNT9J6mVT7nrlH/qu0PbgLGg/V2cgTkU8OnB6Gbdm10DWG3U9/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353676; c=relaxed/simple;
	bh=it9I/8DpuDYFPKPCOeB47GSBHk4KybmoHRzqAwVN08g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k0hVXJaimJBMjx+pAcVZI3CPreUPVLt/G2MPGNTM5V18GHk3gbro5D1Y40iXMAIgDSFcVXRgpsAkc/LWxTjVTTiDraq/Gc+31HppOQRddDOjJ4VPLe2hp9rQUpi/4yNdq0zWKgUIJT7NtYsGE2nZHlAXAAgUu+8N1zdvKu6TxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAnJ3GLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAnJ3GLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D41F000E9;
	Wed,  2 Sep 2026 12:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788353674;
	bh=9VSpQ02cjiV+47GWn87PY0sa+XrBkyOj6+r4BuEnhhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CAnJ3GLtdywJThi8VwN6e6QwqTOIkXRCQKczY+Lxgi+d7BOKmtL0kjSg2qGVrx+BN
	 ETGRyClJ/OtDuqoSmTHjUV9oStJPICys3ByuhNsf59VV0lU6lXjKH4gPxyzkTD1gBz
	 YxUmUsTRjEVLA8pZ9tsJezJYKWYw8vBaxriABHahiUUfg4WKRx5tSTGjGjq/qTy6IF
	 2DUFXsNcAdKB+RN5i0L6OQQS3FePdn4tF00C8KwvnHaY3Xl3H5rZV4FdA0isWbgJYw
	 ecu45XoxoGYWXPAxNY1h0WRYRwqiyH9eMATAad3XIoAkqoAHZhOabHbFhcIe0ny50d
	 2V08mSoeGsNpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in
 tcp_diag_dump()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>
Cc: mptcp@lists.linux.dev
In-Reply-To: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
References: <cover.1788248601.git.zihanx@nebusec.ai>
 <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:54:34 +0000
Message-Id: <20260902125434.820D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing fallback to resume by `s_num` when the dump cursor is inva=
lidated, causing dump restarts and duplicate socket messages.
--

commit 027317402fdfe4d3580f395cdc040206720287ef
Author: Zihan Xi <zihanx@nebusec.ai>

tcp: diag: bound bucket lock hold in tcp_diag_dump()

This commit limits the time spent under bucket locks in tcp_diag_dump() by
collecting only a batch of referenced sockets while holding the lock. It
introduces a cursor mechanism to resume dumps instead of restarting from
the bucket head.

Link: https://lore.kernel.org/all/cover.1785307984.git.zihanx@nebusec.ai/

> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index ba1fdbe9807fd..842e13ee79e5b 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
[ ... ]
> @@ -344,52 +418,81 @@ static void tcp_diag_dump(struct sk_buff *skb, stru=
ct netlink_callback *cb,
>  				continue;
>  			}
>  			spin_lock(&ilb->lock);
> -			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
> -				struct inet_sock *inet =3D inet_sk(sk);
[ ... ]
> +			node =3D use_cursor ? cursor->sk_nulls_node.next :
> +					    ilb->nulls_head.first;
> +			if (!use_cursor)
> +				s_num =3D 0;
> +			hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {

[Severity: High]
If the cursor is invalidated (use_cursor evaluates to false), the iteration
restarts from the bucket head, but the fallback skip logic:

    if (num < s_num)
        continue;

appears to have been completely removed. By explicitly setting s_num to 0,
does this cause the dump to restart from the beginning of the bucket without
skipping previously processed sockets?=20

If a large bucket has high churn, could this prevent the dump from progress=
ing
past the first few batches and lead to an endless stream of duplicate socke=
ts?

[ ... ]
> @@ -412,34 +517,46 @@ static void tcp_diag_dump(struct sk_buff *skb, stru=
ct netlink_callback *cb,
[ ... ]
> +			if (!use_cursor)
> +				s_num =3D 0;
> +			if (use_cursor) {
[ ... ]
> +			} else {
> +				inet_bind_bucket_for_each(tb2, &ibb->chain) {
> +					if (tcp_diag_bind_collect_owners(&tb2->owners,
> +									 sk_arr,
> +									 num_arr,
> +									 &accum,
> +									 &num, s_num))
> +						goto pause_bind_walk;
>  				}
>  			}

[Severity: High]
Similar to the listen walk, s_num is explicitly zeroed before being passed
into tcp_diag_bind_collect_owners() when use_cursor is false.=20

Does this break the intended fallback skip mechanism and result in duplicate
messages or infinite loops if the cursor becomes invalid?

[ ... ]
> @@ -483,43 +620,35 @@ static void tcp_diag_dump(struct sk_buff *skb, stru=
ct netlink_callback *cb,
[ ... ]
> -		sk_nulls_for_each(sk, node, &head->chain) {
> -			int state;
> -
> -			if (!net_eq(sock_net(sk), net))
> -				continue;
> -			if (num < s_num)
> -				goto next_normal;
[ ... ]
> +		node =3D use_cursor ? cursor->sk_nulls_node.next : head->chain.first;
> +		if (!use_cursor)
> +			s_num =3D 0;
> +		hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {

[Severity: High]
Here in the ehash walk, the original check for skipping elements
(goto next_normal) was removed, and s_num is zeroed if the cursor is missing
or invalid.=20

Could this lead to the same duplicate dump issue if a socket pointed to by =
the
cursor is closed and unhashed between recvmsg() calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788248601.gi=
t.zihanx@nebusec.ai?part=3D1

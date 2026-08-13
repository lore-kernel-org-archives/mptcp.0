Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE2431A22
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604191; cv=none; b=UMPr6CFAoZMWZtKdB7krCwQZ8kyNGABIwD8BcLU/WTZQQevSLEekrp5kN3ak9JeqZUPB5Qz4VuUn6SYCkT+yn9nybmeLpABaGp+FQ9EfmeppONGtPQlhpzwuEqcBRFZNzCjbjBU5QEtkDA1hLy4o57/kwRzGTw9z2KHNowqVAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604191; c=relaxed/simple;
	bh=Xl+i9qvzwbe/UO6snzeFL+sG986zK5FoZvvi/b1prtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EZ6JeK/e25NQwno5raNPyVXEc1p71fSbJIsAmIkOvDSXSfmONLx6WzrmO/BqybRdiJjkgsPVC0i6Rj/428wgDC65/N+yaTe5Uk1RzlAQ0O1d76ABwSmC1jo9K4Y/qWS7PsbE4gehxIXBRfAx12B57owqpRvV/Igo8fVCXi3vJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBBb2J40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBBb2J40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908AC1F000E9;
	Thu, 13 Aug 2026 06:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786604190;
	bh=qoGQUT9KfRjsZi+B7Grns+N6tcLK21nM3Es8qezLKSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBBb2J40+RqzB3f5BrC6nLVxLeLTkDuVZabBk++7lfy3RLuirK8o5Xm/p6Szu3ts5
	 zFNMsdZt/ftTzSXNM9+L1HLKkHRRRfCC+y7WFlcERHvIRxTxVJ/FIj79G1bdNqEkX2
	 alTdAUE/vhY6Scr0aOMl9QBGUtcFM3uge3sne0hirTGmWILiBRNIxxoWWUPaYOZ4lM
	 X92mt6rh1XigbpDKNJOwly/s+BUaqvP8KMxHc9i6h90yoBLnhKw6Bpw2j1J3qj/ogL
	 RL/XfY7O+LjUsjodiYL9Ao7691OFx92F6Z+9vEz829A2KI6lz/ZUsi9D9u3Va65AIK
	 WLDizKxgFgicw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/2] mptcp: hold MP_JOIN msk ref when cloning
 reqsk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>
Cc: mptcp@lists.linux.dev
In-Reply-To: <e3aeafa4dc2afb7ea36143eae163635eee23395c.1786497414.git.yuantan098@gmail.com>
References: <cover.1786497414.git.yuantan098@gmail.com>
 <e3aeafa4dc2afb7ea36143eae163635eee23395c.1786497414.git.yuantan098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:56:30 +0000
Message-Id: <20260813065630.908AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TCP request migration clones MPTCP request sockets without updatin=
g or re-hashing the `token_node` list pointers for MP_CAPABLE requests, lea=
ding to hash list corruption and a reliable kernel warning (`WARN_ON_ONCE`)=
 that can cause a Denial of Service.
--

--- Patch [1]: [PATCH net v4 1/2] mptcp: hold MP_JOIN msk ref when cloning =
reqsk ---
commit 2b2ebcd4a3ea728b0d1c8d74d1e09d5e75f65848
Author: Ruide Cao <caoruide123@gmail.com>

mptcp: hold MP_JOIN msk ref when cloning reqsk
   =20
TCP request migration clones pending request sockets with
inet_reqsk_clone(). For MPTCP MP_JOIN requests this byte-copies
subflow_req->msk, but the clone does not take its own reference.

Closes: https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trail=
ofbits.com/

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e1f20ff8fdb42..8f8e1229766d4 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -47,6 +47,17 @@ static void subflow_req_destructor(struct request_sock=
 *req)
>  	mptcp_token_destroy_request(req);
>  }
> =20
> +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> +			       struct request_sock *new_req)
> +{
> +	struct mptcp_subflow_request_sock *subflow_req;
> +
> +	subflow_req =3D mptcp_subflow_rsk(new_req);
> +
> +	if (subflow_req->msk)
> +		sock_hold((struct sock *)subflow_req->msk);
> +}

[Severity: High]
This is a pre-existing issue, but does this clone helper also need to
handle the migration of token_node for MP_CAPABLE requests?

When inet_reqsk_clone() performs a byte-copy of the request socket, it
copies the token_node list pointers (pprev and next) as-is:

net/ipv4/inet_connection_sock.c:inet_reqsk_clone() {
    ...
	unsafe_memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end,
		      req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end),
		      /* alloc is larger than struct, see above */);
    ...
}

Because the list pointers are copied without re-hashing or updating them,
the original request is destroyed and removes itself from the token hash
table, leaving the clone with a stale pprev pointer.

When the cloned request is eventually destroyed,
mptcp_token_destroy_request() checks hlist_nulls_unhashed(), which returns
false due to the stale pointer. It then fails to find the token in the
bucket, which triggers a WARN_ON_ONCE:

net/mptcp/token.c:mptcp_token_destroy_request() {
    ...
	pos =3D __token_lookup_req(bucket, subflow_req->token);
	if (!WARN_ON_ONCE(pos !=3D subflow_req)) {
		hlist_nulls_del_init_rcu(&pos->token_node);
		bucket->chain_len--;
	}
    ...
}

This could cause a kernel panic on systems with panic_on_warn enabled, and
permanently lose the MP_CAPABLE token from the hash table, breaking
subsequent MP_JOIN requests for that connection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786497414.gi=
t.yuantan098@gmail.com?part=3D1

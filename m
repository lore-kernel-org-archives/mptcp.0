Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8242123D
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486091; cv=none; b=okTV9FkIeu06euBXVWIg8jX3wyVt1mb6Nd8GpJ4EgNx47SY501cJ8Qr8qUnhbDW5w1bl3cgCXona6+Zr4k50N3hHj1A25fTg8cL89g8Hx7MLlaXjccQbTt/WS/HrCTSHBmr3VRqfEb8+GQH2cjnL7JLcU5fM0Jj8E7dpF3vbQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486091; c=relaxed/simple;
	bh=QXg50PrNSDWW52p+hBVTdujVsCZUE0Bgp/72E2lIobo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MISE3b+75EZfoc3FfJk3k60IInWRJBaBo/7z6KP9R3lDXyalllxdMj5HVRwe8QihjizUhrkBJK9GlcjiQ+DBawQQLiIruIhkFMfd/xNeagwE4eJinujEWjhIMysromdYvrt7Y8kNtoZipjBBhq4olqggOxP0TR0vnIuskJVLhaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvm/x4vk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvm/x4vk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC431F000E9;
	Tue, 11 Aug 2026 22:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786486090;
	bh=3TSevLh0huW/2DaS7j5N4kdJI1b+uvxj/Tc42h3gvbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qvm/x4vki71U0nhqTSeQEkou5rggk7yq+bOE5YvawW5SOXQplLy6FL6QLTBgp+c4E
	 OJbg9i8fus8OKdadbtp8n1JoGBS2qB49kddJkPFdiFvwWcsIBUErOM/mFmdL2wmEyd
	 pvbZyzqwNpVIEX1jYPaoNaPIFipvZ0Lon8+eZdqRcQlPmxe0wBQ7oBMMQw0s/XEcQr
	 8zdMjaMyCyqFAicBBwp/ztSxC8u5wXN1NUXZ1U42HlAmOPkrRFsXcop/q1c0Yax3di
	 5O32C+Mhy06tVKYay4rnrt3ga10+Pv2hed0ZqN+rG6NOKzbyZDygotUB3/eXIgSl6c
	 nnrh1T+Iq49Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp] mptcp: fix uninitialized local_id in syncookie
 MP_JOIN reconstruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshit Varu" <harshitvaru666@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260811215135.87756-1-harshitvaru666@gmail.com>
References: <20260811215135.87756-1-harshitvaru666@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 22:08:08 +0000
Message-Id: <20260811220809.CBC431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The `request_bkup` and `thmac` fields in `mptcp_subflow_request_=
sock` remain uninitialized when processing MP_JOIN SYN cookies, leading to =
state corruption and KMSAN violations.
--

--- Patch [1]: [PATCH mptcp] mptcp: fix uninitialized local_id in syncookie=
 MP_JOIN reconstruction ---
commit 0b8fe993e0c1f5676def1ed9e644c11a85aca0ae
Author: Harshit Varu <harshitvaru666@gmail.com>

mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction

This commit fixes an issue in MP_JOIN SYN cookie processing where the
local_id was not restored from the saved cookie entry. By restoring
subflow_req->local_id, it prevents the use of stale memory from previously
freed request sockets.

> diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
> index 7f22526346a7e..b5cac57011221 100644
> --- a/net/mptcp/syncookies.c
> +++ b/net/mptcp/syncookies.c
> @@ -118,6 +118,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_=
subflow_request_sock *subfl
>  	subflow_req->local_nonce =3D e->local_nonce;
>  	subflow_req->backup =3D e->backup;
>  	subflow_req->remote_id =3D e->join_id;
> +	subflow_req->local_id =3D e->local_id;

[Severity: Medium]
This is a pre-existing issue, but do we also need to initialize request_bkup
and thmac here to prevent similar stale memory leaks?

It looks like these fields are not stored in the join_entry struct during
mptcp_join_store_state(), and therefore remain uninitialized in
mptcp_token_join_cookie_init_state().=20

Since the request socket slab is SLAB_TYPESAFE_BY_RCU and not zeroed, does
this cause uninitialized stale data to be copied into the new subflow conte=
xt
when the child socket is cloned?

net/mptcp/subflow.c:subflow_ulp_clone() {
    ...
    new_ctx->backup =3D subflow_req->backup;
    new_ctx->request_bkup =3D subflow_req->request_bkup;
    WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
    new_ctx->token =3D subflow_req->token;
    new_ctx->thmac =3D subflow_req->thmac;
    ...
}

Could this lead to state corruption for the path priority or uninitialized
memory access warnings if those fields are accessed later during packet
scheduling?

>  	subflow_req->token =3D e->token;
>  	subflow_req->msk =3D msk;
>  	spin_unlock_bh(&join_entry_locks[i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811215135.8775=
6-1-harshitvaru666@gmail.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83692282F30
	for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786881149; cv=none; b=f9SYpiOzP4pf4xftgSTnOLUGvafWdTHO2KG8QgGucMQM+OFRvxJGDkoPUvkSOtqemmZBDzQnkMT4+o4H6ffiDFmS1JZypnEtaLpKAn0jV8D3jEybyi9uKlK68hK/dGwC2tllW7NWUHUxIatbfkn4osD9hK3VrcmzQjlWA0nOjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786881149; c=relaxed/simple;
	bh=9nap7RaGzamxMYl54TxABPeSmandh045p32/lNFwFQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mw/NFtq5C3e8P6YBLloKbHsMks+ol59X5/r4UerFHJy4s+XtB992I9vUDroF+Lb4jLmkoPe32tvPEG36qGEfINmax3d3CrAlHQqtDlO06/qgjK/GZcVbBrzTrCEXVhdQTfuKtNCBqgoXWsAFcp2s7xvfAPTxF4Vj/tVECQ4oWsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lne8IyWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lne8IyWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C361F000E9;
	Sun, 16 Aug 2026 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786881148;
	bh=/Xma5gFNT5+wC6fcPhjpPIA+H4w7gIU5X9LWsxVIxDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lne8IyWBXNKK3evlYiY3B604Zzu0CmEtK2AqPd9fiCGT8UglrhQ7W9ACDObV/E5EF
	 ZTChWxKJ5y8RyDTNurTvqYo8Q9SAZ99puRzj+g4VeLVYXrGCCjV+pCF2/I+MHZ4ege
	 5VepjHOcuVAQjsFOyRqZsvVVmxz/d96Ly6hIA1Vn19fS9+wJRFfhn/fz19w76Eu+5I
	 ZYTZD7Oqe0cbLQrfzyuU99CLiG8A2zjWrMBQJm3RB/OKg9ZhUKcwfSm9iqVoCRccjp
	 3v+KvCwXLv2iRsClrkxxERS17ZC9KX8y5lUS14r0ShAcQIC5VYgQL/aDIr5r8sltf3
	 hKWctLPVvnrwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] mptcp: fix uninitialized local_id in syncookie
 MP_JOIN reconstruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshit Varu" <harshitvaru666@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260815115205.197151-1-harshitvaru666@gmail.com>
References: <20260815115205.197151-1-harshitvaru666@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:52:27 +0000
Message-Id: <20260816115228.04C361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `request_bkup` bitfield in `mptcp_subflow_request_sock` is lef=
t uninitialized during syncookie MP_JOIN reconstruction, causing stale data=
 to dictate the subflow backup state.
--

--- Patch [1]: [PATCH net] mptcp: fix uninitialized local_id in syncookie M=
P_JOIN reconstruction ---
commit ac471f0880c8ac59556dc5bd33e8a83b1849726c
Author: Harshit Varu <harshitvaru666@gmail.com>

mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction

This commit restores the local_id field from the saved cookie entry when
rebuilding the request socket for an MP_JOIN 4th-ACK handled under SYN
cookies. This prevents the subflow from using stale slab memory as its
address-ID, protecting the path manager's bookkeeping.

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

[Severity: High]
This is a pre-existing issue, but does this code also leave the request_bkup
bitfield uninitialized during syncookie reconstruction?

While this commit fixes local_id, the request_bkup bitfield in
mptcp_subflow_request_sock doesn't appear to be saved in
mptcp_join_store_state() or restored here.

Since the request_sock slab is SLAB_TYPESAFE_BY_RCU and memory isn't zeroed
on allocation, subflow_init_req() zeroes some adjacent bitfields but misses
request_bkup:

net/mptcp/subflow.c:subflow_init_req() {
    ...
    subflow_req->mp_capable =3D 0;
    subflow_req->mp_join =3D 0;
    subflow_req->csum_reqd =3D mptcp_is_checksum_enabled(sock_net(sk_listen=
er));
    ...
}

When the final subflow context is cloned, it copies this uninitialized state
directly from the request socket:

net/mptcp/subflow.c:subflow_ulp_clone() {
    ...
    new_ctx->backup =3D subflow_req->backup;
    new_ctx->request_bkup =3D subflow_req->request_bkup;
    ...
}

Could this stale memory cause the MPTCP stack to erroneously treat primary
paths as backup paths (or vice versa)?

>  	subflow_req->token =3D e->token;
>  	subflow_req->msk =3D msk;
>  	spin_unlock_bh(&join_entry_locks[i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815115205.1971=
51-1-harshitvaru666@gmail.com?part=3D1

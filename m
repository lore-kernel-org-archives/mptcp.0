Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705283;
	b=GaNtv/CJ452Rif824g3iwPYe9lRJ8onClGMDuUT1MUjk+XViuCyVfjl5jUbk5Tih6nYK
	 PNEXD7j4lskFlIvZIbb9c06Gta1upZy6UmMPtfizgYS6IWsfdU/LpHSFdsfpTEOwzYnZa
	 beMxHgNrw2Su3+j1P2l2ftqF46wrP/AK52jpG5Jkx8++xw3G5QzrCTn8ahyI4d1lwBsf3
	 ksI2kAwsSLr8+/C22B7xoce3BHaayN5l+TtJ5eamqVCBEliSSuov/DYnZWy30huUdUSiX
	 K7pOepZp8Cgt2jEk0yCIxA1D4qdpaOdSCnzac2NvXLG1NrKhCi0qVClxgIz9NAZD8rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705283;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=C/w2FyBdqBk/dnq0rfKVT2UXuhJSj3cnrs8P5rgRnBk=;
	b=2D5Nxzl+UxRLDTgqcMfQ2+xTd+/Zz/DTDwum9/09GUeLNfpfZaFi5P9MziADgcmJfgxk
	 wHLiaEIOBiSxg6K6O7r/2+iMhy5d8e3EoU0/yD+JjHlKMpRH+SwoUTFKx39o5HaY+DLZt
	 sKl3MOhDpE+1NJT5+dU3Fh0Hv0MgqD5cBOP2f8v3aDTpmWEuI+CKPO+on/mJRWHiP0zWa
	 WI62QQGQoRn+aKW7PlIxHZVRTnWJqX9/8Kk6A8Brd0RFzmgOJyrDH8wu6R5xV0LEiWglS
	 tlj53n8Z18CstsDQFj8TAfkobYGD00hUgJgfDsKoyT5pfaJtDGqSVfzqgxP1Q6qP0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h7U4vNew;
	arc=none smtp.remote-ip=91.218.175.147
Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F081606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 15:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F081606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h7U4vNew
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=7vskAqRNnBmACM3MiTOmQ1c8xLgZhtoid38o3TJo+mY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795705280; v=1; x=1796310080;
 b=h7U4vNewq2EA/ud1s984TEfpOe7VHgDW/22z/8VSeFlv/2B5YP47KHGdYOMlndN6eINUeYSV
 lUm7rDfgAUrMFWnSdFs8dW2qh/j1Q0QFb8mCpHB9oCxxyawh2cewKvZqxh2eOjfz9VkNeXtZ3bD
 sAUez1oR0veS7xhKWv0yI99c=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 81eba1fba23596cf;
	Thu, 26 Nov 2026 15:01:20 +0000
X-Mizu-Trace-ID: 81eba1fba23596cf
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 26 Nov 2026 15:01:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <0f1d9633b78cdacd57f4c235a5a787426083d788@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v9 1/2] mptcp: pm: in-kernel: fullmesh: skip
 closed subflows
To: "Abdul Wasey" <w453y.me@gmail.com>, mptcp@lists.linux.dev
Cc: "Matthieu Baerts" <matttbe@kernel.org>, "Mat Martineau"
 <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
 stable@vger.kernel.org
In-Reply-To: <20261126101818.3916631-2-w453y.me@gmail.com>
References: <20261126101818.3916631-1-w453y.me@gmail.com>
 <20261126101818.3916631-2-w453y.me@gmail.com>

Hi Abdul,

>=20
>=20diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d465524902f0..af3b092e45ba 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -199,6 +199,16 @@ fill_remote_addr(struct mptcp_sock *msk, struct mp=
tcp_addr_info *local,
>  return 1;
>  }
>=20=20
>=20+/* Closed subflows can stay in the conn_list, e.g. the initial one: =
their
> + * addresses and IDs are not reliable, possibly even reset.
> + */

What about dropping this comment here?=20

mptcp_subflow_is_closed()=20is a generic predicate =E2=80=94 "is this sub=
flow
closed?" =E2=80=94 while "closed subflows can stay in the conn_list with
unreliable IDs" is a concern of the two loops calling it. And the commit =
message
already spells out the rationale.=20

>=20+static bool mptcp_subflow_is_closed(struct mptcp_subflow_context *su=
bflow)
> +{
> + struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> + return subflow->closing || inet_sk_state_load(ssk) =3D=3D TCP_CLOSE;
> +}
> +
>  static unsigned int
>  fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
>  struct mptcp_addr_info *local,
> @@ -216,11 +226,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock =
*msk,
>  * already created by incoming ADD_ADDR
>  */
>  bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
> - mptcp_for_each_subflow(msk, subflow)
> + mptcp_for_each_subflow(msk, subflow) {
> + if (mptcp_subflow_is_closed(subflow))
> + continue;
> +
>  if (READ_ONCE(subflow->local_id) =3D=3D local->id)
>  __set_bit(subflow->remote_id, unavail_id);
> + }
>=20=20
>=20 mptcp_for_each_subflow(msk, subflow) {
> + if (mptcp_subflow_is_closed(subflow))
> + continue;
> +
>  ssk =3D mptcp_subflow_tcp_sock(subflow);
>  mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
>  addrs[i].id =3D READ_ONCE(subflow->remote_id);
> @@ -243,6 +260,20 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *=
msk,
>  break;
>  }
>=20=20
>=20+ /* The initial subflow can be closed: like fill_remote_addr(), use =
the
> + * remote address of the MPTCP socket for the remote ID 0.
> + */

Another question, why don't you just use 'full_remote_addr' here, like:
'''
  if (!test_bit(0, unavail_id) && i < addrs_size &&
            msk->pm.extra_subflows < limit_extra_subflows)
        i +=3D fill_remote_addr(msk, local, &addrs[i]);
'''

It hasn't been tested, just wondering if there is a specific reason to ke=
ep
the duplication here, as I would rather reuse the existing code.


Thanks
Gang



> + if (!deny_id0 && !test_bit(0, unavail_id) && i < addrs_size &&
> + msk->pm.extra_subflows < limit_extra_subflows) {
> + struct mptcp_addr_info remote =3D { 0 };
> +
> + mptcp_remote_address((struct sock_common *)sk, &remote);
> + if (mptcp_pm_addr_families_match(sk, local, &remote)) {
> + addrs[i++] =3D remote;
> + msk->pm.extra_subflows++;
> + }
> + }
> +
>  return i;
>  }
>=20=20
>=20--=20
>=202.43.0
>

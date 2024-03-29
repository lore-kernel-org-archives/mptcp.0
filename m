Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3522C853
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687829; cv=none; b=ZryuSjdlDdPavJy3qBQDo1G6EZ5+o1kRqDocCUloRlSTLS+/X5HSbIm+qgbIFGctXAraLZJcKeOE3RdbYfdB48h3p0xpe1WJ7xeHtkpo2YgROj1wnp0QawaDzkWAiTfgJJghAdqIGOpi4dTDwbkzbOaAh4yfl0+1s1fnRuWQtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687829; c=relaxed/simple;
	bh=lANsQAROjLV2ddC7nq9O1fppNQWjLdk9XdI7hitECP8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BcTtLs0pGElEKKyz4K0h2g9ljY6le4NKPUHremQl33kXTNBVlY4r1qw49mdVnowyg5FUq2xUiHLid88QIBwz9iYhitGUj86NYviJPZwyVvM+PsK9xt7c+BvLm5LTCFx3ysqARsl5LrZHVyj9CsPsi0E1fhYuSCRAFVLHB4eTamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo6kKRi7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo6kKRi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38209C433C7;
	Fri, 29 Mar 2024 04:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711687829;
	bh=lANsQAROjLV2ddC7nq9O1fppNQWjLdk9XdI7hitECP8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Yo6kKRi7C8a/SlPTFOY/xXaIlpVtwOpopNZ8Ba39O2Swy3T52+ud/KYU2uO6BfS/2
	 z6r+MwOtAiv18Dq9JD8LBY/1XKDZwWq4TPe+jw3CPjMt3Ne+aeh8uLJe/hvXMkieDA
	 ukX3pBB0qqDvWcBevO4/0nZ7iNpnRuukfPeMS3qYInd8UgnhpwEfkos9UbcBqSviwM
	 +LURk6vIIvb93EpSvkYTzZ3GZg2Uz/TTRbCxxue4h5njilKA8YgFrzpVrgmjfdEoXZ
	 RAgB3k2cJ43yOgrAC3FMuEeLxoSb3vbMy7A/am38Ai89GwsPDqPMmynnlra1/uObc7
	 6u1KSiDXk8+lQ==
Message-ID: <312270b886e5d3fd2c50fa0493077fd1db8dbc06.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 6/7] mptcp: add check_id for
 lookup_anno_list_by_saddr
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 29 Mar 2024 12:50:24 +0800
In-Reply-To: <5b35a798-744d-4b07-98f9-a16e0be378d2@kernel.org>
References: <cover.1708588977.git.tanggeliang@kylinos.cn>
	 <608dcc5649b212dc1a37c72fa7b465d3e8619316.1708588977.git.tanggeliang@kylinos.cn>
	 <426ebb6d-18af-4a8f-a291-82faddb66b30@kernel.org>
	 <5b35a798-744d-4b07-98f9-a16e0be378d2@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matt,

On Thu, 2024-03-28 at 19:27 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 26/02/2024 11:07, Matthieu Baerts wrote:
> > Hi Geliang,
> >=20
> > On 22/02/2024 09:03, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > >=20
> > > This patch adds a new helper mptcp_addresses_equal_check_id() to
> > > test the
> > > address ids, as well as the address. This can be used to test if
> > > the two
> > > given addresses are identically equal, they have both the same
> > > address and
> > > the same address id.
> > >=20
> > > Add a new parameter check_id for
> > > mptcp_lookup_anno_list_by_saddr(), pass
> > > it to mptcp_addresses_equal_check_id(). Then in
> > > mptcp_pm_del_add_timer(),
> > > the input parameter check_id can be passed as the new parameter
> > > into
> > > mptcp_lookup_anno_list_by_saddr(). After this, this condition:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!check_id || entry->addr.=
id =3D=3D addr->id)
> > >=20
> > > can be dropped, only test if 'entry' is NULL is enough.
> >=20
> > Or use an extra variable? Please see below.
> >=20
> > (...)
> >=20
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index 5c17d39146ea..7d755c0a32bb 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> >=20
> > (...)
> >=20
> > > @@ -324,12 +325,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock
> > > *msk,
> > > =C2=A0	struct sock *sk =3D (struct sock *)msk;
> > > =C2=A0
> > > =C2=A0	spin_lock_bh(&msk->pm.lock);
> > > -	entry =3D mptcp_lookup_anno_list_by_saddr(msk, addr);
> > > -	if (entry && (!check_id || entry->addr.id =3D=3D addr->id))
> > > +	entry =3D mptcp_lookup_anno_list_by_saddr(msk, addr,
> > > check_id);
> > > +	if (entry)
> > > =C2=A0		entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
> > > =C2=A0	spin_unlock_bh(&msk->pm.lock);
> > > =C2=A0
> > > -	if (entry && (!check_id || entry->addr.id =3D=3D addr->id))
> > > +	if (entry)
> >=20
> > I probably missed something, but why not only do the modification
> > here
> > as suggested in the v1 instead of changing the signature of
> > mptcp_lookup_anno_list_by_saddr() and introducing
> > mptcp_addresses_equal_check_id() which is indirectly only used once
> > from
> > here?
> >=20
> >=20
> > =C2=A0 bool stop_retrans;
> >=20
> > =C2=A0 (...)
> >=20
> > =C2=A0 spin_lock_bh(&msk->pm.lock);
> > =C2=A0 entry =3D mptcp_lookup_anno_list_by_saddr(msk, addr);
> > =C2=A0 stop_retrans =3D entry && (!check_id || entry->addr.id =3D=3D ad=
dr-
> > >id);
> > =C2=A0 if (stop_retrans)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->retrans_times =3D ADD_ADDR_RETRAN=
S_MAX;
> > =C2=A0 spin_unlock_bh(&msk->pm.lock);
> >=20
> > =C2=A0 if (stop_retrans)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk_stop_timer_sync(sk, &entry->add_timer=
);
> >=20
> > The refactoring would make sense if you have multiple users of this
> > long
> > conditions. Here, it looks like it is adding more complexity to get
> > functions more generic, with more checks, just to handle one
> > particular
> > case that can be extracted here, no?
>=20
> Regarding this patch that is still tracked on Patchwork, just to know
> what to do with it: do you plan to send a new version with the
> suggested
> modification here above or should we just drop the patch from
> Patchwork?

Please drop this patch from Patchwork.

Thanks,
-Geliang

>=20
> Cheers,
> Matt


Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026D745C1
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188235; cv=none; b=P4M+ywGJbS5NMO2HE1IJ+z3d6WN59eYZPlfPZt+VZw8kO/LQvM7fHdqTkr/4i+/UypNjy1iIs/+SEvE/0R+QbNDtGCFCV7sq+AMArJJ/NUkw5QVUQGTrlW8NazbBurETDZqDlnoSQ2n4wDP20Mk7Z8UBSxvycLLBbkEEEwzh2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188235; c=relaxed/simple;
	bh=ry/EZWihsdAJWYlVR01yYusWcIBpxiG0ph3sJ3f+D5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LoqOH/5rkCheHGtW9VZPdz2XMLej7JE8fK3HmfszkzI3PR/9X4eUvSLM+xlFOh/ySlAdJGRcGxtsr2r6WchymdNCFGdNegnKGlvUDG9UZV95ksxNowbsIsZEXEjZR3EpSgz9GRhpGuNS1QKIcDYh0xff34I/WUMuoi6vzMMfMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ts9MQ2IY; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ts9MQ2IY"
Message-ID: <8bbb6d165777dd32ec9cb3c9b679a7bf543b17f8.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707188231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SE5zL5Jvq0smLIEVzyRpiPjSLcWMb35M/RJ3/YTDZpk=;
	b=Ts9MQ2IYzTSCeWbnaVy0kokTlbAY3pdp0+Mtb5zvXpOfoBCQWtnFNbpz/fEpaKJBW81wZC
	ylQG+v9ytwkF1eMDhzQ1xqLPugPX8pHkGclxHAfGcivTgcCv07et2ig8gsEnKcG5XYAzk3
	q6+RNwSYuBLVO2n4WtAbdlDZwpeW6PM=
Subject: Re: [PATCH mptcp-next v10 10/23] mptcp: check userspace pm subflow
 flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Geliang Tang <geliang.tang@linux.dev>
To: Mat Martineau <martineau@kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, Geliang
 Tang <geliang@kernel.org>
Date: Tue, 06 Feb 2024 10:57:01 +0800
In-Reply-To: <38c3cf2e-ba53-b30f-cf2c-e39d793851f2@kernel.org>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
	 <8df3db253cf4e880813e2b499b12887904474736.1705558030.git.tanggeliang@kylinos.cn>
	 <38c3cf2e-ba53-b30f-cf2c-e39d793851f2@kernel.org>
Autocrypt: addr=geliang.tang@linux.dev; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

Hi Mat & Matt,

On Tue, 2024-01-30 at 18:28 -0800, Mat Martineau wrote:
> On Thu, 18 Jan 2024, Geliang Tang wrote:
>=20
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
> > announce mptcp_pm_nl_announce_doit(), MPTCP_PM_ADDR_FLAG_SUBFLOW
> > flag
> > should be checked in mptcp_pm_nl_subflow_create_doit() too.
> >=20
> > If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags
> > field
> > in the output of dump_addr. This looks a bit strange:
> >=20
> > 	id 10 flags=C2=A0 10.0.3.2
> >=20
> > This patch uses mptcp_pm_parse_entry() instead of
> > mptcp_pm_parse_addr()
> > to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag
> > check
> > in mptcp_pm_nl_subflow_create_doit().
> >=20
>=20
> Hi Geliang -
>=20
> Have you tested this change with mptcpd?

What do you think to test 'mptcpd' in our CI too? If you agree, I'll
try to do this, and add a new ticket about it in Github.

>=20
> Is the addr flag (SUBFLOW or SIGNAL) relevant for userspace PM
> addresses?=20
> It doesn't seem like a useful distinction: the userspace PM is always
> creating a new subflow in this context, since address signaling is
> handled=20
> by mptcp_pm_nl_announce_doit().
>=20
> Two options I see:
> =C2=A0 * update the userspace tools to cleanly handle missing flags for=
=20
> userspace connections
> or
> =C2=A0 * have mptcp_pm_nl_subflow_create_doit() always set=20
> MPTCP_PM_ADDR_FLAG_SUBFLOW for the local addr even if it's missing
> from=20
> the netlink attribute (and maybe don't allow
> MPTCP_PM_ADDR_FLAG_SIGNAL?)

Thanks for your suggestions. Option 2 has been updated in v11.

-Geliang

>=20
> - Mat
>=20
>=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/mptcp/pm_userspace.c | 10 ++++++++--
> > 1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index f1582f40f70e..ca0d6e1dfade 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -361,11 +361,18 @@ int mptcp_pm_nl_subflow_create_doit(struct
> > sk_buff *skb, struct genl_info *info)
> > 		goto create_err;
> > 	}
> >=20
> > -	err =3D mptcp_pm_parse_addr(laddr, info, &addr_l);
> > +	err =3D mptcp_pm_parse_entry(laddr, info, true, &local);
> > 	if (err < 0) {
> > 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error
> > parsing local addr");
> > 		goto create_err;
> > 	}
> > +	addr_l =3D local.addr;
> > +
> > +	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
> > +		GENL_SET_ERR_MSG(info, "invalid addr flags");
> > +		err =3D -EINVAL;
> > +		goto create_err;
> > +	}
> >=20
> > 	err =3D mptcp_pm_parse_addr(raddr, info, &addr_r);
> > 	if (err < 0) {
> > @@ -379,7 +386,6 @@ int mptcp_pm_nl_subflow_create_doit(struct
> > sk_buff *skb, struct genl_info *info)
> > 		goto create_err;
> > 	}
> >=20
> > -	local.addr =3D addr_l;
> > 	err =3D mptcp_userspace_pm_append_new_local_addr(msk,
> > &local,
> > 						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > !mptcp_pm_has_addr_attr_id(laddr, info));
> > 	if (err < 0) {
> > --=20
> > 2.40.1
> >=20
> >=20
> >=20


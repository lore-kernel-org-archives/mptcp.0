Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB22D2497
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436388; cv=none; b=ESMO2dBFpDl2p8hZ+6rEnwWiG4dN/g12DGxi9OnKw2Q+emXmGGJs/jjwp2iPEe1//OHT53INr/8EsmRHbgM7N8FSVXmwnvBzSvzTeWZGHQJIb7+/7tdBYPlCdJh/Fm/Jt02IVpRe8WTDXnYHANN4JkD8G1DbQV8Wtq/eHM1gDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436388; c=relaxed/simple;
	bh=mMtorA6NYTA/9vLW3mOY8KEXj4F6Ki10mLJXRy8o2gs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtYwh7WSvLVVQIIxAp2Usu0zcmp+As6IM/oHI2FINEmOAORdJ2RpwXidaYeR3bOJh8B6aZyV38cW/51RYp7Ip50kUPZ0etSV72UuorBtYSuo8litKnGuThH/tIm3Ya0OMOvPm7Ux0j3DQlrak17/sAh64eAhh4O2loQf8jj0f10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgSAb3wN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgSAb3wN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AFDC4CEE7;
	Tue, 14 Oct 2025 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760436386;
	bh=mMtorA6NYTA/9vLW3mOY8KEXj4F6Ki10mLJXRy8o2gs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=PgSAb3wNPXotozUFrNts6xyPk5Rhk9fkqwGhVQi5/3oxEUyPqxucqrN9zWDe1TbC7
	 FaE5tvsor1V7vag1jqT5MgsmMDQdlWYA8h2B1/92RMbPQl4tmihPD34Yaqh7PaTMgb
	 RAG8F3PoJHzv6vFEJCwgGelDpI/JIH9VVfBEARKBj9dlKbl3Z1MKSM4EXqAMAHEQhy
	 phcpbz6ufd4xE5jRFPUMGMDHZNhAnV6C7LqOZqZnc2IXsiJHjffMkzuMKz7qdMnGV4
	 q8ISUDeyIRre9xQGKYesB4t8bcmb/TwGb14HSVtcIkP1Or8H0oCK4DSY0C9icgMIfA
	 h9iNG5TxvMZng==
Message-ID: <2ab2aea824a6d5f85f6c780b2414abdbf54d077f.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 6/7] mptcp: pm: in-kernel: record fullmesh
 endp nb
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>
Date: Tue, 14 Oct 2025 18:06:22 +0800
In-Reply-To: <7fd7973d-e45f-4177-90cd-b65ac4547c04@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
	 <20251008-c-flag-add-addr-delay-v1-6-c624eb3bf10d@kernel.org>
	 <e7340af8302a2dc98c41580423c0663954db8523.camel@kernel.org>
	 <7fd7973d-e45f-4177-90cd-b65ac4547c04@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-10-14 at 12:02 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 14/10/2025 09:20, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this patch.
> > 
> > On Wed, 2025-10-08 at 16:00 +0200, Matthieu Baerts (NGI0) wrote:
> > > Instead of iterating over all endpoints, under RCU read lock,
> > > just to
> > > check if one of them as the fullmesh flag, we can keep a counter
> > > of
> > > fullmesh endpoint, similar to what is done with the other flags.
> > > 
> > > This counter is now checked, before iterating over all endpoints.
> > > 
> > > Similar to the other counters, this new one is also exposed. A
> > > userspace
> > > app can then know when it is being used in a fullmesh mode, with
> > > potentially (too) many subflows.
> 
> (...)
> 
> > > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> > > index df2bc36593d0..054d85045381 100644
> > > --- a/net/mptcp/pm_kernel.c
> > > +++ b/net/mptcp/pm_kernel.c
> 
> (...)
> 
> > > @@ -603,9 +612,12 @@ fill_local_addresses_vec(struct mptcp_sock
> > > *msk,
> > > struct mptcp_addr_info *remote,
> > >  	int i;
> > >  
> > >  	/* If there is at least one MPTCP endpoint with a
> > > fullmesh
> > > flag */
> > > -	i = fill_local_addresses_vec_fullmesh(msk, remote,
> > > locals,
> > > c_flag_case);
> > > -	if (i)
> > > -		return i;
> > > +	if (mptcp_pm_get_endp_fullmesh_max(msk)) {
> > > +		i = fill_local_addresses_vec_fullmesh(msk,
> > > remote,
> > > locals,
> > > +						     
> > > c_flag_case);
> > > +		if (i)
> > > +			return i;
> > > +	}
> > 
> > I'm not sure if endp_fullmesh_max needs to be checked in
> > fill_remote_addresses_vec() too, something like:
> > 
> >    if (mptcp_pm_get_endp_fullmesh_max(msk))
> >            return fill_remote_addresses_fullmesh(msk, local,
> > addrs);
> 
> No, it doesn't need to be used with fill_remote_addresses_fullmesh(),
> because this helper is only called if the local endpoint has the
> fullmesh flag, see fill_remote_addresses_vec().
> 
> 
> In other words, when calling fill_remote_(...), we have the local
> endpoint (where the fullmesh flag might be set), and we need the
> remote
> addresses. When calling fill_local_(...), it is the opposite: we have
> a
> remote address, and we need to find local endpoint(s). It is only in
> this case we need to know in advance if there are any "fullmesh"
> local
> endpoints.

Thank you for your explanation. If that's the case, please add my
review-by tag:

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt


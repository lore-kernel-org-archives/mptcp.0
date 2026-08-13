Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48B219E8
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613849; cv=none; b=pyuCM4+B3bt76wRhj2gXaWThxnkdmUUUZev8xgQb49YHwgCjOpcB9hq/DtDSlPhep6FE9dpKzop8kEeXLOspB1TLAVe+TsVUEFC5A3UQ6JZjkxGDShjXWK9nCNO9nlqJ16smz6FMMBq/PI5UwcSMoFhDtaISR03hdxtPvrYfxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613849; c=relaxed/simple;
	bh=dLpGEjFAsaf9z0VTFVfEgmZsuYoUrJVtVUUkgQscmvU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=iF2MmWf9GGRLQv9UinGzWvo3vVo1M3poN9tkc4rpHlY0XONHTTXUTr7smwc9pKCdUJ6RylsmEorzwvdOkNt1UNAupcNF5r6SHnEdc/SWo5VwwZM0B2yP6DZ5pQN1TpnqUrPvgAAh3vTcTtCiS3N+ZM8WedSgOJDAH14i9h8i9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rcr5VcWx; arc=none smtp.client-ip=91.218.175.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rcr5VcWx"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dLpGEjFAsaf9z0VTFVfEgmZsuYoUrJVtVUUkgQscmvU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786613844; v=1; x=1787218644;
 b=Rcr5VcWx/eXo28FCnZ6A8LdVSh3LHSQVw/eWU742CudqFGX2cDvPvaR7oUaPOQ+qaKXS//5V
 0wUnVy5pQxNPwh9kCOi6+yfk4sXDIuqHOe9NGB07q8jxKzXcD4/eAobfeCGSHHO2vleboRoygyv
 8YWkucp54O5IKRlxmTjzR+Mg=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id cd44cfb02970f928;
	Thu, 13 Aug 2026 09:37:24 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 09:37:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <754c2939260e07b2c73c14e951dd2afc4da62a58@linux.dev>
TLS-Required: No
Subject: Re: CI failures on nipa
To: "Matthieu Baerts" <matttbe@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: "MPTCP Linux" <mptcp@lists.linux.dev>
In-Reply-To: <be3d9d4d-2a4c-4ed6-a341-f184d85cc664@kernel.org>
References: <02830f64-bb5f-41fc-8211-5f7aa36b828e@redhat.com>
 <9db96388a1c72d264d0576e0a58f4944560e93a7@linux.dev>
 <be3d9d4d-2a4c-4ed6-a341-f184d85cc664@kernel.org>

August 13, 2026 at 5:20 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:=
matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org=
%3E > wrote:


>=20
>=20Hi Gang,
>=20
>=20On 13/08/2026 10:59, gang.yan@linux.dev wrote:
>=20
>=20>=20
>=20> August 13, 2026 at 3:57 PM, "Paolo Abeni" <pabeni@redhat.com mailto=
:pabeni@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E >=
 wrote:
> >=20
>=20(...)
>=20
>=20>=20
>=20> >=20
>=20> > Judging on the final status, I *think*/*guess* the (re)connect is
> > >  hanged, possibly due to bad remote address?!? It could be useful t=
o
> > >  print out on stderr the reconnect destination address.
> > >=20
>=20>=20=20
>=20>  Hi Paolo,
> >=20=20
>=20>  That reminds me of an issue when I was reading mptcp_connect.c a l=
ong
> >  time ago:
> >=20=20
>=20>  At the end of 'sock_connect_mptcp()', it calls 'freeaddrinfo(addr)=
',
> >  the 'peer' pointer (which points into 'addr') remains. Later, the ma=
in loop
> >  uses this peer pointer for reconnection attempts. If the memory has =
been freed
> >  and reused, the address data could be overwritten, resulting in an i=
nvalid
> >  remote address.
> >=20=20
>=20>  That might cause the hangs or failures you are seeing, right?
> >=20
>=20Good catch!
>=20
>=20Are you working on a fix for that? I guess we should copy the content=
,
> not just the pointer. Or maybe we don't need to do this copy:
> getaddrinfo() should return the same thing, no?

Hi Matt

I can working on this right now =E2=80=93 and with the help of AI, I beli=
eve we can resolve
it quickly. :)

Thanks
Gang

>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>

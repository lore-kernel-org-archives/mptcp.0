Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098188;
	b=nmZlUjTISsCJTnR/jNWQzFMkdExeUfCwCAuHQ88LvWdrVDpwGgt8ZaH5CFE9d+XnqxhE
	 BLaWd32RHUZyFD5psEmH5Cx98eAfyEfsUUZU1Tks/zMM+GuJFPveKyFEtY+w0qJgOIobo
	 +ABSYci0LsKwuWqC1mIeuFflNxUuU1x7K0i9ksdNHrJHKoU1OFLVCpA7ctpcn1KjtwiTR
	 lIUGZR1gHiLhlJV6S1dCJZ+tOY58mE1CzTycRrBp9WHyXaE3yhUQttKhjkZqV/ZRBvJM8
	 VcF7eV87KQFGaEYlnxnhI+5xTgiXDeTjvr+fh+mPe9wUuqdndit41o+lgwh9WbqfDFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098188;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=RiCfex1kGfNbkK27vp5Nyt9MEY7BVfJJv2wzxSNzg1I=;
	b=MHDTj6bKMI1GEoYc3p/MKqqcySK1ckVdw/IxG8DAOviLF9ANDzR4/M/zkxsKnqwxXKIn
	 GXzS6h7L6fAQqV77ssC5HCio6NiR0ITUYmLR8+TIIHJ7DZGov1j6LX2Oo5csUNkgM0CBd
	 lkvIp4eiZL9HFowUPRLo5DWSbYvfdUz2avFH4j2eCYcP0SDSMaiAvgdAHFWq1yIVUhjlW
	 /JI+njRRzBAs4eXAF7EmnfvOhnBTnZIJCFSOl2BaTN7A0ULNpdHyJVo7MKoPJ1t0ufeik
	 fpo5HUqsy6Oh9QcEPgUgHfL4OvQpKZ49kbdjstduELCGuVlHkS/rfFYa8WGRdft9XdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gG47Znnm;
	arc=none smtp.remote-ip=95.215.58.40
Received: from mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31541606A328
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 10:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31541606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gG47Znnm
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=aUJZK25pSuxND1idZI/uP9uBJuxAjjsvQSrvwuweh+E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793098186; v=1; x=1793702986;
 b=gG47ZnnmUCwuuGe0sJRH5vRQmyV4NtocvvKFubaZNkD5dYTzfOmYlPJbGx9jd71dEO1i/nx+
 N9TPa8v3uTRCUEZqsLF2AxftWMW+vEq74sI81vM0u05m8oSktihQm+Xd7xlpVA+pHvplAJkXbkM
 Tao7a4e8pQRHMPQZxGFzR86Q=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 3bc0126add26557b;
	Tue, 27 Oct 2026 10:49:46 +0000
X-Mizu-Trace-ID: 3bc0126add26557b
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
Date: Tue, 27 Oct 2026 10:49:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <9731943752d315d69916dc84e774e1e6a806652d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
To: "Cen Zhang" <zzzccc427@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 mptcp@lists.linux.dev
In-Reply-To: <f88992ae9b2dc51fd3a0ba2f9c23a29a91660877@linux.dev>
References: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
 <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
 <CAFRLqsU2QHD2Ta2aL_qSVr9nVFrn6mXV_nZ987+oqHUbCa7ZSw@mail.gmail.com>
 <f88992ae9b2dc51fd3a0ba2f9c23a29a91660877@linux.dev>

October 27, 2026 at 6:41 PM, gang.yan@linux.dev mailto:gang.yan@linux.dev=
  wrote:


>=20
>=20October 26, 2026 at 10:44 PM, "Cen Zhang" <zzzccc427@gmail.com mailto=
:zzzccc427@gmail.com?to=3D%22Cen%20Zhang%22%20%3Czzzccc427%40gmail.com%3E=
 > wrote:
>=20
>=20>=20
>=20> Hi Eric,
> >=20=20
>=20>  Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=
=8826=E6=97=A5=E5=91=A8=E4=B8=80 20:38=E5=86=99=E9=81=93=EF=BC=9A
> >=20=20
>=20>=20=20
>=20>  Adding these stack traces without symbols is not really nice.
> >=20=20
>=20>  Time to use scripts/decode_stacktrace.sh
> >=20=20
>=20>  Sorry about that, v2 carries the report decoded with
> >  scripts/decode_stacktrace.sh and trimmed to the relevant frames.
> >=20=20
>=20>=20=20
>=20>  msk->first is a TCP socket: TCP listeners have SOCK_RCU_FREE, and
> >  tcp_prot / tcpv6_prot use SLAB_TYPESAFE_BY_RCU. Reading two integers
> >  under rcu_read_lock() is safe, and stale values are fine for diag.
> >=20=20
>=20>  Thanks for the suggestions.
> >=20
>=20Hi Cen,
>=20
>=20Basically this looks fine to me, I don't see any issue with the overa=
ll
> approach.
>=20

Sorry,=20I replied on the wrong thread, my previous email was actually me=
ant
for the v2 patch.

Thank
Gang

> Also, could you send v3 separately to the MPTCP mailing list? It seems =
the
> CI checks were not triggered this time. I guess it might be because the
> patch was not based on the export branch of the mptcp repo on GitHub, s=
o
> you can generate the patch based on that branch
> (multipath-tcp/mptcp_net-next, branch export).
>=20
>=20Two notes for next time (Important):
> 1. For MPTCP-only patches, it is enough to send them to the MPTCP list
>  only, no need to CC netdev.
> 2. If a new version is needed, please wait 24 hours before sending it.
>=20
>=20Thanks
> Gang
>=20
>=20>=20
>=20> Best regards,
> >  Cen Zhang
> >
>

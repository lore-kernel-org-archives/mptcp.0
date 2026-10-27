Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097685;
	b=VKDMHiXaybHsb/UeXiK0vPrJXAIFx4sKuwftuyYTGuZmfdwGLRN86Z9mW6Ek4ZPJ6Dfl
	 d8M0YKBITx9Kdg+3ku+8cCZO3rHBv5nb7Rzn7ruzn5be41D0G5i5zLyoYelmLbf8Krj4g
	 J2KXyFWmaz+inj728n6itCKSxyMzb077OVAkbm2loedkznv1n4Nmg7f36cWch+puB50OL
	 /HTI7hk7fieJkvhRKWaEy8tEoW+d1DzjcwLoz/F+fg1DtbUAmnvJvFTySvp+13zXoqYF8
	 Gu+EDvU9Jx+9fAz9a0FmatRrgUc7bLNjTCBDEF/tP5cYwsAHN9p4I7OBvd409zF09sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097685;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=zSzxpuNBZGTL3sCPUmF9sYLDET9CcW0uV9i5/gpcgJQ=;
	b=K5BjKwHQFTP5nZOAgY2tVXeFgmuRptY28U5WWOTH/5aUgJCgh1vwp6MLdDCg6KLg/JXa
	 bG4AAvdWJ4OOHiiEJG3grxR+OJcOvSCHiI7jvhSSqEcuSKFUsJs1XzqYwvllMbxVRZln1
	 GlF/JKS1j0iB7FRvBRWd/6t5GDReUdk/3+0mLgRZ9y+qi2Q3wmG1NZL2ZNuZ/60Vy3KJc
	 3mVuhPNo1r6IbXcbGFAqNUMiw8Yef4DsikAbqKcEQY965AN2hquOK9khhtdmM1bN9GLFQ
	 MMrd8j8HJkWja4dhK33A+UH3Uaxv6S1DtCIYatpdzqJLacC19qnhnrm3kbdxy6Z2Zdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TaCCg0UC;
	arc=none smtp.remote-ip=95.215.58.250
Received: from mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572E606A31B
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 10:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9572E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TaCCg0UC
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ZdMAZAoqaOEltNIDxSXjIZRNw1tltjocsB24YtoDDKE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793097681; v=1; x=1793702481;
 b=TaCCg0UCa8h8T+VlM626DglJ1l9gEyd92u+u4CkgCgPdxom1GkeQgdQQkVTAjmypc6bLHBSj
 vookrjavYSJAd8G3MfUbdb5++1uUlcm20bfOkt9rG7enHHivP76MW8lTgyi7IVHBiGeOXz/WEhF
 V9+5Fx2aabhONXQd+Db2uBJo=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c738543dc2c8c0d4;
	Tue, 27 Oct 2026 10:41:21 +0000
X-Mizu-Trace-ID: c738543dc2c8c0d4
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
Date: Tue, 27 Oct 2026 10:41:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <f88992ae9b2dc51fd3a0ba2f9c23a29a91660877@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
To: "Cen Zhang" <zzzccc427@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 mptcp@lists.linux.dev
In-Reply-To: <CAFRLqsU2QHD2Ta2aL_qSVr9nVFrn6mXV_nZ987+oqHUbCa7ZSw@mail.gmail.com>
References: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
 <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
 <CAFRLqsU2QHD2Ta2aL_qSVr9nVFrn6mXV_nZ987+oqHUbCa7ZSw@mail.gmail.com>

October 26, 2026 at 10:44 PM, "Cen Zhang" <zzzccc427@gmail.com mailto:zzz=
ccc427@gmail.com?to=3D%22Cen%20Zhang%22%20%3Czzzccc427%40gmail.com%3E > w=
rote:


>=20
>=20Hi Eric,
>=20
>=20Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=882=
6=E6=97=A5=E5=91=A8=E4=B8=80 20:38=E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20>=20
>=20> Adding these stack traces without symbols is not really nice.
> >=20
>=20>  Time to use scripts/decode_stacktrace.sh
> >=20
>=20Sorry about that, v2 carries the report decoded with
> scripts/decode_stacktrace.sh and trimmed to the relevant frames.
>=20
>=20>=20
>=20> msk->first is a TCP socket: TCP listeners have SOCK_RCU_FREE, and
> >  tcp_prot / tcpv6_prot use SLAB_TYPESAFE_BY_RCU. Reading two integers
> >  under rcu_read_lock() is safe, and stale values are fine for diag.
> >=20
>=20Thanks for the suggestions.

Hi Cen,

Basically this looks fine to me, I don't see any issue with the overall
approach.

Also, could you send v3 separately to the MPTCP mailing list? It seems th=
e
CI checks were not triggered this time. I guess it might be because the
patch was not based on the export branch of the mptcp repo on GitHub, so
you can generate the patch based on that branch
(multipath-tcp/mptcp_net-next, branch export).

Two notes for next time (Important):
1. For MPTCP-only patches, it is enough to send them to the MPTCP list
   only, no need to CC netdev.
2. If a new version is needed, please wait 24 hours before sending it.



Thanks
Gang


>=20
>=20Best regards,
> Cen Zhang
>

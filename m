Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3F374E5B
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785133257; cv=none; b=i61pwbNaLg70zzCE+/spsK/5M9zLW2W/ZxPShkvmHOPpfe6ns+judJFIeawC30u3ZEvwHVTF3xJuOHisfpg511mIwywNUgE9z8sYgO+EoI/B0kXpFCBCAGMUptdow8LaTKigwna42Ssa+n+ZWCeMdnZEZwMFjAdrmtA2qm/wMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785133257; c=relaxed/simple;
	bh=u6+93P8Rla5f7rTfyOsdSsSeDQn8ftxENktSDYEleqs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=BSLaBOe146HB/mNwSsHf89Ja0627AcyQ36TXnEe3j546o3kkLyUIvTHLrLb4dcE8ug13djBh9kFCbf1VcZ4CSDKCr3aprTCbq5+9SOnPpeadxbrJ4g25zojrjqyppoHjX+548COdV+X1r8VFFDFD6w1XBkv31Ygm2GYJVVtBTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h7sgXmfO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h7sgXmfO"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785133254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbB3wfkk91CGGo4RavMmHcFw2505yWLDwde7YVHBtro=;
	b=h7sgXmfOy2UPrbSvcbnb78927qL9aEWZ2JlU3gqBIxpWDHGkEDKebfGH0uCGV49YYQB25N
	EjI7B4M/7TVTtW6DLHm0+WprUN4mf/I/zyGYHItkQCWSESFh33jAM6kOeOpB0VHqCfS7BT
	pqFZLYmu9m8BWEkubhDy9sB/37oZ4ao=
Date: Mon, 27 Jul 2026 06:20:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <2f786253a7d07989757b58b97cb4623e978ee562@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v3 0/7] mptcp: add bpf_setsockopt support
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <7769654745b0fc72ac1a2a9c697ead37dc841666.camel@kernel.org>
References: <20260727022849.20923-1-gang.yan@linux.dev>
 <7769654745b0fc72ac1a2a9c697ead37dc841666.camel@kernel.org>
X-Migadu-Flow: FLOW_OUT

July 27, 2026 at 2:04 PM, "Geliang Tang" <geliang@kernel.org mailto:gelia=
ng@kernel.org?to=3D%22Geliang%20Tang%22%20%3Cgeliang%40kernel.org%3E > wr=
ote:


>=20
>=20Hi Gang,
>=20
>=20On Mon, 2026-07-27 at 10:28 +0800, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  Hi, Matt, Geliang, Paolo
> >=20=20
>=20>  Patch 3-4 have been reviewed by Paolo before, and ready for merge
> >  [1][2].
> >=20
>=20Do not put unrelated code into a single series. This series is for
> adding bpf_setsockopt support; other patches do not belong here.
>=20
>=20>=20
>=20> Changelog:
> >  v3:
> >  =C2=A0 - Patch 2 keeps the mptcp_setsockopt_all_sf as Geliang sugges=
ted.
> >=20
>=20I recommend that you hold off on sending this patch for now: "Let's
> wait until IPV6_TCLASS is merged before posting this patch." Rather
> than keeping an unused mptcp_setsockopt_all_sf.
>=20
>=20Do not send code that has not passed compilation to the mailing list.
>

Hi Geliang
=20
I=20sincerely apologize for the noise. I'll drop this patch and wait for =
the IPV6_TCLASS merge.

Thanks
Gang
> >=20
>=20> v2:
> >  =C2=A0 - Patches 1 and 2 are new in this series; they address TCP_MA=
XSEG
> >  =C2=A0=C2=A0=C2=A0 handling in the bpf_setsockopt() path.
> >  =C2=A0 - Patch 4 adds an early return to fix msk->sk_rcvlowat being
> >  =C2=A0=C2=A0=C2=A0 unexpectedly modified, an issue seen in v1.
> >  =C2=A0 - Patch 5 makes the hook safe for the non-tcp master socket: =
it
> >  guards
> >  =C2=A0=C2=A0=C2=A0 bpf_sock_ops_cb_flags_set() with sk_is_tcp() to p=
revent out-of-
> >  bounds
> >  =C2=A0=C2=A0=C2=A0 heap reads/writes through tcp_sk(sk)->bpf_sock_op=
s_cb_flags, and
> >  does
> >  =C2=A0=C2=A0=C2=A0 not set is_locked_tcp_sock for the msk (unlike tc=
p_call_bpf()).
> >  That
> >  =C2=A0=C2=A0=C2=A0 flag authorizes the verifier's direct tcp_sock-of=
fset field
> >  accesses;
> >  =C2=A0=C2=A0=C2=A0 since the msk is not a tcp_sock, leaving it at th=
e default 0 is
> >  safe.
> >=20=20
>=20>  v1:
> >  =C2=A0 Link:
> >  https://patchwork.kernel.org/project/mptcp/cover/20260713095735.1222=
033-1-gang.yan@linux.dev/
> >=20=20
>=20>  [1]
> >  https://patchwork.kernel.org/project/mptcp/patch/20260522-sockopt_lo=
ck-v5-2-108629a46e98@kylinos.cn/
> >  [2]
> >  https://patchwork.kernel.org/project/mptcp/patch/20260522-sockopt_lo=
ck-v5-4-108629a46e98@kylinos.cn/
> >=20=20
>=20>  Gang Yan (7):
> >  =C2=A0 mptcp: drop unused @max arg of __mptcp_setsockopt_set_val
> >  =C2=A0 mptcp: take TCP_MAXSEG handling into __mptcp_setsockopt_set_v=
al
> >  =C2=A0 mptcp: use sockopt_lock/release_sock in sockopt
> >  =C2=A0 mptcp: reject sockopt requiring ssks' lock in BPF context
> >  =C2=A0 mptcp: enable bpf_setsockopt on the master socket
> >  =C2=A0 mptcp: add TCP_CONNECT_CB sock_ops hook
> >  =C2=A0 selftests: bpf: verify mptcp bpf_setsockopt from TCP_CONNECT_=
CB
> >=20=20
>=20>  =C2=A0include/net/mptcp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 ++
> >  =C2=A0net/core/filter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> >  =C2=A0net/ipv4/tcp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> >  =C2=A0net/mptcp/protocol.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> >  =C2=A0net/mptcp/protocol.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 ++++
> >  =C2=A0net/mptcp/sockopt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 127 +++++++++++-----
> >  --
> >  =C2=A0.../testing/selftests/bpf/prog_tests/mptcp.c=C2=A0 |=C2=A0 61 =
+++++++++
> >  =C2=A0.../selftests/bpf/progs/mptcp_setsockopt.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0 32 +++++
> >  =C2=A08 files changed, 223 insertions(+), 52 deletions(-)
> >  =C2=A0create mode 100644
> >  tools/testing/selftests/bpf/progs/mptcp_setsockopt.c
> >
>

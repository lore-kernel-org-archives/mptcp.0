Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A430F7EA
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699712; cv=none; b=XVDYWPF14pZQTTj+DLBQPBTDZ0hF519xtbs+vSe86VuYpUwRoDfGsxOpd2FlpQgtd3nBs+aDsCEW+COT5lzhfGUs3cYmEh/gvo0dlRUjKIKUDyeeEqtAhxjgLVxnmbiRysbWvudXhs5EiFE/a+YIakAOS5tuCL/TGMwimSpzTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699712; c=relaxed/simple;
	bh=fHu59Cel7orjNQjiEFnOBj9/DQKWuvN9Ki0qpYliMYI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ZHZwcpT/NCZS2ej6vR6cYOCR0E1VT10sPIQGqYAMzYlBeCkneXzH012ub2DadZQZhXAqxMVbQQjJyBi45iyNjy1oXWA4A9X7gYetR03BCBpb7y9jet+g7uqw66z6yVb9rpCbMQGu0jc5GHVdecCw2bmFBWc9mBKBCzLUrJKO9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l88AxBKb; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l88AxBKb"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779699708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaxGas0WyccdzxVconcTajdnpOXH7y0m9viDYt/VWLE=;
	b=l88AxBKbCWGm2FzjXXjZZCIZBv+mpFok5xvzG3LLL8ik+6bLq1I1s7jiD5OrOYgqo/vkhc
	DU09eGgZjiU8UXpf5iHqxN6/jcUzEFkZdLItbPMW503OOV1zkfhUA1POt42ee09bR+32A+
	iSD361KW7etvkonhn+gXa2BZM9FDZaQ=
Date: Mon, 25 May 2026 09:01:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <ab405d42521cb862e62d652ce0f400a5ab73d7b7@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v5 4/6] mptcp: reject sockopt requiring ssks'
 lock in BPF context
To: "Paolo Abeni" <pabeni@redhat.com>, "MPTCP Linux" <mptcp@lists.linux.dev>
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <0887aa80-13c0-47eb-9178-a7f1cf9ba5e5@redhat.com>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
 <20260522-sockopt_lock-v5-4-108629a46e98@kylinos.cn>
 <0887aa80-13c0-47eb-9178-a7f1cf9ba5e5@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 25, 2026 at 4:32 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@r=
edhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 5/22/26 11:12 AM, Gang Yan wrote:
>=20
>=20>=20
>=20> @@ -600,6 +609,9 @@ static int mptcp_setsockopt_sol_tcp_congestion(=
struct mptcp_sock *msk, sockptr_t
> >=20=20
>=20>  cap_net_admin =3D sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NE=
T_ADMIN);
> >=20=20
>=20>  + if (has_current_bpf_ctx())
> >  + return -EOPNOTSUPP;
> >=20
>=20I think it would be better to move the check earlier and drop the
> previous patch.
>=20
>=20Possibly it would be considered avoiding touching in patch 2 the othe=
r
> functions where EBPF support is disabled here, but I have mixed feeling
> WRT this later option, due to code consistency. Not a big deal either w=
ay.
>=20
>=20/P
>

Hi Paolo,

Thanks for your review.

Would you mind reviewing patch 1 separately? I noticed that patch 1 is do=
ing
something different from the rest. Patches 2=E2=80=936 focus on MPTCP soc=
kopt issues
in BPF context =E2=80=94 they should really be a separate series, and I'l=
l iterate on
a new version for them later.

My current idea is to build on patch 5 and patch 6 to try supporting a su=
bset
of setsockopt operations in BPF environment. For operations that need to =
take
the subflow lock (including the first subflow), we can use has_current_bp=
f_ctx
to return -EOPNOTSUPP.

WDYT?

Thanks,
Gang

Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C076C21E091
	for <mptcp@lists.linux.dev>; Sat, 11 Apr 2026 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775879482; cv=none; b=U5VMrnD1+uCMGF2zNkxKFKj8vjzluVO7piBhiXlQD9VeUxpbLrmYFoBGWlfoBdE26tXrdBz0TIfBvSeyrJyX8Mz1UGoQWe1KiaO2FdVKzQS5514AUVv81SHm62rVgyO9d2C/qKjlo/auK4ktmixpmgSc0HPXcjQg3Z5VP1kuDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775879482; c=relaxed/simple;
	bh=zcw92UTzm5mmvfV3oN0nd40fdzf8AqDUFxmWvzsLCHc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=obPAPymq/jrX9E2X7jcEIDdtxHgOtfK1WPlHc3HcMMDJQ695KTRka2lThJ25ZA9sRpDtRfclw+bS/NM65x31I5UcvrXoSxuZL2A/e6ym3AfVQpVQQBdS1sOHzxRQJCE1MM6Ry8yhYUyLM6iCDoK34ZtuHVl8jebxNHFiHcmeb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OROdvcC3; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OROdvcC3"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775879478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FByICIzCDiN3a+RvU5Q/aMGOVup11jitsFCoKsW8Mc=;
	b=OROdvcC3HnG9PBfWAGSMHltrcIDRkcCEVjhrU0VwCQCGNe0ShEGV5MGVwhS/sQetrwrMOn
	FHeLCGK+qCJ8RauUZ2cX9klS7n2bHgKJTU3MMdvPVe3fzoPSFWUi/ikpUPwEvnUwPJjuj1
	2FN+qaZL03svhWPN63rMuuYodhUUoJA=
Date: Sat, 11 Apr 2026 03:51:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <c5992c62c4e0205087c27c0ad69eef348f774bb7@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v3 1/2] mptcp: sync the msk->sndbuf at accept()
 time
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
In-Reply-To: <9b3a7675-cf38-4107-8c79-6ec7ccdbb2e4@redhat.com>
References: <cover.1775551182.git.yangang@kylinos.cn>
 <79d5862da1c7db353e27c56a26da78e6dd548659.1775551182.git.yangang@kylinos.cn>
 <9b3a7675-cf38-4107-8c79-6ec7ccdbb2e4@redhat.com>
X-Migadu-Flow: FLOW_OUT

April 10, 2026 at 5:04 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni=
@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 4/7/26 10:45 AM, Gang Yan wrote:
>=20
>=20>=20
>=20> From: Gang Yan <yangang@kylinos.cn>
> >=20=20
>=20>  After an MPTCP connection is established, the sk_sndbuf of client'=
s msk
> >  can be updated through 'subflow_finish_connect'. However, the newly
> >  accepted msk on the server side has a small sk_sndbuf than
> >  msk->first->sk_sndbuf:
> >=20=20
>=20>  '''
> >  MPTCP: msk:00000000e55b09db, msk->sndbuf:20480, msk->first->sndbuf:2=
626560
> >  '''
> >=20=20
>=20>  This patch synchronizes the sk_sndbuf by triggering its update dur=
ing
> >  accept.
> >=20
>=20I finally could wrap my head around the root cause: tcp_child_process=
()
> -> tcp_init_transfer() -> tcp_sndbuf_expand() can and will grow the ssk
> sndbuf _after_ tcp_check_req() -> subflow_syn_recv_sock() ->
> mptcp_sk_clone_init() where __mptcp_propagate_sndbuf() is currently hoo=
ked.
>=20
>=20I think the latter __mptcp_propagate_sndbuf() invocation can be remov=
ed,
> and the commit message expanded to capture some of the above.
>=20
>=20With the above included feel free to add:
>=20
>=20Acked-by: Paolo Abeni <pabeni@redhat.com>
Hi Paolo,

Thanks for your suggestions. The v4 code will be sent soon.

Cherrs,
Gang
>

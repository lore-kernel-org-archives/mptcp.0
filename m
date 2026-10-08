Received: from mta1.migadu.com (out-243.mta1.migadu.com [95.215.58.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02C494826
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465212; cv=none; b=ioMffUAEPutsxZqIwnFORMi+mEw6Ki9Z3uNCN3TX9kD3IAWTiWfQqwCexcN3jfCRa5Oa2pTJb3d2LLX//hCehsM36Yprf0F/CSesllGIOfdwn2W9p9A+LmAfN2vV83sBMKbSn8U4ZVhga9QhFvYkMT/taFrGiZ9R8162Dd7MUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465212; c=relaxed/simple;
	bh=Wqvlm2aqNcwgTmLOrKORlyn9qE3NSkl+gKoHDODQLtA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=LkWk9YegsyxV320QAAy5JVLm1tohsf28s+mWRkBa8NlCWaHlx6lBqMTa0jS9idIvGNkY2I3NqbL3ehK1N2+C8RnRrPpFgJBV4v3uepdHyMlPb8g8GR7rsGRoXCAh1zWLdUOT62EqqMZI1ERInTELmql3Vj1+2w7LtnN6KMhdEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fVKowr5X; arc=none smtp.client-ip=95.215.58.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fVKowr5X"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Wqvlm2aqNcwgTmLOrKORlyn9qE3NSkl+gKoHDODQLtA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791465206; v=1; x=1792070006;
 b=fVKowr5X+CLAj+BAYYFgIs+HT5FaYTiy1IlbGD69Cw27+XRmfzChnTj/NvdNKkEMOwbYGXv6
 KKqfvtoEzPrW5n9tpVjbPISSPYfYjgu2t5HVmX7K2kUuMFcSI3yl8dA5VA6Gs5ChlTjzGyZppIz
 bywRP3oFs+5oCk8Ohddn10no=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4cdeb51eeb73c8e4;
	Thu, 08 Oct 2026 13:13:26 +0000
X-Mizu-Trace-ID: 4cdeb51eeb73c8e4
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 13:13:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: hangbin.liu@linux.dev
Message-ID: <c964a8b2026ec59e4f9baea7b07a7cfbd91e8557@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next] selftests: mptcp: remove unused configs
To: "Matthieu Baerts" <matttbe@kernel.org>, "MPTCP Linux"
 <mptcp@lists.linux.dev>
Cc: "Hangbin Liu" <liuhangbin@kylinos.cn>
In-Reply-To: <8af523ad-9333-4c6a-963a-faee24877770@kernel.org>
References: <20261008-mptcp_config-v1-1-269d05f7e6be@kylinos.cn>
 <8af523ad-9333-4c6a-963a-faee24877770@kernel.org>

Hi Matthieu,
October 8, 2026 at 7:48 PM, "Matthieu Baerts" <matttbe@kernel.org> wrote:
>=20
>=20Hi Hangbin,
>=20
>=20On 08/10/2026 11:28, Hangbin Liu wrote:
>=20
>=20>=20
>=20> From: Hangbin Liu <liuhangbin@kylinos.cn>
> >=20=20
>=20>  After converting the mptcp selftests from iptables to nftables,
> >  the xtables-only options are no longer needed.
> >=20
>=20Thank you for the follow-up. Should we squash this into "selftests:
> mptcp: convert iptables to nftables for mptcp_join.sh"? This commit
> already removes one unused option, plus ip*tables* from mptcp_lib.sh.
>=20
>=20WDYT?

Sure, makes sense to me. Feel free to squash the patch.

Regards
Hangbin

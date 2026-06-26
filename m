Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CB3EB0EF
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469450; cv=none; b=GENRg4aDihtR3Ot5RjgrthUvH5HUa8edyagf5nBB5e+DrLeazOAs3Dx85iepIXoGbpq5pLl0YUn9DrOauw5aPSCN5jriAjMOW2VRCqHpVFKSmAR7C8I+fMyOFLVE7ORNGiEO40B+WuwqjHi1b+WlJISmgMDdu0e64WYelyJG0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469450; c=relaxed/simple;
	bh=HrUMyAz22oGa0laVvGkXswiq6KSC5SMzgbIw2ZXou7g=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=HbRE5CoxQ1kEVdS1gNGMt7tDoPeSUJJkJs8Vbco9WPNWPDD9htv4dhQTa7f/prI7hi2/FPNisTIf/mmONisv5+n0A0s5DsHdMpLtF6WVjf2dSb0Wt4i1cPvIaQjELQh2z1WRz1+IHuL4Hu8gxb2blCN2qDqYbk98JYKR7TG6lrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+0xmvb+; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L+0xmvb+"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782469446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sfdT5gVRqRrJ/qAf/VBBjwvq9ixeXTB9v/npiIG5X0=;
	b=L+0xmvb+vdztgu1xu+DDOY2rGeWeLBDjrpuX2eKteIwT5fv9nnqbj/na3GnhgdmlSI53tA
	zuEczsdRDAo6tk+VztdtE+AjrCXxMrQ4xvtnckR52i6t9E4S4roNEkKqhZaYnLmvC0UwjC
	AHNdsw4e7QudBEzniCfQT0C77F70tUY=
Date: Fri, 26 Jun 2026 10:24:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <0bdfd823d64a18b9c9230d176082289418d25a4a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v5 0/3] only remove entry from local_addr_list
 when sending a REMOVE_ADDR
To: mptcp@lists.linux.dev
In-Reply-To: <74f86b7879f96bd71d989e4323750c4bf77627c5@linux.dev>
References: <cover.1782457962.git.tanggeliang@kylinos.cn>
 <74f86b7879f96bd71d989e4323750c4bf77627c5@linux.dev>
X-Migadu-Flow: FLOW_OUT

>=20
>=20From: Geliang Tang <tanggeliang@kylinos.cn>
>=20=20
>=20 v5:
>  - rebased.
>  - add Matt's reviewed tags.
>  - add a RM_ADDR from the server to the client as Sashiko suggested.
>  - mptcpd tests (make check) are still OK after this modification.
>=20
Hi=20Matt,

Sorry for the off-list email before, I forget to cc the mptcp@lists.linux=
.dev

First, no offense intended =E2=80=94 this is in no way a comment on this =
patch.=20
The=20patch itself looks good to me. I'm replying here only because the
thought came up while reading it.

While looking at mptcpd recently, I noticed that 'make check' doesn't
seem to exercise the userspace PM logic in a meaningful way. The
userspace PM cases in test-commands issue the per-connection (mptcpd_pm_*=
)
calls with a fake token that doesn't correspond to any real MPTCP connect=
ion,
so they only really verify that the command dispatches and the genl reque=
st
is sent without crashing.

This made me wonder whether it would be worthwhile to add functional test=
s
for mptcpd within the selftest framework =E2=80=94 for example, via a ded=
icated script
(something like selftest_mptcpd.sh) that actually starts mptcpd with spec=
ific
plugins (e.g., sspi) in a namespace/veth environment, and then asserts th=
e
expected path-manager behavior end-to-end.

In other words, I'm asking: does the community think mptcpd's userspace P=
M
functionality deserves similar test coverage within selftest?

Thanks
Gang

>=20
>=20v4:
>  - rebased.
>  - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1776466=
833.git.tanggeliang@kylinos.cn/
>=20=20
>=20 v3:
>  - update userspace selftests.
>  - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1744787=
273.git.tanggeliang@kylinos.cn/
>=20=20
>=20 v2:
>  - squash patch 1 into patch 2 as Mat suggested.
>=20=20
>=20 Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
>=20=20
>=20 Geliang Tang (3):
>  mptcp: pm: userspace: drop delete_local_addr helper
>  selftests: mptcp: join: update userspace dump_addr outputs
>  selftests: mptcp: userspace: send RM_ADDR between server and client
>=20=20
>=20 net/mptcp/pm_userspace.c | 35 ++-----------------
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 6 ++--
>  .../selftests/net/mptcp/userspace_pm.sh | 16 +++++++++
>  3 files changed, 21 insertions(+), 36 deletions(-)
>=20=20
>=20 --=20
>=20 2.53.0
>

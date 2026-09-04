Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2B3AC0EF
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506738; cv=none; b=GuiO92J85dBVdqu0v9b60eqpEszSfc5fDMo4AsgjOYdWpUjGUSKorZTyXBVsNdCNXjSkGIiJ2hwy43MixrfEMiI+/9/60hsId9QffdtlTcW+OUtgnYJrw19/++lCDx4qxpYeMGKAjMiUmoTw5gQtPLKfB99AwOtUqgLdqgaOI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506738; c=relaxed/simple;
	bh=Qjl1GFqDl/olrMEdBVe5JHxcKoIT5aRhCndFd1dqOSc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=bPaizp9ML8j+AYbINJL8QDvQ9mPkhcw8fX7Iv8uQEhPgts6E+W1lgrytSuHqVG3PyWFxPUqAAakLuoSYWhjCRPgVbDZcAg3l3bE3ggdDxpHV134WYjIVTjadCaVF41kA2wSn7KsvryVgMvGtQ0lBDYatV3MkAAqCp1Ou6pWPNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KKF2VxSG; arc=none smtp.client-ip=95.215.58.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KKF2VxSG"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Qjl1GFqDl/olrMEdBVe5JHxcKoIT5aRhCndFd1dqOSc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788506734; v=1; x=1789111534;
 b=KKF2VxSGVeINTfCmQummGgj3PuV/k96IzgJFRaamuX0ogp7LUTXjGi+FzhG0cVM2oSwPhzNJ
 c7nql3iAoYUCRjHB7+oK2N+l4lqGwpx96WuoYq0456/lt0vOijnN7p3jNgOPhw/Hn7/CoWkUKNT
 B/xLTcQt+ZzLs4niUxv9Y8D4=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 20fc282cdf6367eb;
	Fri, 04 Sep 2026 07:25:33 +0000
X-Mizu-Trace-ID: 20fc282cdf6367eb
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 04 Sep 2026 07:25:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <3f13f3acd4c329480331cccf5a12411dc01ee721@linux.dev>
TLS-Required: No
Subject: Re: [RFC] Mitigating Sashiko-driven iteration noise on the main
 MPTCP list
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <6f86381a-72d4-4a47-bc7d-1880cc39da64@kernel.org>
References: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
 <6f86381a-72d4-4a47-bc7d-1880cc39da64@kernel.org>

September 3, 2026 at 5:52 PM, "Matthieu Baerts" <matttbe@kernel.org mailt=
o:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.o=
rg%3E > wrote:

Hi, Matt

Thanks for your reply and detailed explanation.

> I agree with you here, having to face many iterations is not good for
> the reviewers, and not for the devs either.
>=20
>=20>=20
>=20> My suggestions
> >=20=20
>=20>  To decouple the machine=E2=80=91driven iteration loop from human=
=E2=80=91driven review, I would like to propose a
> >  split workflow:
> >=20=20
>=20>  1. Initial submission (v1): The contributor sends the first versio=
n of the patch series to the main
> >  list (mptcp@lists.linux.dev). Maintainers can quickly glance at it t=
o filter out obviously invalid
> >  or low=E2=80=91quality patches early.
> >  2. Bot=E2=80=91driven iteration (v2, v3, =E2=80=A6): For subsequent =
versions that only address Sashiko's feedback,
> >  the contributor posts those revisions to a separate, dedicated list =
(e.g., mptcp-sashiko@lists.linux.dev).
> >  Sashiko watches that list and provides its feedback there. The contr=
ibutor can iterate as many
> >  times as needed without bothering the main list audience.
> >  3. Final polished version: Once Sashiko reports no meaningful commen=
ts (or only false=E2=80=91positive warnings
> >  that the contributor has already handled), the contributor resends t=
he final, cleaned=E2=80=91up patch to
> >  the main list for human review.
> >=20
>=20But I cannot support your suggestion :)
>=20
>=20Sashiko's usage has a cost: it is useful to have it to flag some
> potential issues, so we want to continue having it for "legit" patches.
> If its usage is "abused", then we might lose it for all patches.
>=20
>=20At the last netdev, devs got told to run pre-checks locally, includin=
g
> selftests but also AI reviews (when it is possible). Many companies are
> already using LLMs, then their devs should also have their patches
> tested by a local Sashiko. Sashiko can be easily executed locally, with
> different models. The project's README explains how to install and use
> it. In short, it is supposed to be easy: configure the model to use, ru=
n
> "sashiko init", then "sashiko review". That's it. Or course, we cannot
> force people to use it locally. Some refs:
>=20
>=20 -
> https://netdevconf.info/0x1A/docs/netdev-0x1a-paper49-talk-slides/Devic=
e%20driver%20workshop%20(2).pdf
>  - https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-lo=
cally
>=20
>=20Ideally, authors are expected to reply to Sashiko's emails and review=
ers
> can help checking if Sashiko is hallucinating (which still happen
> frequently...) or is asking to fix issues that cannot happen in real
> deployments. But the thing is that Sashiko can review and generate a lo=
t
> of text that humans -- especially busy reviewers -- might take time to
> process. So the idea here is not to rush things, and ask questions when
> something is unclear or look suspicious / wrong.
>=20
>=20In conclusion, I don't think we want a "hidden" ML, but we do want to
> reduce the traffic on the ML, and the recommended solution is to push
> people validating their patches with the same tool (or closed to, if
> possible) before any submissions. WDYT?

I now see that my idea was probably too naive/overly simplistic :)

I have tried deploying Sashiko locally and noticed that different models =
can
produce quite different review outputs. For now, I am willing to defer to=
 the
community's existing practice.

Thanks again for your time.

Cheers,
Gang

>=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>

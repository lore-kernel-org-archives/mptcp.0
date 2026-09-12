Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238442DA55
	for <mptcp@lists.linux.dev>; Sat, 12 Sep 2026 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202576; cv=none; b=Z2EBO0zrNsex2BqqChu2g0vSkowUph4moN4ZKJQpqsLKvrq5kpw2J6f3ipkVP4V4h7+wFcBlH8Xklf/w5Q17IunwtNqSnCyZQE3iORmvuq3HAeHA910NnvjavXhcRavN+GeESzjhfHMTTTrxL+x7W4VJVVyGathFWShqA43ZSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202576; c=relaxed/simple;
	bh=wGpiRarVulJuhvK/ztifCseQjRARiJd2S92COlF9B8s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrNr5nxvaIoxC3g0Gic6thQxqtSaAOdsk0x6I7eOg0LnMVKqxexMGCbDnwKKilKo6aVvTrjkWClgdTj66LekEE0L8BzIp7sMtXQiEEzPxqagNdKsKpAU0CnioB5NiqlSOb8nQZdZqr02B82eLzOHXGPxA2MpalVQdHgfJevMF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GWa3IAJu; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GWa3IAJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789202563; x=1789461763;
	bh=jfhNje47WEu+p+q9NA2xmQHNHrqx8JW3xxIdM+RVg2g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GWa3IAJuUgNBrbratCH/GuRame0Ie/nnwEFP79TZ7UL4C6/XriJX/t1ntQBaOf3Az
	 O/wV8fcAnA/5323Y/rWh5iPb+IMhBY4N7UsCH/wbMff222F+Ju65BPl+qi24Cp2RZv
	 UCGt60W32Dnou4ZYUzAzg762YgItnA0j1RxcY2K8dCVyjBrMIOkcCpZs8Hc8PwZBE9
	 tynsbXSvKqMo4E4u2/Lq/E4HF7umfRfGWlP5AjgegNSrc914K8aNUW/5SwvzF4eH2N
	 roSyumMsajpIzVp+OfrNYboKt8C3nHojq/BIvyzNmLeBRZ+B9p8SawjZMAGZBonpxV
	 HXoaIC+PByT1g==
Date: Sat, 12 Sep 2026 08:42:40 +0000
To: Matthieu Baerts <matttbe@kernel.org>
From: quanyeyang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: retry connect after early fallback
Message-ID: <-ZGGpW4fRsw5nfnV8SiV4YNI0qeW_COcXZIfYFiTAtTRENexps8-vPd6Y1Z8DLUx9WWTLlHus0WJMuvbQ9zcB65LJI_w6GjGM5QY-HHRf2g=@proton.me>
In-Reply-To: <9f979653-9817-4daf-89a2-bb6394b406c6@kernel.org>
References: <20260911-mptcp-connect-undo-net-v2-0-54224cea2238@proton.me> <20260911-mptcp-connect-undo-net-v2-2-54224cea2238@proton.me> <9f979653-9817-4daf-89a2-bb6394b406c6@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 62382f02239df28ca441d658c356bc9bda01e4f5
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, September 11th, 2026 at AM 10:20, Matthieu Baerts <matttbe@kerne=
l.org> wrote:
=20
> Thank you for this test, but we cannot accept this: it is good to have a
> test linked to a fix or a feature, but it has to be maintainable. If
> each fix/feature adds 300+ LoC, that's unmaintainable (or LLM become
> mandatory for that, but that's not what we want: we still need to be
> able to read the test).
>=20
> Ideally:
>=20
> - create a small packetdrill test instead, using the MPTCP version [1]
>=20
> - not everything can be tested with packetdrill (even if it can also be
>   extended) and adding code in the selftests is OK, but, if possible, it
>   should reuse the existing tools and helpers
>=20
> So in this case here: can you have a packetdrill test instead? It should
> be possible, no? If not, can you only use 'mptcp_connect' and the
> existing helpers from mptcp_join.sh?
>=20
> Also, mptcp_join.sh is to validate cases with multiple subflows. I don't
> think you need that, right?
>=20
> [1] https://github.com/multipath-tcp/packetdrill/
>=20
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>=20
>=20
Thanks for the detailed guidance.
Agreed, 2/2 is too heavy. I will drop it and try to add a small packetdrill
script under gtests/net/mptcp/regressions/ instead: record a blackhole,
then fail connect() on the same fd before SS_CONNECTING, clear
blackhole_timeout, and check the retry still sends MP_CAPABLE
(TCP_IS_MPTCP / the 3rd ACK).
The kernel fix in v2 1/2 does not depend on that selftest. Could you
apply that one on its own?
Thanks,
Quanye

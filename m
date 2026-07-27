Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2429C3F824D;
	Mon, 27 Jul 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153510; cv=none; b=r55lZnH0OyJnVBJwXCqLn1DAE1/T83xLDTCT5NHn6Bb0FYjJTOtNn2EWhHyHAVla0TZN16SmmLNM+k8ZHkba+LkVqehmTMy0b4J2UGrMqVH0IjGuo+4El2XytHb72CnyTknccJ5yzh6dvOWEECn2dQYlNw0pGveeYBXAMSWd5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153510; c=relaxed/simple;
	bh=SzjrISe0q2eeqep3ox/nJoLw7KB0CxpdGDcPMRmFCYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VEGEkrqV5XM6vI3/Y30ItXcS4TBH2yC5WVM4ZWhAxFQCt/wJa+i+cNdIXU0suPprnO9P1xdYNylNFmUCKDVK4QIwrKbIKYaSzUmKC2rRU3wwNZZlVYJJRg9VmR1hl2sTB+ivrS0tqWZq2mDiNW53iuTSZbb03u6Da6c2tOtGBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y81S7S89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y81S7S89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABA41F00A3A;
	Mon, 27 Jul 2026 11:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785153508;
	bh=krbGZKLd0O8JA4ydKurme+tDNfqpnhsHFKUIwH7Hfug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y81S7S89vmen4nypsdQDdcIvTx2A+KSV7agJRtqYJspYB3gOJ20G2OHO2BKGMHEZX
	 MtK69DPPHcpnA4u6sW/QvOU0dPy6jS+ZcDApu32OX01kz1DW9NZcCu8aRE0sqGGPmm
	 cI6oxoz28vV3O+VL7440HR6/tTRrTYZXfilabbEpa7aimDQeLLwJwRExhUJjr2rJ3i
	 FYb62hUEwlxXsfdRrT7nDQK4Cecvgqg5bDubIsAdiB4XGG2BGcxi2A+PtkrSQsEX5c
	 RwcJS0kUJuht1p3mL5cLbW9t7wZkFFIa4BpyPYgNNznhe1HKp/tEin+j5wxvP5RD2K
	 b6L/coik+c0Ag==
Message-ID: <b2b89abe26e0c603e929733a32240484b7feaa05.camel@kernel.org>
Subject: Re: [PATCH net-next v2] mptcp: sockopt: implement IPV6_TCLASS
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, David 'equinox' Lamparter
	 <equinox@diac24.net>
Cc: Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Date: Mon, 27 Jul 2026 19:58:24 +0800
In-Reply-To: <f2c103ac-b85e-4c9b-a590-23f63388855f@kernel.org>
References: <20260713135551.569365-1-equinox@diac24.net>
	 <c3b017e1c96cdafce15012e737389108d7cbf8f6.camel@kernel.org>
	 <alYF-78I4LUaePGo@eidolon.nox.tf>
	 <f2c103ac-b85e-4c9b-a590-23f63388855f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi David, Matt,

On Tue, 2026-07-14 at 11:53 +0200, Matthieu Baerts wrote:
> Hi David, Geliang,
> 
> On 14/07/2026 11:48, David 'equinox' Lamparter wrote:
> > On Tue, Jul 14, 2026 at 10:22:12AM +0800, Geliang Tang wrote:
> > > Thanks for your patch. However there is already a version under
> > > review
> > > on the MPTCP mailing list that adds IPV6_TCLASS [1] (as well as
> > > IP_TTL
> > > and IPV6_UNICAST_HOPS).
> > > 
> > > https://patchwork.kernel.org/project/mptcp/patch/2617b8684039574734b8622936ef126d6a7cd519.1754986785.git.tanggeliang@kylinos.cn/
> > 
> > Darn, I looked for patches for this & didn't find any, but I've
> > also
> > been carrying this locally for a bit.
> > 
> > Anything I can do to help get your patch moving?
> I was hoping to do some refactoring around Geliang's code, but I
> didn't
> manage to do that so far. I will to see if it is fine to apply
> Geliang's
> patch (after netdevconf) and do the refactoring after.
> 
> @Geliang: do you mind rebasing this series, please? No hurry, I can
> also
> check later on. (And sorry for the delay on that)

I finally had time to do this IPV6_TCLASS refactoring. I merged my
changes into David's patch, keeping David as the patch author and
adding "Co-developed-by" tag for myself.

To verify the correctness of IPV6_TCLASS, I added IPV6_TCLASS support
to "NVMe over MPTCP" feature I'm currently working on, and all the
tests passed.

I will include this IPV6_TCLASS patch in my upcoming v3 of "Fix socket
options used by NVMe over MPTCP" soon.

Thanks,
-Geliang

> 
> Cheers,
> Matt

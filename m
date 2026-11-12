Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486339;
	b=CRcG8qfDxUGLKeUbY8b4zbOFh+uSQFwuPBpAIftngh3QJfndq+Ds0gdkgnjoQiDaQiOQ
	 i91S/+EqzzZynRH/YoMEO4RBZ0kFtIJz3IZxaRbHbmdKEX568P/cmkiIaMq9h7ibJ8uQJ
	 TSj7Sr+p9LwqjxLwpyg9zv85/OfIXwbx9QWq+bDIZPF9sohri2aqV5PatJT4xBvr09j9L
	 PgqVKE/8OFDiIFMuIQYEsN94m+F1kvcyExJKk89NwXN2LicAwQNUq/AESNpkWX8cpEBMy
	 J9ChSYxeIqubqMjlIpseGGTN3ZFxVexRdRucFKLb4PrU3AHoxWUX9sUkeAeDVezTWqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486339;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=A6vPMY7cyYlKsSRGPl5H+ro9cUpKdZRcckw58bC2a0E=;
	b=1N+Xsb3LS03MKc7zlTSmSvrtKeSQ5vglCcVGQ2qEyfDZKSiSqWVuu2nxVhxDU4vWzvyZ
	 momZO4YewtrLW6kk1TIzpLQ4zOpOm6DQ0FUsBBC50ufHxNYtV6MQEDFuyKbXI4qFu31hv
	 mnS5iJ5+YMVQNiy/TRniT2fCUPhhWCnh+dx0Q9CZ1/79aXJNm8/bFQ0/pRQ3Z7EFhpnwo
	 /9TwZQwpINCMCz24nhT+VmMYW1IlJa63zkTFwdfmg4c2yaIXWFwM7oita1pIFxsasx/RT
	 837cW4EBbLi0aXT1wQH/iPiWwwJgsW6ygnHLMsaxchBlm0y0ikGrlBEJAtAegHOUlCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmRVTMH1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A0606A321
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmRVTMH1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E8E1F00A05;
	Thu, 12 Nov 2026 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486339;
	bh=A6vPMY7cyYlKsSRGPl5H+ro9cUpKdZRcckw58bC2a0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HmRVTMH1yLOj4duG+cYBFfGbzfoJkIXW5laInjJiOTyONmdh7+rTO9YbxfqjW0QEp
	 NLjNCX9zbUf1L5309Xch3eRDEY6BvpjHDRwNai5IHPW8j3DMb60S2i5L9otSqOtsVF
	 ZGpgp1Ee+T7N2nxCY6sp3bgb5SIS6W5CcVJxG4Ij4ISsTt1AyHnRiV05nLbZ0DbAkm
	 zbiXhabayiehDMhKNtDtsguMA9u2kqR0WjrT33rdNx72fPMx1HB+8vFr6iG6BgChIw
	 IYCMelJpF289Q56qFZm3k9Teuux2jugEcWFU2rOxJVGwxMjj8Ed3u66FGMVeVdmQF/
	 r3KRLqxfYtPOw==
Message-ID: <c923da02-1429-4aa9-a044-5440232a47e0@kernel.org>
Date: Thu, 12 Nov 2026 13:25:31 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC net-next v12] mptcp: normalize sequence numbers using socket
 address
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, "shardul.b"
 <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>
References: <20261106111645.786225-1-kalpan.jani@mpiricsoftware.com>
 <1a1ce1e9b07.f015539104390.2600884748737974966@mpiricsoftware.com>
 <08451824-13d5-4e92-adb6-2ebd6c5cf053@kernel.org>
 <1a1cf8c61dd.83068f79144867.7028423115634706290@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1a1cf8c61dd.83068f79144867.7028423115634706290@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 12/11/2026 12:37, Kalpan Jani wrote:
> Hi Matt,
> 
> Thanks for reviewing and pointing this out.
> 
> Regarding the base commit, I understand the issue. My local patch was 
> tested against a tree that is not present in your current mptcp_net- next
> tree. I will check the correct base and prepare the patch as a replacement
> for v11 rather than stacking it on top of v11.
> 
> Regarding the offset, I understand your concern about exposing information
> derived from the MPTCP socket address.
> 
> One alternative could be to use independent random offsets for the local
> and remote sequence-number directions, generated once per MPTCP connection
> and stored in the MPTCP socket structure. This would avoid deriving
> the offsets from a kernel address.
> 
> However, this introduces additional state and initialization requirements.

Indeed... I think it would be better to avoid that "just to hide the
real values".

> We should also consider whether it preserves the expected semantics of
> the sequence numbers reported by MPTCP diagnostics.
> 
> Would retaining the existing `local_idsn` and `remote_idsn` values be 
> preferable, or do you think independent per-direction random offsets are
> worth exploring?

If we want to store the offsets, then better to use that, yes. But it
feels like we should do something simpler. At this point, I hesitate
with two options:

- when mptcp_diag_fill_info() is called from mptcp_diag_get_info()
  (Netlink, not getsockopt()), use a generated offset based on the msk
  address (or maybe there is something else we could use for the offset?
  We don't want to use the token for the same reasons).

- Or also only when called from  mptcp_diag_get_info(), return 0 for the
  sequence numbers.

Not sure the first option is worth it if it is costly "just for that".
So maybe just the simple second version?

> I would appreciate your thoughts before I proceed with the next revision.

Thank you for your patience.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


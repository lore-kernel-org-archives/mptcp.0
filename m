Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DFE33993
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147211; cv=none; b=tmcT72YoVBuEe8w37FW9VO0+CFpX10/xXgYQ8oaIBsXr2+ANoROhiqD/v6gQskM3r1uErLPqMTidGlW2PK8YrKs8EwguAxGB/9h+lIXMPvmTws7ssuHgheb0pahcDx1irVcqV/irwv2+qpUAMNthAd53CN0AlR8VDrYmOtEy59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147211; c=relaxed/simple;
	bh=5ueYwBQ+OINHhdqPlhoRNqcMAMuVnjyenyR2TqTp0d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OAqVZ1dKU1kQH1krMoez+Vms+iDTh48LeVFDh+ZVePG5XkWdlbBw0xPEw+39L4bCdHkGetBxdIGUXWrsSwd/B2ABq99YSPmzCpvuENDOEkzAfJ9VJU/60s5usd/MZecy6RsBZQ4L0z1FpOxgp5Yb0v0siI4bS/eD0SGywm9ZKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4405dNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4405dNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AF51F000FF;
	Fri, 11 Sep 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789147210;
	bh=tsaylWXDzaR7JQkz8tZ2Podd+Lf/rDdgnXNAeo8RGBI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=V4405dNR7b/Y8TZHO1c3feCqrut5qXETjhxhR74IXnIS9PNOUoJusjpTt/9FvPcAO
	 3cPEaghyV9/9kfQgMmGk63B39oDj9Nd5z2pPxeTzZsO8HOloGh2CHesPxvYKJxn8ti
	 kESazy0ROTLzcftITgnR3mUH66tmTYMZ7Psv+zaFpDHPk784+NtRq3+17sdR82aB06
	 8PGj4rPrJb+slUmuigB3YldkdR+jRfah6JiJotZnFIFhwUTbIDOkPH5aDXEfh/CxdT
	 ecU0WRdw1cKHoGj49Bk2Z6Ns6w30sth54y+cCLbK0DRYzJnwyc0QVvMMLmnCFWAg+t
	 q8e2qopyAZOGA==
Message-ID: <9f979653-9817-4daf-89a2-bb6394b406c6@kernel.org>
Date: Fri, 11 Sep 2026 19:20:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: retry connect
 after early fallback
Content-Language: fr
To: quanyeyang@proton.me, mptcp@lists.linux.dev
References: <20260911-mptcp-connect-undo-net-v2-0-54224cea2238@proton.me>
 <20260911-mptcp-connect-undo-net-v2-2-54224cea2238@proton.me>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260911-mptcp-connect-undo-net-v2-2-54224cea2238@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quanye,

On 11/09/2026 17:42, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> Cover leftover msk state when connect() fails before
> SS_CONNECTING. Existing mptcp_connect tests always use a fresh
> socket, so they cannot see a sticky fallback on the same fd.
> 
> Add a small helper that optionally issues a wrong-family connect()
> on an MPTCP socket, then connects to a real IPv4 destination and
> checks MPTCP_INFO. A new mptcp_join.sh group (-n) runs two cases:
> 
> - a failed connect without early fallback must not poison the retry
> - after a blackhole-driven early fallback plus a failed connect,
>   clearing blackhole_timeout, the same fd must complete MP_CAPABLE
>   again

Thank you for this test, but we cannot accept this: it is good to have a
test linked to a fix or a feature, but it has to be maintainable. If
each fix/feature adds 300+ LoC, that's unmaintainable (or LLM become
mandatory for that, but that's not what we want: we still need to be
able to read the test).

Ideally:

- create a small packetdrill test instead, using the MPTCP version [1]

- not everything can be tested with packetdrill (even if it can also be
  extended) and adding code in the selftests is OK, but, if possible, it
  should reuse the existing tools and helpers

So in this case here: can you have a packetdrill test instead? It should
be possible, no? If not, can you only use 'mptcp_connect' and the
existing helpers from mptcp_join.sh?

Also, mptcp_join.sh is to validate cases with multiple subflows. I don't
think you need that, right?

[1] https://github.com/multipath-tcp/packetdrill/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


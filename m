Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CAA1CBA02
	for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928328; cv=none; b=XFKNV+moP/hgOBQIxPuwL5RXXSa2l448HDK0fL0Byhc7cUQE0BOo2f50x3KbcKuzO/zsnS6LXOa9q/OzELNBUBKVbqaomEvgu4Hud1eZ9lteMiM0XH/jwfMK3+19QvpNJh3vxsjrAEdfKSWaq9NLVTDjBMnTSjxoP/yYDhE/QbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928328; c=relaxed/simple;
	bh=KEpYyQkhtn02REDVk45UG+zcBVA+tx4GOdkfcbnJBlk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gOniuYmet4/rZMGAYmZXlV68CLn021gk+kzdAm6nwuP4U/IbaqMgpgrTdK9ONYYCTXJZIDLuS9MViDIeSzgPheZzqsnrkvGH7qkTv/TuqMKzPVRF/l0EJiSOrMYc+SeVrQ/HXobDgZa/wMjjGCr4NReW+f7H0mQXMhRP218I7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A6oP/BS4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A6oP/BS4"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742928323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KEpYyQkhtn02REDVk45UG+zcBVA+tx4GOdkfcbnJBlk=;
	b=A6oP/BS477BtR/JAts6zR7b9e+3Ac2KXT6VPmEgqG7QiDqdLJsSAjU8RIOVuQpBc4lGnIr
	F5FVHEh+DG9/u1U5utOgVZei254+hzRShKw7vzHZRaHRterKIwIi95U2mY/p5dFb42kZ89
	9q0IIjZ+a9xjid9S/1bdQNHV56s2wkg=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] mptcp: pm: Return local variable instead of freed
 pointer
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <e47b3661-7cc6-4d3f-8174-e3866f6462ec@kernel.org>
Date: Tue, 25 Mar 2025 19:45:10 +0100
Cc: mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C6930CC-2B90-4331-9086-CF02BE86780B@linux.dev>
References: <20250325163251.135510-2-thorsten.blum@linux.dev>
 <e47b3661-7cc6-4d3f-8174-e3866f6462ec@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 25. Mar 2025, at 19:28, Matthieu Baerts wrote:
>=20
> It looks like the CI had some issues to apply your patch [1]. Strange,
> it was fine for me to apply it with 'b4 shazam'. I manually sent it to
> the CI, I will wait for it to validate it before applying it.
>=20
> =
https://patchew.org/MPTCP/20250325163251.135510-2-thorsten.blum@linux.dev/=
logs/git/

I get a 404 Not Found when opening the link.

Weird, I made sure the patch applies to mptcp/export.

Thanks,
Thorsten


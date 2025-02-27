Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0F221F13
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694709; cv=none; b=NAp2IoEJEflMT7PKRaXQCyNhozDru+yZJZVZZ8Nvts/rGtwGE8mizQJDUP0+9O6JIwIzJ/FB+R1C00JNbdeZLOoJmhk7RGYeg8jDys7EbRyHIhhFlR6jO8fG1FpSn4ThcX+LlZugASs81bozsaoivBKJS5hY8pT8Uza8+qAKg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694709; c=relaxed/simple;
	bh=K/rn+d2RtnozAIBA4gEuJwh3DxQBvmyOFbJiqyXvXT8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XxhQ/jp+zBR7eWZWtmeov6d5DjB4MYOQ6QJaeUDfGuPkMtjqK+0vyDJmFIWv+00G/CbZe1CHFONjO5aGSkej16c+XsWXkgR/eDDspxmj5inOSgmmEnICJtsdSA7cJZg1QkM8XJUQUtxU+ZFn7Lvi10S1BZovw71uY92KwShX1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKOfkipZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKOfkipZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0135C4CEDD
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 22:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740694709;
	bh=K/rn+d2RtnozAIBA4gEuJwh3DxQBvmyOFbJiqyXvXT8=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=FKOfkipZ/IJWSayK6wema56Fetik4poXC1fY2AS+TWp8RgT48Zyr44oZ9u8jiM/zH
	 qD6EhYXHXz+2zxoTYwyxUp/NQ6L9W9Wmqpnc98vOW3x0W/n59YhzU6OC1hNgMtuKRG
	 x3XlIhJCRCf77jGybaTrIKliqipWVeHR2vYg9gEAwtvChV6r8gSIPD3kE4xVIyWz2k
	 YCwmV8bA6NPAAJ5Im3TOZZVMgA11BSHqbDIZZ4/uRIveL4T4EM9pGDUExezI2AC4aU
	 J7djXd9jnKCArsKiJ5SO9MhYpkCcFNVeO4Xr+TCSMANxx1TZ3AUKGsRplpk1AYjTUK
	 eYM8UX5c4va7A==
Date: Thu, 27 Feb 2025 23:18:23 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Message-ID: <a7f91862-a60a-4690-9ab4-670cbc220650@kernel.org>
In-Reply-To: <a4ec8328-ab85-afc7-1a85-1076e8a8c5e7@gmail.com>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org> <a4ec8328-ab85-afc7-1a85-1076e8a8c5e7@gmail.com>
Subject: Re: [PATCH mptcp-next 0/7] mptcp: pm: code reorganisation
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <a7f91862-a60a-4690-9ab4-670cbc220650@kernel.org>

Hello,

27 Feb 2025 21:39:01 MPTCP CI <wpasupplicant.patchew@gmail.com>:

> But sadly, our CI spotted some issues with it when trying to build it.
>
> You can find more details there:
>
> =C2=A0 https://github.com/multipath-tcp/mptcp_net-next/actions/runs/13575=
269560

One of the errors is a false positive one, just because the ignore list nee=
ds
to be adapted because two functions have been moved to another fine.

The other one is a small issue due to a last minute commit split, I can fix
that in a v2 or when applying the patches.

Cheers,
Matt

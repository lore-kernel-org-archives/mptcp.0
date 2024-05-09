Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7585653
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290994; cv=none; b=GtLldhqyz7NzeTF9mcfBNpJCPBlQmnH5N+wfLFgMCo0yW8nVOTJQrturaqPAwsgzqrGVL9Ido5TonvbdOVR9B55cu6ryX8GFcqTxuwoHdxLGRtAXSmJ3rUtCivlkaMzmFxwzOPzv3s4e91gHusOWmlVg2jSoM9Kj49b5HU3dpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290994; c=relaxed/simple;
	bh=1cr4Hhh0xgOCOz6kFB4T1GPISm5EHphEtvmaK7YqmFo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ln7magrd6doKL5V+ziOb4uhFMG0Cs12cnDLrhol7q+lS470l4C13p780jl0l2VQaisVBiqhHUfqwYSsBXvmIHWc51eQXRUqbQ7h9/ph16o+CGiFWL39xv2H7NQUzvTnrZa+2w2BN4MI2wN4RqZMjJto3BJBIcXMPtGlRuWfpW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhA53KfR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhA53KfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77D0C116B1;
	Thu,  9 May 2024 21:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715290993;
	bh=1cr4Hhh0xgOCOz6kFB4T1GPISm5EHphEtvmaK7YqmFo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KhA53KfRnFQLA5EULmcJ2rJldhOexVCTEpsZiJ7a/MrumaObrdjOZWBUSaaktopnT
	 XHodoKdFhDvy2B+JXMeoH4HvSpA1wk54PBJNYkr6maQHxFOCDd+UC9fxOrNjye2ghS
	 mmiQhycE05HtYMklxfG9QVymuMuP6TDdm9qZPVIkhEA1/j0RumKDsX7TDCkR7l3UjM
	 G3TPtwQOy5XQDsjc2XqswMeBJ71fbs2xyQLWRcTxvbp+t95OEwzkXhu1QIfUgiwXw0
	 fEsbJe3jWDfHCYMv8Kz8Ues5CArAQU3dMmioseSr5SajKWCQcLiYZYmn1B1J+njJR1
	 GzKJ80GGB40zg==
Date: Thu, 9 May 2024 23:43:10 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Message-ID: <77dc9ea1-02b2-45c3-9fb6-8b153285dcfa@kernel.org>
In-Reply-To: <5464ef10-4c64-17da-7cd3-c819af2fa837@kernel.org>
References: <5464ef10-4c64-17da-7cd3-c819af2fa837@kernel.org>
Subject: Re: MPTCP selftest failures on Fedora 40
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <77dc9ea1-02b2-45c3-9fb6-8b153285dcfa@kernel.org>

Hi Mat,

9 May 2024 22:17:11 Mat Martineau <martineau@kernel.org>:

>
> Just a heads-up, Fedora 40 shipped with a broken 'ss' command which causes MPTCP self test failures.
>
> In short, the "-i" flag is ignored by the 'ss' command. I've filed a Fedora bug:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=2279920

Thank you for the heads-up.

On Debian side, they ended up taking the fix, not the revert:

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/misc/ss.c?id=87d804ca0854b09c07872e9fd6036bf5d3e0cc85

https://salsa.debian.org/kernel-team/iproute2/-/commit/14cfd95e598ba712c9000a5212f57c8282223c19

Maybe better to suggest to take this fix instead of the revert?

Cheers,
Matt


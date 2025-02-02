Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809811EEE9
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738473220; cv=none; b=DPiOGBhGYAoLrTbR7jTC9iGy9B8UMu6TPGmnDWOLdFOm7rBJWx2Vah/2CKgXpgCeomN07/RCQo0Lda6boBdlgF/mw5ztde76noB4noZAdGhxaGKnLHgTo/KkluFUPnt0wgGs5jH4dhObFqVdJKysIGMeyCkI4JZrvM/7Cqs8qjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738473220; c=relaxed/simple;
	bh=kxLuLC5+Dv2DO58e6J4g2WnSVCzwYJ+a71U+Tx+/Yg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XajxqRx0XkOVUMoqv2xjuGl4PueOKbBPR4GPuHvguV+3hXGlYnAc02MwR2M4aCpFayIGeGTXP+3oxJbjHDHddmBrgQQLjj+qSXH5jodeFu/YzjzyPBrAEyg2d0WA0bkP3B+pVSo0CqOOu60jiGkvZSBQm8MV/Ab7LSteR48zlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzzcBHaq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzzcBHaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04693C4CED1;
	Sun,  2 Feb 2025 05:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738473219;
	bh=kxLuLC5+Dv2DO58e6J4g2WnSVCzwYJ+a71U+Tx+/Yg8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UzzcBHaqGFPslXsImUEISCVjaS22bIAuChQhUynV6XVDxVMONPhGHWgXjXiiu0mIE
	 Wpx+Ngd18qHRVjg80rwanhHcKmukryGGiCCLtQ5sSz2rt0ncJ3O7Tg1IJ1bvXh4kZH
	 yJYk/P5q3mQ9gWGCtwm/X5UTUWQv2wHvWFyqod0jo7/aMkCXmukAEarTTUiz0i7D8v
	 CBkKOTSpc3tfLckvxQvZ15vtUkt05fHzIY1hQYtaWY6ht++punlJ73wkC44BJvJAHK
	 f6eNTFUqDtK1sg5Ni8XIZli2Fhil0XfIKlEs9cbsa/s2iQgeJr+CUEP172KArQOuW6
	 rotcH7NdI+yOw==
Message-ID: <b6d67da98dc974ba28a26451d78e2faab6e672cb.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 3/3] Squash to "selftests/bpf: Add
 mptcp_subflow bpf_iter subtest"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 02 Feb 2025 13:13:37 +0800
In-Reply-To: <c42f4e70-fd6e-499e-a8b7-9f7cb1e57b91@kernel.org>
References: <cover.1737714424.git.tanggeliang@kylinos.cn>
	 <19d3e15f4f32c29c4c3ba5049b123f96ac0fde5c.1737714424.git.tanggeliang@kylinos.cn>
	 <c42f4e70-fd6e-499e-a8b7-9f7cb1e57b91@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2025-01-24 at 17:10 +0100, Matthieu Baerts wrote:
> On 24/01/2025 11:28, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Drop bpf_mptcp_sock_acquire/release.
> 
> It might be good to share a link to the WIP commits/patches to Martin
> (and us) to better understand how it is going to be used.
> 
> Maybe a link to a git repo containing commits from the series "use
> bpf_iter in bpf schedulers" where the squash-to commits have been
> squashed?

Sure, I'll do this.

I think it would be better to directly send these patches to BPF
maintainers as RFC ones for more suggestions. Since the last time I
sent the link to Martin, he didn't have time to read these patches.

Thanks,
-Geliang

> 
> Cheers,
> Matt


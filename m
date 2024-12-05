Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55666193
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383737; cv=none; b=P9TrJ1ZHWyIwBricT2Tqf/d7BRjhD1aPeqCo9NhdbrmqcOSzwA7uVNOECzBsE354CyMxITqha9/w+EVzzeAO1vsyhl5VlitWcV2bSIivWvJWiYapw0Jb8JDaIpFctSmCg+u+0PjWVJv3HEvF6bJm9bJo2fyadEfIoPWIg7rDeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383737; c=relaxed/simple;
	bh=9only1/1hB4Z3/JnPlc6lWgpaY9NQxn/1egsbJK7hHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E+wIZY0hVbp1O6Pgdq26oE5NbnD3Byw+TNHp6WpRovzSjfSOZoZ2Jx/j4c+1QH4rAxydg/bkfy2RWpUFmTbo8aiH+NxhFwyU9cctMnvMzpB5ZSA3wxUPVuHIakYHbn/FOmGIjVKiqdxEo8GigU383ITxLF6+Cr3+RhWLOsxZYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twBEHVw9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twBEHVw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AF0C4CEE0;
	Thu,  5 Dec 2024 07:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733383737;
	bh=9only1/1hB4Z3/JnPlc6lWgpaY9NQxn/1egsbJK7hHA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=twBEHVw9JFxSeWXno6D/LOObzFSjdFWcHbU1Mz7k8oMoPmqTn0PAGTcFmf6Wawh8N
	 DcxAsn5VZI4aZma5E+0jx2F5r9HsnopjqGK8WsWFwHMfT+Io6Hfl3v/HzXRusW8TBa
	 wr/ooni6KP2QUFBD6gzeTHfQ8NtKomuOQwbYgbgJR9Wr0C5H/gF1zbaViEIvz/eKnQ
	 ikWc3vW02PRwXJVGkgOAm8v1yRErsdudG/9D6mGlxVLMp/qjGEfJxM3WHBigCxPdM+
	 hVOZWIlMLbaN9rML87BOzzHt5dou80m412/NreqkkPjmh2Mrja8/SW4GeSbixVQaI9
	 2+8dfM5xcXMwA==
Message-ID: <58bbf5825b1e26e7bc111ed46a4795ec80772e57.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 7/9] mptcp: drop struct mptcp_pm_add_entry
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 05 Dec 2024 15:28:53 +0800
In-Reply-To: <7d33f358-4893-4e2d-bcdd-89403a8855de@kernel.org>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
	 <b881437711fb806cbe9aa7a0b2e36b5bb3cc1c84.1730961810.git.tanggeliang@kylinos.cn>
	 <7d33f358-4893-4e2d-bcdd-89403a8855de@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-12-04 at 18:49 +0100, Matthieu Baerts wrote:
> 
> 
> On 07/11/2024 07:45, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > There is no need to add a dedicated address entry type
> > "mptcp_pm_add_entry"
> > to represent ADD_ADDR addresses. Additional fields for ADD_ADDR
> > addresses
> > can be added into struct mptcp_pm_addr_entry directly. This makes
> > the path
> > manager code simpler.
> 
> To be honest, I don't know if the "union" simplifies stuff: we will
> need
> to make sure some fields are not overridden by mistake. Always a bit
> risky.
> 
> Do you need this to simplify another patch later on?

No one needs it, just a cleanup. I dropped it in v4.

> 
> > Here "union" can be used to merge struct mptcp_pm_addr_entry and
> > struct
> > mptcp_pm_add_entry into one. Then all mptcp_pm_add_entry can be
> > replaced by
> > mptcp_pm_addr_entry.
> > 
> > Although this increases the size of the structure even more, but
> > that's OK
> > to do so because it is not used in an array.
> Cheers,
> Matt


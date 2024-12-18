Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F951DFF7
	for <mptcp@lists.linux.dev>; Wed, 18 Dec 2024 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484319; cv=none; b=dk1YMJ+lIuM+9Bsh8gBQzaFS1Zp90/A5TDIFaeSy/RIzWYQf0/qlOPPzllP3qD1YvUFtqRBv0OJfbhlWql88psNXXLD7jM6M1/qPfRVqh8cU0w24URw3tp1cwT/vYeQVdzvzG2Kq8IyD8LFyFfMm3I+SZZ5UPgAZh6Ur3qwWGSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484319; c=relaxed/simple;
	bh=1PwRzR1vykKkIGTYQGDHeMFYl+rAivYW3FYo2p/nEuw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djzpCKXksLqyz6KkL4gGV98FLDAqyH1KnfLINxhakvwTBDgUxPxFYzb6HhIvi7KeYayZTd+bzXeR/T36zH+4/z8vf1JVap/sESDnO46OKrCSbu1x1vesJWwj7qBcq6oWs6O27p3tkEIUiAEg7GXp2KgT93w1wBj5eb6ziMv7Omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGzF9zed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGzF9zed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E980C4CED3;
	Wed, 18 Dec 2024 01:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734484319;
	bh=1PwRzR1vykKkIGTYQGDHeMFYl+rAivYW3FYo2p/nEuw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=aGzF9zedv4Nnx8SDkQ+SPp3V7et7RzNm+BftMFHG8wFmB+v9+gSIB+E6Zx3Yb1A9X
	 j1AboIwpy6LyeMCtzMkEsg6nGP4y0pULTGrDkxwnxuWYVI4JVuFqpfvDpcZi1vK8Q6
	 y1OC241g8PInszEAy9VUOLKNcQ8m3ut7Ecpmlq86ON1Ndj8d8FoQhDs9y9jWy0948N
	 hwuTyaJFUrpyPSRWSa9NrBTSWej3mAVtrCN7sTf2Np3c92d1yQ3Citzx0bOmnB9LPO
	 D7d8iZYaDkpNUnGKobk/n0mBWGgx+VpYAdPavEDbKHJ3ZPJGqF1tRX2XlWxbkG9CyD
	 pgiJFHTYyJrqA==
Message-ID: <9f5b171f1aeb9af65dc1217f4dca7add8540ed7c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/3] netlink: specs: mptcp: events: missing
 and clearer attr
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 18 Dec 2024 09:11:56 +0800
In-Reply-To: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
References: 
	<20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Mon, 2024-12-16 at 11:39 +0100, Matthieu Baerts (NGI0) wrote:
> Three small fixes for the documentation:
> 
> - The 'server-side' attribute was missing for two events
> 
> - Attributes were written at the beginning, but without explaining
> what
>   they were.
> 
> - Replace two "todo".
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - Patch 2: shorter prefix: "Attributes:" instead of "The defined
>   attributes are"
> - Patch 3: new patch
> - Link to v1:
> https://lore.kernel.org/r/20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (3):
>       netlink: specs: mptcp: add missing 'server-side' attr
>       netlink: specs: mptcp: clearly mention attributes
>       netlink: specs: mptcp: fix missing doc

Thanks Matt, this set looks good to me. Please update patch 3 when
applying it.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> 
>  Documentation/netlink/specs/mptcp_pm.yaml | 52 ++++++++++++++++-----
> ----------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> ---
> base-commit: abd143d0ceebde7465127242f5eeef1e9ea4e253
> change-id: 20241213-mptcp-pm-nl-spec-doc-attr-663cc79843cf
> 
> Best regards,


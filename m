Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC037756C;
	Wed, 13 May 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635769; cv=none; b=VaVpVrZgd23N+NabAasfxddKpZ3mLygphinEO+i5pI0AprYdiV/I4d/DpLlU+S2e3tBtlxGdrWVgdpK4ZeWY9pVj5CProLkp7sKUasYxSn2H+mK62PDToWXpGPc2gRXSmb7pqwdsstiENqRVP8qKslR7rdoCsZQXQsep3HhhUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635769; c=relaxed/simple;
	bh=UI60qE0xrssiwXQX/k9lqGBdzhvN8cNyoClGMjrfOxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEPxYhm8ZEyOkNEGLJ4H3G4sWora9bKH/mApyMxE3OmoyQ8ezUKYDCITmTn3Hhgsv4UL0l1B2C+QCNRoWvsfekA+O3eBpe46A3psrH1ixVcNDLJwiKkPFcAgk3/doaUaAqF3e1Op53OKhPbwJYpTZffZJLG5B5Dl81JWWJv/td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPubm+Qa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPubm+Qa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F95C2BCB0;
	Wed, 13 May 2026 01:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778635766;
	bh=UI60qE0xrssiwXQX/k9lqGBdzhvN8cNyoClGMjrfOxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPubm+Qa+ETRSx4xpk3PAsAhzl9n82ikv4pYFrnCd8epEV76U0+DZLyBcPHMYMPvz
	 ncqdcH9w9DokMX9BXZFP08pRXcQ+jRlIF9CZ0pCSbphgUGuQFdj9BPvGNBMSJlZ7QE
	 UN3UH0DsP/Th7MT5K5rKkFQ6VvclqfhCLeLlV1sXHVP5fNcNHJIParVZ2zTym191pi
	 Lu7WkOQogABoMmunIf54kx5mwrCEid/5LyneC48DoULQrYANZmVT5osbiQvvqPuL3k
	 1q2skli8kp1u4pqfF63H4H4aXBX4Ef8/bOHRQfsWARdvUoWs/au6mGahkmHTdcQTqJ
	 wmGMvQJusmh7Q==
Date: Tue, 12 May 2026 18:29:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 5/5] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Message-ID: <20260512182925.4b4b9082@kernel.org>
In-Reply-To: <20260512182611.7bfbebe5@kernel.org>
References: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
	<20260511-net-mptcp-misc-fixes-7-1-rc4-v1-5-5ee57cb2b7eb@kernel.org>
	<03ad4927-6bde-45c4-a90c-92ecfa0a680f@kernel.org>
	<20260512182611.7bfbebe5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 18:26:11 -0700 Jakub Kicinski wrote:
> On Tue, 12 May 2026 15:02:20 +0200 Matthieu Baerts wrote:
> > Arf, I missed that when reviewing this patch: the 'inline' keyword
> > should be dropped here.  
> 
> I'll drop when applying

Let me take that back, IDK why the Fixes tag points to the commit that
fixes the issue for TCP. I don't think that commit broke MPTCP did it?

Also there's a review in netdev's patchwork for patch 2.

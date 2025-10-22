Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AADF59
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127658; cv=none; b=VtVIcT0yizgNNl6r5rnxh5vhmRIAf6ljYyGM+HVzfabPFlM1Z5Gm7GCDaLnEveeqah3/tnPs2RWSDdJ62Gu0UNIPFQtASYBN7ixu1dwxndOzGKSwdfJqWdx+QzR8YlWTrm97injpTUSUPNjt6bd9fgXnoGmJI+g2hwwNSdaKsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127658; c=relaxed/simple;
	bh=BnQr51swnP7tzkYij/fAIRjQ59dnJR0EFS6gf8vY+wQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EIofva3mKqNag+xu3MrWxOtHY+IqvT9Fg4oI/46zH9M+VkIz8k9/xTt3XCijIoulh2EzPQlcHR5sxsFN5uRwkEESzidb+55+RS5kIGxWrJVXi5SWw2RynfcA+BoQoaKZ23Iv+E+d3Twynl2WA8Fox5nckJUy3DxHSd+OJuzNCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp9I9laQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp9I9laQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727D8C4CEF5;
	Wed, 22 Oct 2025 10:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761127658;
	bh=BnQr51swnP7tzkYij/fAIRjQ59dnJR0EFS6gf8vY+wQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mp9I9laQlCPjcLfI+9NP1EU68hFL//d123onCUf232ZFH8rCwq91GH9GlE32LBAXC
	 Lr3/aqWfefysA+hZ4HCxplheio/RGP7v1qhoQdAhy3Z5D4+zmU08O/ymBRBACp/WZP
	 YCfDpdmY7F82TGbesXw3AGJI/2/IJ4vHlLC5uURWllS5apXGtS/4PIuX/ZBqTkhe89
	 zaKBcUOllqWKN83/7XPcA/+gG9SbrDlwu/eOyBRmWH4nUNuzpM2iA/NLwmenCxYkLE
	 NB5oOsdvNEqpIFG0I82dpyllW4NaUP5B3eUYRwdnnJ8awJBl4aDdW0ET/wZL3RSv3N
	 I7r1y4qZF204Q==
Message-ID: <5676a1d0af9ee91eee8f90be2574ed297bd70272.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: restore zero window probe
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Date: Wed, 22 Oct 2025 18:07:34 +0800
In-Reply-To: <cover.1761118636.git.pabeni@redhat.com>
References: <cover.1761118636.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Wed, 2025-10-22 at 09:39 +0200, Paolo Abeni wrote:
> It turns out that the issue reported by Geliang on the pending
> backlog
> patches is actually on older one that the new code made more easy
> reproducible.
> 
> The first patch in the series addresses it[1], the 2nd one introduce
> new
> mibs to hopefully catch this problem sooned.
> 
> I have a pktdrill to validate this scenario. I'll share that soon.
> 
> @Geliang could you please validate the above in your testbed, on top
> of
> the backlog and splice patches?

Thanks very much. I've already started testing, and so far everything
is running smoothly. I'll let it run loop tests overnight and will have
the results by tomorrow morning. I'll provide you with feedback then.

Thanks,
-Geliang

> 
> [1] at least here, at least with the packet drill reproducer ;)
> ---
> v1 -> v2:
>   - drop unneeded delta in patch 1/2
> 
> Paolo Abeni (2):
>   mptcp: restore window probe
>   mptcp: zero window probe mib
> 
>  net/mptcp/mib.c      | 1 +
>  net/mptcp/mib.h      | 1 +
>  net/mptcp/protocol.c | 8 +++++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 


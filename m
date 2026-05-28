Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317913203B6;
	Thu, 28 May 2026 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004581; cv=none; b=S7XR/zalOalmPy84b5dUMH0tnfr3Qpy/g4HJywWSlumujuxgTn2jKKB4Wy354PbmCsRw/KwlvCuvO7uVXeSY6MH9NnyblTsZMWmNACYnX7n4SN609XLoFRkeYGkLTwIYrqNTbcr4/yPj50oOWUfM10E/z+HCn0RDWEtvFGbSUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004581; c=relaxed/simple;
	bh=Tv6rYG/Lpc0tSbuz5htUaHEa/zhzD84cr4C5frNAWvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xb+r6UnIlTVzteCWpwFr9z7ZnJElyMqz8Igj21VnjbQceM6GYa3OyNqQL+mPY/n2qBMWJ/z4dPzyJDFNU09EgnkOQ5P3t1ONtMHJwGORekcEH2U7/m7/V+PIOVmoGCEHXMdZ5iThPDV+jFD7IVxcEN8XaRHWaxGLPrixS4Xwb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg6M88GS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg6M88GS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57131F000E9;
	Thu, 28 May 2026 21:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780004579;
	bh=Tv6rYG/Lpc0tSbuz5htUaHEa/zhzD84cr4C5frNAWvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cg6M88GSwj78Xwr3uS43e+W0bDOs2gPg2Y+HDtkjR8SixyhHeSInIcFQ414Y2l8ZO
	 vPsi9TbTYFKV3tP+KzcRiNrYjV7jmiSAnpLPfBi5Xjam8PrW6H6t1GB+Q4moQwkXrN
	 kyaGW7Mr3HesmyRu4ZKv41+YfWmsL7ErQTZotMLWv2v5ZvSPohZQNlfpJZzrnYbrMB
	 6vTFGPuvGlTIn9qHp5H5YrxFitCY+VQpBBqJSz7ett7rzcwtatrQBH7Isma85Aacxu
	 n9XxUHDI9LBpiwur7a6vNHg25XxbiRj0jzesr4jggtGcQmZKo1cQZidLgxEr9bUdOx
	 Fs31XrOfNL1hg==
Date: Thu, 28 May 2026 14:42:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 0/3] selftests: mptcp: reduce bufferbloat and
 cleanup
Message-ID: <20260528144258.58bbc950@kernel.org>
In-Reply-To: <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
References: <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 22:11:33 +1000 Matthieu Baerts (NGI0) wrote:
> Bufferbloat is baaaad, even in our selftests: let's kill it (or at least
> reduce it). By doing that, the tests (seem to) have a more stable
> transfer, and are then less unstable. That's what patches 1-2 are doing,
> and they can be backported up to 5.10.

Could you explain a little more what this is actually fixing?
Does it give a huge increase in test stability?

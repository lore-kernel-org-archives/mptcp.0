Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5E3ED3A6
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200082; cv=none; b=UtUElkEL/riuo6mL7s4uEe9L9ZpQmSnGrcpxD7y+zuPMx2xFdT/33CrEOV+q9SWVXd+YTdsUTrErGh96Nn7Vk0ApKwMi4y9RmwCjwWX2yF1XPm+Ar0kPZpfzYyFg67r6uNDe5xxINNkqTgJXdKgR3HjFq7rB1DHdsB2lCuQit8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200082; c=relaxed/simple;
	bh=/F691C61Fe4LRiURqPA83cr4nL7SiwJfn9tZnVGn3kY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=N3QXa63d+NriA79Mc3J1LPvD3DzMyy/TVxg/yuthNa2fneyuNjOw4MriKoi2uTUuGAM0qL1mKYH5AR2SZfBiw6VFLUDtunB4ARF/sMBXnlQ3lg0nZdUp/HVGyslcXFx+gk/N0L35BHqMAWh0eZZeXug17JFCgbfgW3rTZICuuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inNFW/fy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inNFW/fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF2CC2BCB8;
	Tue, 19 May 2026 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200081;
	bh=/F691C61Fe4LRiURqPA83cr4nL7SiwJfn9tZnVGn3kY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=inNFW/fygmMs7T8OW3jHWNQSWm99r2p5fzFN35/Ke/PMfq4TBjx9CtXasz+7wAhbi
	 0g/LKLKWFQ4VK1P15P62xgpfCtEmk90XBLMTlF35CYMTlQA/tJ/UP3qhpZvWXnTPYz
	 rwxyf1I5Z6uGayOoud341IXF93rL1Ax0R1JcwnRWUCd+ZicuKC9nXS+z6INKZhk37z
	 TR5ehq265MoSD12QWNjIpqEOWuQA6ZNIeDuJ5Cq+l14JPvhskRlQQfspNI56KDncKa
	 hk9vcO0616XjME4nXPzvTJEi3rj/5+9rgKyxEnrrGUuekHLC8xg5EgucKU0UWkxvg3
	 JvfPn/tB9BGqg==
Date: Wed, 20 May 2026 00:14:33 +1000
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Message-ID: <d279a587-970f-471a-bfe7-6fdc1d42126f@kernel.org>
In-Reply-To: <463c1fe0ca198d7bcbd8446682181d421a24ed74.camel@kernel.org>
References: <cover.1779159524.git.tanggeliang@kylinos.cn> <463c1fe0ca198d7bcbd8446682181d421a24ed74.camel@kernel.org>
Subject: Re: [RFC mptcp-next v14 00/10] NVME over MPTCP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <d279a587-970f-471a-bfe7-6fdc1d42126f@kernel.org>

Hi Geliang,

19 May 2026 17:43:06 Geliang Tang <geliang@kernel.org>:

> Not sure why, but this version didn't trigger CI and sashiko. Could you
> help trigger them for me?

It looks like patchew is missing one patch:

https://patchew.org/MPTCP/cover.1779159524.git.tanggeliang@kylinos.cn/

Not sure why, I received it.

But sashiko did a review:

https://sashiko.dev/#/patchset/cover.1779159524.git.tanggeliang%40kylinos.cn

I can force the CI to run when I'm back on my computer, if you still need the CI.

> Sorry, the version has been iterated many times, since sashiko keeps
> complaining.

Are these complains often correct? If not, simply reply on the mailing list.
Or add a note in the commit message.

Cheers,
Matt

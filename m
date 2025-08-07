Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E633F3
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754545921; cv=none; b=pGjbTFRI94kDdewz9yzi3R4fcsUGtpObNL0DNfBoP3tm+llkAHI3BeXPKcIwwbbDErX3tHTsZc8vR9sAqbSK7I5Sb4PG+pLtNNY9bXgw7856fHYi4SypToBHP1+2sW1QRJTRWNhlIf5DUQ96yuTrsjpTi/ijm8rA6Qn4jkVXQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754545921; c=relaxed/simple;
	bh=oqTAEqay3aPTJuxdmmhgE7b3NvwybZDa4HbN35SwV7E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHfFhJK0vBXKfq23XP5yFinG+iI8bJ65sU9uMx3gC5Smtl81IbQzfGhWbY+4EiEX+WCxc+OzLcWzHVpAgwTopySS+HK2EQUagVS5SjFvQUEekSrnVqj5sTyfJIKeaEvSZKxIEKao6SNHCBwcWCo743TIyPPg1CyXKQcK3yEc9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5V9uFPD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5V9uFPD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447F5C4CEEB;
	Thu,  7 Aug 2025 05:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754545921;
	bh=oqTAEqay3aPTJuxdmmhgE7b3NvwybZDa4HbN35SwV7E=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=S5V9uFPDsy6CgELUSYrRH2P9SZWppnmGDn/r9bN0wQGVUTVOsYOLHEvrw5KftwrAL
	 pvNsz0YZX9z6yYgLypXenFCjTooeFZcEvWJsv9oLaYShgZ9By306AmBSZSzYCkww2J
	 66Iu+ZP3QlzY/ccs7v+UL9tEMAYoI1GmWJf3yEetfIFwMog/qWityJEr0PS5sHKGZZ
	 oOsza7x9suPpXg7GxjJF18wDjRw2N+8mycfFsDzmS8TncN0SJeUYkK5xwIAYicLfYM
	 J/dA8V9RgxRvBbYAbzkY8+yzllOFhI3nJhRA3XNg68mjuGCMa/RNuI1ApXmV6sbjLA
	 2NO4IFL43wnJw==
Message-ID: <2bac7c8d71386096c1e8b0c0a73b760e4e216268.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/3] mptcp: improve ADD_ADDR timeout
 handling
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, Geliang
 Tang	 <tanggeliang@kylinos.cn>
Date: Thu, 07 Aug 2025 13:51:50 +0800
In-Reply-To: <baa6c928-cd9a-4488-ad95-8161ac37816e@kernel.org>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
	 <c59fed78-9dee-af6e-c844-e450c7d0cd27@gmail.com>
	 <baa6c928-cd9a-4488-ad95-8161ac37816e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-08-06 at 17:36 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/08/2025 17:29, MPTCP CI wrote:
> > Hi Geliang,
> > 
> > Thank you for your modifications, that's great!
> > 
> > Our CI did some validations and here is its report:
> > 
> > - KVM Validation: normal: Unstable: 2 failed test(s):
> > packetdrill_add_addr selftest_mptcp_connect 🔴
> 
> Don't forget to update the packetdrill tests.
> 
> Also, if you are still using mptcp-upstream-virtme-docker, please
> make
> sure you are using a recent version where the tolerances are now only
> increased in debug mode.

Here it is:

https://github.com/multipath-tcp/packetdrill/pull/166

Thanks,
-Geliang

> 
> Cheers,
> Matt

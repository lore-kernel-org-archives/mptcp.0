Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A630F88;
	Wed, 11 Oct 2023 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVuEeJRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D97C433C8;
	Wed, 11 Oct 2023 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697041377;
	bh=L+z+TtDcCiFtqaagBTUm6XkUXnNHXrekg2OIPgiZcXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kVuEeJRI1gd5wh/U+7Ky1UVZRzfUOEzHsmYTvBY4kBBQmbScFQnBqENnpkKwTNNpx
	 KM1n6l+VmlwiQtm0bufmOzcXj6uLm1PFXj4RdpM5JHWrk18iN6RebIO703itEA2C9w
	 IH4QHmCD7QfrT13c5vyGeJhDunCJzo3roNSCjkA7X/lo2CFpxDeZDhC2++mNymECka
	 DsVDBa/OMnv2N+fLGvCtYFAkmJtpS7WRN4i6YEHdV0UUlaF8xwJR+emy+Hz7i0rmEW
	 R8NePblJv6srOC9FEwDBGEjUKR8zTPB0IllJM+PZ7ERi0RrCPgs72EgHCx6xx3g/+g
	 nZKJCXb3X3arw==
Date: Wed, 11 Oct 2023 09:22:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec
 for mptcp
Message-ID: <20231011092255.383ae6ed@kernel.org>
In-Reply-To: <CAKa-r6sT=WaTFqumYOEzOKWZoUi0KQ8EYpQ753+C5JjjsUb3wA@mail.gmail.com>
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
	<20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org>
	<20231010180839.0617d61d@kernel.org>
	<CAKa-r6sT=WaTFqumYOEzOKWZoUi0KQ8EYpQ753+C5JjjsUb3wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 12:13:04 +0200 Davide Caratti wrote:
> > Do you not want the exact length for this?
> > If YNL doesn't support something just LMK, we add stuff as needed..  
> 
> ohh yes, we had NLA_POLICY_EXACT_LEN before but ynl doesn't seem to
> support it. I can try to add the support and include another patch at
> the beginning of the series, is that ok?

Yes, definitely, thanks!

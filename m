Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B22CA6
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 01:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFE7C004DD;
	Tue,  7 Dec 2021 01:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1638839809;
	bh=HlSKShVsqFNo4kUKzbuArXbVoS/vnekwv8QlQi2g3/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UrC3sisHgOkB8SR4l7pVzftzBPjfkx6U0R4yXMqH2SmNr5ALopuTtzaTGdgvUyMgc
	 za9p/vp7GPVm4pTKwUq1Fe2HyhmNIcAvANqwblHZJeDfjopReBs7nHfLr1ErIEFKEM
	 R4qJWbOFWJI7gVq2Ytc/v3186LWvR6369BakdgFDtYodFniybSKQ5RzrhRz3TY0liM
	 7l6Fv2rpTHx2WTjlP6cWIZmRq4w0sVYIEUYhJA/JSsF0nlG9Va4AiLJXnHobzbAEAT
	 VLMCtVCqUIemQWg9PmSDYYnyBCrE3NH7sMBWzJ/wispo8hssXsMvUBFOveA7p6T6De
	 JKRG7gQTEh4AA==
Date: Mon, 6 Dec 2021 17:16:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
 davem@davemloft.net, matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 03/10] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
Message-ID: <20211206171648.4608911f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211203223541.69364-4-mathew.j.martineau@linux.intel.com>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
	<20211203223541.69364-4-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Dec 2021 14:35:34 -0800 Mat Martineau wrote:
> +		if (sk->sk_state == TCP_LISTEN)
> +			return -EINVAL;
> +
> +		lock_sock(sk);
> +		__mptcp_move_skbs(msk);
> +		answ = mptcp_inq_hint(sk);
> +		release_sock(sk);

The raciness is not harmful here?

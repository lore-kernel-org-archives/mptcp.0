Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832CEEBA
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202860; cv=none; b=Ie+ACXAzUG3peLSkYz+99kXHPN7BXU4IxgKxQDo/V3dDuc2sgFb0WXqI/XSf/bGkNTM4bhkN9/biiJOTNtRuTPrm7wOfEVUPy6X5Yr2k0LNjoGWvZO2UU2k3RSErJR+1KLxwfR2Lt6dMX8UiZJTzCUcvK5xifpR1xQY5Us9/48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202860; c=relaxed/simple;
	bh=lZem22/oSad8oqJ9xoTs50ypSYNZsGywcQx6qoLcK+M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fy3/PwvcTj13Fy8ogwbZKPCPimgeDUbDNYk3oM94UmvKZ2gMPqOqznheqpkyX9c7uga6ufgnC/geSeM4bRX3XiT9sv4zzvbRnFQ4ooqOINTd+BqcL5yYB6+VtdkDTcteovHQb8RZdq5CKSIWLaF+HsbBlRp+yOd67KjnkkStDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYAtvPt+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYAtvPt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239E3C4AF0E;
	Wed, 21 Aug 2024 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724202860;
	bh=lZem22/oSad8oqJ9xoTs50ypSYNZsGywcQx6qoLcK+M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dYAtvPt+fx40Tw2CZiyF4gn/xfqjMjIFgF184zZZZuGwMRTgslba9OtIIvWSGUeYi
	 3094hGnhQIbEpE7Icl/LaABK2ZdjDaTORUqHCu+DLE5y5Z7Az4aipD4oXgJC8ge9yG
	 XwVuqG1Rzld+eGAb3JLpOEIBLUf1olpoAndxjpsF4DelrQHnXobhiUJCoxGLdx5wEB
	 bd/l5R3TaR2WngVTP7JIeoJNbgR/gRz3DJTa1A91bLFtFmZK7GKOpdSfyGhEOnqkmG
	 t+wKRyRTgIaE3pt1YDYapt0btwa3vHJTXfldoH1nFAu43fik+VHsulCjjkMFePkPIr
	 ITLV79HKA+snw==
Date: Tue, 20 Aug 2024 18:14:19 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v7 3/3] mptcp: pm: send ACK on non stale
 subflows
In-Reply-To: <20240809-mptcp-pm-avail-v7-3-3d0916ba39b4@kernel.org>
Message-ID: <9778db63-daaf-ac0d-8c0f-5465f14b534f@kernel.org>
References: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org> <20240809-mptcp-pm-avail-v7-3-3d0916ba39b4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 9 Aug 2024, Matthieu Baerts (NGI0) wrote:

> If the subflow is considered as "staled", it is better to avoid it to
> send an ACK carrying an ADD_ADDR or RM_ADDR. Another subflow, if any,
> will then be selected.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - It sounds safer to do this modification in -next. I also wonder if
>    we should not add more check, e.g. not on backup flow except if
>    there are no other non-backup ones, or still pick a staled one if
>    there are no others, etc. But maybe we don't need to care for an
>    ACK? And we can always improve that later!

+1 for the -next tree.

I don't think fancier logic is called for, if all subflows are stale a 
single ACK on a backup subflow (if it happens to be first in the list) 
does not seem like a problem. If all were stale, for reliability it 
might make sense to send the ACK on all subflows! For this corner case, I 
think the current patch is sufficient.


- Mat

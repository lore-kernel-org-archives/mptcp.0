Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206718DF93
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865143; cv=none; b=b4XEH5dZ+6d6irBQhBdyst5WmduBdFhcyVq0S8Cim8WU3yZG0jrLBtkuL7PpKwxtlOmvqHPg5x1pefkn54N6hWce9hnhwenLIO8w19W3uRD/iw3AC0Xyc4moCNSlzawBjWfuiOptlj2nA6Ie/+3a/izzJWuQXoRPvd8xvHNv3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865143; c=relaxed/simple;
	bh=7YE+lKT4L46PML3BsPMdJNw02S1eXvlCii+lTWXS8vU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2SH95P017vkxq20ugub0s2i0la+2ysdchOkuXG0vFQeVPPgVA6S4NszqyP4APUa13MQaQed+3GvncSIAvpEVxBhpPhgd+jVe55qs37Acaee2QcjRgt0CSJzlPvD6eIPFAjKR7eA4M4zvS4q1wPAYfifUPLvGYKZ/D00v6faAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj6EWTkC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj6EWTkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74029C4CECD;
	Wed,  6 Nov 2024 03:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730865142;
	bh=7YE+lKT4L46PML3BsPMdJNw02S1eXvlCii+lTWXS8vU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Gj6EWTkCqL0ad21J1gVA8e/8/t8oyu/ElbPJlnJHXW7QTbNlRWjiG+gK9+Oui/49h
	 LVYFrL9FqS21oTiEjHluQ+41uMoOMCHgPakez2AqtADuRCYywU7JGexsGAahg0CzWL
	 RznhXCGOsyXYC/oRwMtRbSY+jQbzn4m80PwGMp+baAE9teRzq0/QliNU4c7YS7HEOB
	 oZ/4/uNH7gvBGe659dH5udPdolfDHvDyNdQHAgCW5M7dtSYs1a/Ooyqqy2NHqGPCpz
	 5FmlWiVv+3Gai32Y/eOgO6RJQM6TKDBxrRQJU76DlahKlnLOaXEempLgLuIA/tpt+8
	 wovyOKKCvP3gA==
Message-ID: <809731d55c0df18e07a1847d7638a10c66c1d264.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 0/4] add netns helpers
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 06 Nov 2024 11:52:18 +0800
In-Reply-To: <5952d268-5c4d-4623-b91c-44e6db4395a6@kernel.org>
References: <cover.1730260715.git.tanggeliang@kylinos.cn>
	 <5952d268-5c4d-4623-b91c-44e6db4395a6@kernel.org>
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

Hi Matt,

On Wed, 2024-10-30 at 18:34 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/10/2024 05:03, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v4:
> >  - Use netns_new/netns_free instead of create_netns/cleanup_netns
> > as
> > Martin suggested.
> > 
> > The commit 1e115a58be0ff ("selftests/bpf: netns_new() and
> > netns_free()
> > helpers.") now in bpf-next makes v2 of this set useless. v3 only
> > uses
> > these new helpers in mptcp selftests and drops other patches.
> 
> Thank you for the modifications! The new version looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> If that's OK, I will wait for a review from the BPF maintainers
> before
> applying these patches in our repo, not to do too many manipulations
> just in case an (unexpected) new version is required.

Patch 1 has been merged into bpf-next/net by Martin today. Please apply
this set in our repo too. After this, the "add mptcp_subflow bpf_iter"
series in our repo is ready to be sent to upstream.

Thanks,
-Geliang

> 
> Cheers,
> Matt


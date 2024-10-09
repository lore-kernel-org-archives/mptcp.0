Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662A19005F
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469475; cv=none; b=Ft4JOk+2V8yRgDoFxrc9hgtdlpZkQDSN56FgkrVVaLcijPK4gap/Y8B0DT+Zhhqv+HlMe7c3u4VXAIAk8nEgTqoK4ZWzlVqaWuijwQejUry8bBUZZEwrTwPcXwk4k/nXNoFXSVff+6stYkaMvIe/TW3j1toG/cVpvXdMqCv6XHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469475; c=relaxed/simple;
	bh=YzrNUwdnkzEdtCyxI1nl3vfUvOBvGN+OSLv6huTafC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nWCRrvppydsy2YwJjbRDPTfJcxIGzapp9kBmil+ynHcX/tMqtSsV4W6TeAzhbeSrByek/aBUimaFgS7S1sFtBpoM7RXjJPigO5Cy8FS9kzPO88NJRIU87DBVkRHh3QaUqNbRD4dLn7ZSM9+WXvNIGemif/x2nxS2Lacb2mvofA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Niwc3Hw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Niwc3Hw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880C9C4CEC5;
	Wed,  9 Oct 2024 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469474;
	bh=YzrNUwdnkzEdtCyxI1nl3vfUvOBvGN+OSLv6huTafC0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Niwc3Hw5cFK8/MKXRVE6pixa9EglBOZW5ZVWO0/FsJk25x+gIFRDps+7CNLGpUkLf
	 4wGx7DF0zZTLWSM1p238nwej4n+khORGp3o83pi8jl2PQ7rpo/OKPUSa+/X9yTHwNH
	 rr0lQ0zVIgwyiy5eIhc6+Y9LcJeYZM/Jla3HTW/6acAbkuXeGc1AGd65PJlxn9Kfd8
	 vSjHuQN1nR6AnJvXsdn6n9ho+d3Z/fGe9oByBLiznz5IAAGi5h94PdcsRr4B7Ayf1j
	 HA4eMwhhqoT894JPj8wpkM1ue6SxmI0yAaiMHfzk8opiLK4yGFigjPv9KLZAsRDIaR
	 iwTb0CfEuHkiw==
Message-ID: <b5dd06d255ad9be502f4bb1bdf310fcebe47aa38.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/13] refactor PM interfaces
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 09 Oct 2024 18:24:30 +0800
In-Reply-To: <60e02d26d9b5dd133bc51ef005a9deabfbeb2d79.camel@kernel.org>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
	 <60e02d26d9b5dd133bc51ef005a9deabfbeb2d79.camel@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-10-09 at 17:59 +0800, Geliang Tang wrote:
> On Tue, 2024-10-08 at 17:58 +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v2:
> >  - split patch 5 into two.
> >  - new patches 9-13.
> > 
> > In order to implement BPF path manager, this set refactors get_addr
> > and dump_addr interfaces of PM.
> > 
> > Depends on:
> >  - cleanups for PM interfaces, v3
> 
> Based-on: <1728298100.git.tanggeliang@kylinos.cn>

Based-on: <cover.1728298100.git.tanggeliang@kylinos.cn>

> 
> > 
> > Geliang Tang (13):
> >   mptcp: add id parameter for get_addr
> >   mptcp: add addr parameter for get_addr
> >   mptcp: reuse sending nlmsg code in get_addr
> >   mptcp: change info of get_addr as const
> >   mptcp: refactor dump_addr with id bitmap
> >   mptcp: refactor dump_addr with get_addr
> >   mptcp: reuse sending nlmsg code in dump_addr
> >   mptcp: add loc and rem for set_flags
> >   mptcp: update address type of get_local_id
> >   mptcp: change is_backup interfaces as get_flags
> >   mptcp: hold pm lock when deleting entry
> >   mptcp: rename mptcp_pm_remove_addrs
> >   mptcp: drop free_list for deleting entries
> > 
> >  net/mptcp/pm.c           |  17 +++-
> >  net/mptcp/pm_netlink.c   | 197 ++++++++++++++++++++++-------------
> > --
> > --
> >  net/mptcp/pm_userspace.c | 161 ++++++++++----------------------
> >  net/mptcp/protocol.h     |  22 +++--
> >  4 files changed, 185 insertions(+), 212 deletions(-)
> > 
> 
> 


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04BE17F37B
	for <mptcp@lists.linux.dev>; Tue, 14 May 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701074; cv=none; b=O0RLMHnrRpXwXRFy0Kj3aAGOSBSfuPZJlwq4eBRd9eHuHBHdhKOcGycTCHXqjYPqJXMtSOg77mvTVp6aCMmo08KcJkmcJh6L4xFj/VlLL6nu75QFvmboqNRG6oyeiZ4j+L/C3mR4RpwC/Qx9R0bQhrmsrL/tmbpXFRrxi0z9uGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701074; c=relaxed/simple;
	bh=tCrqy7ZeoGTOOUBzJtAnmyJU5dRShApi0Vk2WtwTdBc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o3YKA50CM7dRK8pODA2UhZR+lR4CKAVJ+eYD/WTYZC+KCeFopB6kgT1cRvJyBdSGrEhTGX+a7kYU3KSuMjbN8+P2WI+n9mbWbambQGPIG0138kLOQTGZnVmU3ybQM5CcOOjhAsk11e5XH9fAeXCYA2UFUyjQvs/XfWEnkPTL9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3dFgvHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3dFgvHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32471C2BD10;
	Tue, 14 May 2024 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715701074;
	bh=tCrqy7ZeoGTOOUBzJtAnmyJU5dRShApi0Vk2WtwTdBc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=t3dFgvHPFoE80saF6L8YGzKLJ0T926klquKOGCYweTdE3b7fPyS7GHJ8ttgr3d5bH
	 gAaXA03H7bscwVTdo0+Ld0ZLFv6OIUqwABxAhEab3Sz8RnVOXQggTp0nN7qKJ0CBAJ
	 gu0S/E96MucDO6c79aV7X+ShiORJbNZ1fvONpUDuJf1vnE/t66qoxq87sD2aIUYxGD
	 Bw68a87JFlDlt/lQnRMyAI2NmE8E4he4Gsl/Z8XkgmNQji100hsMuzBZWsKPk+YHkG
	 3Lna2MkDIHcXinBGOz70xe0QAbm97bp4pGaJfppN+0NMmOCHNDLYIOhpvndk2mzTqD
	 cTeBbWK//ONiw==
Date: Tue, 14 May 2024 08:37:06 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] convert helpers for win and space
In-Reply-To: <cover.1715416511.git.tanggeliang@kylinos.cn>
Message-ID: <1f838c2b-e265-3a68-9d79-833a377da43b@kernel.org>
References: <cover.1715416511.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 11 May 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Paired with mptcp_win_from_space(), added an mptcp_space_from_win() helper,
> use them in mptcp_rcv_space_adjust() and mptcp_set_rcvlowat().
>
> Geliang Tang (2):
>  mptcp: use mptcp_win_from_space helper
>  mptcp: add mptcp_space_from_win helper
>
> net/mptcp/protocol.c | 4 ++--
> net/mptcp/protocol.h | 5 +++++
> net/mptcp/sockopt.c  | 2 +-
> 3 files changed, 8 insertions(+), 3 deletions(-)
>

Series LGTM, thanks Geliang!


Reviewed-by: Mat Martineau <martineau@kernel.org>

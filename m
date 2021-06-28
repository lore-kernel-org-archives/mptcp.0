Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4901C177
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 20:10:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 4C23561CC7;
	Mon, 28 Jun 2021 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1624911005;
	bh=tlDEp28ND5UAGXHGJOa+/XW57qA85/PNnwUUKeMzxaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oE16RwWRxh7bx7ZwyOV7BCjtd1TgQqSMLr3dxeM945E4HncFD5J/fs086mVdczTp9
	 H+i0BOX5NmxklpY8wFl/uyughRQ1rf6aQTCsH1j1getIdmhsbsXvQZKZ6wXx96/MPF
	 IxLBidVGY4i0HFJoBGLMLvsZ0YyK3xReOS1oyr7P8VfevV1v86Z7d15PWbvgLv4SuG
	 tnS8o7DiLJILi8RmO39Hg/KM3j2QqTYj6ImgMXtudD495qQK5d6qCIiAvI1v0K8jnB
	 gA6faZce3HkWcUtDPT5W3+w0U71cSGFgb1TIGKX7jOjwinr2uG3Bj8bRd8h7H3XhgG
	 O74KZs8MpDQNQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4688260D02;
	Mon, 28 Jun 2021 20:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: fix 'masking a bool' warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162491100528.2562.743940781000501523.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jun 2021 20:10:05 +0000
References: <20210625212522.264000-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210625212522.264000-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, matthieu.baerts@tessares.net, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mptcp@lists.linux.dev,
 dan.carpenter@oracle.com

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri, 25 Jun 2021 14:25:22 -0700 you wrote:
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Dan Carpenter reported an issue introduced in
> commit fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf") where a new
> boolean (ack_pending) is masked with 0x9.
> 
> This is not the intention to ignore values by using a boolean. This
> variable should not have a 'bool' type: we should keep the 'u8' to allow
> this comparison.
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: fix 'masking a bool' warning
    https://git.kernel.org/netdev/net-next/c/c4512c63b119

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



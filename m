Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6B168
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 16:40:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 9502C6128E;
	Tue, 13 Jul 2021 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1626194403;
	bh=DgebdvLjqE0RN6YbiHJD8f6gPMTe/vpQYXAV3mWqAeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o9g9y5k8BWyexBWlAlBw+o/OTC10fjEfZuFF35eHJAGkc7We3ZZysecgwAN1taKk4
	 0hZGNbJQisiLLZZnN6YYANCSpaOg9P+L5o499TJqvvCgZKe6LsRsBZNmGnMeGvaTXu
	 t23MKygot+/chMiv12he1SX2NjSVRCzrbQqCQWRJj6YadT8nlQxlDw1byHDqx+ZZEi
	 lKwGHwPaRVpIAKis0V+UZygRSw6fMug/aHhXDWD7Y5KBTdftdIxUvBwbTb59CBr5k9
	 kOYof7XFoSfHly7VghpaKjeIZf9CMmoTUApu5FX/FiaJzY+h9x1ST7abRmjxGsyCBA
	 JwDGZ6w41063Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 89F4860CE4;
	Tue, 13 Jul 2021 16:40:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: Use nlmsg_unicast() instead of netlink_unicast()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162619440355.1289.14646732123262264150.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jul 2021 16:40:03 +0000
References: <20210713024824.14359-1-yajun.deng@linux.dev>
In-Reply-To: <20210713024824.14359-1-yajun.deng@linux.dev>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
 kuba@kernel.org, mathew.j.martineau@linux.intel.com,
 matthieu.baerts@tessares.net, pablo@netfilter.org, kadlec@netfilter.org,
 fw@strlen.de, vyasevich@gmail.com, nhorman@tuxdriver.com,
 marcelo.leitner@gmail.com, johannes.berg@intel.com, ast@kernel.org,
 yhs@fb.com, 0x7f454c46@gmail.com, aahringo@redhat.com, rdunlap@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-sctp@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue, 13 Jul 2021 10:48:24 +0800 you wrote:
> It has 'if (err >0 )' statement in nlmsg_unicast(), so use nlmsg_unicast()
> instead of netlink_unicast(), this looks more concise.
> 
> v2: remove the change in netfilter.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> 
> [...]

Here is the summary with links:
  - [v2] net: Use nlmsg_unicast() instead of netlink_unicast()
    https://git.kernel.org/netdev/net/c/01757f536ac8

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



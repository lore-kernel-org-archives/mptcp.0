Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA73FC8
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 10:00:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 98000610CF;
	Fri, 24 Sep 2021 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1632477607;
	bh=gUxJcpu1rnGRxe3SNb2x9mWZ3EnqhsShJKrhT43DLGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EsxXjBXOLhBgtpLfWfWWqvBZxpUiiOhrV7gB8Bkf+nZnrE7dLER0lrW0Oy/DT+stl
	 6e6jcNypj+iP9bqTnqcbzXFD7vuTSPzfFQeuA5m/odX3madgqfDOo3LSITEKUzRu6e
	 PQ19leLbHZnDK1Wj1QAISV7PDo6vt5JRGhX35UtjKoAY1wY6vUyiH8ow7T53oWTLbo
	 TybFqBp9cwDv1Lkrzj3tRc/hJ1fWfKPzPpwaPCp9skfRZl+Hh71AfiqWm7Gd0KXVtb
	 NLaF/NHGS6wKGEXuCiQAz7dMAR2WZTHCFvTQAKxfJcPVwCp9UYRB2Ufkh4TS69dLhQ
	 jGTOOf80PI+eg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8B98A60AA4;
	Fri, 24 Sep 2021 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163247760756.4339.13788840891692093277.git-patchwork-notify@kernel.org>
Date: Fri, 24 Sep 2021 10:00:07 +0000
References: <20210924000413.89902-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210924000413.89902-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev, fw@strlen.de,
 dcaratti@redhat.com, pabeni@redhat.com, geliangtang@gmail.com

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Thu, 23 Sep 2021 17:04:10 -0700 you wrote:
> This patch set includes two separate fixes for the net tree:
> 
> Patch 1 makes sure that MPTCP token searches are always limited to the
> appropriate net namespace.
> 
> Patch 2 allows userspace to always change the backup settings for
> configured endpoints even if those endpoints are not currently in use.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: don't return sockets in foreign netns
    https://git.kernel.org/netdev/net/c/ea1300b9df7c
  - [net,2/2] mptcp: allow changing the 'backup' bit when no sockets are open
    https://git.kernel.org/netdev/net/c/3f4a08909e2c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



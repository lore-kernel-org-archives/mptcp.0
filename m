Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBF3FC1
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 23:10:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 47CD2610A2;
	Wed,  1 Sep 2021 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1630537806;
	bh=7F5Y7Wj+bVjMPVASQ3WvRLKuZIbZFW5k3jZsWslAfVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bC33ll/cE9QCmcc4D0zotiDxUF+XStHQ7MaTR/HgxdwnoyStkZY+sRriDX8du0ByB
	 EAAXR2KvKzrOUh94ov5uSF6v3l88IJKuqSEsKExEWt6D/w/GReLQ7YFSOg8BGdzxwV
	 xKyAqfQF3Q9LyC6RNyPa2P4R3h+TLklC4xNeAs0k8Sh4kflitJbtQfamOkYxlO7zGo
	 lXU4s9rvq8M7CC4NghYAw8mVRsI/FIiHd8lFd7dUuWGH7jiUbIx9etTd/V2vK0hqPq
	 mLnplH3XTFe86YQR8u6T9TYWZSQeYDn63LRXOhS83Y3j/RjAmrU0eatqSWMGM6cYhb
	 25HWAKg35VFww==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 39DA860173;
	Wed,  1 Sep 2021 23:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] mptcp: Prevent tcp_push() crash and selftest temp
 file buildup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163053780623.19243.8685961450090874953.git-patchwork-notify@kernel.org>
Date: Wed, 01 Sep 2021 23:10:06 +0000
References: <20210901171537.121255-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210901171537.121255-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Wed,  1 Sep 2021 10:15:35 -0700 you wrote:
> These are two fixes for the net tree, addressing separate issues.
> 
> Patch 1 addresses a divide-by-zero crash seen in syzkaller and also
> reported by a user on the netdev list. This changes MPTCP code so
> tcp_push() cannot be called with an invalid (0) mss_now value.
> 
> Patch 2 fixes a selftest temp file cleanup issue that consumes excessive
> disk space when running repeated tests.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] mptcp: fix possible divide by zero
    https://git.kernel.org/netdev/net/c/1094c6fe7280
  - [net,v3,2/2] selftests: mptcp: clean tmp files in simult_flows
    https://git.kernel.org/netdev/net/c/bfd862a7e931

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



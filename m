Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48C71
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 21:50:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 769AF611C1;
	Mon, 21 Jun 2021 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1624312204;
	bh=xwBL3uq+6uBXVO1fM9uFND/0FkN+qeVhxLs0Lf6DQQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oYCxBRULQdMVdzR2Xv+Qz7uS+iUVhJ0kfN8ebAEVhBvyoaMu+6SZiM7/daRYLEs6q
	 w2RYE75wHQCEQPMi5192fWzjw/GH+ACp778ogOuY0z2/VQOmhhYaPnYJu2IXYTqIbO
	 /lhwm2+UYTe9cPqweLcpxyaN79juUn4Wbsm1Prnf4R/2zqjxwLyn2Dx/mekdqKHjzt
	 ZdCy+99KRRltjYkMwtoL4n5nmzGS/uOQn7sgnoLqc4g9p+iPgn36X3GyVVXakRlwU4
	 X2xo40kdumOllXuPXJ1lDe/W6I6HGmwimje9Lj4PbCq/fsnowOlF58Kur5OSfObRZZ
	 x3fHx0tChpMcQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 64E4F60973;
	Mon, 21 Jun 2021 21:50:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: 32-bit sequence number improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162431220440.17422.8872440735370690772.git-patchwork-notify@kernel.org>
Date: Mon, 21 Jun 2021 21:50:04 +0000
References: <20210618220221.99172-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210618220221.99172-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev, pabeni@redhat.com,
 fw@strlen.de

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Fri, 18 Jun 2021 15:02:19 -0700 you wrote:
> MPTCP-level sequence numbers are 64 bits, but RFC 8684 allows use of
> 32-bit sequence numbers in the DSS option to save header space. Those
> 32-bit numbers are the least significant bits of the full 64-bit
> sequence number, so the receiver must infer the correct upper 32 bits.
> 
> These two patches improve the logic for determining the full 64-bit
> sequence numbers when the 32-bit truncated version has wrapped around.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: fix bad handling of 32 bit ack wrap-around
    https://git.kernel.org/netdev/net/c/1502328f17ab
  - [net,2/2] mptcp: fix 32 bit DSN expansion
    https://git.kernel.org/netdev/net/c/5957a8901db4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



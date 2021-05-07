Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFA972
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 23:10:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 7D56F61469;
	Fri,  7 May 2021 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1620429011;
	bh=5rhx6cXnG6ECkS9pH0sj0FqvmpcKymOqmIfOKz1znjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O8ASfUNE0oNYn9UUnsg85eimqjQzF+3Vp0JxiaUTE/i0yyEMFxfcqwDuWau9ABVUM
	 fciYTc1HdN94b3swceOnlX0pJusdmheWmk1DzUdraHtmdcSKPWQfz7+A4KG5BdsCir
	 14W7HGl3Y/USUKqDSll4xlYy4sXrxOJnxBD4kBNHIlV03cY0MBP2JZ8mwLkZ3FZW+I
	 2N1iF0M3eUZSvb8KFM1n3BpuEzSTkvdi10ABHb1TUBr8sekbWZBH5E7hTteawFJ1LM
	 n1mYDcJhnA/Xh86yy4vqlYnXV2jHUvCCovIKkbbb34YF20pI88SFfHPZunwamxSQPP
	 rjjJ8nrvXTIHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6DCBC60A5C;
	Fri,  7 May 2021 23:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: fix splat when closing unaccepted socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <162042901144.19618.5919379422935351498.git-patchwork-notify@kernel.org>
Date: Fri, 07 May 2021 23:10:11 +0000
References: <20210507001638.225468-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20210507001638.225468-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 kuba@kernel.org, matthieu.baerts@tessares.net, mptcp@lists.linux.dev,
 fw@strlen.de

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Thu,  6 May 2021 17:16:38 -0700 you wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> If userspace exits before calling accept() on a listener that had at least
> one new connection ready, we get:
> 
>    Attempt to release TCP socket in state 8
> 
> [...]

Here is the summary with links:
  - [net] mptcp: fix splat when closing unaccepted socket
    https://git.kernel.org/netdev/net/c/578c18eff162

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88672
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 13:50:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 02EEB610A1;
	Wed, 22 Sep 2021 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1632318607;
	bh=ec2tiGE5YvoGjFWX5FtXYz0pmxudhLJ2ENq2Qy6TPy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lF34YDzp3d5KXgRZy3JtDudIr+kSCgd9PkHD/tlPx0EYMJpbBTtFTQCRTGZrYl8y4
	 5hFNNIeSBWLuW6Z6mhSRm6QbdNYfRpFNIzxS9J1KI4QkXFdR30eFQosRChQIdd1Fsh
	 ffukVqADvsuj5mlQDDxzZ+lzmFeOWrb3Sa7DSq/S23w19SqvY2Fvd8C0UlPeWrGA6U
	 TCWuXL3RoIc5kobLiESfctGgmj49VvWn17e6ZfvhOAMRoIHFD2Mfg0wzBa5vjFSgI9
	 qp6DbJ4wNwe1vMQLfXJKpekds/dRK92qsk3usNnpj3Y57I9keVMgawpWVM9g8sHAlt
	 SgTvt50nSC6Cw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ED33760A7C;
	Wed, 22 Sep 2021 13:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: ensure tx skbs always have the MPTCP ext
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163231860696.30033.15490074655889330874.git-patchwork-notify@kernel.org>
Date: Wed, 22 Sep 2021 13:50:06 +0000
References: <706c577fde04fbb8285c8fc078a2c6d0a4bf9564.1632309038.git.pabeni@redhat.com>
In-Reply-To: <706c577fde04fbb8285c8fc078a2c6d0a4bf9564.1632309038.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mathew.j.martineau@linux.intel.com,
 davem@davemloft.net, kuba@kernel.org, mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Wed, 22 Sep 2021 13:12:17 +0200 you wrote:
> Due to signed/unsigned comparison, the expression:
> 
> 	info->size_goal - skb->len > 0
> 
> evaluates to true when the size goal is smaller than the
> skb size. That results in lack of tx cache refill, so that
> the skb allocated by the core TCP code lacks the required
> MPTCP skb extensions.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: ensure tx skbs always have the MPTCP ext
    https://git.kernel.org/netdev/net/c/977d293e23b4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



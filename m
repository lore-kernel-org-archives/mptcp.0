Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C92D20E5
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4DEEC34117;
	Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1648520412;
	bh=8ijaKd1pMoh9IcSpaI9MLgq73wlza4qM6JlDumi8674=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W646H58rbmUTYs/6upPFQ91NPm3H9p06ygeqTjYE5c7p7kb8nfRn/bbDpXbDhRmrl
	 rXJPPFjzMEu5r8GD36IUPymSxE4Om6cNbdinjUpi9m7VBi5VE7bY7qFbRDz+GzS0st
	 V/hzGWX++x5/HvgFPI+acuEcEllKSMG5HGfwPgWEwc7JPQiexU0HVeoLPkPvI+PGHY
	 m0U9ErAAYLQLKM8oKqsmz53CxJpKvwBMw1SPOZVgv2KJD070e/EsZcVjuNqwuiwLQN
	 VZgP9TdU2q656940zKMALiaEej6TVZYRMbaSqV+ZpYpnZu3FXKsdprlqx2f7XV5iW4
	 UQHIDoH3IfYZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8863BE7BB0B;
	Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Sync comments for bpf_get_stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164852041255.3757.11920454122901613646.git-patchwork-notify@kernel.org>
Date: Tue, 29 Mar 2022 02:20:12 +0000
References: <ce54617746b7ed5e9ba3b844e55e74cb8a60e0b5.1648110794.git.geliang.tang@suse.com>
In-Reply-To: <ce54617746b7ed5e9ba3b844e55e74cb8a60e0b5.1648110794.git.geliang.tang@suse.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Mar 2022 16:37:32 +0800 you wrote:
> Commit ee2a098851bf missed updating the comments for helper bpf_get_stack
> in tools/include/uapi/linux/bpf.h. Sync it.
> 
> Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/include/uapi/linux/bpf.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: Sync comments for bpf_get_stack
    https://git.kernel.org/bpf/bpf/c/98870605b374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



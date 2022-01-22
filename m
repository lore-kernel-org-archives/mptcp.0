Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AF168
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 03:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F06AC340E4;
	Sat, 22 Jan 2022 03:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1642822810;
	bh=5nPrRQxVOAj/qv9D1fN4iOkzeZZgJo5G6vEXoTa4yQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ab0RniSxwvqxQZPVpBO4VKpkkZD5JQQUyCGNGdTM/3e25TjUlpmxWq3zjJ6lqfLTz
	 zz14pnuKIjxWd39hObQBHx/bx06v+LiSiINFwBhsR5hlVE12PI8+A1kOMISwJeTtAK
	 /P3xywjw8QgF3AvDxH1YDvu2EzCyQ3y9KAS1RGSAd5eIJJXULM6WDR3qkq0umDGTJU
	 5WQ1hmjaEyeVjt+RfDtohxoqd+i+BcIfK3snJ5XXkLiIe6ttZWX2zyw5u0brVfezZ7
	 kf2H2ruio5cKPB5A64bzIz6XZrND+V73+NG+8BqllnZyV0A7lEFCyQfGotC8MLoaxF
	 cpLmqJp29Iixw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32D1CF60796;
	Sat, 22 Jan 2022 03:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mptcp: Use struct_group() to avoid cross-field memset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164282281020.32276.3955066233217706965.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jan 2022 03:40:10 +0000
References: <20220121073935.1154263-1-keescook@chromium.org>
In-Reply-To: <20220121073935.1154263-1-keescook@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jan 2022 23:39:35 -0800 you wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Use struct_group() to capture the fields to be reset, so that memset()
> can be appropriately bounds-checked by the compiler.
> 
> [...]

Here is the summary with links:
  - mptcp: Use struct_group() to avoid cross-field memset()
    https://git.kernel.org/netdev/net/c/63ec72bd5848

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



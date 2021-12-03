Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309C2C80
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 17:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4672C53FCE;
	Fri,  3 Dec 2021 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1638552610;
	bh=DxoTwU/UVZ224zzzh9kr51W4O+wUeQ/emBFSSVrA0vA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C6XwGEEDZF25ZmMb/fcQccGmbY38hoHRWCY0Cjx5befwqIPQJ1d8WBG8+4WbzJQow
	 wQd784S04XzAHmJ8ajqpaqTW0Su+0gJIqNzZ3xJK6b2txRNGPT8CYlHxSWfswe4Odl
	 SjA81tx9sO8etmrLCxeGRuXmMw4/Pu0etWOAUlbzJwZ2mVop63dJWmzMkoXmTNYVzM
	 1PN36gsgMsCB2vmASPWHQA7qcVeMJowddfH8PSXtNKmQm8CJ6FktHC1Qkr9Hq3ls3C
	 0cXhx0s1snXLv36eS9YvCbDafJ+XHlsKeIN/4typgd1aQngIcWSFI2yTbjRMcMY5ZD
	 6OdyY3WiUtvQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AED1660A5A;
	Fri,  3 Dec 2021 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] mptcp: add support for fullmesh flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163855261071.12933.2698419022198127985.git-patchwork-notify@kernel.org>
Date: Fri, 03 Dec 2021 17:30:10 +0000
References: <247b8dfb7254d4a1fb435b5efa756cea989b62cb.1637922870.git.pabeni@redhat.com>
In-Reply-To: <247b8dfb7254d4a1fb435b5efa756cea989b62cb.1637922870.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri, 26 Nov 2021 11:35:44 +0100 you wrote:
> The link kernel supports this endpoint flag since v5.15, let's
> expose it to user-space. It allows creation on fullmesh topolgy
> via MPTCP subflow.
> 
> Additionally update the related man-page, clarifying the behavior
> of related options.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] mptcp: add support for fullmesh flag
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=432cb06b453a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



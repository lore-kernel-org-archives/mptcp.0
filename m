Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29C17C9
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 01:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A6A1C433EF;
	Thu, 20 Apr 2023 01:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681953619;
	bh=b/5BKQ0VH2PtX3y81oVCg/1Mk2m/CPrOfxJ7F7Iz1vs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GZqxx1mURIuEGG/bJu2YxO7oXXFz+QVeEJIG1qdyfHXnEBy1sY8S3N+gmTyKSyRJZ
	 sDzzneCiyEp256zXdtX8ASzSyRTbE7IlsQGhJHLa587MkxK4arG9F/Y3Es7c954ZMu
	 86RuRqZQOuPhMaX68+Q0+Tq5FfPnVXkavZ4EX5hl1FmfpiMQIrWAltkGVJZsH5vns0
	 lj3OGpoVk67UdZLiiCo/8BmWNOS3qclax41Ptzb6hwj1X633tZ3KZALQ9I2GOOT7Kk
	 DxjheRptw6NGfVVUB63+uPvIF7QAtWtbMVbqcN74acmJUQHTzvCsbxKKDpUHx9Wg4t
	 9+aM6RblSAtag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 545FEE4D033;
	Thu, 20 Apr 2023 01:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mailmap: add entries for Mat Martineau
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168195361933.31134.18158689364466953201.git-patchwork-notify@kernel.org>
Date: Thu, 20 Apr 2023 01:20:19 +0000
References: <20230418-upstream-net-20230418-mailmap-mat-v1-1-13ca5dc83037@tessares.net>
In-Reply-To: <20230418-upstream-net-20230418-mailmap-mat-v1-1-13ca5dc83037@tessares.net>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, martineau@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Apr 2023 10:36:59 +0200 you wrote:
> Map Mat's old corporate addresses to his kernel.org one.
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)
> 
> [...]

Here is the summary with links:
  - [net] mailmap: add entries for Mat Martineau
    https://git.kernel.org/netdev/net/c/7b3aba7ea336

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



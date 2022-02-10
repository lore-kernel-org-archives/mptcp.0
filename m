Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A172F23
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 05:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D877EC340ED;
	Thu, 10 Feb 2022 05:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1644472208;
	bh=8l4/xMMFusQmOxay4LeDZ4IazojfRRGme8YEX8Hv7II=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q76Zp5RZXINX+bg4ByM9/QuGqHnaYnUITWkabC5z2Ok8pFdkOvUocINE4uyvzsAtM
	 nhFpJwx0N8m5kRBUz4KmLixHOX539muzhrWErMiV58xrTUh9xWbaJQ46VR4w8/VPs7
	 XIouviSjzzXfqClKKKbtiNvU75CCaGyw7g92PyxEan2GvDxYI9l79KVDrM5/HL0/lb
	 JwxB5CgurA8bJ5pa1CcBJiMJpP8D/Pxg3xLgkEiBI/tmNhBK22x6EP3DtIZEZikOhu
	 BXJye6ie/8gKFHoR55aZQUi+yHhTtg179CnX+6ecYYZW/RGWfiouRYHg6IakakyHsB
	 HgOG/MWSWHi7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA9DE6D446;
	Thu, 10 Feb 2022 05:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: Fixes for 5.17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164447220876.5409.2789457508100360921.git-patchwork-notify@kernel.org>
Date: Thu, 10 Feb 2022 05:50:08 +0000
References: <20220210012508.226880-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220210012508.226880-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Feb 2022 17:25:06 -0800 you wrote:
> Patch 1 fixes a MPTCP selftest bug that combined the results of two
> separate tests in the test output.
> 
> Patch 2 fixes a problem where advertised IPv6 addresses were not actually
> available for incoming MP_JOIN requests.
> 
> Kishen Maloor (1):
>   mptcp: netlink: process IPv6 addrs in creating listening sockets
> 
> [...]

Here is the summary with links:
  - [net,1/2] selftests: mptcp: add missing join check
    https://git.kernel.org/netdev/net/c/857898eb4b28
  - [net,2/2] mptcp: netlink: process IPv6 addrs in creating listening sockets
    https://git.kernel.org/netdev/net/c/029744cd4bc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



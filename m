Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C05EA9
	for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 02:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A201DC43142;
	Thu, 29 Sep 2022 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664418017;
	bh=HqHC1Lw2ikAePwJrjBNkUpMLl/aWPqgbaZ+qf/Qti2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DMSBlF+t5HFBvK5aJ08LtfuwV1mistOf+XD1ppPt5FjlgeQy6cuu4Pc35epnMTVec
	 KoMkBb/3oWPPODcZhEyj+8pxEwtWxcyi0dkOIFpdw8gvCb0ZjGo88y4rXBGJIuKWlY
	 v+dhyXMQeIi8ez1eF07ru8grt1jJp28ikQkU3N7g0iWRUQoAOOCW4GsirWJwV1OkhQ
	 8nkk7+Nz+l3hB6SpfNuzvwgAkr12Q3T1H5qPmW/u47g351ImJ1FUhwzNmvz0WgHNWA
	 K3NPQgvdo5wAZ5VdZAiHnjvnYYHfP8I7LWPjCDcPRoB35fXdGOriFp8rhcXAy52re/
	 n7JxmUjqFu0Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81336E4D023;
	Thu, 29 Sep 2022 02:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: Properly clean up unaccepted subflows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <166441801752.18961.14079404286061785586.git-patchwork-notify@kernel.org>
Date: Thu, 29 Sep 2022 02:20:17 +0000
References: <20220927193158.195729-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220927193158.195729-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, fw@strlen.de,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Sep 2022 12:31:56 -0700 you wrote:
> Patch 1 factors out part of the mptcp_close() function for use by a caller
> that already owns the socket lock. This is a prerequisite for patch 2.
> 
> Patch 2 is the fix that fully cleans up the unaccepted subflow sockets.
> 
> Menglong Dong (2):
>   mptcp: factor out __mptcp_close() without socket lock
>   mptcp: fix unreleased socket in accept queue
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: factor out __mptcp_close() without socket lock
    https://git.kernel.org/netdev/net/c/26d3e21ce1aa
  - [net,2/2] mptcp: fix unreleased socket in accept queue
    https://git.kernel.org/netdev/net/c/30e51b923e43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2294F51
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 12:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75721C340EF;
	Sat, 19 Feb 2022 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1645274410;
	bh=nYWDjvMeFNzUggvQY7QoHxcu2awj+Pwz82vQ7/rz7Ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TtUdiwkuA8/OwdRMEt0S1NFDM9RGzOFKobex3yeWlpl0Lz7HSzEoE8Z3ltj66795M
	 0mThtZTP4cXksLO9TPlJLLZDDAp5o9I4TRq5MMjkA/LgpE8fiHBklh5cg1c3Mudz7l
	 NQwQCq6U7SjvXIVkyeDl5FwjaDeuhWxcRa+FqnbUTWgG6nYS7136nqbpMmvIDvKv2z
	 LWMtHHzKP14UyTslHeFKGTmiym2AJKaEsyhipmhzJ7BEcSY2t9Tei1SFTWUWWmr5bc
	 NMjjsJR9v4Qw7Mt+s9uqoiTWTinPH8oNtIoKTfaF5FcackrQbrEOiH0XgAOZGtvn8v
	 E4SmYRuaV1MIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56ABFE7BB0A;
	Sat, 19 Feb 2022 12:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] mptcp: Fix address advertisement races and stabilize
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164527441033.11752.7886795976671254449.git-patchwork-notify@kernel.org>
Date: Sat, 19 Feb 2022 12:40:10 +0000
References: <20220218213544.70285-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220218213544.70285-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, pabeni@redhat.com, geliang.tang@suse.com,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Feb 2022 13:35:37 -0800 you wrote:
> Patches 1, 2, and 7 modify two self tests to give consistent, accurate
> results by fixing timing issues and accounting for syncookie behavior.
> 
> Paches 3-6 fix two races in overlapping address advertisement send and
> receive. Associated self tests are updated, including addition of two
> MIBs to enable testing and tracking dropped address events.
> 
> [...]

Here is the summary with links:
  - [net,1/7] selftests: mptcp: fix diag instability
    https://git.kernel.org/netdev/net/c/0cd33c5ffec1
  - [net,2/7] selftests: mptcp: improve 'fair usage on close' stability
    https://git.kernel.org/netdev/net/c/5b31dda736e3
  - [net,3/7] mptcp: fix race in overlapping signal events
    https://git.kernel.org/netdev/net/c/98247bc16a27
  - [net,4/7] mptcp: fix race in incoming ADD_ADDR option processing
    https://git.kernel.org/netdev/net/c/837cf45df163
  - [net,5/7] mptcp: add mibs counter for ignored incoming options
    https://git.kernel.org/netdev/net/c/f73c11946345
  - [net,6/7] selftests: mptcp: more robust signal race test
    https://git.kernel.org/netdev/net/c/6ef84b1517e0
  - [net,7/7] selftests: mptcp: be more conservative with cookie MPJ limits
    https://git.kernel.org/netdev/net/c/e35f885b357d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3557136C
	for <mptcp@lists.linux.dev>; Sat,  5 Mar 2022 06:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44D61C340EE;
	Sat,  5 Mar 2022 06:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1646460021;
	bh=hUIdtqRbJWm5CMHptbIB8uNOaz9K3+jQv9pi8BFDCVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f1ilnMOzYcjDHim9si1dc+JjvzjA1fvFpUuBFEdDX70Bau29ybvrAdFym4PmcVAU5
	 gaSeruPLCHS4wN+utXBRO8GMMw2/ifFzp4CWg6ODv72Yb1YwTnx1OfRzsyE7O5hGi7
	 keFRogqgwxQDjweisK/Q16NMsJu4RRDyCYzSAwOtzhfCt58DcclO1OlNAucp9XWZ3o
	 9/0PcvgxgotDR5WOPw6uAsFnPr4wzxaE/nNQ2wSos2YF69dwAoDj8U2/gk6ZU3wxjE
	 Yf9rhyMHfZc4zw5K8MCqNhDz818Yv1nRYbsrmKfZjXJl4NwQf2aw7QWgAJTo/NdGjP
	 FCc4VpizjTAKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21EDFE7BB18;
	Sat,  5 Mar 2022 06:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] mptcp: Selftest refinements and a new test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164646002113.31837.15868652515983059293.git-patchwork-notify@kernel.org>
Date: Sat, 05 Mar 2022 06:00:21 +0000
References: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Mar 2022 11:36:25 -0800 you wrote:
> Patches 1 and 11 improve the printed output of the mptcp_join.sh
> selftest.
> 
> Patches 2-8 add a test for the MP_FASTCLOSE option, including
> prerequisite changes like additional MPTCP MIBs.
> 
> Patches 9-10 add some groundwork for upcoming tests.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] selftests: mptcp: adjust output alignment for more tests
    https://git.kernel.org/netdev/net-next/c/9a0a93672c14
  - [net-next,02/11] mptcp: add the mibs for MP_FASTCLOSE
    https://git.kernel.org/netdev/net-next/c/1e75629cb964
  - [net-next,03/11] selftests: mptcp: add the MP_FASTCLOSE mibs check
    https://git.kernel.org/netdev/net-next/c/e8e947ef50f6
  - [net-next,04/11] mptcp: add the mibs for MP_RST
    https://git.kernel.org/netdev/net-next/c/e40dd439d6da
  - [net-next,05/11] selftests: mptcp: add the MP_RST mibs check
    https://git.kernel.org/netdev/net-next/c/922fd2b39e5a
  - [net-next,06/11] selftests: mptcp: add extra_args in do_transfer
    https://git.kernel.org/netdev/net-next/c/cbfafac4cf8f
  - [net-next,07/11] selftests: mptcp: reuse linkfail to make given size files
    https://git.kernel.org/netdev/net-next/c/34b572b76fec
  - [net-next,08/11] selftests: mptcp: add fastclose testcase
    https://git.kernel.org/netdev/net-next/c/01542c9bf9ab
  - [net-next,09/11] selftests: mptcp: add invert check in check_transfer
    https://git.kernel.org/netdev/net-next/c/8117dac3e7c3
  - [net-next,10/11] selftests: mptcp: add more arguments for chk_join_nr
    https://git.kernel.org/netdev/net-next/c/26516e10c433
  - [net-next,11/11] selftests: mptcp: update output info of chk_rm_nr
    https://git.kernel.org/netdev/net-next/c/7d9bf018f907

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



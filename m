Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A62CA5
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 02:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F56FC34604;
	Tue, 14 Dec 2021 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1639449009;
	bh=j7EBYK/DEWIfG2XPHxm7HTjm+Q7aGiZ1ezL0FXI+Hi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CyuDLQK5j+Cz/0G9Egt/IXSkwf8M5Snm4egkW3VFM76KCL+RDpBQFO+veDUKUCCGY
	 u+KQsukRrPpzn2PTU63xo53FHD0kktqeCdrRGV6AKkC1ZYA0vvbf9J3IKzeBUAkrsy
	 VWgcIx3aldR3nJY6Dxo1sc1kTGIgKPAoNwI9YnJoVE6Raj3tgGJDlz3jyTnDlfhkT4
	 aXlfGOdL5wtyLrRv/3R2yzlN/Ai63a1UOP8Y1J2cNqOrvS3kT6W0nOLl7uBG7EQCLn
	 vlKVb4fWlv47RQzP3K2iQYJfpVV62Wy8JYbtmYAr0yV56co7pvnxRUFvqT7Fs5qdci
	 hpjbzA1ci9ezQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F100960A00;
	Tue, 14 Dec 2021 02:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: never allow the PM to close a listener subflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <163944900898.467.489302277423272021.git-patchwork-notify@kernel.org>
Date: Tue, 14 Dec 2021 02:30:08 +0000
References: <ebc7594cdd420d241fb2172ddb8542ba64717657.1639238695.git.pabeni@redhat.com>
In-Reply-To: <ebc7594cdd420d241fb2172ddb8542ba64717657.1639238695.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, geliangtang@gmail.com, mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Dec 2021 17:11:12 +0100 you wrote:
> Currently, when deleting an endpoint the netlink PM treverses
> all the local MPTCP sockets, regardless of their status.
> 
> If an MPTCP listener socket is bound to the IP matching the
> delete endpoint, the listener TCP socket will be closed.
> That is unexpected, the PM should only affect data subflows.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: never allow the PM to close a listener subflow
    https://git.kernel.org/netdev/net/c/b0cdc5dbcf2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



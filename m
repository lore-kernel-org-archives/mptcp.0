Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545765137
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 21:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1686C340F0;
	Fri, 18 Mar 2022 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1647638413;
	bh=1nmMWiYNcjCRu0y7t8Gr4VgP3eDKoAYhbGIR/JIpUMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bYk3qVdCU/J8HYrU3Fl+/10r1HlgJMwlIy3TKNZZZr0UbRSwxJvZBbOFvSUTfFSZ4
	 t7sY6owgZv2xp1yvRGpkwmjeLD1MI6lvuPeh42cL/PDon8SVwUqTI+H3iiEIqPN07q
	 mOODBRFrjw3H7beQqm1EHkPcT6gBZRxmI5Bg9W5pg7KGP/SvXY/dMrHnTDNP9v10eW
	 abBQbYnBG910L8xOuDaJXpc958aw29AnoYU2N9xMksjzvXw7bzAy69MmsBqH5bjcPx
	 AydRwjLdgzHmcbGg3DjqY0KaVGjZvG/O6HwuEr6GsC1UwzNNIVovmfGS+E0nagYyzv
	 zvtpDLzqGP1qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7A3AE6D44B;
	Fri, 18 Mar 2022 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: Fix crash due to tcp_tsorted_anchor was
 initialized before release skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <164763841287.20195.16890121074112773780.git-patchwork-notify@kernel.org>
Date: Fri, 18 Mar 2022 21:20:12 +0000
References: <20220317220953.426024-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220317220953.426024-1-mathew.j.martineau@linux.intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, liyonglong@chinatelecom.cn, davem@davemloft.net,
 kuba@kernel.org, matthieu.baerts@tessares.net, mptcp@lists.linux.dev,
 stable@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Mar 2022 15:09:53 -0700 you wrote:
> From: Yonglong Li <liyonglong@chinatelecom.cn>
> 
> Got crash when doing pressure test of mptcp:
> 
> ===========================================================================
> dst_release: dst:ffffa06ce6e5c058 refcnt:-1
> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> BUG: unable to handle kernel paging request at ffffa06ce6e5c058
> PGD 190a01067 P4D 190a01067 PUD 43fffb067 PMD 22e403063 PTE 8000000226e5c063
> Oops: 0011 [#1] SMP PTI
> CPU: 7 PID: 7823 Comm: kworker/7:0 Kdump: loaded Tainted: G            E
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.2.1 04/01/2014
> Call Trace:
>  ? skb_release_head_state+0x68/0x100
>  ? skb_release_all+0xe/0x30
>  ? kfree_skb+0x32/0xa0
>  ? mptcp_sendmsg_frag+0x57e/0x750
>  ? __mptcp_retrans+0x21b/0x3c0
>  ? __switch_to_asm+0x35/0x70
>  ? mptcp_worker+0x25e/0x320
>  ? process_one_work+0x1a7/0x360
>  ? worker_thread+0x30/0x390
>  ? create_worker+0x1a0/0x1a0
>  ? kthread+0x112/0x130
>  ? kthread_flush_work_fn+0x10/0x10
>  ? ret_from_fork+0x35/0x40
> ===========================================================================
> 
> [...]

Here is the summary with links:
  - [net] mptcp: Fix crash due to tcp_tsorted_anchor was initialized before release skb
    https://git.kernel.org/netdev/net/c/3ef3905aa3b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



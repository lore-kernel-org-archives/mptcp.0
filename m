Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F216D2F0
	for <mptcp@lists.linux.dev>; Sat, 25 Feb 2023 01:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FD02C433EF;
	Sat, 25 Feb 2023 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677289218;
	bh=QIlJNRK7O/fYSQ2XdQDu6fwQR/yjiyEw+lpxtMVbZ2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BF1y+1f62G6yk/Rm4r1YNqO7D7vgoHNZ8Vy7yt+5V38n+jSgJk95uyZiZ6e6hGXQZ
	 uZ07mxQCqBkVGDg6YHjCHpcS0i8tmd06NFj62J2sjsBSYGQR5dy9EbvYS+DNhlBSv3
	 fUYADk1gDkwG08Sp1ueLJSncSKs1GWQaVfK37ioEyy8+oHLPQCKy9e7iIxlbkDHazV
	 NqS339HPwzJALVjS8wu+SWmmgpFsEfabSRiCfYuFZpr7+IXTFk5XQLeoz0i2UWf6CP
	 Fqv5W9wrhNbkqm2XGtFWfNPbcKMfY4QkQ0kp8+d8RCiGVywroSZwiuglUzdK/mKkHw
	 2e46RyndGeeUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8F9BE68D2D;
	Sat, 25 Feb 2023 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/2] move SYS() macro to test_progs.h and run mptcp
 in a dedicated netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <167728921795.31034.7569688658636917497.git-patchwork-notify@kernel.org>
Date: Sat, 25 Feb 2023 01:40:17 +0000
References: <20230224061343.506571-1-liuhangbin@gmail.com>
In-Reply-To: <20230224061343.506571-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, fmaurer@redhat.com, matthieu.baerts@tessares.net,
 mptcp@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 24 Feb 2023 14:13:41 +0800 you wrote:
> As Martin suggested, let's move the SYS() macro to test_progs.h since
> a lot of programs are using it. After that, let's run mptcp in a dedicated
> netns to avoid user config influence.
> 
> v3: fix fd redirect typo. Move SYS() macro into the test_progs.h
> v2: remove unneed close_cgroup_fd goto label.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/2] selftests/bpf: move SYS() macro into the test_progs.h
    https://git.kernel.org/bpf/bpf-next/c/b61987d37cbe
  - [PATCHv3,bpf-next,2/2] selftests/bpf: run mptcp in a dedicated netns
    https://git.kernel.org/bpf/bpf-next/c/02d6a057c7be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



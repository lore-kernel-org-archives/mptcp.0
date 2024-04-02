Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136315A4A8;
	Tue,  2 Apr 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077828; cv=none; b=GPdtYiN8+SOEbz+sDAah0qoXQoZZpuUyRO1VQwkiR8DJ4cN607MMJqQHB/ccSNsa0lsYtykx+ymxN5FVTOjlS0FxhsGMzYXNGZRZrEexJg8wmNkZ1HlHi3vQdbdn8Lp8c//IzK6b3dP4iy3cL9BcD4+exsXimHpjNVsxYKul6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077828; c=relaxed/simple;
	bh=nBxMIIz8oay+ZtVIDgtyL6CUJut3CqIwZJgq7e7ePD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TgKMZUYZk0rksUiouG1uTT69uoSGBK/JoA4Ioy2Qw5I2ejqWoT7ryKLeB/u5cmBOt81UvzSmUQAUJlXSCaoOMyltFXovnB3+6A0qQCBBCmnqjQ7jlfDabL0h/o8X4H7CVxSPya8bGKe/Ov+CmCl4lzE76DJCS+XuWCXNffg5ZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3D5+iV5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3D5+iV5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93BF3C43394;
	Tue,  2 Apr 2024 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712077827;
	bh=nBxMIIz8oay+ZtVIDgtyL6CUJut3CqIwZJgq7e7ePD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a3D5+iV5m9qimuxNTzmpY+ggLCaALB8U+sqEI1ENcAtOP1wcwwO1oqUMJ8hq3y4iq
	 SjG6hClcBDy30dtAYpKEoHdnPUgqSjtNfoSKZqDqKsUfORx9TJ9JC9Q3QW7r4EO9qm
	 HoBSyfEi6WWy9diBbbUPw81ng3tLr8IHOxYReZDGQh/XTp0YUr4WqoRUqjoI1+A2Ov
	 lRbMIZ8S/JPTFgamuKxJWsMxqyfUJyUQ7epcYkRibB0ptQrtMEnWJoMEJgsVkzADh9
	 zmLsitBbm69pBLBvwE6LhH4suv7SXGUzY+gGoI1z3qsB4s7PGEoF7HAp8kX89Re7o8
	 AMY3zg18tIInw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EC9ED9A14F;
	Tue,  2 Apr 2024 17:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Add pid limit for mptcpify prog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171207782751.23966.17498315397998033703.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 17:10:27 +0000
References: <8987e2938e15e8ec390b85b5dcbee704751359dc.1712054986.git.tanggeliang@kylinos.cn>
In-Reply-To: <8987e2938e15e8ec390b85b5dcbee704751359dc.1712054986.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, mptcp@lists.linux.dev,
 martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  2 Apr 2024 18:50:21 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In order to prevent mptcpify prog from affecting the running results
> of other BPF tests, a pid limit was added to restrict it from only
> modifying its own program.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Add pid limit for mptcpify prog
    https://git.kernel.org/bpf/bpf-next/c/c07b4bcd5163

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



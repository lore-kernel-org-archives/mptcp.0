Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CC5337A;
	Mon, 25 Mar 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383029; cv=none; b=porsHX6GEAtIVhNtRRIVdyHAr+lsjaGwLJnT+RHTWu0uSKVuvKlpp/1ogxH9E6+DMhDW8gUL6PR126gq88YEjjLMoVFnclj2dmWTKWlWFtF4dAhPGGdNY5jkZN8hzZOcgwnqx8nhpk/Xl7iwH0xPoWYOx6h9lJIvNmf1tm/607k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383029; c=relaxed/simple;
	bh=3YS5ftnftIpBwAMZsT4xOHUDvDcN6IqXiDyRtZbf3wk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TbeaSQkptUViT7T+9iGhmG61k1FPwOgyHZDd7zqfi3lmFTg7/EXGSdA22WUjHGgboOX4G36XDsjz0tAO8pN93AExDbRg6sX7dVBC8MZJYfmHP/tYaYhE20SMS37rYHQljsJ0T5FTimwJS1WxzvV94euiUD951H7meHFHXP8mmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muTDBM+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muTDBM+E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28037C43394;
	Mon, 25 Mar 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383029;
	bh=3YS5ftnftIpBwAMZsT4xOHUDvDcN6IqXiDyRtZbf3wk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=muTDBM+EKXqY0ds3miNz7c9Wn22KWA+O4VbSOunPzHwdp1/+5cJPmfzhf/ZlCOFt3
	 NL8j0uQj7OU1eGyhhydqq81InG6a3+E5wB/aa5mYJpV5hq57kBjvlNL5VzcytQelpW
	 Xa9Q/50pKYZjmuKK1szqucxSOcgVxl7a9vSXff3jrFt62n8U+eOvHGqYuTyq1c2UQy
	 DlFOuPZ8asHtsCjff/jnVLBJ7f8Y1HBoUoawzH74FUx7997EyCfYD+LC5eCkfaen5L
	 Z389BhsdU9+rlEfjtmuHp7pGaAVOgxdVH3ycy/Xsxi1ZR1dcqDNIT05JLdA2TS45OY
	 s59rgiLRccpjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09541D8BCE8;
	Mon, 25 Mar 2024 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Use start_server in bpf_tcp_ca
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171138302903.9923.4075117636868880118.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 16:10:29 +0000
References: <9926a79118db27dd6d91c4854db011c599cabd0e.1711331517.git.tanggeliang@kylinos.cn>
In-Reply-To: <9926a79118db27dd6d91c4854db011c599cabd0e.1711331517.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, mptcp@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 25 Mar 2024 09:56:15 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To simplify the code, use BPF selftests helper start_server() in
> bpf_tcp_ca.c instead of open-coding it. This helper is defined in
> network_helpers.c, and exported in network_helpers.h, which is already
> included in bpf_tcp_ca.c.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Use start_server in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/c29083f3f506

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620614;
	b=Los7xeRz0WV3a6b9RPZdv7pYTIsW26lAUHceuogHeI2aw4RhDjZM1yxJVKw0QV3ek4as
	 gjGAWmtqSH/9KCq997OFsoKcCrUekyQTiTUqpZxtjgE9AnO8ZboknXf7GAxf+0reEq7C0
	 NT9bJte4+F9sld3UhdjyqD9JmzXNM7XpfEhREoimbIkGS1MwBu77f+HzWg042T1mSHhmM
	 SBT6mQUprnB6S1cyhfhnpJek+5RApmy9l1JYVgrig4NRdtV+cCW7eqXCtPGIrbjre3aZH
	 6fGnmBgBzdaXVcQEg2mwNZnWQJAZZR3ITxF2cGHra9x6vpftbze3F6wcMThL3c2tZ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620614;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TjfwzSYRpA1l0cjpEsSqZ3w7L7M3XTzJFsciAOi1dms=;
	b=QwLkziBhhWnpbKZ+U+RLvJqH3cPedo3uSKwI6Bb4/uB2UBnYRwLMt7VBwWwzR4azTPFy
	 LCr6lFZxdElnYc3ZxtDfN0oGS/MBKaGEIC9f+ZbOlYdu/MjrmLLPaUncnLRkUYPFxsAPn
	 h5M5o6jIuLsAGQ4soDbyzpWBxK+WeCTWKvFgLjNQrRwc8UnbfZ3rYeZdyPHRRLdUM907h
	 pQw3t36Pl8tSUiTPTVHQmhWm3CP86JVMydWy9TWR6PUrD9pK9mlRXj8cprpBISZTdIwIZ
	 jeCrjEGrOVX9cWUZO6Vz3yE1qZNdfo9dLyx9VSS0HIfv2Ej+lYskzY052e9TV38wQkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rc2ddZCq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FA606A32A;
	Wed, 25 Nov 2026 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rc2ddZCq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421E31F000C0;
	Wed, 25 Nov 2026 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620614;
	bh=TjfwzSYRpA1l0cjpEsSqZ3w7L7M3XTzJFsciAOi1dms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rc2ddZCqzUoRbNWSRjrQAE+H307p/PntbSSjxOqs/+HKew8JY72p+7lqWF0VGZzei
	 r5BFJ1Ks3pWixiZAslbRn3vaYJe/+cwh9zlGYi+smGTRTSpIUVv1Bpe1CEDu/fEzzJ
	 8cSDqhwAA780RT8CnutMZsq5bBVz0ugqYb7/hc8Otco6Hao98lIl9gJWualG7wRZEW
	 z6RGJRapl1VzXVXmUADFQA6aqaQ1x39kZTLQPfpfvqy1cjz6tQ0NbVyjH+m9BoeUw0
	 Pcbn0osSxr/o2eNcyYUcysezPeoYrfPsxSLtv4lqyNjdAVadZ3indzifOoeSVqeagV
	 a9yu+eM2lchEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3E23808209;
	Wed, 25 Nov 2026 15:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH mptcp-net] mptcp: gate diag sequence counters on
 CAP_NET_ADMIN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179562061310.619539.2248917862989217647.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 15:30:13 +0000
References: <20261119192159.2646113-1-dmnk@google.com>
In-Reply-To: <20261119192159.2646113-1-dmnk@google.com>
To: Dominik Maier <dmnk@google.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 pabeni@redhat.com, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 dmnk+artist@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Nov 2026 20:21:59 +0100 you wrote:
> In net/mptcp/diag.c, subflow_get_info() restricts MPTCP sequence-related
> subflow attributes (rel_write_seq, map_seq, map_subflow_seq, ssn_offset)
> to callers holding CAP_NET_ADMIN in the network namespace.
> 
> However, mptcp_diag_get_info() unconditionally exports mptcpi_write_seq,
> mptcpi_snd_una, and mptcpi_rcv_nxt via INET_DIAG_INFO because
> .idiag_get_info does not receive the caller's net_admin status. Any
> unprivileged local user can therefore dump or query cross-UID MPTCP
> sockets by token via SOCK_DIAG_BY_FAMILY and read live 64-bit MPTCP Data
> Sequence Numbers.
> 
> [...]

Here is the summary with links:
  - [mptcp-net] mptcp: gate diag sequence counters on CAP_NET_ADMIN
    https://git.kernel.org/netdev/net/c/7ed616970b65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



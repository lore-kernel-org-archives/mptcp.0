Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633C370D7C;
	Wed, 23 Sep 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129479; cv=none; b=rMgBlSOjABcNjcB5a0Ic+FdwK0PKKOyZbzGHcFyqr+C4sSSKea3Im1tRiNmuoRkHWkaKFGYu1Ht2fkzCzwr8Edc/seV2lOp4ZoqF9+KgylQ3fEX5hDoaoTSNT3Wq/x3jE7ENVy+W5j/gLTdFiLedFtLjt5xkdrAA4rjRlUNn01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129479; c=relaxed/simple;
	bh=VED52qYEajXb47uMktaF/wqtr6qhvhWuiL4rk2RPNvw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C5FKa4JyRRpdSeXb/50D+NhhdalbTHoGTPDwfIksHkOgv/jh8u5GCsGZ7ZNu46Ab8dpxERwonEUWLopN+9yUmvYC+8I9bcmuAW6j6TZhz4pt6lUxKjPsGPOENaTzliCdSJcFZh4H4A2Gj3Bc8va0ibqRuuFvCONhtMDoYMyHL9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW6fWRw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW6fWRw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491141F00893;
	Wed, 23 Sep 2026 02:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129478;
	bh=MRZsWKJ0JLFJ2y9rZZoaJ0mG6fDZyGa/qldRqSsF+Vs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iW6fWRw+ntCdjoUrM9/I0JlX5QIP4hNvxhRURUH6bcLdCMqru8nG6UYkrdDBbbWx6
	 Q5IhnY9YHzR92ZigiYj/1f3wrE7m5XUtb/GQTvDYaqLOAXuI1RSwOSbOa50HV54GMZ
	 EcCkPZA/lofwTF2ex93psFWbIUF/tKXjXqDJHCFganWDGV+Ks2e4GAFARIBTwtgDm5
	 WR3yZX99X6b/q6Sb7A85IkcIwP/wJJpKhkB/SR5Hj6CWRhmKCWFVIA2y4wYrJoc0x4
	 klsAZ5wCxmA6XL/5zDFp6LNzctWr/3If+RqHMDn7cgmgFJ7S1jBgHNT0bIi+Dodt7Q
	 3CH/yIMfLDZJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197753924472;
	Wed, 23 Sep 2026 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012940865.177114.1142007941387252817.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:10:08 +0000
References: 
 <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
In-Reply-To: 
 <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, tanggeliang@kylinos.cn,
 netdev@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Sep 2026 19:06:18 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use
> MSG_SPLICE_PAGES") moved tcp_rate_check_app_limited() inside
> do_tcp_sendpages(), turning it into a wrapper around tcp_sendmsg_locked().
> Later, commit ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now
> a wrapper around tcp_sendmsg") inlined the wrapper in tcp_bpf_push() with
> direct tcp_sendmsg_locked() calls, which perform the check on every path
> that queues data, but kept the outer tcp_rate_check_app_limited() that
> was previously needed to cover do_tcp_sendpages(). The outer call is now
> redundant.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] bpf: drop duplicate check_app_limited in tcp_bpf_push
    https://git.kernel.org/bpf/bpf-next/c/91f8613d95ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



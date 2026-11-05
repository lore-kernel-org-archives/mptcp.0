Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887807;
	b=T5V+OJDjHMWR9ypOmyPbklbHCCbAouBGjwA3kaHoL/SO28nMLznmtAW6uzXy5jhVm9sn
	 H94SutiFfaqGimT4+6HoUPTQ2/dH5m4Ejfks/lPe3SIdFtSsAWi/D2DCWSEQ+1yRT+l2G
	 fRgt1uncZ+EUl/TwqX9fxVjB19WIsBpeOOixA1FFzQP6gBxUHl6Fi7qiRq9L8MhWNT3mf
	 E9fgXb38smSLUthkSu+0ko7+WUODxAPeOvh7CeZfF7rj4erRNG88OVxqyKQ7tP+uW4ent
	 h+vVZC3hIzTOgiUk5HJf5FcQdWl6oWB8nJi5gza4PwWf3nPAQItYNvarCK5cMqVClrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fPWc/9PjRvCbS/gxkmZWbhNKYXJiH6BMZd4rli5z0qg=;
	b=3bSPO4+Tbj+kZKK5aRMVn8q3dFA4fkSpC9BZ1V1XNnRcBilNbVi3WmAw0ma+B+Zd0OAA
	 OmeWSK4QRv0yLtka43KIebeV57k1gFAs47VWESC4RU8KsN0bkydDfGG2+qxX9SDu44LdR
	 lqQshv1e9fFJ1JgtIQPL7qWH1ZkfbZENT1xsMsVtZjxAk5w2EOC0F07jmIzjY8fMdOurY
	 CV0D4gh+a8UyrpkiidYNveqdDkoMIpqyPY7M7tEXc5fuTYeFnN8CmNM+ph/dC9K38vJGT
	 gT1tDneNvqeD8SF5d2CE4HZ4gkqrCb/46+ofaO0lZuhpoh80kTjW4VNN89pY+veHsSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkTVR8rm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F5606A31B;
	Thu,  5 Nov 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkTVR8rm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCE61F00919;
	Thu,  5 Nov 2026 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887807;
	bh=fPWc/9PjRvCbS/gxkmZWbhNKYXJiH6BMZd4rli5z0qg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gkTVR8rmfjGDmiTF6QhfbQMbRdIP1NgpLaf/Ib5xSMa2jERGdn2Y+KlTaCSBmtjFm
	 fOWGkkBgbBM+hsCySYo3Fn3HcPFF9XKA4JNtIqCzdJMRAvouuCaRFggbhIdv8bBgXH
	 Qt3e8YjXz4XL71oYtI6cERzW4HHxNQl1uxJ21G/OkeZTcIuhniw4wxKdDx3eYBz4dm
	 a68OeHgRRZjmvqwMwAOGkzp02376aYoYNDyjIGnooejRfDJImOSab6aIDhrfHRRbUr
	 0DWsGjlzdJ4l0d9VteZUEp16jNypagXszob0frSsUoToZdT+vi4mWGAgFSeyTK5Wen
	 dR5b9V2iMNUQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03217391AF93;
	Thu,  5 Nov 2026 14:10:07 +0000 (UTC)
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
Subject: Re: [PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179388780580.3729553.2491090300566756882.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 14:10:05 +0000
References: <20261030042255.74216-1-kylebot@openai.com>
In-Reply-To: <20261030042255.74216-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 21:22:55 -0700 you wrote:
> mptcp_pm_nl_create_listen_socket() starts the TCP listener directly
> instead of going through mptcp_listen(). It consequently misses setting
> SOCK_RCU_FREE on the parent MPTCP socket.
> 
> tcp_child_process() can invoke the listener's subflow_data_ready()
> callback without holding the MPTCP parent lock or a reference to the
> parent. An authenticated MP_JOIN racing with endpoint teardown can
> therefore access the parent after its last reference has been dropped.
> The ADD_ADDR error path can also close an already published listener.
> 
> [...]

Here is the summary with links:
  - mptcp: pm: kernel: use RCU to free endpoint listeners
    https://git.kernel.org/netdev/net/c/49b09ae0bf57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



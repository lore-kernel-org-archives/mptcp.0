Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4131A555;
	Thu, 17 Sep 2026 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605674; cv=none; b=Jt1Q9uzpWAWsN0D8r1hKyh6NfX49vEys/AZ0HfgsrE1vgg6vOj3nEaWTKsQ5OW2RuKVoUFGyu4p6n8FpfDQOo5jqUgkmJiWcHz/PHJ2bQRBdNwXcewMj9XtiHLwCpdlIrI9PUZ7yCLHfQMtQzheWmWBWgoR9X6qB5VGVerlXOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605674; c=relaxed/simple;
	bh=nv8ehzXNWQ0YNPXGG1PuuM/QJ9hcptY2hc36fynuM4w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TZS75eFWyPs1VvDzgB69UKPpMdby3tSO15ZO0iiP0+ATkR3XujIYsLFW+5bAzhEzVxAHiy2eTWm6NEHn8Gz25tSkSmwoWLnyXwr+X/EPb/03/XhjIwOjy4zNiqYhTa4NoZAsoJxHnrkIZRfPMNTGuyls8T4BsxW/qHEvcxApHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbpixoQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbpixoQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79111F00893;
	Thu, 17 Sep 2026 00:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605673;
	bh=KLVHZY0CAS1n0MDo2625TmenwP1t/VjdqFNKwIwcANM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XbpixoQSLQtf6CIrx8/KS7F4TMM4kL0JDtNtynizKwpCcBAz8Q6B2sbkCnYcrZ9B7
	 0AJeM5uaIfJIoSgsbaDokTOnlsACFXbHyfZsNr+qdQD6Nv1XRrK2NlEUuFBrxTnkOF
	 abpOQkSYp+xHVHOJVrSy5mKRMV1gPecgkTneebafBMhfOjLP0uwhNBJguY4IyduNVN
	 q2vPjvXHC0J7qm1XbSLmOwbR1dtKVSXdua21TStABZaD+qWo+DgilCLl6YHdE8Dj0p
	 m8+DKMRNCPdFHaJAnpC70+Xh+vPf7ktopA3Hcme+JhsmGYiQHiObp7gnsPRrp8jCuL
	 WsAOqgYZahw0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D089D39E9601;
	Thu, 17 Sep 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: return sk_wait_data() errors from recvmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960560738.3354472.16740899411483597781.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:40:07 +0000
References: <20260913-b4-send-mptcp-recv-error-v1-1-4eaa3684a8b8@gmail.com>
In-Reply-To: <20260913-b4-send-mptcp-recv-error-v1-1-4eaa3684a8b8@gmail.com>
To: Mark Amirkan <markdamirkan@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, mptcp@lists.linux.dev,
 kuba@kernel.org, geliang@kernel.org, davem@davemloft.net, horms@kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 10:30:05 +0000 you wrote:
> From: Mark Amirkan <markdamirkan@gmail.com>
> 
> Commit 581302298524 ("mptcp: error out earlier on disconnect") made
> mptcp_recvmsg() stop when sk_wait_data() returns an error.  The error is
> stored in err, but the function then jumps to a path which returns
> copied.  When no data was copied, recvmsg() therefore returns zero and
> reports a false EOF.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: return sk_wait_data() errors from recvmsg()
    https://git.kernel.org/netdev/net/c/60404266ef3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF6470115;
	Tue, 21 Jul 2026 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658656; cv=none; b=nPUtjdAU1axM8R/SkOgw5hsOCtakDJ05g9f/V8XFoXHrJXautAJU29jsZ8Xp7MooYQsB0FvvJDnqu5OyAH8Tn0fHPQ7ujxzRzxsxPxelJSAnvyaactzLxjCCvBg9rOdPvS0SHeE+mArjZ/ZshALRcWhW4Mk+um7hoRLdAmmuOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658656; c=relaxed/simple;
	bh=dBxOrRIWdHZFStPPW1Q9cbdtwWtQcSOPF6BeDWm5w2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eYOoiY8KPtLbJC/bm/sx2rzbUv1c6Smqs7HmsZWs0wRaAsTUBl0wZ2OBg52vV+pD+rIUgB8qFzfGcY+2wTfp+MQByAwV486E5xRQwOAVU3ASbBgrAHOLbVhHd9UECAeDs1DmpKNbuCm5YPPrq36SakDXYe5SSjZLdAs/COlAHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU9GtBtw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU9GtBtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C8C1F00A3E;
	Tue, 21 Jul 2026 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658654;
	bh=HgWatc5Kr9sPHMrTsQOPC/SAR3Kik5oSiJY/pHZe6uU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZU9GtBtwwj/0nVad5ZCEG3+EDV5wkX5cWci4pJs+6ACWs4mbYGsRPya2Miy3CXp27
	 mFvhbuTiWGnwLl9oPua5r2kAGMbyG9uynA5dPYUjUQpog28TDIhEAvqn3BDy3fdVMq
	 mBPsH9NZZ9Mm0hr1y4li9HCNmhtLcN/WwXNAZqTBnZarBIcpp9akSRrcy4PM1YFIwh
	 0s6Gv9s3mQk6wxv+ieGy8kdfYNEXhLmNCqvp2GG9LD6atmCkxtwMwAqI/fe9cQUWwW
	 jd2YbT+V5aKyE9ILNWX0d1Gy2dpQ4rgFQowcIDoD9m0ZTmC/bT/Bd0sdJRL/dzUp2U
	 QBG/SAlUNRhLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1991039253EE;
	Tue, 21 Jul 2026 18:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] mptcp: only set DATA_FIN when a mapping is present
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465862363.931197.5667414572140309118.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 18:30:23 +0000
References: <20260709191925.2811195-1-michael.bommarito@gmail.com>
In-Reply-To: <20260709191925.2811195-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, gang.yan@linux.dev, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 15:19:25 -0400 you wrote:
> mptcp_get_options() clears only the status group of struct
> mptcp_options_received; data_seq, subflow_seq and data_len are filled in
> by mptcp_parse_option() exclusively inside the DSS mapping block, which
> runs only when the DSS M (mapping present) bit is set.
> 
> A peer can send a DSS option with the DATA_FIN flag set but the mapping
> bit clear. The parser then records mp_opt->data_fin while leaving
> data_len and data_seq uninitialized. For a zero-length segment
> mptcp_incoming_options() evaluates
> 
> [...]

Here is the summary with links:
  - [net,v3] mptcp: only set DATA_FIN when a mapping is present
    https://git.kernel.org/netdev/net/c/b2ff91b752b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFA3F1045;
	Sat, 29 Aug 2026 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787981468; cv=none; b=qxGlhMf/dU7PKIZetXubx/jrzpfmveofqmd0ZTr3Z7CezlcbTiiZ1kt/C7J+zbLh5QloORS/yn53mobQ36U5TKZZ1eyyLNr275CDFqCIJqoezfwz4/ExlH+k03JRuyDoZpPZvhEUrknIr+mAAmjNyNRw0hFpT8fLRoqIQvYrAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787981468; c=relaxed/simple;
	bh=ITs9qIqe3Wpeo4pIZ/jbSBTgNIVyR04nZvo2x4q7OZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pej02VJKpvrUVQ91rvZaM7Bcl0imY89CzUG7XOFB3FqwqJS1eq8/i/iYp/GaB8ShcgENlfCH+0xfMZN+31CQQ8vsQREWMVuJluBamb1038jxr5EkAwnahnTTizWT8WKD0EXYWxlLHbcgvnFHLdFj1iky4SEQiSy5DaKChJbwpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4ouYXb6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4ouYXb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977161F000E9;
	Sat, 29 Aug 2026 05:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787981466;
	bh=Ain05BJCy5NsIwfYaX0WDpEr4lzuh/JsNHswjjjqE4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q4ouYXb6EicWRIRXtzwrjQ2txoNqggZ6CDd0NkoDeS3BGHAEEuul5Z+e1CLMUhYSE
	 MrxTLm7RZPFGiddgfButxHj72iV/NBRvuwNCkFPU2OvM1jOfG2iYvaWSb2K0NnCoA1
	 9r7z1SVRkLPIeO72KxIA1kF2B6Ul8SeGSjRxYZc3QGXuHlg4lmTOmLIve0E3HIOkaD
	 Q8MeV+2eW5ifjEhV3en6ddQ4lyFGCSoUTxyL1bAN/I5S4f7Tn2b+UMop3mXaFqdeEv
	 4237D30qDfeKSAQmRShiqMfD74smtxhGiE6pp1tS2wvuPYbYgLXwQNeSqXJdA/XH9f
	 Ed2pTjhEo+t9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56938380AAD2;
	Sat, 29 Aug 2026 05:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] tcp: fix use-after-free in do_tcp_getsockopt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178798141089.2932800.13873660526223105626.git-patchwork-notify@kernel.org>
Date: Sat, 29 Aug 2026 05:30:10 +0000
References: <cover.1787870710.git.blbllhy@gmail.com>
In-Reply-To: <cover.1787870710.git.blbllhy@gmail.com>
To: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, horms@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, yhs@fb.com,
 kafai@fb.com, andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu,
 tgopinath@linux.microsoft.com, kys@microsoft.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 19:55:09 -0400 you wrote:
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
> 
> do_tcp_getsockopt() has two lockless reads of icsk_ca_ops. Since BPF
> struct_ops congestion control made icsk_ca_ops point to dynamically
> allocated memory, a concurrent setsockopt(TCP_CONGESTION) can replace
> the pointer and free the old object while either reader is using it.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
    https://git.kernel.org/netdev/net/c/5271b79b7ad6
  - [net,v3,2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
    https://git.kernel.org/netdev/net/c/385e474086c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



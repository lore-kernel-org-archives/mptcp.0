Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DD1BF58;
	Thu, 28 Mar 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601428; cv=none; b=R0RqDbemUmZ0s6le8rzc/HqauElqyOxAMGFshgjdKFvALE8+nsrb+/lganM8vl71ri7q60C4T/WdFXlSaWmEJMadGJ+xF212nyVl0V29KzN29zT6zyhalhZlFx/V6gowLAew5pHVvgyEkWkFPhPkcOOneJRU41Gq0f/xvsBN0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601428; c=relaxed/simple;
	bh=udkx8TTOn6zSn1nUXC3etJTiKnUwSJqFpdlj/Uf9YxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dk0TWpDFE44jaS2o4IVnIZCtiUXpLmpXfTzDtoa9pEhk4IVDyfyQQiqjGbbLDZY9GcBTkqZ7Dalx57Qh4zBbETd5p7RLzsQJXxda9qfz8ZEjd3zspkeFdzwVESt1aR85AZyytRTVnzEexCmV9ENBaIBhgEE1fwARGkPDlhudlPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWNMOrWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWNMOrWC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 755F0C43390;
	Thu, 28 Mar 2024 04:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711601428;
	bh=udkx8TTOn6zSn1nUXC3etJTiKnUwSJqFpdlj/Uf9YxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HWNMOrWCITNutmYhz5aJ0wIP1HPyzd5foHbIjmOLLYdjVgJKGj6Ofei52Ab/EUeoC
	 uQz1/vYPFLZjbaFLjYCteY4rISOsjMXwKgxaKz/6gtXBzHeliFMBS/I1I+dImNv/UI
	 YOGkwXIC7PYwfIbP48gGaM00xabMf2Imn9TqSUxmIwInr+lAr3O18dAa++Ai7uGpHK
	 jW+cFo716bml5ykintObajJRh4jLEh88g8oDghT5gGoXCRc6HxvMo2qyi9X/npGCPl
	 E2ZEpySuoQlJIeE9ZxfNeKHCAdYXwcmqdpUgqlhQRlMsjE15I/goPjYCZVJPLEH8ui
	 UbMz9kSpUmj9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CDEDD9505E;
	Thu, 28 Mar 2024 04:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] Use start_server and connect_fd_to_fd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171160142837.898.15588043044071096564.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 04:50:28 +0000
References: <cover.1711447102.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1711447102.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, mptcp@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 26 Mar 2024 18:03:37 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v4:
>  - Matt reminded me that I shouldn't send a square-to patch to BPF (thanks),
>    so I update them into two patches in v4.
> 
> v3:
>  - split v2 as two patches as Daniel suggested.
>  - The patch "selftests/bpf: Use start_server in bpf_tcp_ca" is merged
>    by Daniel (thanks), but I forgot to drop 'settimeo(lfd, 0)' in it, so
>    I send a squash-to patch to fix this.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] selftests/bpf: Use connect_fd_to_fd in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/ed1697153d40
  - [bpf-next,v4,2/2] selftests/bpf: Drop settimeo in do_test
    https://git.kernel.org/bpf/bpf-next/c/9a3aa22de842

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



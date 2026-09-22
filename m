Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63453D0C9;
	Tue, 22 Sep 2026 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078233; cv=none; b=SPoljrceop3VCbzByDxZ56fK61UdHSyVlIJKDfaTkPBYmwPRlMGg5zUw9ZsCvkj8rMJSqZb+GpvOvJev/CyoFAYg36yV62vhZUtP2baPrMK4+FdYzudePkaQ/emMozN95nRSdupScIfvZrBirc0LQJLJfUBXGZk1nT1yzaCjuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078233; c=relaxed/simple;
	bh=4gBjgFda6pMs6UTC13Km+qBb2HFKEcN8UHIseIYcn9Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SF75gO8V+MOzM5pBHyqZXkhVBYHVZq8ohRZfzyRiINoTO98BSYIi04a2hFPXbdbIEgQS4PuslHE8Nk6lnZ91YkpJItkH9GZzSDvy5mgRP7kn294/e/8rSDl2vCR0lpLNOlgZFLIKeyv9n83gtYgNesIwMzNut5jbPcCmiNz6Ni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm+PbuaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm+PbuaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263CB1F00893;
	Tue, 22 Sep 2026 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078232;
	bh=4gBjgFda6pMs6UTC13Km+qBb2HFKEcN8UHIseIYcn9Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Qm+PbuaKwDXd/xjc+4VSzO7kUGhXWlY3BOZf0xI9NEoXM2ts/GXcLQMqXByFcCazc
	 GbuQ//+BSi0BvOtqE1dND9YxF4DERbM5IXUvycMIUPUV1TuDUkOJHqIl0yHARUkQEU
	 X7L6y6OOT6J0UJxAi2K9yphf91I8wAWXMzWZkLvpVtUGMxNgHg37tZKBKFxJ4WSbRA
	 yH3PBaUNtfF6glwE04a+KGYuOZuC8jcssG/VNoFBBb0g6neUhYV3I+WpUvHB+2rc6K
	 JS0UoNOkc/wtsHwC6g5WKHtTaZL33p+zy8Y6ia7+8pVhyAo6Mml+6SMAzJEUh86U2g
	 qElcVipBfTBHw==
Content-Type: multipart/mixed; boundary="===============0288408739989712393=="
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <cc4f8eb66555e38a28d629136531a9ec0187263f7080ded5d01304551f686f45@mail.kernel.org>
In-Reply-To: <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
References: <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v4] bpf: drop duplicate check_app_limited in tcp_bpf_push
From: bot+bpf-ci@kernel.org
To: geliang@kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,edumazet@google.com,ncardwell@google.com,kuniyu@google.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,matttbe@kernel.org,martineau@kernel.org
Cc: tanggeliang@kylinos.cn,netdev@vger.kernel.org,bpf@vger.kernel.org,mptcp@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 11:57:10 +0000 (UTC)

--===============0288408739989712393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: drop duplicate check_app_limited in tcp_bpf_push

This isn't a bug, but would "bpf, sockmap: drop redundant
tcp_rate_check_app_limited() in tcp_bpf_push()" match the prefix and
naming used by the other changes to this file? The prefix for this file
is normally "bpf, sockmap:" (or "tcp_bpf:"), and "check_app_limited" is
not an identifier that exists - the removed call is
tcp_rate_check_app_limited().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35720598036
--===============0288408739989712393==--

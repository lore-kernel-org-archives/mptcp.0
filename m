Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2943624AB;
	Wed, 30 Sep 2026 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734259; cv=none; b=FLBeuFiff1nhclnl/pMLp24nSLGi5rl0dd+5NQMf9EcfZRcK0K3V+5RNqteZCWIQyH5ZP+66WJuPlbdR+iWQp+TZtREqbhcGrBxSrhNa5E6hO2/BnYP6vBmK+emUp7AmHbnE/eQukN9+syNUXuOG1GgyKRhW9a97QTOWbeIdUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734259; c=relaxed/simple;
	bh=W32nvCISOv+QAJ7rEbXFq6CPdoKleRQ4nNHOcgg+XXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyuwasbRgYR3RRJP2F08IJKE2Eg95PqmINIkpzKNyRsD7zuEvCiH920815mPxxgX27Ef0ooq+kjyBLfgQphK0MdP/CeEfQw4l4N2efjxG/FRxVMsDivGzheWMAH/plFSCg5uILWZ6YgLI013t/dyuPZJ8A42jo9R2uzxM6z0KtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKWTL9o6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKWTL9o6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0951F000FF;
	Wed, 30 Sep 2026 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790734258;
	bh=T8EKNXYenlstFgfxKWv/tz4x7AnSYkrIn/LqQvDI5R0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mKWTL9o6nKJlBF66yGNpF33GCCUPS3gjhqk8KAxXS0RzpyPDEXZkseniftYAVpMBl
	 Ctp1RuNf4O/2UqJssJxYkInE2TDKBPhMQF27bNe9mf1BQGWTmHaGB7Qdi6n37sW8XI
	 em04GNqYeOJV5XRZAOyDT6aqRGZOrIWwSVe4GOaKTvKFsC8mv0Mpav6WbCy/8ACCJB
	 aQVtXms+1jEv4RLnTaKy7kVULL6LLwxEkuIpygYnijEhgPCcYBh2dizarij+7dXaIS
	 T9nfnWa7fl1wVquHTRgU6FZCQGCSKdvc5mkQL0/CLDOUEHBGiMOex/8rtkqZQDgnUT
	 F0GlirUPeZGNA==
Date: Tue, 29 Sep 2026 19:10:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, quanyeyang@proton.me
Subject: Re: [PATCH net-next 5/5] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <20260929191057.45ff98e4@kernel.org>
In-Reply-To: <4278a970-2957-4387-8f20-604ae4ae97e9@kernel.org>
References: <20260926-net-next-mptcp-misc-feat-7-4-v1-5-67af4ab37406@kernel.org>
	<179058242453.3145.1450534124183352369@kernel.org>
	<deb5e3b3-d1d7-4d1e-8bb6-95050769d656@kernel.org>
	<4278a970-2957-4387-8f20-604ae4ae97e9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 23:17:59 +0200 Matthieu Baerts wrote:
> > Indeed, the RM_ADDR will be added in a second MPTCP option. It looks
> > like Netfilter doesn't handle that case. But that seems to be an issue
> > on the Netfilter side, rather than with the command that should work. I
> > will follow up with Netfilter devs. If a fix cannot be added on their
> > side, I will change the nft command to look at a specific offset.
> > 
> > Note that the command here is just to check there is no RM_ADDR sent on
> > the wrong side: it shouldn't catch any packets here anyway.  
> 
> After a discussion with Netfilter devs, it looks like a fix will not be
> easy to have. Yet, I wonder if it wouldn't be better to apply this patch
> like that (it doesn't break things), and have an explicit follow-up/fix
> to document this issue somehow.
> 
> @Hangbin: do you plan to look at a fix for that? I guess a raw payload
> looking at the same fields as what the previous cBPF rule was doing
> would be enough.
> 
> Don't hesitate to fix the "low" priority comments as well.
> 
> https://lore.kernel.org/all/20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org/T/#u

-110, let me take the kernel patches for now, repost the selftests
please, in whatever form you decide to have them.

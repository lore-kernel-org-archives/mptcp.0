Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA228DB54;
	Thu,  5 Feb 2026 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259481; cv=none; b=QuYEXefpaNUswMPMmX64s18JqBvnKIC+8ClIa9xPRo8vQLXOQZkmlV99+RO43+8VNs+KH5Eic/x7G/CgFAtBXf4cfNbmGsP1zwuvFUk5A1tV6QRKT9hAN1bA7cMFC15sXBYx4Tg3mAxOliYcZxeYnV5zxGvmP7Irj0gR4fXJvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259481; c=relaxed/simple;
	bh=82wiatBuHnfM4LF/SRUhPD6lg8sy5nMAA9K0lKu65QM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeGqVx4GSWzXITx31hmhagfM0LVofnbh0Ai+4ujMayrqFaUPn1Po/pJ0Dd513wF3nirteOvT21nBpvauKJ2nurP4binxlKG4y8EDjO7CEGOVdIA62w3hlpMMIQN2OxloNyaWvfHFeajmU6AUdgXD38UHClcE9n5a07rRuCVlYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7lzGvhd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7lzGvhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AF4C4CEF7;
	Thu,  5 Feb 2026 02:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770259481;
	bh=82wiatBuHnfM4LF/SRUhPD6lg8sy5nMAA9K0lKu65QM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F7lzGvhdy0pCp1uxnGnieKSZWe3O2W8e6C0IYvZqXMx0gyEgEzFGPZMnaMH1ervol
	 jnPrCOLd4waieiwTyJb+vfUVYWRMeWHLy6hSHJC/r4MnaZbdqN7s6IVGyTUdjvDJJb
	 4b59mkLVxEoDPK3P+4dwX+BTqBC+2rbpuCyvGl4ffaQeXsNaLvMiW9aZ5UpvUoIzK9
	 hjsyuanAxPOq3thPFOmlsIkqE9vSC7pcutPCex8l9EPQ5SpJa29tstBjmE3H5iydie
	 bXAm7Pa+WApOdtcjlqDHyI+p24zt8NJq7GHRaG4LfNAzchfjmjfYXOLFrtewNuoamI
	 Z8836GJzrhSIQ==
Date: Wed, 4 Feb 2026 18:44:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH net-next 07/15] mptcp: allow overridden write_space to
 be invoked
Message-ID: <20260204184439.4f1a65a0@kernel.org>
In-Reply-To: <8037fb73-4e18-4ed1-9eaf-e4cd8b2c9d53@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
	<20260203-net-next-mptcp-misc-feat-6-20-v1-7-31ec8bfc56d1@kernel.org>
	<8037fb73-4e18-4ed1-9eaf-e4cd8b2c9d53@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 11:47:13 +0100 Matthieu Baerts wrote:
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index f4bfe91ca7f9..0bd1ee860316 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -975,7 +975,7 @@ static inline void mptcp_write_space(struct sock *sk)
> >  	/* pairs with memory barrier in mptcp_poll */
> >  	smp_mb();
> >  	if (mptcp_stream_memory_free(sk, 1))
> > -		sk_stream_write_space(sk);
> > +		INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);  
> 
> Is it possible to drop only this patch from this series? It is
> independent of the rest, and the AI review tool spotted that
> sk->sk_write_space is not sk_stream_write_space by default.
> 
> I can send a v2 without this patch if preferred.

Ack, looks like this is the last patch in terms of real code
so can do. BTW I've been offering other sub-maintainers to
run the AI stuff on their patchwork instances. Looks like
there's a mptcp instance in k.org patchwork. 

LMK if you want me to hook it up (..when time allows).

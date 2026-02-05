Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1222301
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284807; cv=none; b=MnYdrf1WFVY5vHRoBc20W6gKheeouAPDpZdMm52ZtizcvI70ub/rzsCtmdubmw0oaefmIo3GUMa/xUUXj3M78/fD5pQN91bX4wTQYaAe/b5TE0/T8iOFPatwjh57WJeQq+k59kXfai8OB4ORiEpF4WZIc1M+ooYgqlwgmiOWN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284807; c=relaxed/simple;
	bh=S8GWTbHSUSmGBLSBZuQUge/vjM5tsjoNTajz0GloTcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqg6cze5xRkLlquAq2dDxWCjdhF1E8EjJYAbqP62TR3R+BiK+H6vfV7D0HGeUKWTJZh3l0/uwj2Z3NiMafOnj/S/GU8PRQtoKbvKgL8W+914toUa3ZqBwJsgqKeTKrj6VhrBlNEcDHO6R/WYdsHa4/YV4ffyWWAGV0eK3J1uT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+LPs/nR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+LPs/nR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B357BC4CEF7;
	Thu,  5 Feb 2026 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770284806;
	bh=S8GWTbHSUSmGBLSBZuQUge/vjM5tsjoNTajz0GloTcE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W+LPs/nRlFFn5c5xmNnDKh+jmVZQ9ZE83U0xUWTQJQ/KgyC8rjRom8ircsRctbE9z
	 2+pIhR2hYicwth5/ylbd9LIFkWmDsD8cKlvhJisGUSPEE6AuhkCz207vPLeIwUYUSj
	 JzPycfZsDfQjrc/JWptn90C2OREF2pHTGCz85ktbcx6VW5VQId0merLIWOLgSz0S14
	 z9L3lMBcv43EicssHrHsAjt1flA+o1SfUkVAUJiVdFrMZIL8iWtOzF7ZxPPRx/E9x/
	 ZEdELgLypG/NGpMY+vFj/zeT0FlPuv0cOHmtagCza/k0xGkLJx9OZS0vHywIen1wng
	 kuutQE3daojSA==
Message-ID: <d1326460a84c0abb955b85321ef9db596c10ecd6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/3] mptcp: allow overridden write_space
 to be invoked
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>, 
	mptcp@lists.linux.dev
Date: Thu, 05 Feb 2026 17:46:42 +0800
In-Reply-To: <85d8137d-77a5-4bda-90e3-29b399431c8d@kernel.org>
References: <cover.1767504329.git.tanggeliang@kylinos.cn>
	 <2efc3455052c3a33cad0c8744b171dfc6e7a6d8a.1767504329.git.tanggeliang@kylinos.cn>
	 <85d8137d-77a5-4bda-90e3-29b399431c8d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2026-02-04 at 12:56 +0100, Matthieu Baerts wrote:
> Hi Geliang, Paolo,
> 
> On 04/01/2026 06:29, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > psock may override its own sk_write_space functions. This patch
> > ensures
> > that the overridden sk_write_space can be invoked by MPTCP.
> > 
> > Note: This patch was initially included in the NVME MPTCP set.
> > 
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Co-developed-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/protocol.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index cd5266099993..f5d4d7d030f2 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -1014,7 +1014,7 @@ static inline void mptcp_write_space(struct
> > sock *sk)
> >  	/* pairs with memory barrier in mptcp_poll */
> >  	smp_mb();
> >  	if (mptcp_stream_memory_free(sk, 1))
> > -		sk_stream_write_space(sk);
> > +		INDIRECT_CALL_1(sk->sk_write_space,
> > sk_stream_write_space, sk);
> 
> As I mentioned on the netdev ML when sending this patch upstream,

Sorry for the trouble.

> there
> is something fishy here: sk->sk_write_space is never set to
> sk_stream_write_space here with the MPTCP sockets, but to
> sock_def_write_space. (Subflow sockets use sk_stream_write_space.)
> 
> In other words, this patch changes the behaviour, which was not
> supposed
> to be the case, now calling sock_def_write_space() instead of
> sk_stream_write_space().
> 
> So either sk->sk_write_space should be set to sk_stream_write_space
> for
> the MPTCP sockets (I guess, I don't think sk->sk_write_space() is
> ever

I just sent a squash-to patch to set it to sk_stream_write_space for
the MPTCP sockets.

Thanks,
-Geliang

> called with an MPTCP socket for the moment), or
> sock_def_write_space()
> should have been called before (then a fix is needed).
> 
> Cheers,
> Matt

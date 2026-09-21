Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4245D19E
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984774; cv=none; b=hYOztaua0PN2OZzw9O1PsgAA/iea2yrw2MdA5Pb8/m9n6pMkAhf7EZOBEaNqKMT7YfJNyam92EiWeN2XHghNbFROoNDdp/jjdaXng0q5XlzM1dx+TPt7hfxWEReiOI2mhN1DwdinU9K2ntnWyqZnIFYda8VTCMIHzmQrvRpIuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984774; c=relaxed/simple;
	bh=N8gTYoja7HMuc5aANBgq0v6ZVckjyzqVhIylHUMj7BM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ke8QSmKaXfiS0mBtjE/sEI6Jr+jBg124TrEbmYgp1s+zzLqLlGU/6JypA8exZIGIJCNyT6AMdc+MfuHVSrbfxm1wIXL8L2xiGNatg3AzfnAS97h1jJB4I/l+FP1sl30NWiTfI3uzL7bHfp6n/Gj9PmdSo1AgNkjJ9kw+2RrXBZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciV0Uv5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciV0Uv5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A5A1F000FF;
	Mon, 21 Sep 2026 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984773;
	bh=gGYrDKiswJDFdko15FCudeaOT863H4aNBvHYnnuiRYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ciV0Uv5qU/Db6+F5JtToRwK1XXRhBJ29+//e8zaX1WxvJyYPy+wkCQfg3qFNggC8q
	 4gNvex/fMP3OyotbmlQtgnKQ6WGWVQARd97Y3pMZuQLTk1p9BejpgeP8BRnvfrBu5c
	 L1GJXkdfBLqlShFyNowK+pW5hLjHMR0CBcrJgBBQ38yKzA/2zE4QM3LW5VjVMgXHx2
	 hsFIayAjOWxwNVWJYhrJjStnilBUfiyf1RwuP0eIaOOqwICCTXEIQoCQqwblpS7A63
	 tWcWJC2XVxzpnFtSJUTaXpsSxQqxeE60kjjD1v64kLhzxm0S+ToG3NdEksjBDMjuWU
	 C4KYVxalEGcmw==
Message-ID: <a29bd9c420ec8c70ca0091690f441dcf14c699e1.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: userspace: unify entry free
 path via RCU callback
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 21 Sep 2026 17:59:28 +0800
In-Reply-To: <c0d1afe2-3e24-47e7-8863-8f0ba018fce9@kernel.org>
References: 
	<de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn>
	 <c0d1afe2-3e24-47e7-8863-8f0ba018fce9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for the review! Sorry for the late reply.

On Wed, 2026-08-26 at 15:51 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 01/07/2026 08:11, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > In mptcp_pm_nl_remove_doit(), sk_omem_alloc is decremented
> > immediately
> > but the memory is freed later via kfree_rcu(). This allows a
> > CAP_NET_ADMIN
> > user to bypass the socket memory quota and exhaust kernel memory by
> > accumulating RCU callbacks.
> > 
> > Fix by using call_rcu() with a custom callback that uses
> > sock_kfree_s()
> > to free the entry and decrement sk_omem_alloc atomically. To ensure
> > the
> > socket remains valid until the callback runs, take a reference with
> > sock_hold() when storing the socket pointer in the entry, and
> > release it
> > with sock_put() in the callback.
> > 
> > Convert the synchronous freeing paths in free_local_addr_list() and
> > delete_local_addr() to use the same RCU callback, ensuring the
> > socket
> > reference is properly released.
> > 
> > Additionally, mptcp_userspace_pm_append_new_local_addr() now checks
> > SOCK_DEAD under the spinlock before allocating. A SYN+JOIN handler
> > holding an msk reference from mptcp_token_get_sock() could
> > otherwise
> > race with __mptcp_destroy_sock() - sock_orphan() sets SOCK_DEAD and
> > then mptcp_userspace_pm_release() clears the list, so a new entry
> > allocated after that point would never be freed and its sock_hold()
> > would leak the msk permanently.
> 
> (...)
> 
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index da40c6f3705f..250736eae0be 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -257,6 +257,8 @@ struct mptcp_pm_addr_entry {
> >  	u32			flags;
> >  	int			ifindex;
> >  	struct socket		*lsk;
> > +	struct sock		*sk;
> 
> Also, I don't think 'lsk' is used with the userspace PM: can we re-
> use
> it instead of adding a new one? (Or using an anonymous union?)

Done. lsk and sk now share storage via an anonymous union in v4.

Thanks,
-Geliang

> 
> > +	struct rcu_head		rcu;
> >  };
> >  
> >  struct mptcp_data_frag {
> 
> Cheers,
> Matt

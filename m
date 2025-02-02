Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471617FE
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738472664; cv=none; b=CM4qjhgx0lc+f5L+91E3g1QWcI0HVfpmAwKauSnhEX1m5JShldRN4iY7eBEJ1BmdBjPOoFbJhlql9lN1NAF3CJ79yr3wWfF3PvetA4YiBIVr8f+zj7d1vERuBKYqRy4lzgAf9LR6aY8D6i1pQHJlupk4Zi5jWcBYfHcn0s8eDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738472664; c=relaxed/simple;
	bh=VzbmJhP6Ov+yJgUxK0TLBBb+s5UM1JRIlT1vRQ+3PUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxiqlSshSSJzsJHMXcIih2HT1cjKDNlzZgNwNG14ddKBBrzZ7P+iinyhk2xIT8qJZcCoZRkiiOAOuEf+sE1NXZ67y47EIgqbvrKOsxx3ZCbsYjvHCqobJOtOgQH4Jy4wpAGpPgsZ8EDCL0bHmtXuXARs6KzgtQ0pAovaYAnKsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRG71L/p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRG71L/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DE4C4CED1;
	Sun,  2 Feb 2025 05:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738472664;
	bh=VzbmJhP6Ov+yJgUxK0TLBBb+s5UM1JRIlT1vRQ+3PUc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kRG71L/pOaHIDIKUunpG4ARgMEbamFoK6kQ+kRAd5vTCjrOLj0BT1Zdrg8J7XX83V
	 Rw96Ri5oRdnKNHdFiyo4MvaWZESxqAWLa0jPg7bo5yvO8NyMa3FRbu1B+HAU1Ole6k
	 yOc/TCTZoqmPZ9/balDqh3ClE2OCyjVyMhhJm9cLRB+Q/9EunksTLUNfLo3KY1TfTV
	 Q59BaTd3IDwDzOPI/c71Sjnq3cnpGG24+dctMoBHY/IUcYaeLdqknOK/QYXVDhhllI
	 J4/U8e2YXdtuurouJ5MJ5OBP2kP5zICWv/gzuVPHs5LUmeTk+GnCBoO5dYoJ+xEZc0
	 lfCRin6ifdl5A==
Message-ID: <50c69cd42e32452a46029fb0e93f6fb55e332d7a.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/3] Squash to "bpf: Add mptcp_subflow
 bpf_iter"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Mat Martineau
 <martineau@kernel.org>
Date: Sun, 02 Feb 2025 13:04:20 +0800
In-Reply-To: <3667814e-4e76-45df-90b0-2e3af7a081c8@kernel.org>
References: <cover.1737714424.git.tanggeliang@kylinos.cn>
	 <af7dca496d83aaf6fd7163f767ef1bd1abbab59a.1737714424.git.tanggeliang@kylinos.cn>
	 <3667814e-4e76-45df-90b0-2e3af7a081c8@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

Thanks for your review.

On Fri, 2025-01-24 at 16:04 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> (+cc Mat who reviewed the previous versions)
> 
> On 24/01/2025 11:28, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Drop the NULL check as Martin suggested.
> > 
> > Use the "struct sock *sk" instead of "struct mptcp-sock *msk" as
> > the
> > argument in the bpf_iter_mptcp_subflow_new as Martin suggested.
> > 
> > Use msk_owned_by_me().
> 
> Regarding this, do you mind checking my question on the thread
> initially
> sent to the BPF mailing please?
> 
> > > This set is only showing the cg sockopt bpf prog but missing the
> > > major
> > > struct_ops piece. It is hard to comment. I assumed the lock
> > > situation is
> > > the same for the struct_ops where the lock will be held before
> > > calling
> > > the struct_ops prog?
> > 
> > Can we restrict the use of this helper only for some specific
> > callbacks?
> > Or for only some specific struct_ops?
> > 
> > Last time I looked, I thought that you could only restrict it like
> > that:
> > "this helper can be used by (any) struct_ops". But then does it
> > mean
> > this helper could be called from a TCP BPF CC ops or another
> > unrelated
> > one for example? How can we avoid that?
> Because with the suggested modification, there is no more checks
> regarding the lock situation: it is probably fine now with
> [gs]etsockopt(), but what about later with struct_ops? Can we
> restrict
> this kfunc to be used only in some contexts? e.g. a part or all the
> MPTCP struct_ops, but not the other ones?

We use register_btf_kfunc_id_set() to allow these kfuncs to be used in
struct_ops:

register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
                          &bpf_mptcp_common_kfunc_set);

And we also check if the protocol of the socket is MPTCP in
bpf_iter_mptcp_subflow_new(). So this mptcp_subflow bpf_iter is
restricted to be used for MPTCP. Other struct_ops likes a TCP BPF CC
ops can't use it.

Do you think this restriction is enough?

Another way to restrict kfuncs is to set get_func_proto of struct
bpf_verifier_ops. But this way has not been applied to other BPF iters.

Thanks,
-Geliang

> 
> Cheers,
> Matt


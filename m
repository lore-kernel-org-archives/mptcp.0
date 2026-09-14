Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1C312834
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384315; cv=none; b=Q0h0gMi6U29oAoGh0K219BVWuF2bcL5g9JTqYHLy6ifkwyLBaafE6fzp/Xww+ttqbI/dfgGe6kww3XYCD2Rw5K1Qpt2dQJdVOh0oEXHQbGldXEmAcZdiNQ3WXaN/l4rukB2x5MxB8CTaPouh3yUPiQN9OLQospp/icxElT1/vV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384315; c=relaxed/simple;
	bh=/ARc4wqgQb9CYle9RhN79fol8abILITGt8jpVxEk1bM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qb7pEtYNxjLBSDop61kLcdQegPmrH6SxLSMV9VxJNZoTdcri5P27t98K7gkVlhAFw7GL86hGZQCLwBkHDI1ZAPL7Wa0a5jkPwf4Gu4inhV+vXOLlq1NgB2nZn9kbvt+Y5PUEdFhEDnYnQ4bV3jgC4OFs+8VdC7rKQKJlRyq11aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K61jUrzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K61jUrzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905901F000FF;
	Mon, 14 Sep 2026 11:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789384308;
	bh=Z4Iv6RNsmlZY3W6m/yKrUIz+lVsk0HmZbdpIvviXBJo=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=K61jUrzjsmBivzZimpqQzZGuZYF9qY5d7ZPDsfHq0k9gfpJN/7D9pPnsq045yvOaa
	 umHPyhpxosLaMyCw1Et9fYBP7UI5OTYgaa5ol+q3SJktXAt/1UzwQGox6eo8/ATLZQ
	 9RVNnHXB8/yW9BupubT55WzauuKhoydpC4MdINyfzF52MZRpznQX6BP+ZCMvzgE0W1
	 Jjp5sglfp6/jwSvJPcqgQxfeVu48/AvAdc8BjywOI1Mks+4Yx5huqzVdWyCReyCb/O
	 vc72kCacqv77YKWmUZMvju6+HbaKS4CESTUt+rrsztkUVATh6gGbpCKL7ZtL/JXoCL
	 v5s0AjLvzveSQ==
Message-ID: <09d5ca0458d9add4c9054c246b73b785a48326c5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 00/16] MPTCP sockmap support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 14 Sep 2026 19:11:44 +0800
In-Reply-To: <90b59b07-8200-4990-8186-6e04844c87e4@kernel.org>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
	 <20b73dd157c0e948ba2b33c3600f33097fab5299.camel@kernel.org>
	 <90b59b07-8200-4990-8186-6e04844c87e4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2026-09-14 at 12:58 +0200, Matthieu Baerts wrote:
> 
> 
> On 14/09/2026 11:48, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Sun, 2026-09-13 at 18:14 +0800, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > v5:
> > >  - Patches 1-4 are from "Reduce the differences between TCP and
> > > MPTCP
> > > for TLS usage" set.
> > 
> > I put the four patches from the "Reduce the differences between TCP
> > and
> > MPTCP for TLS usage" series here because this "MPTCP sockmap
> > support"
> > series depends on them. Actually, it doesn't just depend on these
> > four
> > patches - it also appears to depend on "mptcp: remove CB offset
> > field"
> > (see sashiko's comments on patch 9) and "mptcp: implement peek_len
> > for
> > proto_ops" (see sashiko's comments on patch 13).
> > 
> > So this series depends on the entire "Reduce the differences
> > between
> > TCP and MPTCP for TLS usage" series. I could use "Based-on: <...>"
> > to
> > trigger CI based on the dependency, but Sashiko doesn't recognize
> > "Based-on", so it won't be able to apply successfully.
> > 
> > Is there some Sashiko feature that can handle this kind of chained
> > dependency between patchsets?
> 
> Not yet, apparently:
> 
>   https://github.com/sashiko-dev/sashiko/issues/49
> 
> > Or do I need to include all ten patches
> > of the "Reduce the differences between TCP and MPTCP for TLS usage"
> > series in the next version? I'd appreciate your thoughts on this.
> > 
> > Alternatively, let's first do the review of the "Reduce the
> > differences
> > between TCP and MPTCP for TLS usage" series - it's already ready
> > for
> > review - so that both the subsequent "MPTCP KTLS support" series
> > and
> > this "MPTCP sockmap support" series can move forward more easily.
> Probably best to do that. I admit that with all the different series
> and
> revisions, I'm sorry, but I'm a bit lost regarding the priorities.
> What
> should be reviewed first?
> 
> These series?
> 
>  - Reduce the differences between TCP and MPTCP for TLS usage
>  - mptcp: remove CB offset field
>  - mptcp: implement peek_len for proto_ops

Sorry for not being clear. The "Reduce the differences between TCP and
MPTCP for TLS usage" v13 [1] series needs to be reviewed - it includes
patch 3 "mptcp: remove CB offset field" and patch 7 "mptcp: implement
peek_len for proto_ops".

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1788245079.git.tanggeliang@kylinos.cn/

> 
> Cheers,
> Matt

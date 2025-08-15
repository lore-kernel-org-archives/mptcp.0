Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC8EEAB
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301804; cv=none; b=FCkerkVaJIsIce7xjrHttIQDCAodGoVfjj1hZvLOFHBrotzijPy6cvXQYHwxNg93JTFLgK0/QpotxlK81hCwtxeeXCrrK056oOsMQJZEmZcQxzweTYpErIObWWB5z63pfkVGvjrYRObsq1nmLR2R9kAmdOPKVU1M5jmzUTpeVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301804; c=relaxed/simple;
	bh=1zTeeis30nR4HhSSI+ve7MabrbxOFAwwuhSugiMUbTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a16rc66R+6TRraWz1FdEN/ndlRvgXwPEnIN6WlLKYPSBegoq6w8ppg4n38qMoMHfbtiMWRSoKaxiEtasIoMkvyUT9cpHMHE60Bkb5p16djSTjjM3g/rWDuOmocrtbZBqBUbeMRVxIJwaFPwzUH9qMN8vlWwSxEvXH4KsninSnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IegLU5zL; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IegLU5zL"
Date: Fri, 15 Aug 2025 16:49:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755301800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AStwkjtYPFPs1losmNujuyfgT/P/Bko56FEl6sEmJLE=;
	b=IegLU5zL8xqeUevd5W/ZUhA7+P0SoQWo7A3zgD9QHDVTKAOuGgz2faXZ+MVoaRs4rsFHBE
	+UT12MZslTrYzjw9xGeBxraKE859jeYtIwU/Cbz66QXlM3LFo+xlBY2ccazs0qnujoTiOa
	oXsDvKyCz0YyomNTrTSxQonC6Oyhdlo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 net-next 04/10] net: Call
 trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
Message-ID: <pnlok4z77uygki2roci4sn32fosakjyciahfmtg5rnzj5vlkmy@u7jogibgoybx>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815201712.1745332-5-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 08:16:12PM +0000, Kuniyuki Iwashima wrote:
> Initially, trace_sock_exceed_buf_limit() was invoked when
> __sk_mem_raise_allocated() failed due to the memcg limit or the
> global limit.
> 
> However, commit d6f19938eb031 ("net: expose sk wmem in
> sock_exceed_buf_limit tracepoint") somehow suppressed the event
> only when memcg failed to charge for SK_MEM_RECV, although the
> memcg failure for SK_MEM_SEND still triggers the event.
> 
> Let's restore the event for SK_MEM_RECV.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

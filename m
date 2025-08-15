Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4FD1E8332
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300706; cv=none; b=FyL412XzPyFbxB1jsAyBn3u7zUkJZS5OQHrgF3BC0s0a2Mv8D8p54waYfTufXcBJBi1ThzZx6NuQMagPph05OHb6VH45BFsF0y5qfzbwB292LVSBDCyJDn6uZVtwjqfQPSH4CzUsWlmdPIPgAo0MnbDAhzLpQyqvq+oJwOw2ygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300706; c=relaxed/simple;
	bh=IjyK+DpeelkhKjQ4pKnvMKVGUp3feARBxTF26AxXLAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQIYtUh9Lo3ZRC22ER2LfI/HjsultP0J0TB11FVlSz+e2lz33PjdfA/vxPP1JygBJoS0lrUeN0n2qsVYSdkubcHjKD8VyWSsnjpixAYxku7GmD/DcbNd94DlXvd3iMTA15UdPOwQMWQOe2oq9cq9uoKmZU+0/i84PnHF6N/TKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vUalADxH; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vUalADxH"
Date: Fri, 15 Aug 2025 16:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755300701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8mWAMiGacIPdo/U9tWrZ4G95PCsJeEqc6aHk78b6x74=;
	b=vUalADxHq4n5TJyKV8RytL6pshWYqmbgSJ52T0tz2UYUci8EEBIB85xnniIlNi5ddQLAR7
	ucGIjd839HqjVorE6RTr1GxfMme8r59DDlekkpWP/EcvAs2oI7tWmFQdBFW5MpBXbUHFK4
	+Rh2quaCh0LQ46ltOhdBynDEnItymNI=
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
Subject: Re: [PATCH v5 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <3x5m5rvbvtnta6lqyyx6k3uew4zhg5nxt2wmadkpi5t6tlsko6@peltw6axwvkg>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815201712.1745332-2-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 08:16:09PM +0000, Kuniyuki Iwashima wrote:
> When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> sk->sk_memcg based on the current task.
> 
> MPTCP subflow socket creation is triggered from userspace or
> an in-kernel worker.
> 
> In the latter case, sk->sk_memcg is not what we want.  So, we fix
> it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().
> 
> Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> under #ifdef CONFIG_SOCK_CGROUP_DATA.
> 
> The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> correctly.
> 
> Let's move the code out of the wrong ifdef guard.
> 
> Note that sk->sk_memcg is freed in sk_prot_free() and the parent
> sk holds the refcnt of memcg->css here, so we don't need to use
> css_tryget().
> 
> Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

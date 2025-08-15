Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058DEEAB
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301974; cv=none; b=EEGkZYv/6vc/sPlGr1udsLek1VpYq/Rsh5ySKtoMNI8OcfrGmzLD1igjN7PDgBlc1jT+/IswfJgDzj8Aabkrr2864xTbxtJpHZBW0O9ytJ6qw0mi4Bj9SlTsbPJCn9BKsnS3aKRjzM1i0d2Uyb0TWP0joBR6eQA31NKy4/ol8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301974; c=relaxed/simple;
	bh=DwhAXyRjwbbyTokqiNuVIVxgm2HNQRbCisfELT54B5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwBKvxEgYix0dqerTZ69BN7+8p1l/0X1IBVqUYnfzP+ZIFjsho0wjhN5tsrW84SEwEaMusIXyO34RRQZRSLeOpMseCl27+RrzoKETA5iLIFJobURoNwpHkGzvHQQZ2hxtF5qSRYJ6si5l4nP8BnQyWsFTgDa3zkAFutqlh8clvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dtc29LYM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dtc29LYM"
Date: Fri, 15 Aug 2025 16:52:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755301970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44mrTSttEiykRrZrwK94sCaa7posB77laqbOo+14xpM=;
	b=Dtc29LYMtA/hYmueZXIsJmfMnkavasnCVPDJHF3t9HUseuMaeHO/I9+XMGcy1dd5Di3tAR
	z0q5EKjvP/AqSn7PrGOGunGBOrSSw0noHpc4QA0/sLDYOUKHzqJRU+/NPRnaoIbhCNJ4qw
	ENJpET8DF5R6dD8KrMALzgQIYWjwpC8=
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
Subject: Re: [PATCH v5 net-next 05/10] net: Clean up
 __sk_mem_raise_allocated().
Message-ID: <ntttvqtkf4epnw2cstpjvdrokzkhgjcc42asuxrmoesk2pmvw7@hvnlluilnvbc>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815201712.1745332-6-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 08:16:13PM +0000, Kuniyuki Iwashima wrote:
> In __sk_mem_raise_allocated(), charged is initialised as true due
> to the weird condition removed in the previous patch.
> 
> It makes the variable unreliable by itself, so we have to check
> another variable, memcg, in advance.
> 
> Also, we will factorise the common check below for memcg later.
> 
>     if (mem_cgroup_sockets_enabled && sk->sk_memcg)
> 
> As a prep, let's initialise charged as false and memcg as NULL.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

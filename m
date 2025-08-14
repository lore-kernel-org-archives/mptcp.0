Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DE27BF89
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208327; cv=none; b=oAfT/Kv7a+EnV++i5PrCaZ7rT3m8pmXA95X970u8/wt7+qM3QaAyNkyvQotMJnivehthA+voiDS2b9vW8j0KVXoDyHoG47BOaCh6hbUkXP0R0ZiMPSna0ZEIl/aQiM8F8jt1Nc6HlEoB9C7+1IBkKHu6t3zWFaTfL3o0rH0KiuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208327; c=relaxed/simple;
	bh=WnREA4EmIGffwVYe+p1Wq3OblJahuKZyzXDj71NDWfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGDCpTYIE0k0U8Gbf5CGaKJwkmzJdS8HzlYb8vFob52/MrYJELOVGQIAzeW9sD1C0e52YL4R89MiUrAiAGk6zwI8aRMkTqG93ZhvO6qASrKXqNY4KrpIQGPSyaSGViMpuW+l4gFDVXevDHKCfIpanFPHSdh8aDRU6G8f8ulEBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IrN0ga1A; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IrN0ga1A"
Date: Thu, 14 Aug 2025 14:51:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755208323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqdnKsJcJkYJnPBTXkMaUgB7UwMWndORjmIX+sJaJew=;
	b=IrN0ga1A477YwjqiZcuceGQzNznS3SzlrYd+7GS0ASPe9/mRFVQjDkW0St+5h3Wo6IfN2U
	bK+IB04vdumaMqVNLxQSTUp64UctuI6IKtdcHZ+O6X5+e+u0taBRiEekPEbeFSshyg+tfF
	kXJ5/xN1Bf+d4xMzPkNwJiRaL+xoqw0=
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
Subject: Re: [PATCH v4 net-next 07/10] net-memcg: Introduce
 mem_cgroup_sk_enabled().
Message-ID: <abrvz262kbbw7imirtl5675x5mq2xaymvrzt2q6zlpw3znfiij@4rwtubwxkx6v>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-8-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814200912.1040628-8-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 08:08:39PM +0000, Kuniyuki Iwashima wrote:
> The socket memcg feature is enabled by a static key and
> only works for non-root cgroup.
> 
> We check both conditions in many places.
> 
> Let's factorise it as a helper function.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

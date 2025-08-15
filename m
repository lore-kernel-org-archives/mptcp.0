Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225701E8332
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300970; cv=none; b=H6SwJJM/0yqvuH4RlH/s0x5SFq370elL/rCdg/RecJgsIGQ1cUqhxrq6bY+bPpjykqCm9X1UfqCb1Q2rav32LD3sIp8dXbOe0tb/qSEKvu43BPYioeSOowV9oeX3gIUJFRlv6D/hvoFoLK+WJ3khlshj6C1YxNjoyx4m3PXctL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300970; c=relaxed/simple;
	bh=SvwHZHmtWJOIEAJLv2iF3ywLI6i1X93RNzFGEnQYfZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSkgcjQyLhWTHv5gPqhpJlg1nnjYc39jes7WfJi3Qz4+ZATuzurC7DUxgl4TYBg8sR4pIaxf41z+USJ6dfxeygw1V+PKk/ESlng47E6xJPfsbuew42vt0CFSiCY/SUi3OiEWpqJfbTpmRJxB6vvXuo4liL0cKq6IGTcH3MTxXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1KSa3iP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1KSa3iP"
Date: Fri, 15 Aug 2025 16:35:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755300957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcqbcpR+PPLolCotgvnuTTzNHDIi6DR9EnEVb+T8qy0=;
	b=I1KSa3iPECj/Wsi8SDf6g94yBfaB/ykJX7hBJxYk/MeurOgwRt3Sk68DV1gE7JOrcJSbcY
	sS3o3rH35F/X4THaHv0DGoc/9gWC8z4FmjfuNHO+JP535625SiUr+N62DFZU/dW5FX3q2H
	0O9H5Qfvt9jxbHkzIs+OHmZyUXbeSCM=
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
Subject: Re: [PATCH v5 net-next 03/10] tcp: Simplify error path in
 inet_csk_accept().
Message-ID: <a53fhshvazugtmvszdak5j3arzpf2dkiqy227bredme6drt7cj@5vlq2zyeyv3u>
References: <20250815201712.1745332-1-kuniyu@google.com>
 <20250815201712.1745332-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815201712.1745332-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 08:16:11PM +0000, Kuniyuki Iwashima wrote:
> When an error occurs in inet_csk_accept(), what we should do is
> only call release_sock() and set the errno to arg->err.
> 
> But the path jumps to another label, which introduces unnecessary
> initialisation and tests for newsk.
> 
> Let's simplify the error path and remove the redundant NULL
> checks for newsk.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

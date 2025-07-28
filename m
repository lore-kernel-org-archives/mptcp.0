Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827302750E2
	for <mptcp@lists.linux.dev>; Mon, 28 Jul 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718865; cv=none; b=NYuFmjpkn1ea8w5cvblNF48ilTyJshnkcXMqvC9o3S2hnZ3Rr47KjiHcFzukuIxRXEwyWRYUlui0I0MGxQgR6SijHWQ/tg/dm2/RISiscgoP7yMfd0vSWNZcDxuxQQJlkM6D9b7PnZs8UAZDAVqPTdVoMQoIMKU7bAbDvfvTsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718865; c=relaxed/simple;
	bh=RHNgwp/NdNGH7gkst2l4JDCtJhh6aUvSRSKnYwmtNtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZFD0f+83EkSNnfarsbDl5mWAYdqCUqtnf/oVDtsWo+2p4ofpPBUPUjC9yTyWi1Q+IWUZukCid2LGj+IVqoNVsSbfXJshbm/B/n2fuSTd3K2duzhekvOqMcrDxtPaIYKnSAvXtktFUWJC15ygP9VsBgIwHxCFM5L6QLzyNIPpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=W/cJqDYH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="W/cJqDYH"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70756dc2c00so1216686d6.1
        for <mptcp@lists.linux.dev>; Mon, 28 Jul 2025 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1753718862; x=1754323662; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAw+2X708It0VR8pZYVOK00HQXozxtPn6s8nfVW4nlE=;
        b=W/cJqDYHyXFlB8yzsRagfJixGO0e3wBZ+QV/AqcSemoOwJtPBEm4mOADJYfouvmcX9
         zd+qQ0MVR/gz2pcqvdIiDkkBD8W2EXAijc0QggZkqnvAnRwDID8o8VhD5q0aqMpJxtYX
         Z1ErNaWe98CMcRhOs1F8285mGRVEVAXgg4BZXQd4qy+oRcuqL5HAWN0HOdQV8OxGkeQ1
         aboF1XeNC8Foljn+cCwVUjVhVqXK6ooxQAy6hZ8YcKSnZA8lGgjUuU/q+ZRJmk50kpqo
         OhrO4tx/LaOX7WEkrH/tIHVM0o+KL9vvFRiv3pId2YTtqKZKqEKGuCfnqODzLlh0++Sh
         nZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718862; x=1754323662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAw+2X708It0VR8pZYVOK00HQXozxtPn6s8nfVW4nlE=;
        b=hzZww2MoXiEiMdq+uJAaN3aGtHhRW/ESsH1j3lr5Mqal9A06JKzaBcyDXV/SznO7eY
         EyUyrtEeY3zYkGSjb8qqXVuekMVoHpjikDS34JKht2sTvQdYeWAMkeCm7NHK4kuA116S
         mqTSjHl6S45d3eVQwVLWWfY0+eKAfe+xM1UZp4PlMYWCrJIebzgGrsuJM7V+uRNDGyit
         lxCjG4AkszyPzWpD+T9ix6yvyQs77AjrZIix8bBBGjvTwjdiDzNjV4yRh80wQKFBzB/R
         JiykxJuA46cAbSpdEUjxMJ+Su+Bx3d3WuB8Kx+1aD9vBEOWOGTt73PbjZ2GsWWeJIX4Z
         EN+w==
X-Forwarded-Encrypted: i=1; AJvYcCUBGjVS3wXaH9avw9Az7cxctUp6xuOAORDdheKoVd7mmgq3DD6hEA/dHhONkVPyynqTZ/i6wA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIx/tHmp5HYyDyIscMG4NAW5HdfhepeC1w1II9yNwTlsrpZAhm
	u1BunGx6rwxlnqMqXwlhbCrx3lzwwHK3HyidqwBGW4sAMGC2H1Mv2nbBWHPDkOPYYaQ=
X-Gm-Gg: ASbGncuWhtU0tD+jFlcLCqgPQoTlbYrMdyIrNRp/kc9kItomN8uQBJXgFpoO4r5Tazg
	aMKqMcLOXG+Gx7B3/aC34uMgdmkoBG4HxUXPSktzoh1Bd6VjD4ZlxOIrHpgp7x08yjFsxZKTU4T
	/E9IAs6Z/uj2nEjjNuNS9sURakrwui3kEKb2dSJqKk8EuXRB1M2LLPoij7R8oXaxS3xYgvcEnPP
	6s/+som+l+3CeMMtv7d42+b4l9RuCMCZM35mFpsg8In3qVQ52P1FwVsCiqLxNCt3C0C3oM7+cAi
	PpcBRZaK5wiw5FmuSp9JrMIkJDEwHW4OIxIZoXY4EOuzxmFwuCQ2HYi4FL6T/CEECHqlVtOSXjp
	oJpI1F58Yyxm/+WvBicjG0w==
X-Google-Smtp-Source: AGHT+IEaDZooEETiaWkCw4px/kQlCCmeui047F+bWZwnIBB50xOtbajOnYToq+ch+2hvV2HYIRrO0A==
X-Received: by 2002:a05:6214:76d:b0:700:fe38:6bd8 with SMTP id 6a1803df08f44-70720534e2fmr187905276d6.19.1753718861920;
        Mon, 28 Jul 2025 09:07:41 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70729a9657csm33250636d6.31.2025.07.28.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:07:41 -0700 (PDT)
Date: Mon, 28 Jul 2025 12:07:37 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <20250728160737.GE54289@cmpxchg.org>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721203624.3807041-14-kuniyu@google.com>

On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
> 
> When running under a non-root cgroup, this memory is also charged to the
> memcg as sock in memory.stat.
> 
> Even when memory usage is controlled by memcg, sockets using such protocols
> are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
> 
> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
> 
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> In reality, this assumption does not always hold, and a single workload
> that opts out of memcg can consume memory up to the global limit,
> becoming a noisy neighbour.

Yes, an uncontrolled cgroup can consume all of a shared resource and
thereby become a noisy neighbor. Why is network memory special?

I assume you have some other mechanisms for curbing things like
filesystem caches, anon memory, swap etc. of such otherwise
uncontrolled groups, and this just happens to be your missing piece.

But at this point, you're operating so far out of the cgroup resource
management model that I don't think it can be reasonably supported.

I hate to say this, but can't you carry this out of tree until the
transition is complete?

I just don't think it makes any sense to have this as a permanent
fixture in a general-purpose container management interface.

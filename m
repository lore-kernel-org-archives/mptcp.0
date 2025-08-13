Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F812C0F8A
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090020; cv=none; b=L97YSFeBGvkrQniNK2VbDPV4o4chAebJrH7vIqmEFZMLDx9w3gWgdNhxU/t60cpFUMGj3vRBOh/GXQXJX4CJ3D2Ah3EdT6Nkl+yI8oZBFDW2M4TWf2Yg/T1nlkFeztlGdya9kciyTWpUilwCbcgNj1v6b0hcpvWUu6MOcLmhGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090020; c=relaxed/simple;
	bh=kbkSRKewyFcnbz3jsVNMUibXidkHNks9qnhNs9m/Qbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjolkFkIgGdHh5Z+ysAmVkZ+ngEbYP9ttIs8xzRSxaeuyrLQTAH80rXh094SLNKTHIUr95sYMcmkaDNQaQXSXy4zaMIirpzVOa/4ps7v4IFHFg7l7ZovjEOgTKOwCjeTFbF67HI/VRWa31jGVDCBPzRHebdC4egBcH0lfD5X+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=WQM1Yuva; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="WQM1Yuva"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70739d1f07bso77115286d6.2
        for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755090016; x=1755694816; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/BrlZbr/T7l2ZRE6UEhDbhwVQUKfgdvzKuP95OrSQY=;
        b=WQM1YuvaP2R39I146qAJX/OzMMZFmxF+cE99Im/SRfwVOpNSdUqAp38qGROuucl3XD
         zkEB3WrgUl2xseZqgvXf1f6GBBsW48Ve4zahBhARTHuNIuKnbgjCq7D2f3iNSqx+I9ud
         +uQFGIiCHVYNdsNiY/5Afubg3EvZbmh45VRSpkXZZErauO8lnam3xRfd2282E9gEcMLC
         VElLJU04pXgwJyQYMBHQ2h8ug7M0lJMXPHxbhpC4rDIEkwWwKSeK6eHLRkhKeHdhEzW4
         +JS8DNMCRjoZP0EFdTa+rLtMN1ABusTbZssxe0KZPnDXTcbBn1bNv1jp/5lwHj15n2JK
         OkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090016; x=1755694816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/BrlZbr/T7l2ZRE6UEhDbhwVQUKfgdvzKuP95OrSQY=;
        b=LXUaKB+fHEKM/blTd0mu7ELsO3FXkldCYzcN/pOL4vAW65f2tDMdks0/kelfGRtzzQ
         WqWZrP17LYVl6qgdYTQFUR+9YUTzJyX1MensfAGUjnK/EJhL8yLLoeUJBuZI19a7N8KT
         BKy607zUz5HSgWjbYxuPFhp1XrviCQ1riXXI9B1P38W+n1sfmuszohbaCqge56ZhoTWt
         aVCtAGYbga9EV6oz5GHO8zM0k5wuSPD0g0PzLE7pR3/2OVOe7GvlrdKma6lDdP9SKXFi
         ydH0E+8Mmc/PhY4BRIBV41lB7wAy7p979t3NBjEIIcNT1pcLShVErQFI+kiXhnqe6E+E
         GhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNoZdynMreB4IhG5k4FZD4r7ZQHJtxl8ZQBIoYjWdkq9R3TGq4JbKXFgjTtVOEdySBmoJ41Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLc0abov1F+pOMD+pS7vYFmlDRrhxnzetfONCR/Q2v0uyaH2gf
	f/cO5DnygWH+EsPEoyDJa5E5BVYN6mdVEV0kdJ8/30+wz3HtQWcZpjqlCjqh66zHBtc=
X-Gm-Gg: ASbGnctc3cEvWpP7i9Jjvb2v+tg+gG9B3Hxo+hvOD4cTwKbLDNBwwyTQjSDR8z3VU+e
	IVZn7so5XXpHWAyRNULtpsi3rymDQ9KbABeg9p6BuLAHl3/oNMJCSblL3LVVSv/mxlKzmgQ9UrB
	7x6WaU1S5UtRUSL2eScgeTqYWemWxEULNdIHs+Mkpd51TlfYupwUzQ9qND1EjYMK3wbKsSc7bTd
	o9HP2KJPHt7QTMqypt5XU9VQ7EQuGz8j+8FXkP4Qmx3CoZDLjCWG+VB467Nugiuobm3aghbwlY6
	9VcH8QFLp+cgdrs2G0Ltzd44DU+B0RRHyD6XaIfKOtIpz+toC87bqTMSrkwOeO9eYrmuh5wjrI0
	z/Qsd+LTLFUNS+fUAFZ2PQscr+stjHNoU
X-Google-Smtp-Source: AGHT+IFgGWoMlnm/Y1OcmFOyyn2dsuqu/R1TVP5M10fhTPzIDW0MUbQN+HwN5hLswo+SbRfYuOk9QQ==
X-Received: by 2002:a05:6214:27e5:b0:700:fe38:6bd8 with SMTP id 6a1803df08f44-709e8843a0cmr37405206d6.19.1755090015449;
        Wed, 13 Aug 2025 06:00:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70920e28dbbsm188318676d6.62.2025.08.13.06.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:00:14 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:00:09 -0400
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
Message-ID: <20250813130009.GA114408@cmpxchg.org>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812175848.512446-13-kuniyu@google.com>

On Tue, Aug 12, 2025 at 05:58:30PM +0000, Kuniyuki Iwashima wrote:
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> In reality, this assumption does not always hold, and processes that
> belong to the root cgroup or opt out of memcg can consume memory up to
> the global limit, becoming a noisy neighbour.

As per the last thread, this is not a supported usecase. Opting out of
memcg coverage for individual cgroups is a self-inflicted problem and
misconfiguration. There is *no* memory isolation *at all* on such
containers. Maybe their socket buffers is the only thing that happens
to matter to *you*, but this is in no way a generic, universal,
upstreamable solution. Knob or auto-detection is not the issue.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

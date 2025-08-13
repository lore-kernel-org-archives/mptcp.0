Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ABE2AE90
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116511; cv=none; b=UlFK5pCdR6bDF7vB6M22S+8c81YZ7J8B+rN1pqcy7UwJb1i+ruOz//cOUC7jjc68n1L1Fv8BN1orCZddQgw5gEgzXdBA/jTBLsjhOikKH/2nNm/r4WbvDq5MTl9n4rKqcsoU4WsGGm5TVgpqYbgbUOcktXvcY6q8Yn7O9f1Qx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116511; c=relaxed/simple;
	bh=spEw6iTr/TlKdoJ9qRoclMR04HEh7O0DeIyHVYrMPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgy9Wd8kHymPxGdfFnMbtoB+pCa7cjw4PdpjJoCERZSZwd0s2AX+CBfk+iN8lVpR4xgOVqRl8FAhxhfX6FIqEuR20mtLaoEdFHykRIdGhlHzWb/sFm9wc0WutDryUor8YChvSq4wtAjVuopLtyJwUpKe/pMXYmiEE6DiKdskVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nHOMatVK; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nHOMatVK"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8706a6863so26142185a.3
        for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755116508; x=1755721308; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H30kUHUoAp0mgFKEUbjujIS0Xnkk94c0v9Jq8jaPeYc=;
        b=nHOMatVKeA4JRXyipCoMFC5KNc2jpw/7s+xN9TnNaC4ZhyJprIjveWKgMQsP9ey9el
         vTI1aCl3pMGKE4wUQotdJckivfFtzJFgzMrSUBjb5y2uhL9EnVR1iI1ZnhMePymsDLfT
         /BuAGy9PZZ7Cp/yCDgiA/gtAUxq2M8QfMonbOqZN0Wt4ypQrdlaRK1wCk37o+Q/abbcG
         3ViRnmbU/fhTQ8zRI4HZfjGRnOcZ+VNlMZAFTrngZpzV5bQs7Xvm0o6H06puNvrkE7Gi
         dol1wYPX3W0tIXQx2nmpEg8YrKJFZadTsuGnrnvZk65Db7CZfRRQxuxjCebaWsPQBzbg
         5Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755116508; x=1755721308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H30kUHUoAp0mgFKEUbjujIS0Xnkk94c0v9Jq8jaPeYc=;
        b=BM84eGe2RPKq2/1xXu3bC1FMtxWBldW0ZflTkuNqpO049cAqNAiJ6t8DIYyDUHvoDC
         KNXXWOx+hzPbWu37h0y/odUY0ybPeCT7/64XJzqBvjhN1AB4MhJE5Pm8/hnbxplYcgSx
         TeI0gb1GTjM5pKf73Gp0DZMWvCGBPggI9dO1FwE+OKFF+F30dW1iq8dH4zY6TykCCSMr
         ThckpX5KfC3qQnEfOROgEi27RQEuoxlIvT/I6pjkAo3lMR7MA3h5tR2hFgvAY6SsfZga
         KG+OJshJXpNI0dpFZTsJjqKWkeoymYVka16BWUQsdW6zpsz97tCbiycVSHdSIZiYAr3/
         JFfg==
X-Forwarded-Encrypted: i=1; AJvYcCWPMKsDCMo3zQghZCy+Asc0IuW18fZko0Rq3vbz6DKn1DVzkXNm9ORFPKDykOCPvl9Ft8uKQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCdC/tPnpcc3GH926n9+YpLbLCx45/Qgn5SZcYLvPD2WBY7fXX
	oItaPRVC2+21wigJhpH6zbQJN2pm7KCc7Ynjbiew03r2bqb5iTbnhKSXCJcpkUf1zXK/Z3iTo2P
	7IawN
X-Gm-Gg: ASbGncvlYeZptnQXPk/lwun3r57B8t/mz2JjgjlfqPTBhpCX9oUCoxrcKVzRWXeRE+l
	vLJrUTt4ks6TVwzhGi3pcEbtYuvHG3iM1qq/8QkMmAtEPdADAVKklMPpGWsG7VSrsgseG3zEu/y
	iE3NEHFd04mhffXHVRi90/bAhPoHxY5ijJknQGMyBPzHoOmIm5SFziljK+Ox7NI6koPgmtaX7S8
	SFleo38JOli/B5AMoRIazrMzzkWVk7dszUFtmG8YW1CrjngR1iphIxbVNX9wjIFcZ1t5sT9V7sU
	pblkAnYNkvmXDxAtO20URorpQDd79LrBgwdD+YfdpzkNmSrBrtLPKEyDULH+ygAAFyLbOd/2MFM
	u4ASqzUZFP26ezVmtoWcsFQ==
X-Google-Smtp-Source: AGHT+IHL4RX8mGUQFHn3xTKxG6noHoTer9v5afSRdyTGpU+E2ho9o1DxodPcyvf3+YYPPRrSEMF5JQ==
X-Received: by 2002:a05:620a:3bd2:b0:7e3:28f3:8a5 with SMTP id af79cd13be357-7e87045d632mr87942885a.28.1755116507799;
        Wed, 13 Aug 2025 13:21:47 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e8079cfcc9sm1486333285a.29.2025.08.13.13.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:21:46 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:21:42 -0400
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
Message-ID: <20250813202142.GB115258@cmpxchg.org>
References: <20250812175848.512446-1-kuniyu@google.com>
 <20250812175848.512446-13-kuniyu@google.com>
 <20250813130009.GA114408@cmpxchg.org>
 <CAAVpQUB-xnx_29Hw-_Z4EbtJKkJT1_BCfXcQM7OpCO09goF+ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUB-xnx_29Hw-_Z4EbtJKkJT1_BCfXcQM7OpCO09goF+ew@mail.gmail.com>

On Wed, Aug 13, 2025 at 11:43:15AM -0700, Kuniyuki Iwashima wrote:
> On Wed, Aug 13, 2025 at 6:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> This change stop double-charging by opting out of _the
> networking layer one_ because it interferes with memcg
> and complicates configuration of memory.max and the
> global networking limit.

No, we do want the global limits as a backstop - even if every single
cgroup in the system has its own memory limit.

Sure, from a fairness POV, we want socket buffers accounted towards
the containers' memory footprint and subject to their limits.

But that doesn't imply that we can let the cgroup limit be the only
thing curbing an explosion in socket buffers.

This isn't about fairness, but about host stability.

The MM can easily get rid of file cache and heap pages, but it has
limited to no control over the socket buffer lifetime. If you split a
1TB host into 8 containers limited to ~128G, that doesn't mean you
want to allow up to 1TB of memory in socket buffers. That could make
low memory situations unrecoverable.

> > Maybe their socket buffers is the only thing that happens
> > to matter to *you*, but this is in no way a generic, universal,
> > upstreamable solution. Knob or auto-detection is not the issue.
> >
> > Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Please let me know if this nack still applies with the
> explanation above.

Yes, for one I think it's an unacceptable behavioral change of the
sysctl semantics.

But my wider point is that I think you're trying to fix something that
is a direct result of a flawed approach to containerization, and it
would make much more sense to address that instead.

Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5B3845B0
	for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381373; cv=none; b=lxVkrlKS8GV0FC53XxenMZkZ79QbqesseNQQYynfg/3eTqlfzXqpvw8PLNpVLucEoPblzuJQOBIseQckbCPhEejMuVec1nveNTXOh4m00Fq2lw0p/0qqZnukPc0ZHj7wZsMQC0tQG8etHWSILhgUTxY1PBYZDZelodP2NS9prnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381373; c=relaxed/simple;
	bh=5oOEp+Z8TWEm1FMC00+w7WGonIhVFqm3IuNg3fX7YDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i+MP6OOAOsiDeNGjbfYqas72auTpT/1dC148DEArim6gOH9xXe9NTra1TiHl0Axgb75Qu2LcauEFctK5WvhqQK5kVsfcwCaObR4XtMa/f9ORxgD6ZXp/sNKIQo4zs6ze2nhgTmuSZ70blMocQAsBtEP7Xp5KCx3xm6QR3nUOybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DyMNekYK; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DyMNekYK"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so1475777a12.1
        for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786381371; x=1786986171; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+SYd7rUzqwEwb4heARPv6XiZusWTQQc06FiEkDy9tfU=;
        b=DyMNekYK1vahtTnYfR9J13Znjq4e/ryxTtll0X118DVCEsdAcK34GFMhncGHX+f+zw
         pQ8r/JQtJcDo1mypnHUDi44HW1F26ckWCJnc60rXuqJ9nwmyA/DGJudAdIKujfvrzX+u
         gX3lEarvaKsicHm9M72knx17mEH+YTtczPjlj0yhlaFoG/5RFxvSw9DMK9WHlTk2hm65
         /a/SbHyJ73Pjx2VbGdVwBRV8KZc7BLVF5J6ggpjsFk3xYpEj5noFFiQYi2AQCVyU4rjr
         TPYDvdW7YFQdkHlfMq+FNAa7/gzwSx7Ib4Lsyzj9WNGq8+XtbLpqu25Sy60/ofccG5J2
         7oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381371; x=1786986171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+SYd7rUzqwEwb4heARPv6XiZusWTQQc06FiEkDy9tfU=;
        b=j73xWT3Jpb74YOU5esWibqcKqCDkpDlvGg9hfQwhlDNPPJXYnk0dsmbRT6iApUrVIG
         BpbVsQhTv/fbfXmTBlhu9/TSmPAHJzedM/c2hX4nhNcno0STQ+0b3bs+LGSnzp+L4w5b
         yIdN05ZRe1wUsZY+ojZpmnM0HOXPuUpznUEo+ATW83ryUmAvGJkstGzi61wCPeIseOY6
         Gq601tusOGuubDcGWzCG3ARMAQWqrtU7V4gA4WVACqo0uDnHaZaDGHYCTodxhWdKPls4
         gNczMZo747vyEnRGYtB61nXRokGNtZXFix2OCMuuuhvjXUCeGQMPHPQYVwX470PqV5hN
         qzsw==
X-Forwarded-Encrypted: i=1; AHgh+Rpvj8AjyA0775yP1ymPq3OHrpk4SdYFK7W4xQZNPUjDXis+pwkl/EmV6PwB0BzA/Gp/0hfJ4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyErlIDiw2qynN7WBGtHwh/lP0T5j0txJf32TgzX54c9uMKdTDN
	EEe2+3DSdFMSXX6XwqyDp4DxQM7s65yGqpNyuNIQpJoRFftNVCjIo+c2qfZ8O+71twWSs1p/9cK
	YwLdlJQ==
X-Received: from pfbkq9.prod.google.com ([2002:a05:6a00:4b09:b0:848:3e69:4b98])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1396:b0:845:eb88:3d74
 with SMTP id d2e1a72fcca58-84f9c9d8504mr2967730b3a.29.1786381370400; Mon, 10
 Aug 2026 10:02:50 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:02:13 +0000
In-Reply-To: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260810170249.3669017-1-kuniyu@google.com>
Subject: Re: [PATCH net] mptcp: upgrade network refcount before socket lock
From: Kuniyuki Iwashima <kuniyu@google.com>
To: runyu.xiao@seu.edu.cn
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, jianhao.xu@seu.edu.cn, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sun,  9 Aug 2026 17:19:49 +0800
> sk_net_refcnt_upgrade() calls get_net_track() with GFP_KERNEL and can enter
> direct reclaim. Calling it while holding the newly created subflow socket
> lock can create a reclaim-to-socket-lock dependency cycle.

I guess this involves NBD, and then it should be false-positive.

It makes lockdep complain about all sleepable memory allocation
under lock_sock() for TCP/AF_UNIX-SOCK_STREAM sockets.

NBD must process TX requests asynchronously to remove the dependency.


> 
> Upgrade the network reference before taking the socket lock. The socket is
> newly created and has not been exposed to other code at this point, so the
> fields changed by sk_net_refcnt_upgrade() are not accessed concurrently.
> The error path still releases the socket normally after the upgrade.
> 
> The PatchProof static-analysis tool detected a GFP_KERNEL allocation while
> the socket lock is held. Manual source review of v7.1.5 and current
> mainline confirmed the lock and allocation ordering.
> 
> A source-level check found `sk_net_refcnt_upgrade()` after
> `lock_sock_nested()` in the original function and before it after this
> change. A POSIX-thread lock-order model made the reclaim lock unavailable
> while the socket lock was held, observed `EBUSY` for the reclaim lock, and
> then completed with the reclaim-first order. The model checks the ordering
> invariant only; it does not execute the kernel MPTCP path. No live lockdep
> MPTCP test or reclaim fault injection was run.
> 
> Fixes: 1d2f3d3c6268 ("mptcp: adjust to use netns refcount tracker")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/mptcp/subflow.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e1f20ff8fdb4..a9f951cc6a0e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1786,6 +1786,12 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  	if (err)
>  		return err;
>  
> +	/* kernel sockets do not by default acquire net ref, but TCP timer
> +	 * needs it.
> +	 * Update ns_tracker to current stack trace and refcounted tracker.
> +	 */
> +	sk_net_refcnt_upgrade(sf->sk);
> +
>  	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
>  
>  	err = security_mptcp_add_subflow(sk, sf->sk);
> @@ -1795,11 +1801,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  	/* the newly created socket has to be in the same cgroup as its parent */
>  	mptcp_attach_cgroup(sk, sf->sk);
>  
> -	/* kernel sockets do not by default acquire net ref, but TCP timer
> -	 * needs it.
> -	 * Update ns_tracker to current stack trace and refcounted tracker.
> -	 */
> -	sk_net_refcnt_upgrade(sf->sk);
>  	err = tcp_set_ulp(sf->sk, "mptcp");
>  	if (err)
>  		goto err_free;
> -- 
> 2.34.1

Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827C1C36
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 14:35:31 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-34c5fec2a95so12078445ab.3
        for <mptcp@lists.linux.dev>; Wed, 06 Sep 2023 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694010931; x=1694615731; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGlUYGV6FKGTKrHXEc/8wfyJkTzTkG8Ak90V0Yv/IDA=;
        b=RntEhb+J3H4sF1zcP15PQhME2je4c7TYbmpHfL9g3r1ovaCEzUObNy1J3cTP82K1J7
         AHy/tGPIF696vvz26pu8WXPCxw1d5ODKNUiLUHuaiterQjooS+E42kh9lpTG3URpQ9YG
         3nyAaI6U4Vv7U5o4nMGeVnlIQjThT7M6UOeoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010931; x=1694615731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGlUYGV6FKGTKrHXEc/8wfyJkTzTkG8Ak90V0Yv/IDA=;
        b=LHtDFExf/cSlIk2y4FsXcaK5GjZGXYhZRNgbCE1lTv9jc5Aui+V75lyqXLf90bYjKB
         oBpMw+vkP/PSjnc2L7rXqfS6BrMKgGMBYehLjhi49LALDn+jD2YEWITIcQIspTrTt5lO
         zk1vTBfkr7JpKN9h8OVazF+Q9+FWRw6tuvbKyqAUNMwmx573T+xRYqrS0STI9UeemSO6
         NXv6Iv7+COeGJWnTMKP4hD3IIFhtq/Tfk4cX2j0joOzphFzAXI5xdHoaGnv5rshp3OhB
         o119MUjs3ABemwqGEaE0ZAzr0nyZqX5GXxZ/9siazaSvSuzCiExjiUXiMrzQFZ+PhwdW
         tyOg==
X-Gm-Message-State: AOJu0Yy8EyQgNJuDpib8UNmVA/aM/Gutxy9Abh/6g3IHveG7LtWiyDp3
	aJsixd/W4+1+kxeBZRwLgPGm1A==
X-Google-Smtp-Source: AGHT+IHsCY3MvLSvr8Ngr8FPPEj7HK/rV7+hrLWxXlyYEoQzLi6qAJ0h6qWiBxXIAAnxESC2vbm02Q==
X-Received: by 2002:a05:6e02:1d11:b0:349:86f6:e94a with SMTP id i17-20020a056e021d1100b0034986f6e94amr20928744ila.3.1694010930854;
        Wed, 06 Sep 2023 07:35:30 -0700 (PDT)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id b17-20020a923411000000b0034e1acce730sm3879620ila.42.2023.09.06.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:35:29 -0700 (PDT)
Date: Wed, 6 Sep 2023 14:35:29 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Paasch <cpaasch@apple.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <20230906143529.GB1127143@google.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <20230905111725.GA3737639@google.com>
 <ZPc+HGjmY2ZC4WO3@arm.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPc+HGjmY2ZC4WO3@arm.com>

Hi Catalin,

On Tue, Sep 05, 2023 at 03:41:32PM +0100, Catalin Marinas wrote:
> On Tue, Sep 05, 2023 at 11:17:25AM +0000, Joel Fernandes wrote:
> > On Mon, Sep 04, 2023 at 10:22:56PM +0100, Catalin Marinas wrote:
> > > On Wed, Aug 30, 2023 at 09:37:23AM -0700, Christoph Paasch wrote:
> > > > for the MPTCP upstream project, we are running syzkaller [1] continuously to
> > > > qualify our kernel changes.
> > > > 
> > > > We found one issue with kmemleak and its handling of kfree_rcu.
> > > > 
> > > > Specifically, it looks like kmemleak falsely reports memory-leaks when the
> > > > object is being freed by kfree_rcu after a certain grace-period.
> > > > 
> > > > For example, https://github.com/multipath-tcp/mptcp_net-next/issues/398#
> > > > issuecomment-1584819482 shows how the syzkaller program reliably produces a
> > > > kmemleak report, although the object is not leaked (we confirmed that by simply
> > > > increasing MSECS_MIN_AGE to something larger than the grace-period).
> > > 
> > > Not sure which RCU variant you are using but most likely the false
> > > positives are caused by the original reference to the object being lost
> > > and the pointer added to a new location that kmemleak does not track
> > > (e.g. bnode->records[] in the tree-based variant).
> > > 
> > > A quick attempt (untested, not even compiled):
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > 
> > I am not sure if that works. Correct me if I'm wrong but the issue is that
> > the allocated pointer being RCU-freed is no longer reachable by kmemleak (it
> > is scanned but not reachable), however it might still be reachable via an
> > RCU reader. In such a situation, it is a false-positive.
> 
> Yes, with a small correction that the object being RCU-freed is not
> scanned if it cannot be reached by kmemleak (unless explicitly marked as
> not a leak).

Yes I used wrong wording. I meant it is added to the kmemleak rbtree as
something that needs to be reachable, but cannot be reached. Hopefully that
makes sense.

> > The correct fix then should probably be to mark the object as
> > kmemleak_not_leak() until a grace period elapses. This will cause the object
> > to not be reported but still be scanned until eventually the lower layers
> > will remove the object from kmemleak-tracking after the grace period. Per the
> > docs also, that API is used to prevent false-positives.
> 
> This should work as well but I'd use kmemleak_ignore() instead of
> kmemleak_not_leak(). The former, apart from masking the false positive,
> also tells kmemleak not to scan the object. After a kvfree_rcu(), the
> object shouldn't have any valid references to other objects, so not
> worth scanning.

Yes I am also OK with that, however to me I consider the object as alive as
long as the grace period does not end. But I agree with you and it may not be
worth tracking them or scanning them.

> > Instead what the below diff appears to do is to mark the bnode cache as a
> > kmemleak object itself, which smells a bit wrong. The bnode is not an
> > allocated object in the traditional sense, it is simple an internal data
> > structure.
> 
> We do this in other places for objects containing pointers and which
> aren't tracked by kmemleak (it doesn't track page allocations as there
> would be too many leading to lots of false positives or overlapping
> objects - the slab itself uses the page allocator). An example where we
> do something similar is alloc_large_system_hash(). We could add a
> wrapper API if kmemleak_alloc() feels wrong but underlying in kmemleak
> it would use the same mechanism for recording and scanning the bnode.

Ah I see what you did, you basically made the bnode as a kmemleak object in
its own right, and perhaps the kmemleak detector can reach the object you
added. That actually (though sounding like a little of a hack) would work too.
I say hack because the object you added is not an allocated object in the
traditional sense :-D. But as you said, there is precendent for that.

> > That may not solve the issue as the false-positive unreachable
> > object is still unreachable.
> 
> It should solve the issue as long as the bnode is reachable from the
> root objects (e.g. the data/bss sections; I think it is via the
> per_cpu_ptr(&krc, cpu)->bkvcache llist_head). When the bnode is scanned,
> it will find the pointer to the RCU-freed object and mark it as
> referenced (not a leak).

Right! That's what I was missing.

> Anyway, as we trust the RCU freeing implementation not to leak data, we
> can go with your simpler suggestion of a kmemleak_ignore() call on the
> kvfree_rcu() path. Probably even better as the object pending to be
> freed will no longer be scanned.

Sounds good and thanks a lot Catalin! Unless you beat me to it, I'll send a
patch out along those lines by the weekend and CC you with your suggested-by
and the reported-by from the reporter ;-). Let me know if you have a preference.

thanks,

 - Joel


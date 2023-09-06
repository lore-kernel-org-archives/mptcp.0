Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03775125A9
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 22:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7480CC433C8;
	Wed,  6 Sep 2023 22:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694037766;
	bh=kFVb7Ya7mZu6YAwWZYiOa2Mon2Xj7zjlLogJ9/b7Fw4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=r+AcwTCrW+OGMSNDOC6cmW3UG1bMPI49QOpOqUWAc6G/dxHbehY6j6CZ8bSBXhrya
	 XaPNpbV0DHYMLp75oMdkCmG+T0gURHuP8cI6XZZDPVn/K7S8FjqYtXlcd32X0/HylF
	 aK+8yTefPL6M96t1u+I62A65G/IFWaR9GOCvSO+1Rn3nI4C9vILNjS4O7JL0icI5vN
	 0dD5JsBWCy3/fkpF5qbiXfpIKVFzOGuwRLUiSzzL67KwD5iGRdUc72Ca7qpFwu+GFE
	 sYXFhGoRLnx/kOsyVOeK3vtE+6uX3n7LTsWyWcSMGMj9nJq9jP9Bd0CYVwQWzCHFia
	 NwHN/U8NasfZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EFE6ECE0809; Wed,  6 Sep 2023 15:02:45 -0700 (PDT)
Date: Wed, 6 Sep 2023 15:02:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Christoph Paasch <cpaasch@apple.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org,
	urezki@gmail.com
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <38f21251-4911-4300-9b53-e390e621e68a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <20230905111725.GA3737639@google.com>
 <ZPc+HGjmY2ZC4WO3@arm.com>
 <20230906143529.GB1127143@google.com>
 <ZPizxVT5s9JA5MPw@arm.com>
 <24f3d4fc-56c0-46bd-8e5b-af57f09fa777@paulmck-laptop>
 <ZPjxJJjuHJbPVyfT@arm.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjxJJjuHJbPVyfT@arm.com>

On Wed, Sep 06, 2023 at 10:37:40PM +0100, Catalin Marinas wrote:
> On Wed, Sep 06, 2023 at 12:11:12PM -0700, Paul E. McKenney wrote:
> > On Wed, Sep 06, 2023 at 06:15:49PM +0100, Catalin Marinas wrote:
> > > On Wed, Sep 06, 2023 at 02:35:29PM +0000, Joel Fernandes wrote:
> > > > On Tue, Sep 05, 2023 at 03:41:32PM +0100, Catalin Marinas wrote:
> > > > > On Tue, Sep 05, 2023 at 11:17:25AM +0000, Joel Fernandes wrote:
> > > > > > The correct fix then should probably be to mark the object as
> > > > > > kmemleak_not_leak() until a grace period elapses. This will cause the object
> > > > > > to not be reported but still be scanned until eventually the lower layers
> > > > > > will remove the object from kmemleak-tracking after the grace period. Per the
> > > > > > docs also, that API is used to prevent false-positives.
> > > > > 
> > > > > This should work as well but I'd use kmemleak_ignore() instead of
> > > > > kmemleak_not_leak(). The former, apart from masking the false positive,
> > > > > also tells kmemleak not to scan the object. After a kvfree_rcu(), the
> > > > > object shouldn't have any valid references to other objects, so not
> > > > > worth scanning.
> > > > 
> > > > Yes I am also OK with that, however to me I consider the object as alive as
> > > > long as the grace period does not end. But I agree with you and it may not be
> > > > worth tracking them or scanning them.
> > > 
> > > I guess from an RCU perspective, the object is still alive. From the
> > > kvfree_rcu() caller perspective though, it can disappear at any point
> > > after the grace period, so it shouldn't rely on its content being valid
> > > and referencing other objects (other than transiently e.g. in RCU list
> > > traversal).
> > > 
> > > It probably only matters if we have some very long grace periods (I'm
> > > not up to date with the recent RCU developments). In such cases, the
> > > object still being scanned could introduce false negatives. That's my
> > > reasoning for suggesting kmemleak_ignore() rather than
> > > kmemleak_not_leak().
> > 
> > Very long RCU readers still result in very long RCU grace periods.  And,
> > after some tens of seconds, RCU CPU stall warnings.  So don't let your
> > RCU readers run for that long.  But you knew that already.  ;-)
> 
> That's still ok. I was more thinking of deferred freeing well past the
> RCU readers completing.

Ah, that can happen.  Some kernels are built with CONFIG_RCU_LAZY=y, which
delays freeing in order to reduce power consumption.  And kfree_rcu()
will also delay for a bit.  But in both cases, a flood of callbacks
should get things going again.

But an isolated kfree_rcu() might well see a few seconds delay.
Saving your battery!  ;-)

> > > @@ -3388,6 +3389,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> > >  		success = true;
> > >  	}
> > >  
> > > +	/*
> > > +	 * The kvfree_rcu() caller considers the pointer freed at this point
> > > +	 * and likely removes any references to it. Since the the actual slab
> > > +	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
> > > +	 * this object (no scanning or false positives reporting).
> > > +	 */
> > > +	kmemleak_ignore(ptr);
> > 
> > Do we want to un-ignore it at the end of the grace period?  Or will that
> > happen automatically when it is passed to kfree()?  (My guess is that
> > the answer to both questions is "yes", but I figured that I should ask.)
> 
> No need to un-ignore. This function only tells kmemleak it's not a
> leak and doesn't have any interesting data to scan. Kmemleak still keeps
> track of it until properly freed.

Got it, thank you!

							Thanx, Paul

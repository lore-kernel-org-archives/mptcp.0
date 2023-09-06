Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F38EDB
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 17:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBABC433C8;
	Wed,  6 Sep 2023 17:15:52 +0000 (UTC)
Date: Wed, 6 Sep 2023 18:15:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Christoph Paasch <cpaasch@apple.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <ZPizxVT5s9JA5MPw@arm.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <20230905111725.GA3737639@google.com>
 <ZPc+HGjmY2ZC4WO3@arm.com>
 <20230906143529.GB1127143@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906143529.GB1127143@google.com>

On Wed, Sep 06, 2023 at 02:35:29PM +0000, Joel Fernandes wrote:
> On Tue, Sep 05, 2023 at 03:41:32PM +0100, Catalin Marinas wrote:
> > On Tue, Sep 05, 2023 at 11:17:25AM +0000, Joel Fernandes wrote:
> > > The correct fix then should probably be to mark the object as
> > > kmemleak_not_leak() until a grace period elapses. This will cause the object
> > > to not be reported but still be scanned until eventually the lower layers
> > > will remove the object from kmemleak-tracking after the grace period. Per the
> > > docs also, that API is used to prevent false-positives.
> > 
> > This should work as well but I'd use kmemleak_ignore() instead of
> > kmemleak_not_leak(). The former, apart from masking the false positive,
> > also tells kmemleak not to scan the object. After a kvfree_rcu(), the
> > object shouldn't have any valid references to other objects, so not
> > worth scanning.
> 
> Yes I am also OK with that, however to me I consider the object as alive as
> long as the grace period does not end. But I agree with you and it may not be
> worth tracking them or scanning them.

I guess from an RCU perspective, the object is still alive. From the
kvfree_rcu() caller perspective though, it can disappear at any point
after the grace period, so it shouldn't rely on its content being valid
and referencing other objects (other than transiently e.g. in RCU list
traversal).

It probably only matters if we have some very long grace periods (I'm
not up to date with the recent RCU developments). In such cases, the
object still being scanned could introduce false negatives. That's my
reasoning for suggesting kmemleak_ignore() rather than
kmemleak_not_leak().

> > > Instead what the below diff appears to do is to mark the bnode cache as a
> > > kmemleak object itself, which smells a bit wrong. The bnode is not an
> > > allocated object in the traditional sense, it is simple an internal data
> > > structure.
> > 
> > We do this in other places for objects containing pointers and which
> > aren't tracked by kmemleak (it doesn't track page allocations as there
> > would be too many leading to lots of false positives or overlapping
> > objects - the slab itself uses the page allocator). An example where we
> > do something similar is alloc_large_system_hash(). We could add a
> > wrapper API if kmemleak_alloc() feels wrong but underlying in kmemleak
> > it would use the same mechanism for recording and scanning the bnode.
> 
> Ah I see what you did, you basically made the bnode as a kmemleak object in
> its own right, and perhaps the kmemleak detector can reach the object you
> added. That actually (though sounding like a little of a hack) would work too.
> I say hack because the object you added is not an allocated object in the
> traditional sense :-D. But as you said, there is precendent for that.

Even in kmemleak.c we have create_object() for the data/bss sections.
It's just that the kmemleak_alloc() wrapper API implies some form of
slab allocation (though it's any allocation really, not just slab).

> Sounds good and thanks a lot Catalin! Unless you beat me to it, I'll send a
> patch out along those lines by the weekend and CC you with your suggested-by
> and the reported-by from the reporter ;-). Let me know if you have a preference.

I had a patch already but got distracted by a few (real) leaks reported
while testing it. Feel free to pick it up and change _ignore to
_not_leak if you find that more suitable. Well, it would be good for
Christoph to test it as I haven't managed to reproduce the false
positive.

----------------------8<--------------------------
From b25350cb6f8a906a6164b625bfd57021190cb105 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 6 Sep 2023 17:52:45 +0100
Subject: [PATCH] rcu: kmemleak: Ignore kmemleak false positives when
 RCU-freeing objects

Since the actual slab freeing is deferred when calling kvfree_rcu(), so
is the kmemleak_free() callback informing kmemleak of the object
deletion. From the perspective of the kvfree_rcu() caller, the object is
freed and it may remove any references to it. Since kmemleak does not
scan the tree RCU internal data storing the pointer, it will report such
objects as leaks during the grace period.

Tell kmemleak to ignore such objects on the kvfree_call_rcu() path. Note
that the tiny RCU implementation does not have such issue since the
objects can be tracked from the rcu_ctrlblk structure.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Christoph Paasch <cpaasch@apple.com>
---
 kernel/rcu/tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..2ac39b5705df 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/export.h>
 #include <linux/completion.h>
+#include <linux/kmemleak.h>
 #include <linux/moduleparam.h>
 #include <linux/panic.h>
 #include <linux/panic_notifier.h>
@@ -3388,6 +3389,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		success = true;
 	}
 
+	/*
+	 * The kvfree_rcu() caller considers the pointer freed at this point
+	 * and likely removes any references to it. Since the the actual slab
+	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
+	 * this object (no scanning or false positives reporting).
+	 */
+	kmemleak_ignore(ptr);
+
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
 		schedule_delayed_monitor_work(krcp);

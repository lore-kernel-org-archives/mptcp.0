Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD49BE6A
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 21:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD244C433C7;
	Mon,  4 Sep 2023 21:22:58 +0000 (UTC)
Date: Mon, 4 Sep 2023 22:22:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <ZPZKsJUPVeHCsLQB@arm.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>

Hi Christoph,

Please try not to send html, many servers block such emails.

Also adding the RCU list.

On Wed, Aug 30, 2023 at 09:37:23AM -0700, Christoph Paasch wrote:
> for the MPTCP upstream project, we are running syzkaller [1] continuously to
> qualify our kernel changes.
> 
> We found one issue with kmemleak and its handling of kfree_rcu.
> 
> Specifically, it looks like kmemleak falsely reports memory-leaks when the
> object is being freed by kfree_rcu after a certain grace-period.
> 
> For example, https://github.com/multipath-tcp/mptcp_net-next/issues/398#
> issuecomment-1584819482 shows how the syzkaller program reliably produces a
> kmemleak report, although the object is not leaked (we confirmed that by simply
> increasing MSECS_MIN_AGE to something larger than the grace-period).

Not sure which RCU variant you are using but most likely the false
positives are caused by the original reference to the object being lost
and the pointer added to a new location that kmemleak does not track
(e.g. bnode->records[] in the tree-based variant).

A quick attempt (untested, not even compiled):

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1449cb69a0e0..681a1eb7560a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -53,6 +53,7 @@
 #include <linux/sysrq.h>
 #include <linux/kprobes.h>
 #include <linux/gfp.h>
+#include <linux/kmemleak.h>
 #include <linux/oom.h>
 #include <linux/smpboot.h>
 #include <linux/jiffies.h>
@@ -2934,6 +2935,7 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 
 	llist_for_each_safe(pos, n, page_list) {
 		free_page((unsigned long)pos);
+		kmemleak_free(pos);
 		freed++;
 	}
 
@@ -2962,8 +2964,16 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
 					rcu_state.name, bnode->records[i], 0);
 
 				vfree(bnode->records[i]);
+				/* avoid false negatives */
+				kmemleak_erase(&bnode->records[i]);
 			}
 		}
+		/*
+		 * Avoid kmemleak false negatives when such pointers are later
+		 * re-allocated.
+		 */
+		for (i = 0; i < bnode->nr_records; i++)
+			kmemleak_erase(&bnode->records[i]);
 		rcu_lock_release(&rcu_callback_map);
 	}
 
@@ -2972,8 +2982,10 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
 		bnode = NULL;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-	if (bnode)
+	if (bnode) {
 		free_page((unsigned long) bnode);
+		kmemleak_free(bnode);
+	}
 
 	cond_resched_tasks_rcu_qs();
 }
@@ -3241,6 +3253,12 @@ static void fill_page_cache_func(struct work_struct *work)
 			free_page((unsigned long) bnode);
 			break;
 		}
+
+		/*
+		 * Scan the bnode->records[] array until the objects are
+		 * actually freed.
+		 */
+		kmemleak_alloc(bnode, PAGE_SIZE, 0, GFP_KERNEL);
 	}
 
 	atomic_set(&krcp->work_in_progress, 0);
@@ -3308,6 +3326,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 			// scenarios.
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
+			/*
+			 * Scan the bnode->records[] array until the objects are
+			 * actually freed.
+			 */
+			kmemleak_alloc(bnode, PAGE_SIZE, 0, GFP_KERNEL);
 			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
 		}
 

-- 
Catalin

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E912BF3D7;
	Sun,  8 Mar 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772961305; cv=none; b=u/RqxIabZmVagsg+Lpvl5eUIUZGbt6CrZj+pW8M2TIxYraRK7fCgan48TiLpx1pcYaAZecBbSd83tSlNghEVaXl6X/rxGibxTQG1DYfWp/WzC7+HDaS1WqbRHjSLAF4xM0UzRmaDZtqs+or/iCZt8sES4CVOWLXlwEvG0fmqdGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772961305; c=relaxed/simple;
	bh=52QtocqDKEObTSjQNRtNF9jdSncGF37NJ1ZjaGX9/Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bI399Jxno9S2wOG/PgG/13ebev5XaIOdQ1NdIEBSeS2DQThuxfrfA/4EWc7QFANk4TD6624eZ74OgK/VhfOE/1/a96eVPi+Pwpae3v7TbvFMh5kNgOsB7WSWKje306DDKxB4EggxQfHzdJnXhU65UCTrIflBfj4U2dveQH6C1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzKCGzS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzKCGzS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1B5C116C6;
	Sun,  8 Mar 2026 09:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772961305;
	bh=52QtocqDKEObTSjQNRtNF9jdSncGF37NJ1ZjaGX9/Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MzKCGzS/azSRPm5/oQl177GlGpOoeGhcJaCKo+2Idc1YUvVXCbmYV+bQeZBPjPTwq
	 MwEgnXbQQvLp0loNEbMy53d1Cd8GPMHcu4T8M7TJmAuhPtbR7E6fwyq9UeLTLteBJr
	 00ZWoOfMGR/DCrCNPLqULlPUWMiOBGVN68RBw0JSL7g0UC+xhmcPvMyb9nZ3kBNwhU
	 0ksE9hHhUprn9x1j1FYLqFoU6DvQR0ZVEvXVhOhQ+FsBaMlaUmbeLudXveVyIt8bYY
	 pBbMHE4jxQrOeMHmBwv2vHReqMSWPB0mGq8PjxYiEhybEF/vkh+yVF4NNYBZSbsi/s
	 6h6sJdrejS1Dw==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 rcu@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, Linux Kernel
 <linux-kernel@vger.kernel.org>, Shinichiro Kawasaki
 <shinichiro.kawasaki@wdc.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "luto@kernel.org"
 <luto@kernel.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <MKoutny@suse.com>,
 Waiman Long
 <longman@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: Stalls when starting a VSOCK listening socket: soft lockups,
 RCU stalls, timeout
In-Reply-To: <87h5qr2rzi.ffs@tglx>
References: <863a5291-a636-47d0-891c-bb0524d2e134@kernel.org>
 <20260302114636.GL606826@noisy.programming.kicks-ass.net>
 <717310d8-6274-4b7f-8a19-561c45f5f565@kernel.org>
 <a2b573b4-af61-4b84-a7d1-012ed6bb23c9@kernel.org>
 <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org> <87zf4m2qvo.ffs@tglx>
 <47cba228-bba7-4e58-a69d-ea41f8de6602@kernel.org> <87tsuu2i59.ffs@tglx>
 <7efde2b5-3b72-4858-9db0-22493d446301@kernel.org> <87qzpx2sck.ffs@tglx>
 <20260306152458.GT606826@noisy.programming.kicks-ass.net>
 <87ldg42eu7.ffs@tglx> <87h5qr2rzi.ffs@tglx>
Date: Sun, 08 Mar 2026 10:15:01 +0100
Message-ID: <87eclu3coa.ffs@tglx>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 07 2026 at 23:29, Thomas Gleixner wrote:
> I'll look at it more tomorrow in the hope that this rested brain
> approach works out again.

There is another one of the same category. Combo patch below.

Thanks,

        tglx
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10584,6 +10584,11 @@ static void mm_cid_fixup_cpus_to_tasks(s
 
 		/* Remote access to mm::mm_cid::pcpu requires rq_lock */
 		guard(rq_lock_irq)(rq);
+
+		/* If the transit bit is set already, nothing to do anymore.  */
+		if (cid_in_transit(pcp->cid))
+			continue;
+
 		/* Is the CID still owned by the CPU? */
 		if (cid_on_cpu(pcp->cid)) {
 			/*
@@ -10598,12 +10603,9 @@ static void mm_cid_fixup_cpus_to_tasks(s
 		} else if (rq->curr->mm == mm && rq->curr->mm_cid.active) {
 			unsigned int cid = rq->curr->mm_cid.cid;
 
-			/* Ensure it has the transition bit set */
-			if (!cid_in_transit(cid)) {
-				cid = cid_to_transit_cid(cid);
-				rq->curr->mm_cid.cid = cid;
-				pcp->cid = cid;
-			}
+			cid = cid_to_transit_cid(cid);
+			rq->curr->mm_cid.cid = cid;
+			pcp->cid = cid;
 		}
 	}
 	mm_cid_complete_transit(mm, 0);
@@ -10733,11 +10735,30 @@ void sched_mm_cid_fork(struct task_struc
 static bool sched_mm_cid_remove_user(struct task_struct *t)
 {
 	t->mm_cid.active = 0;
-	scoped_guard(preempt) {
-		/* Clear the transition bit */
+	/*
+	 * If @t is current and the CID is in transition mode, then this has to
+	 * handle both the task and the per CPU storage.
+	 *
+	 * If the CID has TRANSIT and ONCPU set, then mm_unset_cid_on_task()
+	 * won't drop the CID. As @t has already mm_cid::active cleared
+	 * mm_cid_schedout() won't drop it either.
+	 *
+	 * A failed fork cleanup can't have the transit bit set because the task
+	 * never showed up in the task list or got on a CPU.
+	 */
+	if (t == current) {
+		/* Invalidate the per CPU CID */
+		this_cpu_ptr(t->mm->mm_cid.pcpu)->cid = 0;
+		/*
+		 * Clear TRANSIT and ONCPU, so the CID gets actually dropped
+		 * below.
+		 */
 		t->mm_cid.cid = cid_from_transit_cid(t->mm_cid.cid);
-		mm_unset_cid_on_task(t);
+		t->mm_cid.cid = cpu_cid_to_cid(t->mm_cid.cid);
 	}
+
+	mm_unset_cid_on_task(t);
+
 	t->mm->mm_cid.users--;
 	return mm_update_max_cids(t->mm);
 }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3809,7 +3809,8 @@ static __always_inline bool cid_on_task(
 
 static __always_inline void mm_drop_cid(struct mm_struct *mm, unsigned int cid)
 {
-	clear_bit(cid, mm_cidmask(mm));
+	if (!WARN_ON_ONCE(cid >= num_possible_cpus()))
+		clear_bit(cid, mm_cidmask(mm));
 }
 
 static __always_inline void mm_unset_cid_on_task(struct task_struct *t)
@@ -3978,7 +3979,13 @@ static __always_inline void mm_cid_sched
 		return;
 
 	mode = READ_ONCE(mm->mm_cid.mode);
+
+	/*
+	 * Needs to clear both TRANSIT and ONCPU to make the range comparison
+	 * and mm_drop_cid() work correctly.
+	 */
 	cid = cid_from_transit_cid(prev->mm_cid.cid);
+	cid = cpu_cid_to_cid(cid);
 
 	/*
 	 * If transition mode is done, transfer ownership when the CID is
@@ -3994,6 +4001,11 @@ static __always_inline void mm_cid_sched
 	} else {
 		mm_drop_cid(mm, cid);
 		prev->mm_cid.cid = MM_CID_UNSET;
+		/*
+		 * Invalidate the per CPU CID so that the next mm_cid_schedin()
+		 * can't observe MM_CID_ONCPU on the per CPU CID.
+		 */
+		mm_cid_update_pcpu_cid(mm, 0);
 	}
 }
 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8536A022;
	Sat,  7 Mar 2026 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772922581; cv=none; b=PGwboNYyJXAZ3N14GVFYbeUo84KQs/uUl1vLcol2p4VjzdGt6/XOyAgoKWCwmFm2VeyILXxsG7zqzAYJg250jSzO0IcKOMnWIayIM/8sgvqI/R2pYcSVjshTq3tl9yMEQSandviXRjNvHHOt5h09iqnHYUJ2PwYfIscNOOCCDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772922581; c=relaxed/simple;
	bh=86FT+jrr9lGMW3QHw5UUhDZPyggZzHYm9O0FiRH+WkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=biE7RJcSz8blcX0IbLbaLesFsKomQQd+0HtN2AGdxKz1OtLUHbHxsbKAaXK5I18PrIWnUQ6rS+saykRXQ3eq3bYUoHl0AhFnwDkSAsVqlgQaNUxwc+gm5dtKe6VqNRKwv/OTaTbTcLfn9TXeToL3l0dbdGpQNDh+OJOBDlew5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPlKjvtQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPlKjvtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99543C2BC87;
	Sat,  7 Mar 2026 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772922581;
	bh=86FT+jrr9lGMW3QHw5UUhDZPyggZzHYm9O0FiRH+WkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gPlKjvtQ5cF+gE/3W0nLutAk5CKaszMueR5skxzq/VMBn5QO/gCsJVXZ0UIWABUyM
	 ABMXz/bXvcP25SRqoPk+yAZak0P2Txk8pUVnQC/3TIAOlNokLvwrPypJ0ZnlXQBPtI
	 281Nmu2q8wdMiHjc8NM4FZ3B5+COBSN8OxZoUmQ2rPj4RHjevT0QhutpmVjFKbsRja
	 Isl+/hDXMez1W6w5Zo6PSZohvesCgb4tPbygO3lMfc7BNxI2jJ3elX4fxvtye8gjW8
	 BDJJUB+ht/tAEy7Fad/DMR8U3gbgPQvVrlfF8UvFCdX3Yqp+ZyS8WaSG0dyNHV6bUE
	 PHtBGVseM+TYQ==
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
In-Reply-To: <87ldg42eu7.ffs@tglx>
References: <863a5291-a636-47d0-891c-bb0524d2e134@kernel.org>
 <20260302114636.GL606826@noisy.programming.kicks-ass.net>
 <717310d8-6274-4b7f-8a19-561c45f5f565@kernel.org>
 <a2b573b4-af61-4b84-a7d1-012ed6bb23c9@kernel.org>
 <ba067933-bf3b-476d-a0bb-53eda56996ca@kernel.org> <87zf4m2qvo.ffs@tglx>
 <47cba228-bba7-4e58-a69d-ea41f8de6602@kernel.org> <87tsuu2i59.ffs@tglx>
 <7efde2b5-3b72-4858-9db0-22493d446301@kernel.org> <87qzpx2sck.ffs@tglx>
 <20260306152458.GT606826@noisy.programming.kicks-ass.net>
 <87ldg42eu7.ffs@tglx>
Date: Sat, 07 Mar 2026 23:29:37 +0100
Message-ID: <87h5qr2rzi.ffs@tglx>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 07 2026 at 10:01, Thomas Gleixner wrote:
> I gave up staring at it yesterday as my brain started to melt. Let me
> try again.

[Un]Surprisingly a rested and awake brain works way better.

The good news is that I actually found a nasty brown paperbag bug in
mm_cid_schedout() while going through all of this with a fine comb:

     cid = cid_from_transit_cid(...);

     That preserves the MM_CID_ONCPU bit, which makes mm_drop_cid()
     clear bit 0x40000000 + CID. That is obviously way outside of the
     bitmap. So the actual CID bit is not cleared and the clear just
     corrupts some other piece of memory.

     I just retried with all the K*SAN muck enabled which should catch
     that out of bounds access, but it never triggered and I haven't
     seen syzbot reports to that effect either.

     Fix for that is below.

The bad news is that I couldn't come up with a scenario yet where this
bug leads to the outcome observed by Jiri and Matthieu, because the not
dropped CID bit in the bitmap is by chance cleaned up on the next
schedule in on that CPU due to the ONCPU bit still being set.

I'll look at it more tomorrow in the hope that this rested brain
approach works out again.

Thanks,

        tglx
---
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
 

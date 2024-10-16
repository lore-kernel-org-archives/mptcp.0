Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE011885BB
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105535; cv=none; b=gr+rFDeHU2Hiz3EF8qJhNKAN5i/9ZQwmZO3Z/nBp6C2GsNlhJeds1FKjigAtLnd28wQDKeoo9C5mFe7aFPJ8DI0xSRQWMHAtbkgFnTfTpO3tFedBqOBNtZn21uURXxLjaw6frULu52AuVpBoNt/cXYFYXDzU3yTpnO0F+yAaDdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105535; c=relaxed/simple;
	bh=d1ENJp7kJFfhdTpnxBulsp99HA/PzWELEryOO3PkslU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VW136Iobk03NGFSHXU4G3kiXHwrGeQluwszbfaXdtmbO+G6ihX0FbEsPOMy4Lb6ZfyfK36zls0wyDIxjXeI88F27IlRqhcm/Woboehrovh3DkRZ/HViTinjuM3NPLWPlyWDL2k7uPo0Xh5EAELCR15sMynF860MDLk2sx6aiNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPh7X/Vf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPh7X/Vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C3FC4CECF;
	Wed, 16 Oct 2024 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105535;
	bh=d1ENJp7kJFfhdTpnxBulsp99HA/PzWELEryOO3PkslU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JPh7X/VfS9wmz0WjO/Ee9Xb6oQdda3NQhc1peeUxjW+EnV0XDDPtYVaJ9/fofPhhp
	 C08jRemvK/bObys6pyzjwEgoEpz0znyY2Zjd1sfcO6wE+J7DNqQ4q4sC2ea9Nr0MLB
	 w9N5V7CIKpAsZXAxQ8M5R/NvbfcSDFW8TpKcd2gZfn/my0lPvY+NYNC+u8rLgc4+D2
	 IoKEJ8ZZOXPN1WHBgEVkkrakpaLRDNIuwqbdLuvp7aaBsr56/YYvZ1jKvJym0iEBK3
	 A/ayS59IX6LpCS5tzyR/wt+deY7GojK3fr8LU3mDB/5+R8O5hOZbaDrXIq3dmArMAt
	 r2zFbboamNIFw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 16 Oct 2024 21:05:20 +0200
Subject: [PATCH mptcp-net 2/2] Squash to "bpf: Add bpf_mptcp_sched_ops"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-mptcp-sched-find-rcu-v1-2-5e9af4fbce11@kernel.org>
References: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
In-Reply-To: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=d1ENJp7kJFfhdTpnxBulsp99HA/PzWELEryOO3PkslU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEA57tWZscxcDpD95R/BG+jxyrTuE/R4PCE9KI
 3RkDKphdgyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxAOewAKCRD2t4JPQmmg
 c39SD/0bpHdYpw+5+DyCje7LFix1kJYhJnFBmSwQYYjrSN97pL8Y6b6c3HYtHRLRVwd2um2I0gt
 I9dEjnymRrilu5zUzokYFiiEgZR5x/LFtjSDelkykoD5xPsam07h3G+fTUaY6LgIQ6dNdSivwPg
 P3xpAU/G6fP0G9WmwBX5UnMK1FeshdPbioeT3zmG9ikyrJAnOtgkr5n4MEUIM5HWFLxx3LPWf7d
 Mk4ldXIID0xnXFCPoz0r6H28tDeIW5ZKpasgdOoBwyX8/ZpYpG6SD7ZvvbKMhPqtP8Qx4j9d72+
 mqoEemNAJmvGWaLIAlamyaNCzJ4J9h8vuLbnJXmPOiwN1zHsVqZ6ja/ooJL8b4lnpRx1FD/uH2V
 kVegeYJM0SvMPSnr1nOiq/e24HmUOhVpizRyee+qYI66qoa2lfjgJZsepQ3SIOkcjpzOBJqbvou
 SCGqKC5YfbwtYKLnCEhY2IY32lqJzU2056lnEwXrUKt+lZDQbN6s0LT7uiTDQLK/a2/foLymLJq
 feqROrTwcAQxRXHoJ3zOlnizXpwisxVJ7RrhQlAOBa8hDch3eNA0AJJk3Zr/uOs1/XOHFcswNwD
 iVRjEu4JzROj+Ks+Cv/Wi6FH1zqjslK+hDJts7FPh1+EGl8XSOi7EY7pGrDTv1cO1twAw3jO07Z
 /vGCixVnKZGhTrw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the previous commit, this splat can be seen:

  =============================
  WARNING: suspicious RCU usage
  6.12.0-rc2+ #1 Tainted: G           OE
  -----------------------------
  net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  1 lock held by test_progs/323:
  ffff888007e16a40 (&st_map->lock){+.+.}-{3:3}, at: bpf_struct_ops_map_update_elem (kernel/bpf/bpf_struct_ops.c:632)

  stack backtrace:
  CPU: 0 UID: 0 PID: 323 Comm: test_progs Tainted: G           OE      6.12.0-rc2+ #1
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  Call Trace:
   <TASK>
   dump_stack_lvl (lib/dump_stack.c:123)
   lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
   mptcp_sched_find (net/mptcp/sched.c:44 (discriminator 7))
   bpf_mptcp_sched_init_member (net/mptcp/bpf.c:128 net/mptcp/bpf.c:109)
   ? btf_type_resolve_ptr (include/linux/btf.h:252 kernel/bpf/btf.c:637)
   bpf_struct_ops_map_update_elem (kernel/bpf/bpf_struct_ops.c:658)
   ? __might_fault (mm/memory.c:6700 (discriminator 5) mm/memory.c:6693 (discriminator 5))
   ? __pfx_bpf_struct_ops_map_update_elem (kernel/bpf/bpf_struct_ops.c:591)
   ? __pfx___might_resched (kernel/sched/core.c:8593)
   ? kasan_save_track (arch/x86/include/asm/current.h:49 (discriminator 1) mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1))
   bpf_map_update_value (kernel/bpf/syscall.c:169)
   map_update_elem (kernel/bpf/syscall.c:1627)
   ? __pfx_map_update_elem (kernel/bpf/syscall.c:1586)
   __sys_bpf (kernel/bpf/syscall.c:5622)
   ? __pfx___sys_bpf (kernel/bpf/syscall.c:5596)
   __x64_sys_bpf (kernel/bpf/syscall.c:5739)
   ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4347 kernel/locking/lockdep.c:4406)
   do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Also similar to the previous commit, this can be fixed by adding the
missing rcu_read_lock().

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/bpf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6414824402e6449ba01efb9093b2293232a67915..a9d6b5b939a2631f17a468ee6ba4867dc33dda63 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -113,6 +113,7 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 	const struct mptcp_sched_ops *usched;
 	struct mptcp_sched_ops *sched;
 	u32 moff;
+	int ret;
 
 	usched = (const struct mptcp_sched_ops *)udata;
 	sched = (struct mptcp_sched_ops *)kdata;
@@ -123,9 +124,12 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 		if (bpf_obj_name_cpy(sched->name, usched->name,
 				     sizeof(sched->name)) <= 0)
 			return -EINVAL;
-		if (mptcp_sched_find(usched->name))
-			return -EEXIST;
-		return 1;
+
+		rcu_read_lock();
+		ret = mptcp_sched_find(usched->name) ? -EEXIST : 1;
+		rcu_read_unlock();
+
+		return ret;
 	}
 
 	return 0;

-- 
2.45.2


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016292;
	b=Y8s1cRV2SIW4/LVzvyW3BtYXpaQksIEj5Hp6D5Lg9epKzroeOH31EBS5wu98kW4Y3EgY
	 JwTwbz6IyB0bwyT/HtPDIEgjLjhcQX13JQQyfqHGp+gA0Rec+h/gB8l2+KsLEdlU6TT+e
	 UsTxgnpVhaoCp1598ptlkOATkqZaYPCWlOimbqUMs2IbqFtqVl1G9Vu4dJbg6sjYN1Mf4
	 OuuqXk9Qp9b4XxTnS6g+k8jGnhhPGbzh0jIjX71orGywUmndm0mNboZr3r63NDIvwF+QG
	 O89HAxumAyv5Y6SeUqvKFl2L9+PxxkTZAFQAI/x2wEBO5XAOJd5u5WGQGE6eJDiWkRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nbUjjjXf6KuwRIcdvlGUS77lfDsF4Q5SkMSxK7RcU9Q=;
	b=GAlnvgfrOUa5EYbb1hxu2prBW4fDZ+D+UATDukIHHM1xFlBKFEWJgFXfwYeVDDA86cxx
	 PBcihRAQTfaY/SivaYmA8UYzPfOLOMDg4jHq31w3+ZukgsVDD2ddTwJmMncNloMK3cmbW
	 RsBDqQcsmVf/X2shYi3/6fOmih0IjPhvGH4Eq/H5UYUw3R7EUtxFi3iu2fXknIjBD1tVn
	 Ln56b4R2o/PGZmk17b4T6EdxU5N9D4BOQ3+zGqYx+OkH5V6hFfd1MYtGSdq7dgfNiaEkN
	 zcgGHUCIdiOWSP2l8CL2TdSHIUeHK/nQvDoLuLvDEjPDrKtv/fJoZmxEYmj+ppE5+7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RB62JT19;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E1C606A31B
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E1C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RB62JT19
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso993075a12.0
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793016291; x=1793621091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nbUjjjXf6KuwRIcdvlGUS77lfDsF4Q5SkMSxK7RcU9Q=;
        b=RB62JT19JaZXPjJkjz1+LEu+VYaH4sn59ETG0oNIud+bt2OHWC91Sn5hR4jD8oardC
         iBdDixaXEVPNmCcTc8Wqc7i2pnLrNq3XqIBDp4hqTHip4UaTZQHAJx+yg98uoyepUeCN
         Mf7uN16/WUGoTyW7thssJrtxfo+Hspv72qLB7j3BEUMVpEYzWtHpd7Iqitu3m0Fc0GGU
         3PMpvA6D1gZyWcswcuicjRe9GrUsXBMqzyxfVPudf8Vw57ABzo1cUnZYZzJiFYDpXMc9
         nR1in1u0IZ+IgdgMTtigpV1/9S89PptFH4GHM/M826mA8jKwk8SYoIM2wSEBPP0fvSsH
         H7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016291; x=1793621091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nbUjjjXf6KuwRIcdvlGUS77lfDsF4Q5SkMSxK7RcU9Q=;
        b=sd+GbkgWSI2k8pUNnbA7rnGdoCNm+JiFfkpfIIL4s88dOnzLVyMU/yVXfD+xEtAZ6T
         1yjGWnIdYsE7swwP9nodPmz+6eQz1oNyg5hk2KnkDi/lXnIVCBSsae+/JOtGQyd/pnNU
         uCrY6IEnB3MVkFeXuVjv1sDpmo+AsDzhm51F1e6gDCaZCCNNALgOVoGVfWKCUlpOfLKZ
         o8ZOzc34JN16OxTP2xnSfjlxrUesRd2Fn+hGkfntu8BqMgYc0Z4jVrp0uadHJYoxsJhi
         UEEF+UVE/XW+Qv3o3YdfL1jo61bGf4jDS+PiM85fi7uo52tva4v41/AccGZrb9axiJF3
         JQWw==
X-Forwarded-Encrypted: i=1; AKwUvByPKPYwvGtJICocgCaNrJRRs+zjaoOXFtmjb094HipTjo4Yox/e/wc3sOrtQxXpc8GzGWYyPQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKnR0CrkuWqiBXGlXpTXTzRpxwp76cFmuTLvBN/aPJI0ifhN6uP
	rvvqZWzLUd0rPVC8dd5wrkE1tC5Bnf9GIhqU3Gn5Y01WeTk+RirXvHMu
X-Gm-Gg: AYBFou0wJWvdZIHVsH3m1tKAllGJ4SIlK9RfDhLxvO3wsSOaqr5w70cAPeBH66bA3aI
	xPQDxbiVeF+In13f9vOc02+vTpFVW7OerQcZBwsWcLLX4y/tJ3oPwFFokbZ/asREYacWbNYV9zu
	od0whbZ5yAp3aNxnItHsoJBxkpmg98WCyRiIxhU3I6JGDG1FvG/BFkZ86CK5YTyANXxMw/vVYd1
	5YivWJ/lOLXSgE3EfzzpzvRiEJcSe7XmiIVw7T+DcxKFWzIYUfCdH3NCf/FzaJkLTUowl1QKGzo
	s8hCxKOmz0JppHLDMZ77p4uUHN8BH7SvUnHMjSdM0Xrs5MFNJpYrhWbIYehEXrS6JmeTn5dZg03
	xMdNdXON3I2QqaEOAYNaQGDIU7DN/4/JevxVq/IEruI5h1of4Z7GdSMuR4OPk1Ua8NA9KptZom1
	2NIwsbfzJo/7w/doEbL55mtWgr7vjyFnaLL3Vox2qnTjh9fTB0p3qsDUr3N+/sjU6xKR0rRZCGu
	FJSMHOmGaFGqRP0a440oiPIHbF0uHiZFF0QRsnoDisNRne21VY=
X-Received: by 2002:a17:90b:4b82:b0:3ac:8af9:4a73 with SMTP id 98e67ed59e1d1-3adead249d4mr5244688a91.28.1793016290637;
        Mon, 26 Oct 2026 05:04:50 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb27a1bsm8251579a91.15.2026.10.26.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:04:50 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: geliang@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH net] mptcp: protect listener backlog reads in diagnostics
Date: Mon, 26 Oct 2026 20:04:42 +0800
Message-Id: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_diag_get_info() reports the accept queue of a listening MPTCP
socket by reading msk->first. The token based dump and the exact token
query only hold a reference on the MPTCP socket, which pins neither the
first subflow nor the listener hash bucket, and __mptcp_close_ssk()
drops the last reference on the first subflow before clearing
msk->first.

An application can disconnect a connected MPTCP socket with AF_UNSPEC,
which removes the token but retains the first subflow, listen on it
again and close it. A dump that obtained the MPTCP socket before the
disconnect then reads the backlog of a freed TCP listener:

  Token diagnostic                 Application
  mptcp_token_iter_next()
    retain MPTCP socket
                                   connect(AF_UNSPEC)
                                     remove token, retain first
                                   listen()
                                     reuse first
  mptcp_diag_get_info()
    observe TCP_LISTEN
    lsk = msk->first
                                   close()
                                     mptcp_destroy()
                                       __mptcp_close_ssk()
                                         release first
    read lsk->sk_ack_backlog

Take the MPTCP data lock around the listener state check and the
backlog reads, and only follow msk->first while no process owns the
socket. Every path that disposes of the first subflow runs with the
socket owned, and lock_sock() has to take the same spinlock to become
the owner, so the reads cannot overlap with the release. Waiting for
the owner is not an option: mptcp_diag_dump_listeners() calls this
function with the listener hash bucket lock held, which the owner needs
to unhash that very listener. While a process owns the socket, the dump
reports the MPTCP socket's own queue values instead.

BUG: KASAN: slab-use-after-free in mptcp_diag_get_info+0x415/0x490
Read of size 4 at addr ffff888111763818 by task python3/499

Call Trace:
 <TASK>
 mptcp_diag_get_info+0x415/0x490
 inet_sk_diag_fill+0xee3/0x1ec0
 mptcp_diag_dump+0x2eb/0x1140
 __inet_diag_dump+0x18c/0x2d0
 netlink_dump+0x4c6/0x11f0
 __netlink_dump_start+0x69a/0x920
 inet_diag_handler_cmd+0x254/0x2b0
 sock_diag_rcv_msg+0x3c9/0x730
 netlink_rcv_skb+0x133/0x390
 netlink_unicast+0x504/0x840
 netlink_sendmsg+0x7f7/0xcf0
 __sys_sendto+0x425/0x470
 __x64_sys_sendto+0xe5/0x1c0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Allocated by task 497:
 kmem_cache_alloc_noprof+0x20b/0x5f0
 sk_prot_alloc+0x65/0x260
 sk_alloc+0x37/0xb40
 inet_create+0x33a/0xf40
 __sock_create+0x2c4/0x730
 mptcp_subflow_create_socket+0xf1/0x9a0
 __mptcp_nmpc_sk.part.0+0x114/0x750
 __mptcp_nmpc_sk+0x5c/0x80
 mptcp_setsockopt+0x5d8/0x2d60
 do_sock_setsockopt+0x1fb/0x430
 __sys_setsockopt+0x106/0x180
 __x64_sys_setsockopt+0xc2/0x160
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 slab_free_after_rcu_debug+0x111/0x290
 rcu_core+0x661/0x1d10
 handle_softirqs+0x201/0x930
 __irq_exit_rcu+0x110/0x1e0
 irq_exit_rcu+0xe/0x20
 sysvec_apic_timer_interrupt+0x6c/0x80
 asm_sysvec_apic_timer_interrupt+0x1a/0x20

Second to last potentially related work creation:
 __call_rcu_common.constprop.0+0x76/0xbd0
 sk_destruct+0x8e/0xd0
 __sk_free+0xdd/0x370
 sk_free+0x51/0x80
 __mptcp_close_ssk+0x903/0x1580
 mptcp_destroy_common+0x16b/0x3c0
 mptcp_destroy+0x4b/0xc0
 __mptcp_destroy_sock+0x10e/0x2f0
 __mptcp_close+0x5df/0xa50
 mptcp_close+0x34/0x100
 inet_release+0x11f/0x250
 __sock_release+0xb8/0x270
 sock_close+0x21/0x30
 __fput+0x39f/0xa60
 fput_close_sync+0xff/0x200
 __x64_sys_close+0x8c/0xf0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM
---
 net/mptcp/mptcp_diag.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d05c0ee..a71bcaee15c8 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -199,7 +199,12 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 			  READ_ONCE(mptcp_sk(sk)->backlog_len);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
 
-	if (inet_sk_state_load(sk) == TCP_LISTEN) {
+	/* The listener walk holds the listen hash lock: do not wait for a
+	 * socket owner that could be unhashing the first subflow.
+	 */
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk) &&
+	    inet_sk_state_load(sk) == TCP_LISTEN) {
 		struct sock *lsk = READ_ONCE(msk->first);
 
 		if (lsk) {
@@ -210,6 +215,7 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 			r->idiag_wqueue = READ_ONCE(lsk->sk_max_ack_backlog);
 		}
 	}
+	mptcp_data_unlock(sk);
 
 	if (!info)
 		return;

Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCF33DEE6
	for <mptcp@lists.linux.dev>; Fri, 23 Jan 2026 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137424; cv=none; b=kZJGWB7VZLGHk3Z4I2/XbHArhiHEbTfGZy3TeTgVfAlR2oPpsLct6Ni+CsfRdADaykSMrm9fuwLHTZ96iB7ggOLFq5v0Z5Cfna2o965BxPuon6QN3zrwiDL0SMWlPdto4llbLK9gFX0A37B3v0PPytMFQyaB5FYduKtyzoN0Es8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137424; c=relaxed/simple;
	bh=U/FNq5rdpbdcZGN7Huo5dHrKnrH2MlVUn0VSIsLzWvg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TvmyJ69FFpv8lbZbsTQJZz3ShFFe5ugEQNrXYKEWA02TcKrHLpnxdE4Trr+S9ZdHBQrG+PncLA5GxDdUc8vHO8BumqpvKrDmvr8+RB/tUQmAob0+Kmfm/UkivRBqqTQoyCN9Ld30ButUHQbIwWdZedSd3FzVUMWYeHaN6jGIcBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pN+VcrQg; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pN+VcrQg"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6a291e7faso574196085a.3
        for <mptcp@lists.linux.dev>; Thu, 22 Jan 2026 19:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769137409; x=1769742209; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fA6qxRoEFh+rpwIl41Oht/rMATH6zAaeudQmjuunb0g=;
        b=pN+VcrQgcv7d3QnuLY9WDZnpImtOOo/A1Oqoj0Q/292NYHhitIgIJrhj2SrSst8m2d
         3febcwhPXH8iV++IFZtQ9KnOgfqdBrVt8Rs7p74TWMZOW9dfeQtIRDX9phbFgrcI58P/
         7yn1hsdHmMUb1TKYnZzmzVPam0bKX3ULOHWBoF4n6mwbVSJBM08sc39MZkmfOad5Hro9
         x0X8lg5Fb6IHLE4mnvAwDQVgFcn6lwsYV8dEBWJBWi+cTAzJrXb2aECNGypM0HALPPM8
         19d288qW8n07P8Q62EblvDXI17+fi4ND43KSRdEyZ6J5lG08Fwu/rkKKi/lJXOTOrDDe
         2U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137409; x=1769742209;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fA6qxRoEFh+rpwIl41Oht/rMATH6zAaeudQmjuunb0g=;
        b=efjSmr7mvNHcx2G/u/+XPGyEnhtyS4q0hYUo6lPILlseeHC1RmQT23TN5JmIgFm0dR
         0/XjaWPTfFmf45rKmDOmMQayA5zy3mCMEvbfmDrPmmRLkWjTj5QOggi0j+qD30AzIecT
         co88hoS+QqBJsYsxY4B6pv8cbAuNHcx/KE4bqhTgPwXBiKhxqdGadgwe+bTN/tiF+V5q
         Om4rtUfCppqNMkG4RPugLU5nOK5P52aa5B4caBgvIzCPm75XyGP9lodHRjPNUDnMTrwI
         XqR2+vxajVhTJkE3p4RX9dDAKJOo96H/5YeKTWtaye532eAYi1tWdB4xoJ03pFEX5aaJ
         42wA==
X-Forwarded-Encrypted: i=1; AJvYcCWtRgenePIFner5rPdv8a+JAtPal5UmCdWzn8zvtuh/D6rRMEjQ1M+Y9NAHgtMhQeTniWbzsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3ncnEZ4FFNHmqHigWDIqLUIfeOXEXUX/uuzFUcZYGDHcQ+mG0
	baUGULCo3dtlOi7xY94+XyR6ngwXkcjBT78xPuj/4ghLLkVnGI//bsmjWmSrz6Kn+lpRsXJAv+0
	CoYia1McvuOnp6w==
X-Received: from qkbdv10.prod.google.com ([2002:a05:620a:1b8a:b0:8c5:335a:95f3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:44d6:b0:8c6:af59:5e2c with SMTP id af79cd13be357-8c6e2d8d992mr218217985a.18.1769137409254;
 Thu, 22 Jan 2026 19:03:29 -0800 (PST)
Date: Fri, 23 Jan 2026 03:03:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123030327.3041148-1-edumazet@google.com>
Subject: [PATCH v2 net] mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@linux.dev>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com, 
	Eulgyu Kim <eulgyukim@snu.ac.kr>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"

syzbot and Eulgyu Kim reported crashes in mptcp_pm_nl_get_local_id()
and/or mptcp_pm_nl_is_backup()

Root cause is list_splice_init() in mptcp_pm_nl_flush_addrs_doit()
which is not RCU ready.

list_splice_init_rcu() can not be called here while holding pernet->lock
spinlock.

Many thanks to Eulgyu Kim for providing a repro and testing our patches.

Fixes: 141694df6573 ("mptcp: remove address when netlink flushes addrs")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+5498a510ff9de39d37da@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6970a46d.a00a0220.3ad28e.5cf0.GAE@google.com/T/
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Cc: Geliang Tang <geliang@kernel.org>
---
v2: Make sure the list was not empty, return early otherwise.
v1: https://lore.kernel.org/netdev/20260122131306.2119853-1-edumazet@google.com/

 net/mptcp/pm_kernel.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 57570a44e4185370f531047fe97ce9f9fbd1480b..af23be6658ded4860133bb9495c7738014815d28 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1294,16 +1294,28 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 {
	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	LIST_HEAD(free_list);
+	struct list_head free_list;

	spin_lock_bh(&pernet->lock);
-	list_splice_init(&pernet->endp_list, &free_list);
+
+	free_list = pernet->endp_list;
+	INIT_LIST_HEAD_RCU(&pernet->endp_list);
+
	__reset_counters(pernet);
	pernet->next_id = 1;
	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
+
+	if (free_list.next == &pernet->endp_list)
+		return 0;
+
	synchronize_rcu();
+
+	/* Adjust the pointers to free_list instead of pernet->endp_list */
+	free_list.prev->next = &free_list;
+	free_list.next->prev = &free_list;
+
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
	__flush_addrs(&free_list);
	return 0;
 }
--
2.52.0.457.g6b5491de43-goog


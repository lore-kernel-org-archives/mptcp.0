Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070BE366DB9
	for <mptcp@lists.linux.dev>; Tue, 16 Jun 2026 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614097; cv=pass; b=nTXL3n/ynbcIJFHe1oYL3Kf4MvAZ9No4EGVwg0hk9+6IPh6LqP3VooPllmE/sxpLEuxcbU926lRaSSG2lojdj8q+A8+pCjCAyLigU+MLbBoW97jzxwZN9EaJlWu4htKy+0125ItqNIbljxnuURbYX4T09hx8gXHqGKhiD7fS3aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614097; c=relaxed/simple;
	bh=/dDcIvrFkRr9qtEgJdl7QzhAtXL7oLj3AJm0nXBEFPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5lsqa2rWW04DqgluntSsDP79QVZouyTOQ2DNHOQKUSWG0QYutmyoA+EDngFNPqE5nFNYIXgWYaAkVRK0uAMZofAkRaetQ24PHoiCnu6V+ROamOGldNa4YZUJ1RGH+WwcoprmJvVSUCe9ZMNzJPgfBMksNNYJnPf+udp897/vG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=Xp2+g52b reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="Xp2+g52b"
ARC-Seal: i=1; a=rsa-sha256; t=1781614091; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lNYWXgOx4O1A0J7vTY8w7KNzSn4dOQ9Ra3MrfsRimO1nCO7YRqKbGsoM9hqsbH0+NLts6GBY6lz5utWc/LBSY4p4hmdacMVZrl0qn4CouSqw7TGVRBZm900mSNwOLWgp5PzEUFG9A9Yg/ecLAngViJzv1LTWZIT7WioLPv1KdRs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781614091; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IgfqegLSQBdGQbEpXmpHmC1cNl6LS34pN2QtnJE22NM=; 
	b=d+e9lKBQ5vT66jLaV8nea+0iOK1azSzjuxKX43iJkgrLiaVEhfLNLnkqLmbyDQOWGn7lXRRP7roa/OSTiSKHU1cViq3SN+rdEyNN3Tcty7vP8Kv77uda5BpfTnhxhSJrw+8yMyxTzwwWNLEqrFku5uE2SAU2AF/OujY1B3h3My8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781614091;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IgfqegLSQBdGQbEpXmpHmC1cNl6LS34pN2QtnJE22NM=;
	b=Xp2+g52bmOQkATGLvdD0XY5VsVqlFp/TgfQMkxnTW7HoN9uVErNDAeYDNnYe/73u
	WP2aplOXeQU62dPv3BHiqAG8aBZB96APNG8s4UctKbOJeffZqD51PxTrO/kQxMOjZ4w
	D7fco4hlVaDL/hxsYmSakcfqSBX4tBDfX1HxgfT4=
Received: by mx.zohomail.com with SMTPS id 1781614089656226.7623322258056;
	Tue, 16 Jun 2026 05:48:09 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matthieu.baerts@tessares.net,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com
Subject: [PATCH mptcp-next] mptcp: fix lockdep splat by using GFP_ATOMIC in sk_net_refcnt_upgrade
Date: Tue, 16 Jun 2026 18:18:01 +0530
Message-ID: <20260616124801.2282199-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The function sk_net_refcnt_upgrade() is called while holding a socket lock
in mptcp_subflow_create_socket(). This function performs an allocation via
ref_tracker_alloc(gfp), which was using GFP_KERNEL.

GFP_KERNEL can trigger page reclaim, which creates a lockdep edge with
fs_reclaim, leading to a circular dependency when combined with other
lock chains from the block layer (nbd driver).

Change the allocation to use GFP_ATOMIC instead. This is safe because:
- The ref_tracker struct is small (~200 bytes)
- GFP_ATOMIC allocation failure is extremely unlikely
- GFP_ATOMIC is commonly used in other locked contexts

Tested with mptcp/mptcp-upstream-virtme-docker CI: all 24 tests pass.

Circular dependency chain detected:
  fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET/1

Fixes: 0cafd77dcd03 ("net: add a refcount tracker for kernel sockets")
Reported-by: syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/599
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8a59bfaa8096..8458c304dabc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2399,7 +2399,7 @@ void sk_net_refcnt_upgrade(struct sock *sk)
 	__netns_tracker_free(net, &sk->ns_tracker, false);
 	net_passive_dec(net);
 	sk->sk_net_refcnt = 1;
-	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+	get_net_track(net, &sk->ns_tracker, GFP_ATOMIC);
 	sock_inuse_add(net, 1);
 }
 EXPORT_SYMBOL_GPL(sk_net_refcnt_upgrade);
-- 
2.43.0


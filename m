Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE12FB965
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678936; cv=pass; b=o2IuHvw5XDFsnvhYrNRSQuFgdgwmtOrd4wOVVsHAnQ+EdrwB1isT8PRmeXVrI+klxvawiV1WHtZpFhoZuDkdSZu4YWwWsZkGtW22Kl0xZxkf2XRNffjKqubvC/4W3SyllUuadREwCo+ziu5lUFxcBArIm59ofKvr+0BniN/I0jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678936; c=relaxed/simple;
	bh=6OwEqVN6lf35BJN+fTiwjdOSrfyql/UJbfA5RPfoudQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQBRhLa0uCxdDT74vUEKvelWjqkc2Kj892tN4j3USC6xw7oztj8zZNjW/HJmxMiH1mk8HBHBldGjLdmovpP0PFrtdI5d70H8gv1l0ifd8c3fLUpMCMcWL4PvLrkxDPfYSGhXVfNIUETjEEb6P6lbkKFgSakzVq66+r3swiTvtp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=OxfXp+Yl reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="OxfXp+Yl"
ARC-Seal: i=1; a=rsa-sha256; t=1781678927; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JqkxQ2GmMFLqN/J8zCzPZD07wNDi6B46HemImu/s97OcKFGGJX4b3s2vwSiRDuQi+HeNo4GV5vRM2hSCDfYBnMv+O14K7oNZTC8leUWfmsoMwZabGDFqs1YCkNqyLmkj5CxCn/8/u5xWcijwNqqjWlmx8qIG28KWPRcOqveAT8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781678927; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IvPz2L3JpD1Hv1qlFe7Z9E5ArwwK/Di7HDN9uM7Vv9c=; 
	b=L3Q2zb8AgJ45O33/GmM0E42FbPHKS6rppLoydW76FODeoBzwYFy3HYUlYhYUeVBjRj063wQqU7d90DJOgu0gaRGsq19oi+X4o4QI/REklZDiSoxFLB+GFhCj4Lp5mJx5X2mmvVFqYpnDBhy9Ee4TFRairadySX0iP5y0+spB5jE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781678927;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IvPz2L3JpD1Hv1qlFe7Z9E5ArwwK/Di7HDN9uM7Vv9c=;
	b=OxfXp+YlsAFu7/ouOiJgHf8dDxq7KWqCI+IkIQD3Zr7VlK1/sxUZglSbKB9wGhoZ
	aekfoAKwYlAtCVE8GDUfQaGNAFBsCQLgR5eRdvyHZZWMs2XYVSS79hDGeLIJ9GRQeZy
	wOPj0yWLPOh5SWOloUHQNyw6P5S6QxTdr+SMqD3g=
Received: by mx.zohomail.com with SMTPS id 1781678924784932.396867762129;
	Tue, 16 Jun 2026 23:48:44 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	akshit@mpiricsoftware.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com
Subject: [PATCH mptcp-next] mptcp: fix lockdep splat in mptcp_subflow_create_socket
Date: Wed, 17 Jun 2026 12:18:35 +0530
Message-ID: <20260617064835.2957303-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Move sk_net_refcnt_upgrade() outside the socket lock to avoid GFP_KERNEL
allocation under lock_sock_nested(), which can trigger page reclaim and
create a circular locking dependency detected by lockdep.

The circular dependency chain detected:
  fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET/1

This operation is safe after lock release since the socket is fully
initialized and no other references to it exist yet.

Tested with mptcp/mptcp-upstream-virtme-docker CI: all 24 tests pass.

Fixes: 0cafd77dcd03 ("net: add a refcount tracker for kernel sockets")
Reported-by: syzbot+fb2c3fa2ba28aec94627@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/599
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/subflow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..0dc8d32ef291 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1800,11 +1800,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
-	/* kernel sockets do not by default acquire net ref, but TCP timer
-	 * needs it.
-	 * Update ns_tracker to current stack trace and refcounted tracker.
-	 */
-	sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
@@ -1812,6 +1807,11 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	mptcp_sockopt_sync_locked(mptcp_sk(sk), sf->sk);
 	release_sock(sf->sk);
 
+	/* Upgrade net namespace refcount after releasing the socket lock
+	 * to avoid GFP_KERNEL allocation under lock (lockdep: fs_reclaim).
+	 */
+	sk_net_refcnt_upgrade(sf->sk);
+
 	/* the newly created socket really belongs to the owning MPTCP
 	 * socket, even if for additional subflows the allocation is performed
 	 * by a kernel workqueue. Adjust inode references, so that the
-- 
2.43.0


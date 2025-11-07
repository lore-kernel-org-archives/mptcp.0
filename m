Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0030F920
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552565; cv=none; b=VftGr1us652THY5IgykiN1EshJgMtgsGA0Y5GOj1rjUx6/5nIlRs4OKkl0nW8uorfXDUDQnbL5UJc+4kCGtUDBHtXzjTh8NAbKnEkcCdr3c8igi+W0pdPA7V371XIqhJApaXrHfsJ2pYi4N0gBwRbwroBAwUd/qTL8x5TzribYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552565; c=relaxed/simple;
	bh=hhbN9q4izFhFofHuFoQK1VaiAWne6mqpGTQt3izVZM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KWqCnbsAvyCjhCLLWQ/fnc8W9wElQ1PE9xk4UOmithL7DCWWth6G/03B4cHIMvg8+WF+72KxfaVPlsQ1n81Gfm613Nb1SLdLmNVFX81Yj1Hr16xTnIxZMxC4VzwURq7KPM1+ffm/QbDt+WhbTRLY/7axuGohK3wU3/89wDWH1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3EJp5qZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3EJp5qZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762552562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=silAlDuEfYZxesie57Qu6zvXqH0ebrjGlUNyt9EJ04Y=;
	b=U3EJp5qZg903NJ0PHPWybmppxXog+w7DwhTyOt2MC0VkOqU7nUuXFN//zodO1OdUWaxqHf
	brI0ac4RffyXnLM9QfShSGP1APB39Su6oEAXE0rYq790NzvvEdOaAWMiFgN01qZawiD+Wq
	nAhnVnr49CrcjwpM7YoYoNJtk+1t3Ek=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-RSqPa25fN9yc5D6deqHYyg-1; Fri,
 07 Nov 2025 16:56:01 -0500
X-MC-Unique: RSqPa25fN9yc5D6deqHYyg-1
X-Mimecast-MFC-AGG-ID: RSqPa25fN9yc5D6deqHYyg_1762552560
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B14CD180034A
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:56:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 476AC19560A7
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:55:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/3] mptcp: factor-out cgroup data inherit helper
Date: Fri,  7 Nov 2025 22:55:46 +0100
Message-ID: <60403f2c512fa05217c72b2d0d840bad3f60d402.1762551942.git.pabeni@redhat.com>
In-Reply-To: <cover.1762551942.git.pabeni@redhat.com>
References: <cover.1762551942.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FMrSBznNmTGBbl5Gt_va5O2h-kk0Fh1sRmWx1Fg4xDM_1762552560
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP will soon need the same functionality for passive sockets,
factor them out in a common helper. No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 20 ++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 051f21b06d33..300ac7030958 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -755,6 +755,8 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
+void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
+
 int mptcp_is_enabled(const struct net *net);
 unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 60f100b2a0c9..599a21d92590 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1721,21 +1721,25 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	return err;
 }
 
-static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
+void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk)
 {
 #ifdef CONFIG_SOCK_CGROUP_DATA
-	struct sock_cgroup_data *parent_skcd = &parent->sk_cgrp_data,
-				*child_skcd = &child->sk_cgrp_data;
+	struct sock_cgroup_data *sk_cd = &sk->sk_cgrp_data,
+				*ssk_cd = &ssk->sk_cgrp_data;
 
 	/* only the additional subflows created by kworkers have to be modified */
-	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
-	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
-		cgroup_sk_free(child_skcd);
-		*child_skcd = *parent_skcd;
-		cgroup_sk_clone(child_skcd);
+	if (cgroup_id(sock_cgroup_ptr(sk_cd)) !=
+	    cgroup_id(sock_cgroup_ptr(ssk_cd))) {
+		cgroup_sk_free(ssk_cd);
+		*ssk_cd = *sk_cd;
+		cgroup_sk_clone(sk_cd);
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
+}
 
+static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
+{
+	__mptcp_inherit_cgrp_data(parent, child);
 	if (mem_cgroup_sockets_enabled)
 		mem_cgroup_sk_inherit(parent, child);
 }
-- 
2.51.0


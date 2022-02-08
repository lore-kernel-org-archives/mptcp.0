Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC62C9C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644347198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYwqW+yN/sja4Ias0iLWRwk9JKIWwJVcdVXbuPq8dd4=;
	b=iVYkprZ9NSKyDNcFnPjqhQUM0QSWhgB1LB97PhGM627YTWPrE2hbZdKaA4zcvBqmOqpy6d
	yogYoE48XjcH+b0F/QDpsOsrymDySPORHhiN9Geetx9jO1Enh9haNqQjG9rnzZjh2lYFQH
	PN4m2MzUWBH5sUvlKxzuWBJ/y9PZqSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-QCjTXgSROqO3MhlCyhbzVQ-1; Tue, 08 Feb 2022 14:06:35 -0500
X-MC-Unique: QCjTXgSROqO3MhlCyhbzVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4438E80292C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A669B60BF4
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 2/4] mptcp: fix race in incoming ADD_ADDR option processing.
Date: Tue,  8 Feb 2022 20:06:16 +0100
Message-Id: <9055dfabebe975c34e5f741885e1c70ecb49da36.1644346664.git.pabeni@redhat.com>
In-Reply-To: <cover.1644346664.git.pabeni@redhat.com>
References: <cover.1644346664.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

If an MPTCP endpoint received moltiple consecutive incoming
ADD_ADDR options, mptcp_pm_add_addr_received() can overwrite
the current remote address value after the PM lock is released
in mptcp_pm_nl_add_addr_received() and before such address
is echoed.

Fix the issue caching the remote address value a little earlier
and always using the cached value after releasing the PM lock.

Fixes: f7efc7771eac ("mptcp: drop argument port from mptcp_pm_announce_addr")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fb8d4bfcfbd6..4b6aa89d45a5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -660,6 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
+	bool reset_port;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -669,15 +670,19 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 
-	if (lookup_subflow_by_daddr(&msk->conn_list, &msk->pm.remote))
+	remote = msk->pm.remote;
+	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
 		goto add_addr_echo;
 
+	/* pick id 0 port, if none is provided the remote address */
+	if (!remote.port) {
+		reset_port = true;
+		remote.port = sk->sk_dport;
+	}
+
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	remote = msk->pm.remote;
-	if (!remote.port)
-		remote.port = sk->sk_dport;
 	nr = fill_local_addresses_vec(msk, addrs);
 
 	msk->pm.add_addr_accepted++;
@@ -690,8 +695,12 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		__mptcp_subflow_connect(sk, &addrs[i], &remote);
 	spin_lock_bh(&msk->pm.lock);
 
+	/* be sure to echo exactly the received address */
+	if (reset_port)
+		remote.port = 0;
+
 add_addr_echo:
-	mptcp_pm_announce_addr(msk, &msk->pm.remote, true);
+	mptcp_pm_announce_addr(msk, &remote, true);
 	mptcp_pm_nl_addr_send_ack(msk);
 }
 
-- 
2.34.1


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AC2FAF
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQn0/gTnQegzSLVGIcVmsl4xkMWRJBh7ya7kxDTOGBI=;
	b=LCkdB8uCaFtQX7/wuAMTjYAfC7yBhhQpC3MAFoy0PKJV/pnyy1lulxZVv98y4Ck1V0fEi2
	I6jp5KxyIlbWL3EJohGL588mL66dpqGmwZ8vLyvn6L5u9ktNV5+rJUr5gLYf9EFyAHLgFH
	vSsZjnnCXqFrL00/p9YOIibdlFRGkUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-TckjFWM9NW2bhU1pRZtIAg-1; Tue, 13 Jul 2021 17:13:55 -0400
X-MC-Unique: TckjFWM9NW2bhU1pRZtIAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFB0A8015C6
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:54 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0064360C5F
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 4/8] mptcp: cleanup sysctl data and helpers
Date: Tue, 13 Jul 2021 23:13:34 +0200
Message-Id: <5bb122d59fd6476c3317dc3d6e10a26141e49d87.1626210682.git.pabeni@redhat.com>
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
References: <cover.1626210682.git.pabeni@redhat.com>
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

Reorder the data in mptcp_pernet to avoid wasting space
with no reasons and constify the access helpers.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/ctrl.c     | 12 ++++++------
 net/mptcp/protocol.h |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 7d738bd06f2c..63bba9d8e289 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -21,33 +21,33 @@ struct mptcp_pernet {
 	struct ctl_table_header *ctl_table_hdr;
 #endif
 
-	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
+	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 };
 
-static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
+static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
 {
 	return net_generic(net, mptcp_pernet_id);
 }
 
-int mptcp_is_enabled(struct net *net)
+int mptcp_is_enabled(const struct net *net)
 {
 	return mptcp_get_pernet(net)->mptcp_enabled;
 }
 
-unsigned int mptcp_get_add_addr_timeout(struct net *net)
+unsigned int mptcp_get_add_addr_timeout(const struct net *net)
 {
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 
-int mptcp_is_checksum_enabled(struct net *net)
+int mptcp_is_checksum_enabled(const struct net *net)
 {
 	return mptcp_get_pernet(net)->checksum_enabled;
 }
 
-int mptcp_allow_join_id0(struct net *net)
+int mptcp_allow_join_id0(const struct net *net)
 {
 	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6f55784a2efd..43ff6c5baddc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -556,10 +556,10 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 	clear_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status);
 }
 
-int mptcp_is_enabled(struct net *net);
-unsigned int mptcp_get_add_addr_timeout(struct net *net);
-int mptcp_is_checksum_enabled(struct net *net);
-int mptcp_allow_join_id0(struct net *net);
+int mptcp_is_enabled(const struct net *net);
+unsigned int mptcp_get_add_addr_timeout(const struct net *net);
+int mptcp_is_checksum_enabled(const struct net *net);
+int mptcp_allow_join_id0(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
-- 
2.26.3


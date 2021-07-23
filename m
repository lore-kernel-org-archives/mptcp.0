Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D7173
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627047097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CJp9cY4sd91wbejT2wptrC0FmEhoG4ZRSLKtIXoHn2s=;
	b=bSjDzXd/aJR3YzkO7diMyZxwLVvpp0gqKYCkNdlYOJVAHlzo1khzSMzR7JIEF8Pc2iTnQr
	kFThMg+B5eoLidGqigaOtw8h6wRKL11IFXc3ctUFbFELjYAgvWgJgIylWafKUPCvei5H7I
	jxhXDGPRtFfoBMSsGN8BGXb9/xjdWV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-HLew3KeAOaOoAwWSotNoSg-1; Fri, 23 Jul 2021 09:31:32 -0400
X-MC-Unique: HLew3KeAOaOoAwWSotNoSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B57E7801A92;
	Fri, 23 Jul 2021 13:31:31 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-240.ams2.redhat.com [10.36.112.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0E975D9C6;
	Fri, 23 Jul 2021 13:31:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH mptcp-next] Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
Date: Fri, 23 Jul 2021 15:31:16 +0200
Message-Id: <4206e5473ed255fa08af48a7b5bc0edd00abb99d.1627047074.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

We don't need to add a 2nd mptcp_addr_info inside out_options:
it's quite huge and only one of local or remote is used.

revert back to a single 'addr' field.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/mptcp.h |  3 +--
 net/mptcp/options.c | 13 +++++--------
 net/mptcp/pm.c      |  4 ++--
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d0b9e4a7121f..8b5af683a818 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -61,8 +61,7 @@ struct mptcp_out_options {
 	u64 sndr_key;
 	u64 rcvr_key;
 	u64 ahmac;
-	struct mptcp_addr_info local;
-	struct mptcp_addr_info remote;
+	struct mptcp_addr_info addr;
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
 	u8 backup;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6803de5d4209..eafdb9408f3a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -665,7 +665,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	unsigned int opt_size = *size;
 	bool echo;
 	bool port;
-	u8 family;
 	int len;
 
 	if (!mptcp_pm_should_add_signal(msk) ||
@@ -675,8 +674,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 
 	if (drop_other_suboptions)
 		remaining += opt_size;
-	family = echo ? opts->remote.family : opts->local.family;
-	len = mptcp_add_addr_len(family, echo, port);
+	len = mptcp_add_addr_len(opts->addr.family, echo, port);
 	if (remaining < len)
 		return false;
 
@@ -692,11 +690,10 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	if (!echo) {
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
-						     &opts->local);
+						     &opts->addr);
 	}
-	pr_debug("local_id=%d, local_port=%d, remote_id=%d, remote_port=%d, ahmac=%llu, echo=%d",
-		 opts->local.id, ntohs(opts->local.port), opts->remote.id,
-		 ntohs(opts->remote.port), opts->ahmac, echo);
+	pr_debug("addr_id=%d, addr_port=%d, ahmac=%llu, echo=%d",
+		 opts->addr.id, ntohs(opts->addr.port), opts->ahmac, echo);
 
 	return true;
 }
@@ -1253,7 +1250,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
-		struct mptcp_addr_info *addr = opts->ahmac ? &opts->local : &opts->remote;
+		struct mptcp_addr_info *addr = &opts->addr;
 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo = MPTCP_ADDR_ECHO;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 692614c1f552..4d1828fd2482 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -282,10 +282,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 		goto out_unlock;
 
 	if (*echo) {
-		opts->remote = msk->pm.remote;
+		opts->addr = msk->pm.remote;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
 	} else {
-		opts->local = msk->pm.local;
+		opts->addr = msk->pm.local;
 		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
 	}
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
-- 
2.26.3


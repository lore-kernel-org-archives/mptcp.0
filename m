Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1013168
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627296944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuoM/A8A4XAh7DwZM7EtyLxd1cEk+i5KQzmBtHd5j+s=;
	b=KJ7EsITOTUn6fBFK46huJCg+SUEbDX/VZh2I2uVgwXyrSBD6uURoXBQMgHFzCH2emhKmrP
	POkmWaXVnmepBuOnfdliP3JRl+dM9X+FNIL4CXSp8f9wR7Is79GKVF6nakfIBAX+82CYOo
	KIbsQsg894OR1g2ycnCH7wWXg45TGBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493--kpHaEa3NiSuNNibjKg1iw-1; Mon, 26 Jul 2021 06:55:42 -0400
X-MC-Unique: -kpHaEa3NiSuNNibjKg1iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AADCB1936B67;
	Mon, 26 Jul 2021 10:55:41 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-71.ams2.redhat.com [10.36.113.71])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E914F19D9B;
	Mon, 26 Jul 2021 10:55:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 1/3] Squash-to: "mptcp: move drop_other_suboptions check under pm lock"
Date: Mon, 26 Jul 2021 12:55:27 +0200
Message-Id: <d945af43d09672ea8bd98d06439db11985a3504a.1627296764.git.pabeni@redhat.com>
In-Reply-To: <cover.1627296764.git.pabeni@redhat.com>
References: <cover.1627296764.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Commit message to be updated appending:

"""
Additionally, always drop the other suboption for TCP pure ack:
that makes both the code simpler and the MPTCP behaviour more
consistent.
"""


Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4d1828fd2482..cd2323e5ccdc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -266,10 +266,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 
-	if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
-	     ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
-	      (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
-	    skb && skb_is_tcp_pure_ack(skb)) {
+	/* always drop every other options for pure ack ADD_ADDR; this is a
+	 * plain dup-ack from TCP perspective. The other MPTCP-relevant info,
+	 * if any, will be carried by the 'original' TCP ack
+	 */
+	if (skb && skb_is_tcp_pure_ack(skb)) {
 		remaining += opt_size;
 		*drop_other_suboptions = true;
 	}
-- 
2.26.3


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49EE1FBF
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650550840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lwxSQtYs3DtTz8QQ9eyhgcYER6AqBrJiuFnazSgJUc=;
	b=RrjLv5ifFxjmB3y9dRzAfd9y1xmweGfVXpYo506TI7CYVLXWOccfeDwa5tQnvXsGZtr/IX
	a53DrLY3dFyZL0EK/PiUaLwdvIVEL10QzLXbyHwjU8pySzvPVDTmrhxh5j17HZpNmfcN60
	ejIUQkWtn7jWCyL6RYQxzB1BtyCim3Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-4ZtpBCRQP5mtJegCQQVD-w-1; Thu, 21 Apr 2022 10:20:39 -0400
X-MC-Unique: 4ZtpBCRQP5mtJegCQQVD-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CC8F1C07386
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.32.181.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C317D14A4F80
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 2/5] mptcp: add mib for xmit window sharing
Date: Thu, 21 Apr 2022 16:20:16 +0200
Message-Id: <ee2019a80867237606b7c4a7a65b6d9eac5fee90.1650550242.git.pabeni@redhat.com>
In-Reply-To: <cover.1650550242.git.pabeni@redhat.com>
References: <cover.1650550242.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Bump a counter for counter when snd_wnd is shared among subflow,
for observability's sake.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index d93a8c9996fd..6a6f8151375a 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -56,6 +56,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
+	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 529d07af9e14..2411510bef66 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -49,6 +49,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
+	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0223a44d6b29..098f8f7d6366 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1153,8 +1153,10 @@ static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *s
 	mptcp_snd_wnd = window_end - data_seq;
 	avail_size = min_t(unsigned int, mptcp_snd_wnd, avail_size);
 
-	if (unlikely(tcp_sk(ssk)->snd_wnd < mptcp_snd_wnd))
+	if (unlikely(tcp_sk(ssk)->snd_wnd < mptcp_snd_wnd)) {
 		tcp_sk(ssk)->snd_wnd = min_t(u64, U32_MAX, mptcp_snd_wnd);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_SNDWNDSHARED);
+	}
 
 	return avail_size;
 }
-- 
2.35.1


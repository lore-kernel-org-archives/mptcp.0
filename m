Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800862F80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620163796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Cme9KNypUiuympsaoou7MKRMXMSohGcMQENyEHTwow=;
	b=GoeksvsNMv3xIkNG7vGBMJSeOq1Px5Gdz9b0v703djavFR7DZ1XzXBFM50gV4GRkiiuXX0
	YLdQkXfNC5OKkLUVto9Xu092x9SK0vt8DO0vP2X0GilH5d5gFoVDoA+VVKrx5RF9cKutOH
	M5SQNnpzqDexn3Zc87Ow/EBWoQEupTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-eow3hp19MPOBzYsdcfUfqw-1; Tue, 04 May 2021 17:29:53 -0400
X-MC-Unique: eow3hp19MPOBzYsdcfUfqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3277C18B9EC3;
	Tue,  4 May 2021 21:29:52 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E19E6061F;
	Tue,  4 May 2021 21:29:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v5 mptcp-next 07/21] Squash-to "mptcp: send out checksum for DSS"
Date: Tue,  4 May 2021 23:29:17 +0200
Message-Id: <ecb4151ba901977739840b437c89ef655afdfba1.1620162984.git.pabeni@redhat.com>
In-Reply-To: <cover.1620162984.git.pabeni@redhat.com>
References: <cover.1620162984.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Account for csum len in mptcp_established_options_dss()
and finalize csum when needed.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - finalize csum
v3 -> v4
 - use opts->csum_reqd (Geliang)
 - reoder remaining, dss_size update (Geliang)
---
 net/mptcp/options.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8ff840bca481..ef951cb2aff3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -479,6 +479,9 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		if (data_len > 0) {
 			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
 			if (opts->csum_reqd) {
+				/* we need to propagate more info to csum the pseudo hdr */
+				opts->ext_copy.data_seq = mpext->data_seq;
+				opts->ext_copy.subflow_seq = mpext->subflow_seq;
 				opts->ext_copy.csum = mpext->csum;
 				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
 			}
@@ -553,15 +556,17 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
-		unsigned int map_size;
+		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
 
-		map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
+		if (mpext) {
+			if (opts->csum_reqd)
+				map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;
 
-		remaining -= map_size;
-		dss_size = map_size;
-		if (mpext)
 			opts->ext_copy = *mpext;
+		}
 
+		remaining -= map_size;
+		dss_size = map_size;
 		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
 		ret = true;
@@ -1375,7 +1380,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			ptr += 1;
 			if (opts->csum_reqd) {
 				put_unaligned_be32(mpext->data_len << 16 |
-						   (__force u16)mpext->csum, ptr);
+						   mptcp_make_csum(mpext), ptr);
 			} else {
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
-- 
2.26.2


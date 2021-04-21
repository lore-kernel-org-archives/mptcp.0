Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2062F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjygErCoXTXBHGMK/Vee+ukKe9I0e8iSum91nZdOJtI=;
	b=D87D6Stevei7G+FH3puxUb49cw+gmihJDdQMZ95DEC1+ibhCob+zx1q3ndlZ1eF70B3sfU
	fausRGdwp9GX5bnCmlXGs1nBncLd1EqtgCC3FM4da4kvX41b5ayN702ZjWYn1cb6EKIsE3
	S9xMTAgyq+4zHfmeGSKbMY9pYlFkFYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-21ntoAvYOy2VTMMVCa-s_A-1; Wed, 21 Apr 2021 16:20:38 -0400
X-MC-Unique: 21ntoAvYOy2VTMMVCa-s_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E40771898296;
	Wed, 21 Apr 2021 20:20:36 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A671C6085A;
	Wed, 21 Apr 2021 20:20:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 06/21] Squash-to: "mptcp: send out checksum for MP_CAPABLE with data"
Date: Wed, 21 Apr 2021 22:17:55 +0200
Message-Id: <24cd20691e91628f144139618403546cddd18510.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
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

Copy the checksum into the opts only after computing it.

This is necessary after:
Squash-to: "mptcp: generate the data checksum"

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 710e3de8c910..814fc43ee97b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -440,7 +440,6 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_ext *mpext;
 	unsigned int data_len;
-	__sum16 csum;
 	u8 len;
 
 	/* When skb is not available, we better over-estimate the emitted
@@ -461,7 +460,6 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 	if (subflow->mp_capable) {
 		mpext = mptcp_get_ext(skb);
 		data_len = mpext ? mpext->data_len : 0;
-		csum = mpext ? mpext->csum : 0;
 
 		/* we will check ext_copy.data_len in mptcp_write_options() to
 		 * discriminate between TCPOLEN_MPTCP_MPC_ACK_DATA and
@@ -472,8 +470,6 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		opts->sndr_key = subflow->local_key;
 		opts->rcvr_key = subflow->remote_key;
 		opts->csum_reqd = READ_ONCE(msk->csum_enabled);
-		if (opts->csum_reqd)
-			opts->ext_copy.csum = csum;
 
 		/* Section 3.1.
 		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
@@ -482,8 +478,10 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		 */
 		if (data_len > 0) {
 			len = TCPOLEN_MPTCP_MPC_ACK_DATA;
-			if (opts->csum_reqd)
+			if (opts->csum_reqd) {
+				opts->ext_copy.csum = mpext->csum;
 				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
+			}
 			*size = ALIGN(len, 4);
 		} else {
 			*size = TCPOLEN_MPTCP_MPC_ACK;
-- 
2.26.2


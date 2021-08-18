Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91A173
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629282962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vde1pqorxvNgBkqkogzX0iGiejEMxJHiobUeoIcwE5A=;
	b=buIMOM1g/MH1coCduTqZhaZatamiCHLsFNL/6ylbXUy5pCku+d6OoepEQ4dd5+F4siNBlf
	XcpKscrjCUf8MDehKbSdlQx/ifrpzVnnbOiydXD6XZrmU8ddNFVedUXiqeUkmmMIX/o/+9
	WfncinefJysikc27+XRN78UvK9CJlyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-3FeEnggbN8y9n5pQ6J1niA-1; Wed, 18 Aug 2021 06:36:01 -0400
X-MC-Unique: 3FeEnggbN8y9n5pQ6J1niA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D90E91082924
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 474781036D35
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 1/4] mptcp: do not set unconditionally csum_reqd on incoming opt
Date: Wed, 18 Aug 2021 12:35:46 +0200
Message-Id: <4209d5f5217483e4c06a43afb8e3e8322566085d.1629133749.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Should be set only if the ingress packets present it, otherwise
we can confuse csum validation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d94ff50c29b3..b3d5547fdb61 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -355,8 +355,6 @@ void mptcp_get_options(const struct sock *sk,
 		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	const struct tcphdr *th = tcp_hdr(skb);
 	const unsigned char *ptr;
 	int length;
@@ -372,7 +370,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->dss = 0;
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
-	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
+	mp_opt->csum_reqd = 0;
 	mp_opt->deny_join_id0 = 0;
 	mp_opt->mp_fail = 0;
 
-- 
2.26.3


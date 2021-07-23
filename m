Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06F2FB2
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627059977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTTbMFAM/gPHAtgO1T9HcAyr56Vq9PCdpqUl0CfxrRU=;
	b=NsaX3pd/Dxxk01eymGvTjBoTUQ4Qld3gY5J1D5J+051ZtyhAJBB1y9YNIVfO5vqTOXRsDd
	1RazB0eN5No2MbNWYUsJFx3RX6tynbo6W7ETv3ly9sLlVqvKnh2VfWebBGtjWsfaLxzaI9
	WM8UzsoflbChEkgD5dgrTZCSuY3Iucc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-Rc3Y0KYEPJuzFatg-Pi7AA-1; Fri, 23 Jul 2021 13:06:16 -0400
X-MC-Unique: Rc3Y0KYEPJuzFatg-Pi7AA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 936A21005D57
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:15 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-240.ams2.redhat.com [10.36.112.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 09FDF1007604
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: shrink mptcp_out_options struct
Date: Fri, 23 Jul 2021 19:06:06 +0200
Message-Id: <35052720a5d781e597cef76c3f298520198b0001.1627059686.git.pabeni@redhat.com>
In-Reply-To: <cover.1627059686.git.pabeni@redhat.com>
References: <cover.1627059686.git.pabeni@redhat.com>
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

After the previous patch we can alias with an union several
fields in mptcp_out_options. Such struct is stack allocated and
memset() for each plain TCP out packet. Every saved byted counts.

Before:
pahole -EC mptcp_out_options
# ...
/* size: 136, cachelines: 3, members: 17 */

After:
pahole -EC mptcp_out_options
# ...
/* size: 56, cachelines: 1, members: 9 */

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/mptcp.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b5af683a818..3236010afa29 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -58,10 +58,6 @@ struct mptcp_addr_info {
 struct mptcp_out_options {
 #if IS_ENABLED(CONFIG_MPTCP)
 	u16 suboptions;
-	u64 sndr_key;
-	u64 rcvr_key;
-	u64 ahmac;
-	struct mptcp_addr_info addr;
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
 	u8 backup;
@@ -69,11 +65,23 @@ struct mptcp_out_options {
 	   reset_transient:1,
 	   csum_reqd:1,
 	   allow_join_id0:1;
-	u32 nonce;
-	u64 thmac;
-	u32 token;
-	u8 hmac[20];
-	struct mptcp_ext ext_copy;
+	union {
+		struct {
+			u64 sndr_key;
+			u64 rcvr_key;
+		};
+		struct {
+			struct mptcp_addr_info addr;
+			u64 ahmac;
+		};
+		struct mptcp_ext ext_copy;
+		struct {
+			u32 nonce;
+			u32 token;
+			u64 thmac;
+			u8 hmac[20];
+		};
+	};
 #endif
 };
 
-- 
2.26.3


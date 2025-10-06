Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF925A633
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738350; cv=none; b=IXDbv32ow3aPJq2qiUbe2cV0ZTuA/d+TvzfchNA3/xbtIG7eYEgJsB72bcD67/xb6c0uzwpEzN4t1NkAx/tHJkrXFk1x2MGUhbJ8FZnQfpV6NCGYVrYRl9U2WICQwUT2tf5QjLqQ3dqY7T7R/s0Uk7kUA+t5YlOn6dmz3x4EZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738350; c=relaxed/simple;
	bh=7VabBeinxxALiH5p3HdZiZxNb11DPqlBxE8kZRcUqUk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qJkrb6xVV1q+nbbTighY8MqHCGF3AVm5YVebx2VVi+0F29RvOrmnnypGh+r9dy9fpZLdJK2gnbTqFA3X9+WFIzdFrrOcDR6QH4SUAfs2tqZYarEi0OUEdNE/KTn2jKyQ7AHHLTa/cn+S+icCb4wsn+CLMth30ubSemQCUZ8O/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gcs2IxZ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gcs2IxZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpdef+2OiUkv1+60fG/qup4gGgKhSS8bbflqwnqPxOQ=;
	b=Gcs2IxZ6L7C+JAaQOuMYvm5LxOu4WT4Zz/hJE6fnM54iI4shu9AJ/bCjVWXlQ97HZRsP5D
	i1EU4d0uVZDAmqvt6YzNosD49D97BjU9TgcSxPMo2YZ1xA7uKurcXc37yiMaZZSWjRw9K9
	x9gEEqjBwZ5SEdT7H0XCGr1YdgtBnhk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-0VQXYJPIN0KJUJ3layKFog-1; Mon,
 06 Oct 2025 04:12:24 -0400
X-MC-Unique: 0VQXYJPIN0KJUJ3layKFog-1
X-Mimecast-MFC-AGG-ID: 0VQXYJPIN0KJUJ3layKFog_1759738344
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAB1918002CA
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0052B1800578
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 06/10] mptcp: do not miss early first subflow close event notification.
Date: Mon,  6 Oct 2025 10:12:05 +0200
Message-ID: <3f9dad349afe9c3fd1302da825e7ed907343c2d5.1759737859.git.pabeni@redhat.com>
In-Reply-To: <cover.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: je6kjUpIYBel8J4r1wzLFc8rkv5RaQBCkJnuKbilJWE_1759738344
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol is not currently emitting the NL event when the first
subflow is closed before msk accept() time.

By replacing the in use close helper is such scenario, implicitly introduce
the missing notification. Note that in such scenario we want to be sure
that mptcp_close_ssk() will not trigger any PM work, move the msk state
change update earlier, so that the previous patch will offer such
guarantee.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ce1238f620c33..6ae5ab7595272 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3988,10 +3988,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		 * deal with bad peers not doing a complete shutdown.
 		 */
 		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
-			__mptcp_close_ssk(newsk, msk->first,
-					  mptcp_subflow_ctx(msk->first), 0);
 			if (unlikely(list_is_singular(&msk->conn_list)))
 				mptcp_set_state(newsk, TCP_CLOSE);
+			mptcp_close_ssk(newsk, msk->first,
+					mptcp_subflow_ctx(msk->first));
 		}
 	} else {
 tcpfallback:
-- 
2.51.0


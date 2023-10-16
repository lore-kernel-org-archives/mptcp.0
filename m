Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDF27EFB
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjZjQeSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697463812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucbB0GphtoiwpQWdgSKDLmgGYenIfGFtJtw2GklnKV0=;
	b=GjZjQeSiDHYHrfJN6T9cDKbWVzvX58z+QGMU7xea5c0MhKgahZnD0ds1R+GfxBWn8pCl5T
	PjQrso3FeTcMZScuAmAy5WB+T0Qa+hy1zj1X/Av84lRcAu8j9DO82k5U37ab+Lrtn1QcW3
	ptebLtY3LPnsTAb1XLq809Gd/S3chS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179--poz674APVOHEZWyAuQxbA-1; Mon, 16 Oct 2023 09:43:31 -0400
X-MC-Unique: -poz674APVOHEZWyAuQxbA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4A64185A790
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:30 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60098492BFA
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:30 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/5] Squash-to: "uapi: mptcp: use header file generated from YAML spec"
Date: Mon, 16 Oct 2023 15:43:09 +0200
Message-ID: <f31205d86a4f8197798c0b7f25e24d6cc43d788e.1697463031.git.dcaratti@redhat.com>
In-Reply-To: <cover.1697463031.git.dcaratti@redhat.com>
References: <cover.1697463031.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/mptcp_pm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 0c7206531eb1..0ad598fe940b 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -11,6 +11,7 @@
 
 /**
  * enum mptcp_event_type
+ * @MPTCP_EVENT_UNSPEC: unused event
  * @MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
  *   sport, dport A new MPTCP connection has been created. It is the good time
  *   to allocate memory and send ADD_ADDR if needed. Depending on the
-- 
2.41.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBD156E6
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOvLkoWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698395695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oziar6924e8qMBBaerXULio50zutjiPRMH/5GKxEI0o=;
	b=eOvLkoWq/oWn2Hsq/YyT6BeZWRqfX6VBODYutYfZy+UigISF1OZvMbXoDB4Hi2cLKP886j
	BLejujuiehR0vdmwTjbA6s/juwxPsmcf2zQJVZsXwBkL82ZYiAKf4YqE4oGdD5BUoM3h/Y
	0tQKHZtgIqdJqjUE+RAARrWIkC1KCa8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-XCsEvTxkMgO441AAkD3xHg-1; Fri, 27 Oct 2023 04:34:51 -0400
X-MC-Unique: XCsEvTxkMgO441AAkD3xHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A399280F8F7;
	Fri, 27 Oct 2023 08:34:50 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E343C1596D;
	Fri, 27 Oct 2023 08:34:49 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org
Subject: [PATCH mptcp-next 2/2] Squash-to: "uapi: mptcp: use header file generated from YAML spec"
Date: Fri, 27 Oct 2023 10:33:02 +0200
Message-ID: <a080e03a44e41ad36f7c2aa4071f9d3177bb5dd1.1698395496.git.dcaratti@redhat.com>
In-Reply-To: <a7bddec718e2702960829e550875401c4ef0e0f4.1698395496.git.dcaratti@redhat.com>
References: <a7bddec718e2702960829e550875401c4ef0e0f4.1698395496.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/mptcp.h    | 4 ----
 include/uapi/linux/mptcp_pm.h | 8 ++++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 64ecc8a3f9f2..a6451561f3f8 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -28,10 +28,6 @@
 
 #include <linux/mptcp_pm.h>
 
-/* for backward compatibility */
-#define	__MPTCP_PM_CMD_AFTER_LAST	__MPTCP_PM_CMD_MAX
-#define	__MPTCP_ATTR_AFTER_LAST		__MPTCP_ATTR_MAX
-
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 0ad598fe940b..b5d11aece408 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -100,9 +100,9 @@ enum {
 	MPTCP_PM_ATTR_LOC_ID,
 	MPTCP_PM_ATTR_ADDR_REMOTE,
 
-	__MPTCP_PM_ATTR_MAX
+	__MPTCP_ATTR_AFTER_LAST
 };
-#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
+#define MPTCP_PM_ATTR_MAX (__MPTCP_ATTR_AFTER_LAST - 1)
 
 enum mptcp_event_attr {
 	MPTCP_ATTR_UNSPEC,
@@ -143,8 +143,8 @@ enum {
 	MPTCP_PM_CMD_SUBFLOW_CREATE,
 	MPTCP_PM_CMD_SUBFLOW_DESTROY,
 
-	__MPTCP_PM_CMD_MAX
+	__MPTCP_PM_CMD_AFTER_LAST
 };
-#define MPTCP_PM_CMD_MAX (__MPTCP_PM_CMD_MAX - 1)
+#define MPTCP_PM_CMD_MAX (__MPTCP_PM_CMD_AFTER_LAST - 1)
 
 #endif /* _UAPI_LINUX_MPTCP_PM_H */
-- 
2.41.0


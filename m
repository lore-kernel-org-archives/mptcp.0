Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997EF156D4
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMrVRv3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698395708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PxyV86KMXkZtR22SF5WbbNnyDfUU6fut+blQDuDpLO0=;
	b=XMrVRv3wKupGqtEsctfd2PCumIS3L2TasYLb/QyFr+GJ773Wh9BHzDZgqYjNdgeTNMWQxv
	ze8FOTZtZcuDFRxxmhWn7bpE0sDLPXFFyi5BUigu54dDdB67fwxvIvJcjRqjAHCooPdrgM
	Gcq5TSBZln7YrRlGRxI1pYy6I0pu0Bk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-d4pBbkDoMsWgcs6qbKS_fQ-1; Fri,
 27 Oct 2023 04:34:50 -0400
X-MC-Unique: d4pBbkDoMsWgcs6qbKS_fQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D27843827DE6;
	Fri, 27 Oct 2023 08:34:49 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C87FC1596D;
	Fri, 27 Oct 2023 08:34:49 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org
Subject: [PATCH mptcp-next 1/2] Squash-to: "Documentation: netlink: add a YAML spec for mptcp"
Date: Fri, 27 Oct 2023 10:33:01 +0200
Message-ID: <a7bddec718e2702960829e550875401c4ef0e0f4.1698395496.git.dcaratti@redhat.com>
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

add cmd-cnt-name and attr-cnt-name to generate _MPTCP_PM_CMD_AFTER_LAST
and __MPTCP_ATTR_AFTER_LAST respectively.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 Documentation/netlink/specs/mptcp.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp.yaml
index ec5c454a87ea..49f90cfb4698 100644
--- a/Documentation/netlink/specs/mptcp.yaml
+++ b/Documentation/netlink/specs/mptcp.yaml
@@ -8,6 +8,7 @@ c-family-name: mptcp-pm-name
 c-version-name: mptcp-pm-ver
 max-by-define: true
 kernel-policy: per-op
+cmd-cnt-name: --mptcp-pm-cmd-after-last
 
 definitions:
   -
@@ -167,6 +168,7 @@ attribute-sets:
   -
     name: attr
     name-prefix: mptcp-pm-attr-
+    attr-cnt-name: --mptcp-attr-after-last
     attributes:
       -
         name: unspec
-- 
2.41.0


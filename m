Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44401AD35
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680802342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3weOfqRro6PgGD3KK5lLOw4Kv0/wG4afsY1+qIT9s0=;
	b=RYNjuYX3DNK6hIf7RdWSMZ+WuZMuVEvYAHKxeMa8dqFAJPSrCljQRCy7V4VVZiyRTSO+3H
	/510DuMDZsM493kFXUeFeJQS+8kjOBZROYwlf3rOMEqAyC3kVKuDlOnK4wsy/c1efVjtBO
	2ymq5UmPGS1pPLMvD5QqhXjhEBDCAEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-mQYlGptDNyq4iKcY7hDlgw-1; Thu, 06 Apr 2023 13:32:21 -0400
X-MC-Unique: mQYlGptDNyq4iKcY7hDlgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 245B2185A794
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:21 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4E1E2027062
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:20 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC mptcp-net-next 1/5] tools: ynl: add uns-admin-perm to genetlink legacy
Date: Thu,  6 Apr 2023 19:32:01 +0200
Message-ID: <37cd08b77ca9ebfee64b40c8948bd75cb12ce54e.1680801697.git.dcaratti@redhat.com>
In-Reply-To: <cover.1680801697.git.dcaratti@redhat.com>
References: <cover.1680801697.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Message-ID: <20230406173201.9mOqdNabRTXTsXCfDclNvOrbyj0iaNpI5QxQK8gBY88@z>

this flag maps to GENL_UNS_ADMIN_PERM and will be used by future specs.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index b33541a51d6b..6d075bfb712e 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -295,7 +295,7 @@ properties:
               description: Command flags.
               type: array
               items:
-                enum: [ admin-perm ]
+                enum: [ admin-perm, uns-admin-perm ]
             dont-validate:
               description: Kernel attribute validation flags.
               type: array
-- 
2.39.2


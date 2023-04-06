Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4AAD33
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680802338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3weOfqRro6PgGD3KK5lLOw4Kv0/wG4afsY1+qIT9s0=;
	b=G43iphSNQjfx3j4lCwmo6Rpyv1hPwtOVBiBp3+8/poQdvrHrgtq3DCf3NGs/GFB5n3esIe
	tZaNWTGYIpqHBGKbXose43KKE1dCtq+r4GXYHtCe2Gy2n2IGKlV0CwBlD8ubftZE8Kx3Tn
	hckPyfhwjVO0L8i0iAEUKTMaV526EDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-XsJ2jt5ZNDO46I4QuAxXvA-1; Thu, 06 Apr 2023 13:32:17 -0400
X-MC-Unique: XsJ2jt5ZNDO46I4QuAxXvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE6C585530E
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:16 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A3622027062
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:16 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC mptcp-net-next 1/5] tools: ynl: add uns-admin-perm to genetlink legacy
Date: Thu,  6 Apr 2023 19:31:55 +0200
Message-Id: <37cd08b77ca9ebfee64b40c8948bd75cb12ce54e.1680801697.git.dcaratti@redhat.com>
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


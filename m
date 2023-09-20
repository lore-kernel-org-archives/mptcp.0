Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90111728
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695201909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfa9+ACr/QU7jEc+H0a3eplswJDylZBvSb1yBQifIVY=;
	b=CwEsLjbXSwMyTCl4aGoWmQu9inbb6EAb31WixDj48rXPwwTO0GAuF2WAxvrNcTJBpvRBfQ
	eWQEc2qexk5pb5MVYuzdWcNKwESnzeR73//AO7bM+RoLqCG+CjPXdIxX+F+2tl+xrWAAxA
	Hv5e4qYVNOJcm385/4xGcZJB5HoNxZo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-g1buRS-QO0CcGgG4pIT_zg-1; Wed, 20 Sep 2023 05:25:07 -0400
X-MC-Unique: g1buRS-QO0CcGgG4pIT_zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64D8A8001EA
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 09:24:50 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DBB7E40C6E72
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 09:25:06 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 1/6] tools: ynl: add uns-admin-perm to genetlink legacy
Date: Wed, 20 Sep 2023 11:24:44 +0200
Message-ID: <19780c4afa435cfc42768f09cbf3f7857b5c57e1.1695201346.git.dcaratti@redhat.com>
In-Reply-To: <cover.1695201346.git.dcaratti@redhat.com>
References: <cover.1695201346.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

this flag maps to GENL_UNS_ADMIN_PERM and will be used by future specs.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 12a0a045605d..c08e5e3a0aaa 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -316,7 +316,7 @@ properties:
               description: Command flags.
               type: array
               items:
-                enum: [ admin-perm ]
+                enum: [ admin-perm, uns-admin-perm ]
             dont-validate:
               description: Kernel attribute validation flags.
               type: array
-- 
2.41.0


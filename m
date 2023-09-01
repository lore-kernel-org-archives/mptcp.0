Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8618BA2D
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693591842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XFz8O0h1/UIQcqpzp/wVukbL+cKGC8tV1Rfmt2IPbQ=;
	b=eQPKRagJKZ3yvab5Wk/zbu4m9ppRhjeW1lfmQB2HJV+WDy+edoD+cWd4ONPp2L2tpqN/s7
	2sRBaPct3PAc/EXf3G3kNaqZ7ewzRjtqqs0rt4/1HYhSj+tnKI841UaSjqcLkqnnlRDpg9
	WEuRvhL3m7wh6tOccUKYz5C6rtNuhis=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-x4O20hgfOyyQHznlqAxSJg-1; Fri, 01 Sep 2023 14:10:40 -0400
X-MC-Unique: x4O20hgfOyyQHznlqAxSJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCCD5381DC8E;
	Fri,  1 Sep 2023 18:10:39 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E991D47819;
	Fri,  1 Sep 2023 18:10:39 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 1/6] tools: ynl: add uns-admin-perm to genetlink legacy
Date: Fri,  1 Sep 2023 20:10:30 +0200
Message-Id: <cf44d6a186bac1c075554fe46bb827a57d473efa.1693591676.git.dcaratti@redhat.com>
In-Reply-To: <cover.1693591676.git.dcaratti@redhat.com>
References: <cover.1693591676.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
2.40.1


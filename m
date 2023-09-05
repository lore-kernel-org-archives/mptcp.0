Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960FD2F0
	for <mptcp@lists.linux.dev>; Tue,  5 Sep 2023 13:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693922081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XFz8O0h1/UIQcqpzp/wVukbL+cKGC8tV1Rfmt2IPbQ=;
	b=HFjB16Zhz9rvUs//DnLsoTGg30c5Yqq2yAUK4lpryLsBLrT77n7koaxCEOD5goBc8eGp+z
	6dDnDDUcSEXqoZrqSo3MeIgP4ta5dR6yZyWf9g9Qxa82TE+UjPhohXlq9IVeg/x7c2XZ+Z
	NaFVAIKJ/QnyuaBmROgz2TL4SpWDR2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-sxotehVWMoOqFtbPu5rriA-1; Tue, 05 Sep 2023 09:54:40 -0400
X-MC-Unique: sxotehVWMoOqFtbPu5rriA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2301947721;
	Tue,  5 Sep 2023 13:54:39 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.32.181.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 32A2B40C84A7;
	Tue,  5 Sep 2023 13:54:39 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 1/6] tools: ynl: add uns-admin-perm to genetlink legacy
Date: Tue,  5 Sep 2023 15:53:06 +0200
Message-Id: <cf44d6a186bac1c075554fe46bb827a57d473efa.1693921470.git.dcaratti@redhat.com>
In-Reply-To: <cover.1693921470.git.dcaratti@redhat.com>
References: <cover.1693921470.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


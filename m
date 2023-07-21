Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FE19A1B
	for <mptcp@lists.linux.dev>; Fri, 21 Jul 2023 09:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689933243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTHsmWlxvt3bz5Nar9/+Qdfw5nyW298NhfVgiT0u8Jg=;
	b=UQV91vCpInLzmUwc5dMAklp/X0X8JGjXwjyaLVVTAXhNqp8LTvVedg/sc7BW2qfCy0xGhg
	kDAFTG5oN+zzRpjRfozc9tQ5pvtYUWBkASq85Ikj0wlu7t1Ud1y14qE1TJzPCp3B9gxVXa
	ChHaaksFQk14aABZAaszce67IajbloQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-nIRdW7BaP0KhIr0jkPIRUA-1; Fri, 21 Jul 2023 05:54:00 -0400
X-MC-Unique: nIRdW7BaP0KhIr0jkPIRUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D8183C0F685;
	Fri, 21 Jul 2023 09:54:00 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FD1B1121314;
	Fri, 21 Jul 2023 09:53:59 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
	pabeni@redhat.com
Cc: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/5] tools: ynl: add uns-admin-perm to genetlink legacy
Date: Fri, 21 Jul 2023 11:53:32 +0200
Message-Id: <d4d8a29eec730e3139f664d5a63d7307b9d36cd5.1689932012.git.dcaratti@redhat.com>
In-Reply-To: <cover.1689932012.git.dcaratti@redhat.com>
References: <cover.1689932012.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
index 43b769c98fb2..5be84312a91e 100644
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


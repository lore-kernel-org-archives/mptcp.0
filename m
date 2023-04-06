Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E035AD29
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680802343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWqTrKBoFL4K91oztAnzJyBDedH/s/3xELJSVJ+uxUM=;
	b=Ga6pHxtxp1nfYXYo6gKTTNrckKJtVfW84YJoHG/yGo1AEGkCgynoJuHU2U6NeIu7+9T02W
	Etu9bs6OUcqmhEy7CRCwB9Lbbyr3IICZSeXueq/bomWmSTU46erleiNAZpwB7cBrvXZM3x
	oHnO25Fjn078mS3b4XnVRbgmoi93+yY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-O969kjGFN6aYOfEONPPSVw-1; Thu, 06 Apr 2023 13:32:22 -0400
X-MC-Unique: O969kjGFN6aYOfEONPPSVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7802884EC0
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:21 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 639AF202701F
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:21 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC mptcp-net-next 2/5] tools: ynl: fix bug in case of multiple nested attributes of the same type
Date: Thu,  6 Apr 2023 19:32:02 +0200
Message-ID: <9414bdc6d3d0212238cec12d4f2d80894910e944.1680801697.git.dcaratti@redhat.com>
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
Message-ID: <20230406173202.3IVAmSK0TruxY_7JCodfb0x3Mi6z6Zo37gLoprcdQUs@z>

when a policy contains multiple nested attributes of the same type, avoid
re-initializing .request and .reply members.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 tools/net/ynl/ynl-gen-c.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index cc2f8c945340..ba55f217a006 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -812,7 +812,8 @@ class Family(SpecFamily):
                     inherit = set()
                     nested = spec['nested-attributes']
                     if nested not in self.root_sets:
-                        self.pure_nested_structs[nested] = Struct(self, nested, inherited=inherit)
+                        if nested not in self.pure_nested_structs:
+                            self.pure_nested_structs[nested] = Struct(self, nested, inherited=inherit)
                     if attr in rs_members['request']:
                         self.pure_nested_structs[nested].request = True
                     if attr in rs_members['reply']:
-- 
2.39.2


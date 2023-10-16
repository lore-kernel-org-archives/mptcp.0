Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0A28682
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhiCopyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697463813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIpimx9Otqnw08mq0i/EKDc3wFzSc03rrUUIgtg8QCg=;
	b=KhiCopyKCt7GAXs0500nUL2cG2xiD1sDP3djjH1e5INFNvTl3lmXTuDXeojy7gBKg3DZaj
	CBE62LItEEJTiMY6NqqiDNbqnZ/5RYEVt3rjqYiH5uGxl9OcxWzZ4G51H8xOsvxmXa9K3F
	CwpFzWEJ0UCLBUl250BzsuN7arI1bgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-HECBFAcrNBuH3WDDa0hRlA-1; Mon, 16 Oct 2023 09:43:32 -0400
X-MC-Unique: HECBFAcrNBuH3WDDa0hRlA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FC3681DAA1
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:32 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF882492BFA
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:31 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 5/5] tools: ynl-gen: add support for exact-len validation
Date: Mon, 16 Oct 2023 15:43:11 +0200
Message-ID: <dd36724a428132078fc63edf48af1a14eb095299.1697463031.git.dcaratti@redhat.com>
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

add support for 'exact-len' validation on netlink attributes.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 Documentation/netlink/genetlink-c.yaml      |  3 +++
 Documentation/netlink/genetlink-legacy.yaml |  3 +++
 Documentation/netlink/genetlink.yaml        |  3 +++
 Documentation/netlink/netlink-raw.yaml      |  3 +++
 tools/net/ynl/ynl-gen-c.py                  | 28 +++++++++++++--------
 5 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 9806c44f604c..812113280148 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -194,6 +194,9 @@ properties:
                   max-len:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  exact-len:
+                    description: Exact length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: &display-hint
                 description: |
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index c08e5e3a0aaa..aa32649e20e9 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -233,6 +233,9 @@ properties:
                   max-len:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  exact-len:
+                    description: Exact length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 3d338c48bf21..3f179f8b95b3 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -167,6 +167,9 @@ properties:
                   max-len:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  exact-len:
+                    description: Exact length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: &display-hint
                 description: |
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 896797876414..96913857ac71 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -240,6 +240,9 @@ properties:
                   max-len:
                     description: Max length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  exact-len:
+                    description: Exact length for a string or a binary attribute.
+                    $ref: '#/$defs/len-or-define'
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 897af958cee8..c58bca967fc1 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -355,10 +355,13 @@ class TypeString(Type):
         return f'.type = YNL_PT_NUL_STR, '
 
     def _attr_policy(self, policy):
-        mem = '{ .type = ' + policy
-        if 'max-len' in self.checks:
-            mem += ', .len = ' + str(self.checks['max-len'])
-        mem += ', }'
+        if 'exact-len' in self.checks:
+            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
+        else:
+            mem = '{ .type = ' + policy
+            if 'max-len' in self.checks:
+                mem += ', .len = ' + str(self.checks['max-len'])
+            mem += ', }'
         return mem
 
     def attr_policy(self, cw):
@@ -404,14 +407,17 @@ class TypeBinary(Type):
         return f'.type = YNL_PT_BINARY,'
 
     def _attr_policy(self, policy):
-        mem = '{ '
-        if len(self.checks) == 1 and 'min-len' in self.checks:
-            mem += '.len = ' + str(self.checks['min-len'])
-        elif len(self.checks) == 0:
-            mem += '.type = NLA_BINARY'
+        if 'exact-len' in self.checks:
+            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
         else:
-            raise Exception('One or more of binary type checks not implemented, yet')
-        mem += ', }'
+            mem = '{ '
+            if len(self.checks) == 1 and 'min-len' in self.checks:
+                mem += '.len = ' + str(self.checks['min-len'])
+            elif len(self.checks) == 0:
+                mem += '.type = NLA_BINARY'
+            else:
+                raise Exception('One or more of binary type checks not implemented, yet')
+            mem += ', }'
         return mem
 
     def attr_put(self, ri, var):
-- 
2.41.0


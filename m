Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009326E16
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIVCHfi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697463811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWp4IvsZO2p2hwMOV0wajiEAv0RWxvi9Q/sJog859Ow=;
	b=fIVCHfi2umYbo+5/O4mzZzKCNg+s57w7mTkXRO24Qkdcz8u0chWmoGoVUtuBlQzg0KEDIC
	tbgON0JsvMRo4SkGIl2eVNXZKk5ceRlwNqVzpkx+B2zRvD4ll88VI+60IFkIh/Y6kLyQKj
	2EOuRb1zv/QYxgNaw1FLedQAm0rpTwo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-6R4TLT7rPSaOJPF--BSKqQ-1; Mon, 16 Oct 2023 09:43:30 -0400
X-MC-Unique: 6R4TLT7rPSaOJPF--BSKqQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 223FF858F19
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:30 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EE26492BFA
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:43:29 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/5] Squash-to: "Documentation: netlink: add a YAML spec for mptcp"
Date: Mon, 16 Oct 2023 15:43:08 +0200
Message-ID: <c6d2fcff55e142e149a4b890505d870f9e5fbfa1.1697463031.git.dcaratti@redhat.com>
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

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 Documentation/netlink/specs/mptcp.yaml | 127 ++++++++++++-------------
 1 file changed, 62 insertions(+), 65 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp.yaml
index f8ebcd009592..ec5c454a87ea 100644
--- a/Documentation/netlink/specs/mptcp.yaml
+++ b/Documentation/netlink/specs/mptcp.yaml
@@ -4,8 +4,8 @@ name: mptcp_pm
 protocol: genetlink-legacy
 doc: Multipath TCP.
 
-c-family-name: mptcp_pm_name
-c-version-name: mptcp_pm_ver
+c-family-name: mptcp-pm-name
+c-version-name: mptcp-pm-ver
 max-by-define: true
 kernel-policy: per-op
 
@@ -13,12 +13,12 @@ definitions:
   -
     type: enum
     name: event-type
-    enum-name: mptcp_event_type
-    name-prefix: mptcp_event_
+    enum-name: mptcp-event-type
+    name-prefix: mptcp-event-
     entries:
      -
       name: unspec
-      value: 0
+      doc: unused event
      -
       name: created
       doc:
@@ -45,41 +45,38 @@ definitions:
         A new address has been announced by the peer.
      -
       name: removed
-      value: 7
       doc:
         token, rem_id
         An address has been lost by the peer.
      -
-      name: sub_established
+      name: sub-established
       value: 10
       doc:
         token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
         dport, backup, if_idx [, error]
         A new subflow has been established. 'error' should not be set.
      -
-      name: sub_closed
-      value: 11
+      name: sub-closed
       doc:
         token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
         dport, backup, if_idx [, error]
         A subflow has been closed. An error (copy of sk_err) could be set if an
         error has been detected for this subflow.
      -
-      name: sub_priority
+      name: sub-priority
       value: 13
       doc:
         token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
         dport, backup, if_idx [, error]
         The priority of a subflow has changed. 'error' should not be set.
      -
-      name: listener_created
+      name: listener-created
       value: 15
       doc:
         family, sport, saddr4 | saddr6
         A new PM listener is created.
      -
-      name: listener_closed
-      value: 16
+      name: listener-closed
       doc:
         family, sport, saddr4 | saddr6
         A PM listener is closed.
@@ -87,7 +84,7 @@ definitions:
 attribute-sets:
   -
     name: address
-    name-prefix: mptcp_pm_addr_attr_
+    name-prefix: mptcp-pm-addr-attr-
     attributes:
       -
         name: unspec
@@ -107,7 +104,7 @@ attribute-sets:
         name: addr6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: port
         type: u16
@@ -116,52 +113,52 @@ attribute-sets:
         name: flags
         type: u32
       -
-        name: if_idx
+        name: if-idx
         type: s32
   -
     name: subflow-attribute
-    name-prefix: mptcp_subflow_attr_
+    name-prefix: mptcp-subflow-attr-
     attributes:
       -
         name: unspec
         type: unused
         value: 0
       -
-        name: token_rem
+        name: token-rem
         type: u32
       -
-        name: token_loc
+        name: token-loc
         type: u32
       -
-        name: relwrite_seq
+        name: relwrite-seq
         type: u32
       -
-        name: map_seq
+        name: map-seq
         type: u64
       -
-        name: map_sfseq
+        name: map-sfseq
         type: u32
       -
-        name: ssn_offset
+        name: ssn-offset
         type: u32
       -
-        name: map_datalen
+        name: map-datalen
         type: u16
       -
         name: flags
         type: u32
       -
-        name: id_rem
+        name: id-rem
         type: u8
       -
-        name: id_loc
+        name: id-loc
         type: u8
       -
         name: pad
         type: pad
   -
     name: endpoint
-    name-prefix: mptcp_pm_endpoint_
+    name-prefix: mptcp-pm-endpoint-
     attributes:
       -
         name: addr
@@ -169,7 +166,7 @@ attribute-sets:
         nested-attributes: address
   -
     name: attr
-    name-prefix: mptcp_pm_attr_
+    name-prefix: mptcp-pm-attr-
     attributes:
       -
         name: unspec
@@ -180,7 +177,7 @@ attribute-sets:
         type: nest
         nested-attributes: address
       -
-        name: rcv_add_addrs
+        name: rcv-add-addrs
         type: u32
       -
         name: subflows
@@ -189,19 +186,19 @@ attribute-sets:
         name: token
         type: u32
       -
-        name: loc_id
+        name: loc-id
         type: u8
       -
-        name: addr_remote
+        name: addr-remote
         type: nest
         nested-attributes: address
   -
-    name: event_attr
-    enum-name: mptcp_event_attr
-    name-prefix: mptcp_attr_
+    name: event-attr
+    enum-name: mptcp-event-attr
+    name-prefix: mptcp-attr-
     attributes:
       -
-        name: UNSPEC
+        name: unspec
         type: unused
         value: 0
       -
@@ -211,10 +208,10 @@ attribute-sets:
         name: family
         type: u16
       -
-        name: loc_id
+        name: loc-id
         type: u8
       -
-        name: rem_id
+        name: rem-id
         type: u8
       -
         name: saddr4
@@ -258,13 +255,13 @@ attribute-sets:
         name: if_idx
         type: u32
       -
-        name: reset_reason
+        name: reset-reason
         type: u32
       -
-        name: reset_flags
+        name: reset-flags
         type: u32
       -
-        name: server_side
+        name: server-side
         type: u8
 
 operations:
@@ -274,29 +271,29 @@ operations:
       doc: unused
       value: 0
     -
-      name: add_addr
+      name: add-addr
       doc: Add endpoint
       attribute-set: endpoint
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: &add_addr_attrs
+      do: &add-addr-attrs
         request:
           attributes:
             - addr
     -
-      name: del_addr
+      name: del-addr
       doc: Delete endpoint
       attribute-set: endpoint
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: *add_addr_attrs
+      do: *add-addr-attrs
     -
-      name: get_addr
+      name: get-addr
       doc: Get endpoint information
       attribute-set: endpoint
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: &get_addr_attrs
+      do: &get-addr-attrs
         request:
           attributes:
            - addr
@@ -308,56 +305,56 @@ operations:
          attributes:
            - addr
     -
-      name:  flush_addrs
+      name:  flush-addrs
       doc: flush addresses
       attribute-set: endpoint
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: *add_addr_attrs
+      do: *add-addr-attrs
     -
-      name: set_limits
+      name: set-limits
       doc: Set protocol limits
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: &mptcp_limits
+      do: &mptcp-limits
         request:
           attributes:
-            - rcv_add_addrs
+            - rcv-add-addrs
             - subflows
     -
-      name: get_limits
+      name: get-limits
       doc: Get protocol limits
       attribute-set: attr
       dont-validate: [ strict ]
-      do: &mptcp_get_limits
+      do: &mptcp-get-limits
         request:
            attributes:
-            - rcv_add_addrs
+            - rcv-add-addrs
             - subflows
         reply:
           attributes:
-            - rcv_add_addrs
+            - rcv-add-addrs
             - subflows
     -
-      name: set_flags
+      name: set-flags
       doc: Change endpoint flags
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: &mptcp_set_flags
+      do: &mptcp-set-flags
         request:
           attributes:
             - addr
             - token
-            - addr_remote
+            - addr-remote
     -
       name: announce
       doc: announce new sf
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: &announce_add
+      do: &announce-add
         request:
           attributes:
             - addr
@@ -372,23 +369,23 @@ operations:
         request:
          attributes:
            - token
-           - loc_id
+           - loc-id
     -
-      name: subflow_create
+      name: subflow-create
       doc: todo
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: &sf_create
+      do: &sf-create
         request:
           attributes:
             - addr
             - token
-            - addr_remote
+            - addr-remote
     -
-      name: subflow_destroy
+      name: subflow-destroy
       doc: todo
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
-      do: *sf_create
+      do: *sf-create
-- 
2.41.0


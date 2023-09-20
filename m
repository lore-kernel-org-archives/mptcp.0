Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678CC125CC
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695201912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4oFCpXc09o76hCfmSOGLF7/65imH+pqeCUxhKzfkyU=;
	b=Msv/P2s67Vg9b6TOuD+Wmx+vcUJjHc89pMw3auNW6nVUBZSq7KmLyWTYF4qQSN6pxgX68F
	pwXRhFS5IH0UCEMzCtA0808O10wP4LT/RdFgM604edyitDMCubBQzR/xyqCdXaTvdyjrtS
	3x8prTFJLct8NtB5mZfif7l5eCilZhk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-uH94JzFZN0-KGbtRgh8ovw-1; Wed, 20 Sep 2023 05:25:11 -0400
X-MC-Unique: uH94JzFZN0-KGbtRgh8ovw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68E9F1C09A48
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 09:24:55 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75B7D40C6EC1
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 09:25:10 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 3/6] Documentation: netlink: add a YAML spec for mptcp
Date: Wed, 20 Sep 2023 11:24:46 +0200
Message-ID: <fedaf3f8ab7db3a7791d85134d23ad63c5103654.1695201346.git.dcaratti@redhat.com>
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

it describes most of the current netlink interface (uAPI definitions,
doit/dumpit operations and attributes)

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 Documentation/netlink/specs/mptcp.yaml | 394 +++++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 2 files changed, 395 insertions(+)
 create mode 100644 Documentation/netlink/specs/mptcp.yaml

diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp.yaml
new file mode 100644
index 000000000000..f8ebcd009592
--- /dev/null
+++ b/Documentation/netlink/specs/mptcp.yaml
@@ -0,0 +1,394 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: mptcp_pm
+protocol: genetlink-legacy
+doc: Multipath TCP.
+
+c-family-name: mptcp_pm_name
+c-version-name: mptcp_pm_ver
+max-by-define: true
+kernel-policy: per-op
+
+definitions:
+  -
+    type: enum
+    name: event-type
+    enum-name: mptcp_event_type
+    name-prefix: mptcp_event_
+    entries:
+     -
+      name: unspec
+      value: 0
+     -
+      name: created
+      doc:
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        A new MPTCP connection has been created. It is the good time to
+        allocate memory and send ADD_ADDR if needed. Depending on the
+        traffic-patterns it can take a long time until the
+        MPTCP_EVENT_ESTABLISHED is sent.
+     -
+      name: established
+      doc:
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        A MPTCP connection is established (can start new subflows).
+     -
+      name: closed
+      doc:
+        token
+        A MPTCP connection has stopped.
+     -
+      name: announced
+      value: 6
+      doc:
+        token, rem_id, family, daddr4 | daddr6 [, dport]
+        A new address has been announced by the peer.
+     -
+      name: removed
+      value: 7
+      doc:
+        token, rem_id
+        An address has been lost by the peer.
+     -
+      name: sub_established
+      value: 10
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        A new subflow has been established. 'error' should not be set.
+     -
+      name: sub_closed
+      value: 11
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        A subflow has been closed. An error (copy of sk_err) could be set if an
+        error has been detected for this subflow.
+     -
+      name: sub_priority
+      value: 13
+      doc:
+        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, backup, if_idx [, error]
+        The priority of a subflow has changed. 'error' should not be set.
+     -
+      name: listener_created
+      value: 15
+      doc:
+        family, sport, saddr4 | saddr6
+        A new PM listener is created.
+     -
+      name: listener_closed
+      value: 16
+      doc:
+        family, sport, saddr4 | saddr6
+        A PM listener is closed.
+
+attribute-sets:
+  -
+    name: address
+    name-prefix: mptcp_pm_addr_attr_
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: family
+        type: u16
+      -
+        name: id
+        type: u8
+      -
+        name: addr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: addr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: port
+        type: u16
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+      -
+        name: if_idx
+        type: s32
+  -
+    name: subflow-attribute
+    name-prefix: mptcp_subflow_attr_
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: token_rem
+        type: u32
+      -
+        name: token_loc
+        type: u32
+      -
+        name: relwrite_seq
+        type: u32
+      -
+        name: map_seq
+        type: u64
+      -
+        name: map_sfseq
+        type: u32
+      -
+        name: ssn_offset
+        type: u32
+      -
+        name: map_datalen
+        type: u16
+      -
+        name: flags
+        type: u32
+      -
+        name: id_rem
+        type: u8
+      -
+        name: id_loc
+        type: u8
+      -
+        name: pad
+        type: pad
+  -
+    name: endpoint
+    name-prefix: mptcp_pm_endpoint_
+    attributes:
+      -
+        name: addr
+        type: nest
+        nested-attributes: address
+  -
+    name: attr
+    name-prefix: mptcp_pm_attr_
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: addr
+        type: nest
+        nested-attributes: address
+      -
+        name: rcv_add_addrs
+        type: u32
+      -
+        name: subflows
+        type: u32
+      -
+        name: token
+        type: u32
+      -
+        name: loc_id
+        type: u8
+      -
+        name: addr_remote
+        type: nest
+        nested-attributes: address
+  -
+    name: event_attr
+    enum-name: mptcp_event_attr
+    name-prefix: mptcp_attr_
+    attributes:
+      -
+        name: UNSPEC
+        type: unused
+        value: 0
+      -
+        name: token
+        type: u32
+      -
+        name: family
+        type: u16
+      -
+        name: loc_id
+        type: u8
+      -
+        name: rem_id
+        type: u8
+      -
+        name: saddr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: saddr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: daddr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: daddr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: sport
+        type: u16
+        byte-order: big-endian
+      -
+        name: dport
+        type: u16
+        byte-order: big-endian
+      -
+        name: backup
+        type: u8
+      -
+        name: error
+        type: u8
+      -
+        name: flags
+        type: u16
+      -
+        name: timeout
+        type: u32
+      -
+        name: if_idx
+        type: u32
+      -
+        name: reset_reason
+        type: u32
+      -
+        name: reset_flags
+        type: u32
+      -
+        name: server_side
+        type: u8
+
+operations:
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+    -
+      name: add_addr
+      doc: Add endpoint
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &add_addr_attrs
+        request:
+          attributes:
+            - addr
+    -
+      name: del_addr
+      doc: Delete endpoint
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *add_addr_attrs
+    -
+      name: get_addr
+      doc: Get endpoint information
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &get_addr_attrs
+        request:
+          attributes:
+           - addr
+        reply:
+          attributes:
+           - addr
+      dump:
+        reply:
+         attributes:
+           - addr
+    -
+      name:  flush_addrs
+      doc: flush addresses
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *add_addr_attrs
+    -
+      name: set_limits
+      doc: Set protocol limits
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &mptcp_limits
+        request:
+          attributes:
+            - rcv_add_addrs
+            - subflows
+    -
+      name: get_limits
+      doc: Get protocol limits
+      attribute-set: attr
+      dont-validate: [ strict ]
+      do: &mptcp_get_limits
+        request:
+           attributes:
+            - rcv_add_addrs
+            - subflows
+        reply:
+          attributes:
+            - rcv_add_addrs
+            - subflows
+    -
+      name: set_flags
+      doc: Change endpoint flags
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &mptcp_set_flags
+        request:
+          attributes:
+            - addr
+            - token
+            - addr_remote
+    -
+      name: announce
+      doc: announce new sf
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &announce_add
+        request:
+          attributes:
+            - addr
+            - token
+    -
+      name: remove
+      doc: announce removal
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do:
+        request:
+         attributes:
+           - token
+           - loc_id
+    -
+      name: subflow_create
+      doc: todo
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &sf_create
+        request:
+          attributes:
+            - addr
+            - token
+            - addr_remote
+    -
+      name: subflow_destroy
+      doc: todo
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *sf_create
diff --git a/MAINTAINERS b/MAINTAINERS
index 8985a1b0b5ee..39abfeeb8dd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14967,6 +14967,7 @@ W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export-net
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export
+F:	Documentation/netlink/specs/mptcp.yaml
 F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
-- 
2.41.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BE18021
	for <mptcp@lists.linux.dev>; Fri,  6 Oct 2023 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBZ9D0y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED74C433C7;
	Fri,  6 Oct 2023 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696603647;
	bh=xVzQJeXStUNFo9i88mTLi/arkIrwSI7/tA7csVVJJBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lBZ9D0y8WYctz2f/rwr6JY00BdEDr6o8yPc9I+vSWLu/CHLE/t5ukM6NzNpLgNAcF
	 txQlJxZFm4z3CLyCcZYwONK97E60sIaknHTVHu/6BDlPvhSwBLike0VlkjmQfiRp29
	 ccKu5UHNMZXsXFdwCSYAQ5D9AHDBuiveYaFDQQvWwq6QndfEtpfMLw1/oDdGT41IeD
	 KkTekkP5fZd5+zzIvpAa+KCcl3wzQOPpf1HELcHijxYHROdhLdrFX9a2jj7uZ1f2nk
	 mnw8SOSPUykD5ZdQK5M9iuTYlTVsZRMPQ+k+x5AA5B0TERchntIsOMu3ABkEGAzXcW
	 tI21irH0Jboew==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 06 Oct 2023 16:46:38 +0200
Subject: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec for
 mptcp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-3-0a97f2f5410e@kernel.org>
References: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-0-0a97f2f5410e@kernel.org>
In-Reply-To: <20231006-upstream-net-next-20231006-mptcp-ynl-v1-0-0a97f2f5410e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10437; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RZatAjWOy8NVD3u6V0rQAzqBL3jkd4oTwfNuYzshWZs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlIB35wCq7ttECG3tL/8FHyn/mazWF6k0IBD08v
 lhQdY6VGT6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSAd+QAKCRD2t4JPQmmg
 c0bKEACkNP9lG9ogwuJ2tcwk8vuQvZZ3eCT2YLG1TsE514LzBaBZnIJNscu3iEaHKe3b8Js9DqD
 MaGSodxJBH3FrEmyRPYJFKVYjBto/PDvK9PnJ7bpiQxdwdE140MwGQRUT0I6tLqs7CXD9xTJwIV
 rk4RKSyPcCeV8I6zlxADwD5QeUBaot/3jGdB/S5ti6krkMSvbZBiPkHt6zXmp6NkB9lz+AVXR/f
 wUkvLepSPnf8rHFgMubaLB1yypnfcayZPH3gK5sm9V+JXyXShsrv1drit5cNVcVAe1IvF27SvMV
 dFnLJg/1QKhGpfyEcfncdCHSt0j8oxHAO8doh83gvxjzwG/qWyNKXt/xY6AC0RPPV+bW/k/C0Hy
 g4xrAhx9716dJBqNEXxpksujevLdANdDJOD1O2waGnWddX8eFoT41nZp/RHDjLik/AFg7tsK0Hk
 pW0YaMeQae8h1GMJQfrdiFTkSix3Bh+jZumNv263MO4a50wTtwYx31jba97GNs+L4/UPUSIufnT
 LsLyVjYKs+txX65hM4OdyWVnaVpQD5Yr922ha547FfIkdx7yExpiUTNL1gqy6733tX7IurcxpPo
 HZI70eHep+cyGYmnvUgIyRclxXYI/cSX52YQibRwyzjOnYPIeh6q/1tHMeq5e7kqPBL6DVzZelR
 w52eTNyF5/bQcgg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

it describes most of the current netlink interface (uAPI definitions,
doit/dumpit operations and attributes)

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp.yaml | 394 +++++++++++++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 2 files changed, 395 insertions(+)

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
index ec91df93eb95..d64e3c9eba3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14960,6 +14960,7 @@ W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export-net
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export
+F:	Documentation/netlink/specs/mptcp.yaml
 F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h

-- 
2.40.1


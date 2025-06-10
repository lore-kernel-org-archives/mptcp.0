Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A422D4E2;
	Tue, 10 Jun 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560407; cv=none; b=P6Nl+oOoSP9Skk3FvSf4Kw2Oisi2yMsqSINQcUKjYSFGWvN/p0rKPwrszngwPQKAsvWbGzL2U513pE65VHtREdJtUVAroz/mV3P2vo/bVEi63HUTby8Ae3XvM6lgmLDvu7ljpuKzWI/zT/52CivOhpKO7UqOQ/K/00g1p8MHagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560407; c=relaxed/simple;
	bh=ruRyxqu11IYo4eZzSdGi8OGpZeomHZZexAOLHjT703U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwskTZKCbgmt38UA8DTdAwTr5Q4siHiS+J38CQyQCukOsqTsE1w4qCLNxAOCrNMKU0i+lH2YdU0a25yyzqOhCgoFhTTtkIQs3qWK8l2U/yWeHLDk92ZJx8nFGkUlZLrKncUTMpvn6IkVlCxzH01++pjf8rQWjSoEEq8tZ3gwQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brrCZ7KW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brrCZ7KW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so34170395e9.2;
        Tue, 10 Jun 2025 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560402; x=1750165202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfBd7lpVrlSmgeZuwrplqniCnY7VqjzOTzQqiKGvaeM=;
        b=brrCZ7KWEyIfVgSIuaaHoJiTk4IgU1YupG9yqVA6Teny/n8AcnC0Xvf4RPlavTwksn
         GDUQD4NSneErfCUZNJ6efAUMb+pSnwNaOcnSbSmCJpDuUrfQxoIScY9hr4zH9IWJzM8+
         n0ll2awHBwP7Tq79HwAAY1Nk8Hsf/Azi1C0+bv3LbQB6LsD0UbJKmN24TnShZNGsFDeI
         gtOX2DS4e7x4kijKeZzQpbndR+5N/K7xYa6iqXy9VCQcP2Tsay7nLfoKs0YFw1fgDOC6
         yVbZ0JYsVvF1O5Dwe6Fazc5Axo6erILbHKJm88bilK5tbPo5J2c/2jc7ONL8MdURzR2r
         s9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560402; x=1750165202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfBd7lpVrlSmgeZuwrplqniCnY7VqjzOTzQqiKGvaeM=;
        b=kkrqW5zMY9RL0qGfzOEDd273e0rZh9imuijjxMvsCXAJJ7t6phu90fImUQ5m1aIy0C
         8d4Zzl+eDRUi9607FuAT+WLV9uhK45YgtWjBRi6YmwQHxgqbxyHnABRmgqqKw7sZ4BhQ
         wYWCdAw37MuQMPUnmEHJa94a38iWM7aDC9PQ23WaUZQ3xNHO80yqP0mGiSXKngzq4sFB
         oLVYx0iqFk76A1VmpITMrIwdGe3Q5Mjk+CvjASVkKThsOB4clZ63WWjbh8uRVPrGyCv5
         N1cO7J4gOOrbrypkZypeYOmPPBKCb9DO8KYCzFj+DXu7+xFkx0xOhbT5seVf3UZcRtu2
         8kdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUscGFqJ1Rs7Dls3TK6zS2gxBZ3phjySng7LFy2dKVTdxOFIkmWg7bffG7PWwKi9wWzf9Hnlug=@lists.linux.dev, AJvYcCXkNaKE3aYxd6po6cMnxEn+HgOtcRY2VHnbCdXL+Z5uhvZSj3hzCyFwGKBbdWFysi0abQt2M71Rcyd0ttGMMqSs8c1juQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyx1Z71O91HFzbZwm7e8NMIs2wT8LEsctySmpRgBOMzpXdUWoA
	S/D62ACVfxVCmjsp8WXTrfr4Zes+z0kL+x7fPIsZXrQF+v8nya4shlJq
X-Gm-Gg: ASbGncsX8HAZPBy5Cm2B7UoHvlBT1Bg2XAGL9spXNrTlCW8HLt8s5d0r7mizcMN8XrW
	o5t2CArzw2cAYgRuFVwIBl+kdCh/iSGvXgMOvtik6hhjGJ3GvFTNvKv9jT6o1tbRdY/0s1aB4gE
	mBkuuTRl3yMZ/7iaRgeEkzjIwObMCwTKeT9WnYXWk7efonGlUOsi9RWFcOpk4ZbAJA4rgYNawlG
	UQsGACAvgBI9/ON0zFdNgo0VfnIr5kOyJBm6PvQzfMqoBy1hT5IX25FCCiH5PHoenL48lb5mqXT
	NJJ/N4Cnfq5VWIAmNtxsjCSe5SqlP2klo+DFVU1aPcj6OlPPNZsI/yPGbPf8frbR0mXNQw1U7au
	K8Tkx
X-Google-Smtp-Source: AGHT+IGG8m04vZTIjxssS5OJuicVpbIoXFqTeWTWJ2geJNryy0EwBrLIG9dwCeF2vAI7dlNrM6w9tg==
X-Received: by 2002:a05:600c:a08d:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-45201373d52mr151874655e9.6.1749560401962;
        Tue, 10 Jun 2025 06:00:01 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:00:01 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev,
	bpf@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 5/7] netlink: specs: fix up indentation errors
Date: Tue, 10 Jun 2025 13:59:42 +0100
Message-ID: <20250610125944.85265-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up all indentation related errors reported by yamllint in the
netlink specs, e.g.

    error    wrong indentation: expected 6 but found 5  (indentation)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/conntrack.yaml |  36 ++---
 Documentation/netlink/specs/devlink.yaml   |   8 +-
 Documentation/netlink/specs/ethtool.yaml   |  54 ++++----
 Documentation/netlink/specs/mptcp_pm.yaml  | 150 ++++++++++-----------
 Documentation/netlink/specs/netdev.yaml    |   2 +-
 5 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index e48add669b6d..c6832633ab7b 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -195,17 +195,17 @@ attribute-sets:
   -
     name: tuple-attrs
     attributes:
-    -
+      -
         name: tuple-ip
         type: nest
         nested-attributes: tuple-ip-attrs
         doc: conntrack l3 information
-    -
+      -
         name: tuple-proto
         type: nest
         nested-attributes: tuple-proto-attrs
         doc: conntrack l4 information
-    -
+      -
         name: tuple-zone
         type: u16
         byte-order: big-endian
@@ -213,74 +213,74 @@ attribute-sets:
   -
     name: protoinfo-tcp-attrs
     attributes:
-    -
+      -
         name: tcp-state
         type: u8
         enum: nf-ct-tcp-state
         doc: tcp connection state
-    -
+      -
         name: tcp-wscale-original
         type: u8
         doc: window scaling factor in original direction
-    -
+      -
         name: tcp-wscale-reply
         type: u8
         doc: window scaling factor in reply direction
-    -
+      -
         name: tcp-flags-original
         type: binary
         struct: nf-ct-tcp-flags-mask
-    -
+      -
         name: tcp-flags-reply
         type: binary
         struct: nf-ct-tcp-flags-mask
   -
     name: protoinfo-dccp-attrs
     attributes:
-    -
+      -
         name: dccp-state
         type: u8
         doc: dccp connection state
-    -
+      -
         name: dccp-role
         type: u8
-    -
+      -
         name: dccp-handshake-seq
         type: u64
         byte-order: big-endian
-    -
+      -
         name: dccp-pad
         type: pad
   -
     name: protoinfo-sctp-attrs
     attributes:
-    -
+      -
         name: sctp-state
         type: u8
         doc: sctp connection state
         enum: nf-ct-sctp-state
-    -
+      -
         name: vtag-original
         type: u32
         byte-order: big-endian
-    -
+      -
         name: vtag-reply
         type: u32
         byte-order: big-endian
   -
     name: protoinfo-attrs
     attributes:
-    -
+      -
         name: protoinfo-tcp
         type: nest
         nested-attributes: protoinfo-tcp-attrs
         doc: conntrack tcp state information
-    -
+      -
         name: protoinfo-dccp
         type: nest
         nested-attributes: protoinfo-dccp-attrs
         doc: conntrack dccp state information
-    -
+      -
         name: protoinfo-sctp
         type: nest
         nested-attributes: protoinfo-sctp-attrs
diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 939e7e12fe30..6f5348f3d08f 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -812,14 +812,14 @@ attribute-sets:
         name: rate-parent-node-name
         type: string
       -
-         name: region-max-snapshots
-         type: u32
+        name: region-max-snapshots
+        type: u32
       -
         name: linecard-index
         type: u32
       -
-         name: linecard-state
-         type: u8
+        name: linecard-state
+        type: u8
       -
         name: linecard-type
         type: string
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0b6a1db71ef5..35b1cb4834a4 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -60,33 +60,33 @@ definitions:
     name-prefix: ethtool-c33-pse-ext-state-
     header: linux/ethtool.h
     entries:
-        -
-          name: none
-          doc: none
-        -
-          name: error-condition
-          doc: Group of error_condition states
-        -
-          name: mr-mps-valid
-          doc: Group of mr_mps_valid states
-        -
-          name: mr-pse-enable
-          doc: Group of mr_pse_enable states
-        -
-          name: option-detect-ted
-          doc: Group of option_detect_ted states
-        -
-          name: option-vport-lim
-          doc: Group of option_vport_lim states
-        -
-          name: ovld-detected
-          doc: Group of ovld_detected states
-        -
-          name: power-not-available
-          doc: Group of power_not_available states
-        -
-          name: short-detected
-          doc: Group of short_detected states
+      -
+        name: none
+        doc: none
+      -
+        name: error-condition
+        doc: Group of error_condition states
+      -
+        name: mr-mps-valid
+        doc: Group of mr_mps_valid states
+      -
+        name: mr-pse-enable
+        doc: Group of mr_pse_enable states
+      -
+        name: option-detect-ted
+        doc: Group of option_detect_ted states
+      -
+        name: option-vport-lim
+        doc: Group of option_vport_lim states
+      -
+        name: ovld-detected
+        doc: Group of ovld_detected states
+      -
+        name: power-not-available
+        doc: Group of power_not_available states
+      -
+        name: short-detected
+        doc: Group of short_detected states
   -
     name: phy-upstream-type
     enum-name: phy-upstream
diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 1d47ad86d619..84ddf9053f2e 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -17,72 +17,72 @@ definitions:
     enum-name: mptcp-event-type
     name-prefix: mptcp-event-
     entries:
-     -
-      name: unspec
-      doc: unused event
-     -
-      name: created
-      doc: >-
-        A new MPTCP connection has been created. It is the good time to
-        allocate memory and send ADD_ADDR if needed. Depending on the
-        traffic-patterns it can take a long time until the
-        MPTCP_EVENT_ESTABLISHED is sent.
-        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, server-side.
-     -
-      name: established
-      doc: >-
-        A MPTCP connection is established (can start new subflows).
-        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, server-side.
-     -
-      name: closed
-      doc: >-
-        A MPTCP connection has stopped.
-        Attribute: token.
-     -
-      name: announced
-      value: 6
-      doc: >-
-        A new address has been announced by the peer.
-        Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
-     -
-      name: removed
-      doc: >-
-        An address has been lost by the peer.
-        Attributes: token, rem_id.
-     -
-      name: sub-established
-      value: 10
-      doc: >-
-        A new subflow has been established. 'error' should not be set.
-        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
-     -
-      name: sub-closed
-      doc: >-
-        A subflow has been closed. An error (copy of sk_err) could be set if an
-        error has been detected for this subflow.
-        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
-     -
-      name: sub-priority
-      value: 13
-      doc: >-
-        The priority of a subflow has changed. 'error' should not be set.
-        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
-     -
-      name: listener-created
-      value: 15
-      doc: >-
-        A new PM listener is created.
-        Attributes: family, sport, saddr4 | saddr6.
-     -
-      name: listener-closed
-      doc: >-
-        A PM listener is closed.
-        Attributes: family, sport, saddr4 | saddr6.
+      -
+        name: unspec
+        doc: unused event
+      -
+        name: created
+        doc: >-
+          A new MPTCP connection has been created. It is the good time to
+          allocate memory and send ADD_ADDR if needed. Depending on the
+          traffic-patterns it can take a long time until the
+          MPTCP_EVENT_ESTABLISHED is sent.
+          Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+          dport, server-side.
+      -
+        name: established
+        doc: >-
+          A MPTCP connection is established (can start new subflows).
+          Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+          dport, server-side.
+      -
+        name: closed
+        doc: >-
+          A MPTCP connection has stopped.
+          Attribute: token.
+      -
+        name: announced
+        value: 6
+        doc: >-
+          A new address has been announced by the peer.
+          Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
+      -
+        name: removed
+        doc: >-
+          An address has been lost by the peer.
+          Attributes: token, rem_id.
+      -
+        name: sub-established
+        value: 10
+        doc: >-
+          A new subflow has been established. 'error' should not be set.
+          Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+          daddr6, sport, dport, backup, if_idx [, error].
+      -
+        name: sub-closed
+        doc: >-
+          A subflow has been closed. An error (copy of sk_err) could be set if an
+          error has been detected for this subflow.
+          Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+          daddr6, sport, dport, backup, if_idx [, error].
+      -
+        name: sub-priority
+        value: 13
+        doc: >-
+          The priority of a subflow has changed. 'error' should not be set.
+          Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+          daddr6, sport, dport, backup, if_idx [, error].
+      -
+        name: listener-created
+        value: 15
+        doc: >-
+          A new PM listener is created.
+          Attributes: family, sport, saddr4 | saddr6.
+      -
+        name: listener-closed
+        doc: >-
+          A PM listener is closed.
+          Attributes: family, sport, saddr4 | saddr6.
 
 attribute-sets:
   -
@@ -298,15 +298,15 @@ operations:
       do: &get-addr-attrs
         request:
           attributes:
-           - addr
-           - token
+            - addr
+            - token
         reply:
           attributes:
-           - addr
+            - addr
       dump:
         reply:
-         attributes:
-           - addr
+          attributes:
+            - addr
     -
       name: flush-addrs
       doc: Flush addresses
@@ -332,7 +332,7 @@ operations:
       dont-validate: [strict]
       do: &mptcp-get-limits
         request:
-           attributes:
+          attributes:
             - rcv-add-addrs
             - subflows
         reply:
@@ -370,9 +370,9 @@ operations:
       flags: [uns-admin-perm]
       do:
         request:
-         attributes:
-           - token
-           - loc-id
+          attributes:
+            - token
+            - loc-id
     -
       name: subflow-create
       doc: Create subflow
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 0422a73776d4..6819c3636841 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -31,7 +31,7 @@ definitions:
       -
         name: hw-offload
         doc:
-         This feature informs if netdev supports XDP hw offloading.
+          This feature informs if netdev supports XDP hw offloading.
       -
         name: rx-sg
         doc:
-- 
2.49.0


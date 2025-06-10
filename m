Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7E2D3218;
	Tue, 10 Jun 2025 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560404; cv=none; b=ZqHLwTFCc9TFDkK3BOKhZGGaAz1ZnTV0X5ZEuWA/WUaGl4JlCAfj62MO81J1IiFkBpFJic4aWUsjcUY4c2VhKydyg+R/tC21PW1/MJNobDXMGsJzMv7QJbOCd+MqEMxfIOjl7vCzh+nlJeiMmIrK2GgRr5W3dUJLnqnatbXM+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560404; c=relaxed/simple;
	bh=5ggtLBn/fC8LW33kGzWZYhNT8p0kOpSONQQefdYNAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o17Ew3ate2eQXBRS6JAaBS4Jjv4R5AqsFradA0i5tTttVhpE496FpXbNyw2jDREajyQVzmHImLovv+NthsSPteDThW8iGp4W1lpxE9rKeRC/dD+Qu7NhBqC/NhNNr9DekvEGdS7aPYOuuQwAc1X6qV/4+5QzzbtkNx8EGqNZk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhlKIUri; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhlKIUri"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4530921461aso20742145e9.0;
        Tue, 10 Jun 2025 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560400; x=1750165200; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olF6cbbV/GQ1QDh802N8RqxyfjAusQs/jMapQ1m2ci8=;
        b=AhlKIUriO+7cafzMkwmJmUp47Rwj5piFl9L7nIdd8b222NjouAxp557JSjQSy6kT1T
         luMxbfRVjVLs/PotsTN8tVoDqqDAZzoYppErkvv5TKjY4Vb6pIoM1ocRmwdDOv+9znKO
         ZiB5vUgyfl7DD0uSaexEL8xdUkkOfkYMDuvSQLo+wv5mBJrTO5cSIHGxE1bALvJ/20BK
         GhS4oEekG8x4MzWYm4H+AU/WZ4CAaIVGQdeGyfCi3whx4GMtEN/+kBrdkWQR4Lb4C5SA
         R+LykHCUKiAy4AaGJFdE5elZsFTa3dOg1QlM6PKSa0zdNTLQiJbWUhqpyQPff+1MKunn
         MK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560400; x=1750165200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olF6cbbV/GQ1QDh802N8RqxyfjAusQs/jMapQ1m2ci8=;
        b=RXio58l4cxX4hauKtYlle7NATxY90Zxg3vVNtym4E3+ov1ZzlZ8/cJStjvZoMsW3Lg
         ourleJvdlEUtO4IRVSkUFk0cdxkzrWVph6/qqeCpQpT0+VFu2VtR2WQRejkM+NOd6ISe
         122X4tuHQJuYF82ECZl39t1GGvUoX+mZlLEIumgf9AuqlO5SLCEAFVcKYheF6bT7U57P
         31Tl8aAqrwt3ln9wkL+E7+O5vddnMQ2YmdoJJSpi+lXJx6u1qIwAB7iMscvPyK8ynzW8
         M4/8apulySn30CxrT0a4ViFktRKaRdjmNpoAvB3h5C3rnECfO57CtDEIUpPEsR4TMJo2
         kD0g==
X-Forwarded-Encrypted: i=1; AJvYcCUyCMEScLFqL1CqqDNzn9HygYFlcKg/gGEdF7c+aSOfVOIORVi/LX8umQmDnWiVon+bJg6CKy8=@lists.linux.dev, AJvYcCWo86wO/qjrD6AokRWD5ge146+1FHCP0Lm2xr+Y/esAccNCwZloOEaNTiJj1s+X5/CWYudlfgKXm7UlJh3fEpK6CcwPng==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwCKvFQYn4J9Ie+p91MeLzlDTZwZwd/+WSf77VcRrzZt8Aa6it
	wm/mauoepc2XrLIACYFz9fmQ4JlmGRVLTqANBSViLIuT7m6OIqT7l4Jf
X-Gm-Gg: ASbGncvf+PQ9oJFOBQuBFXzOJpCEgofyrTJ4UKo0yvvCslLKkOy4x47OBX0IcpRfcs7
	FomqdQO8fFnhFYkki9USltLj5pSUIxVNTH+Mv2QvB16H18AlzyDuNrATMpx3AKy3PBM2n3tTPQV
	s18/1lsjbjNCB4Dtp6tWbUIM0NBHM9THM61I0br+mNh9T6Cpn7mvrvah5cRnwPdDNbrFnaTFsHZ
	1k6Im3bzBZlQ6ps/7F7Auu4uSJ2XbeL11jFpB8C1xbC2r22VppBZcjOot8VHNb/hc2bCh1mbFWx
	LPOSny4FnLGPxHcg+Ely4vTVy4QAWDeR8g6gEwpnD2c0yb9IhPI3AUC6jNlKg48hs70ZW0NTPRY
	YhUOdGlEAzxREsgk=
X-Google-Smtp-Source: AGHT+IEYe4gl3jVV9ikHsBcdnghab5YipQFrjLU+VUYP1mBkpixyw9eo3bALINf+QBYGpW7/OV/OXA==
X-Received: by 2002:a05:600c:1e15:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-452014b64f8mr140967125e9.25.1749560399832;
        Tue, 10 Jun 2025 05:59:59 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:59:59 -0700 (PDT)
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
Subject: [PATCH net-next v1 3/7] netlink: specs: fix up spaces before comments
Date: Tue, 10 Jun 2025 13:59:40 +0100
Message-ID: <20250610125944.85265-4-donald.hunter@gmail.com>
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

Clean up all comments warnings reported by yamllint in the netlink specs:

    warning  too few spaces before comment: expected 2  (comments)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/ethtool.yaml  |   2 +-
 Documentation/netlink/specs/netdev.yaml   |   4 +-
 Documentation/netlink/specs/nl80211.yaml  | 100 +++++++++++-----------
 Documentation/netlink/specs/rt-route.yaml |   8 +-
 Documentation/netlink/specs/tc.yaml       |  18 ++--
 5 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index dc7f8e657967..0b6a1db71ef5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -19,7 +19,7 @@ definitions:
     name: stringset
     type: enum
     entries: []
-    header: linux/ethtool.h # skip rendering, no actual definition
+    header: linux/ethtool.h  # skip rendering, no actual definition
   -
     name: header-flags
     type: flags
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 0ca6c28321c7..0422a73776d4 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -205,7 +205,7 @@ attribute-sets:
       -
         name: alloc-fast
         type: uint
-        value: 8 # reserve some attr ids in case we need more metadata later
+        value: 8  # reserve some attr ids in case we need more metadata later
       -
         name: alloc-slow
         type: uint
@@ -367,7 +367,7 @@ attribute-sets:
           For drivers supporting XDP, XDP is considered the first layer
           of the stack, so packets consumed by XDP are still counted here.
         type: uint
-        value: 8 # reserve some attr ids in case we need more metadata later
+        value: 8  # reserve some attr ids in case we need more metadata later
       -
         name: rx-bytes
         doc: Successfully received bytes, see `rx-packets`.
diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 8d380670ea6a..ba0601474eff 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -285,7 +285,7 @@ attribute-sets:
         type: u16
       -
         name: sta-flags
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: sta-listen-interval
         type: u16
@@ -297,14 +297,14 @@ attribute-sets:
         type: u32
       -
         name: sta-info
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: wiphy-bands
         type: nest
         nested-attributes: wiphy-bands
       -
         name: mntr-flags
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: mesh-id
         type: binary
@@ -317,7 +317,7 @@ attribute-sets:
         display-hint: mac
       -
         name: mpath-info
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: bss-cts-prot
         type: u8
@@ -339,16 +339,16 @@ attribute-sets:
         type: binary
       -
         name: reg-rules
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: mesh-config
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: bss-basic-rates
         type: binary
       -
         name: wiphy-txq-params
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: wiphy-freq
         type: u32
@@ -370,16 +370,16 @@ attribute-sets:
         type: u8
       -
         name: scan-frequencies
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: scan-ssids
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: generation
         type: u32
       -
         name: bss
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: reg-initiator
         type: u8
@@ -416,10 +416,10 @@ attribute-sets:
         display-hint: hex
       -
         name: freq-before
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: freq-after
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: freq-fixed
         type: flag
@@ -483,10 +483,10 @@ attribute-sets:
         type: binary
       -
         name: key
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: keys
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: pid
         type: u32
@@ -495,7 +495,7 @@ attribute-sets:
         type: u8
       -
         name: survey-info
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: pmkid
         type: binary
@@ -513,7 +513,7 @@ attribute-sets:
         type: u8
       -
         name: tx-rates
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: frame-match
         type: binary
@@ -525,7 +525,7 @@ attribute-sets:
         type: u32
       -
         name: cqm
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: local-state-change
         type: flag
@@ -575,13 +575,13 @@ attribute-sets:
         type: u16
       -
         name: key-default-types
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: max-remain-on-channel-duration
         type: u32
       -
         name: mesh-setup
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: wiphy-antenna-avail-tx
         type: u32
@@ -596,7 +596,7 @@ attribute-sets:
         type: u8
       -
         name: wowlan-triggers
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: wowlan-triggers-supported
         type: nest
@@ -615,7 +615,7 @@ attribute-sets:
         nested-attributes: supported-iftypes
       -
         name: rekey-data
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: max-num-sched-scan-ssids
         type: u8
@@ -624,7 +624,7 @@ attribute-sets:
         type: u16
       -
         name: scan-supp-rates
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: hidden-ssid
         type: u32
@@ -636,7 +636,7 @@ attribute-sets:
         type: binary
       -
         name: sta-wme
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: support-ap-uapsd
         type: flag
@@ -645,13 +645,13 @@ attribute-sets:
         type: flag
       -
         name: sched-scan-match
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: max-match-sets
         type: u8
       -
         name: pmksa-candidate
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: tx-no-cck-rate
         type: flag
@@ -749,7 +749,7 @@ attribute-sets:
         type: u32
       -
         name: mac-addrs
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: mac-acl-max
         type: u32
@@ -798,7 +798,7 @@ attribute-sets:
         type: u16
       -
         name: coalesce-rule
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: ch-switch-count
         type: u32
@@ -807,7 +807,7 @@ attribute-sets:
         type: flag
       -
         name: csa-ies
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: cntdwn-offs-beacon
         type: binary
@@ -929,13 +929,13 @@ attribute-sets:
         type: u32
       -
         name: sched-scan-plans
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: pbss
         type: flag
       -
         name: bss-select
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: sta-support-p2p-ps
         type: u8
@@ -944,7 +944,7 @@ attribute-sets:
         type: binary
       -
         name: iftype-ext-capa
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: mu-mimo-group-data
         type: binary
@@ -975,10 +975,10 @@ attribute-sets:
         type: u32
       -
         name: nan-func
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: nan-match
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: fils-kek
         type: binary
@@ -1067,16 +1067,16 @@ attribute-sets:
         type: binary
       -
         name: ftm-responder
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: ftm-responder-stats
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: timeout
         type: u32
       -
         name: peer-measurements
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: airtime-weight
         type: u16
@@ -1094,7 +1094,7 @@ attribute-sets:
         type: flag
       -
         name: he-obss-pd
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: wiphy-edmg-channels
         type: u8
@@ -1106,13 +1106,13 @@ attribute-sets:
         type: u16
       -
         name: he-bss-color
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: iftype-akm-suites
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: tid-config
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: control-port-no-preauth
         type: flag
@@ -1133,16 +1133,16 @@ attribute-sets:
         type: u32
       -
         name: scan-freq-khz
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: he-6ghz-capability
         type: binary
       -
         name: fils-discovery
-        type: binary # TOOD: nest
+        type: binary  # TOOD: nest
       -
         name: unsol-bcast-probe-resp
-        type: binary # TOOD: nest
+        type: binary  # TOOD: nest
       -
         name: s1g-capability
         type: binary
@@ -1173,13 +1173,13 @@ attribute-sets:
         type: u8
       -
         name: color-change-elems
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: mbssid-config
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: mbssid-elems
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: radar-background
         type: flag
@@ -1194,7 +1194,7 @@ attribute-sets:
         type: flag
       -
         name: mlo-links
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: mlo-link-id
         type: u8
@@ -1234,7 +1234,7 @@ attribute-sets:
         type: flag
       -
         name: ema-rnr-elems
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: mlo-link-disabled
         type: flag
@@ -1252,10 +1252,10 @@ attribute-sets:
         type: flag
       -
         name: wiphy-radios
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: wiphy-interface-combinations
-        type: binary # TODO: nest
+        type: binary  # TODO: nest
       -
         name: vif-radio-mask
         type: u32
diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 9c514c543b1f..5b514ddeff1d 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -117,7 +117,7 @@ attribute-sets:
         name: multipath
         type: binary
       -
-        name: protoinfo # not used
+        name: protoinfo  # not used
         type: binary
       -
         name: flow
@@ -127,10 +127,10 @@ attribute-sets:
         type: binary
         struct: rta-cacheinfo
       -
-        name: session # not used
+        name: session  # not used
         type: binary
       -
-        name: mp-algo # not used
+        name: mp-algo  # not used
         type: binary
       -
         name: table
@@ -155,7 +155,7 @@ attribute-sets:
         type: u16
       -
         name: encap
-        type: binary # tunnel specific nest
+        type: binary  # tunnel specific nest
       -
         name: expires
         type: u32
diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 52f62ab11136..dfcb9cc3ea0a 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1161,7 +1161,7 @@ definitions:
       -
         name: keys
         type: binary
-        struct: tc-u32-key # TODO: array
+        struct: tc-u32-key  # TODO: array
   -
     name: tc-u32-pcnt
     type: struct
@@ -1174,7 +1174,7 @@ definitions:
         type: u64
       -
         name: kcnts
-        type: u64 # TODO: array
+        type: u64  # TODO: array
   -
     name: tcf-t
     type: struct
@@ -1336,7 +1336,7 @@ definitions:
       -
         name: keys
         type: binary
-        struct: tc-pedit-key # TODO: array
+        struct: tc-pedit-key  # TODO: array
   -
     name: tc-pedit-key
     type: struct
@@ -2885,7 +2885,7 @@ attribute-sets:
     attributes:
       -
         name: parms
-        type: binary # array of struct: tc-gred-qopt
+        type: binary  # array of struct: tc-gred-qopt
       -
         name: stab
         type: binary
@@ -3335,10 +3335,10 @@ attribute-sets:
         struct: tc-police
       -
         name: rate
-        type: binary # TODO
+        type: binary  # TODO
       -
         name: peakrate
-        type: binary # TODO
+        type: binary  # TODO
       -
         name: avrate
         type: u32
@@ -3698,7 +3698,7 @@ sub-messages:
         value: choke
         attribute-set: choke-attrs
       -
-        value: clsact # no content
+        value: clsact  # no content
       -
         value: codel
         attribute-set: codel-attrs
@@ -3742,12 +3742,12 @@ sub-messages:
         value: htb
         attribute-set: htb-attrs
       -
-        value: ingress # no content
+        value: ingress  # no content
       -
         value: matchall
         attribute-set: matchall-attrs
       -
-        value: mq # no content
+        value: mq  # no content
       -
         value: mqprio
         fixed-header: tc-mqprio-qopt
-- 
2.49.0


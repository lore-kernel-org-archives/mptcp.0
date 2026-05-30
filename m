Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DAA337B97
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780127446; cv=none; b=ArmD0iwZgc9f2oy09f4l1+kSDNUN7w0jZZ0BOXHi3wzWHH/gIX5LzmNTIoIf89zFjJ5RZYgxjYLBHLNcYkKejfITcrZOLhpd1yjKlJCNyXqtl+dV5DoWYMTGzEc88rrdVrKi4dni1cNT5/0F+Zd3/zmcEkKNNifb/RQ6HCLTAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780127446; c=relaxed/simple;
	bh=3zP4uKWI0L1Cit//nGEjZLj+VW87U2tszFrRDNo7cS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWYQrnvKk40eXCz/NLL/V53gcfOpzQicZOkoKf4zvAax0Ce/Jo7xHbRn00aiMfGHMekJ4lBGEg2kBmgV1SIYITRGcUJQTINTnqq3UiSYwPNn1EliJRsoRz8XztjKzx6xy+Xptaase0bvqrxfTyqjdQSLsXE++TLg4djJQvFO+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj6mxK2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj6mxK2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5FB1F00893;
	Sat, 30 May 2026 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780127445;
	bh=6eLa5XMFd9c3V5WAaxR7+H8n3+RT+gYHK8RF38MGCwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qj6mxK2G1wUgWgkdikWPnggT+I/Tvq0XDUQvFGYn8LFlBfeNeF2gYzowQWvY1GxPN
	 IFYXMbzjHS20IiFCf7A9+AUYC+F4f4WfkGoc5G4biYSGg6tyxRfg+Z1CLVqxu/yZDf
	 aUCSuyLmAWRllteyUThD1V0wIvoG2bg9PyMo0XFpkKCxxRswXFbcM3jusChtKRlIk7
	 36hMGtPQhlJnf/O63jdp6Jil3AVaTuYAcfWdsuVYqHM7uQPGD07vhrFVpf3EhOr0Qe
	 drbiLKZQEAJtsKK04qhRdnJizp+8gQ0TJ+YajjZPr6tqXelzv349g6QatdIOJhStjq
	 v/HGbTG/sUUxQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/5] tls: init mixed SW/TOE proto to prevent NULL call
Date: Sat, 30 May 2026 15:50:08 +0800
Message-ID: <e496f6d7ce25fd1f161e33093d7d07f1e6bca488.1780127277.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780127277.git.tanggeliang@kylinos.cn>
References: <cover.1780127277.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When a TOE socket falls back to software offload, update_sk_prot() accesses
prot->prots[TLS_SW][TLS_HW_RECORD] and proto_ops[TLS_SW][TLS_HW_RECORD].
These entries were never initialized, causing NULL function pointers and
kernel panic. Add the missing entries for [TLS_SW][TLS_HW_RECORD] and
[TLS_HW_RECORD][TLS_SW] in both build_protos() and build_proto_ops().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index c7ad212c97a0..3966cda068f9 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -965,6 +965,9 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 #ifdef CONFIG_TLS_TOE
 	ops[TLS_HW_RECORD][TLS_HW_RECORD] = *base;
+
+	ops[TLS_SW][TLS_HW_RECORD] = *base;
+	ops[TLS_HW_RECORD][TLS_SW] = *base;
 #endif
 }
 
@@ -1041,6 +1044,9 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_HW_RECORD][TLS_HW_RECORD] = *base;
 	prot[TLS_HW_RECORD][TLS_HW_RECORD].hash		= tls_toe_hash;
 	prot[TLS_HW_RECORD][TLS_HW_RECORD].unhash	= tls_toe_unhash;
+
+	prot[TLS_SW][TLS_HW_RECORD] = prot[TLS_SW][TLS_SW];
+	prot[TLS_HW_RECORD][TLS_SW] = prot[TLS_BASE][TLS_SW];
 #endif
 }
 
-- 
2.53.0


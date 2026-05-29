Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7422E7384
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053259; cv=none; b=sbXo9ULKHyxSEgT2X9z9WeAft9boS8zlYtC4+L17F/GYx5ok70Fvw+mNFhHuWjDpFOEHV/BoAJwUAmtgDVlHzdDWEHFZ1fp8qZJ0zSwoPR7czHs+flPTRuPbl0tgW5U2n1xidwoBLnYWO1erXgFzgLf+3xkIL3ZPSt/9wrnxfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053259; c=relaxed/simple;
	bh=+9gjmTdNU7JtR8m5IpxhfOn7BhGUqIrQcGhQbnyKidw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwgrfRDynU2W2l+i/hoxBC5FsYFiDFSz3Mj4T/kls+uwFvmLXU7d4GEjX7HCrRx9J92iUQ8P1X8MzMHbQhH3Ywuj12Zc1Hn10hKxIn86GsX4eJdbP8YouyoSHlZ9pGQwNwMRmWrli1WqPQWsM96NbxOA1d2N8WE8Xqs1z6rH/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtAD3anq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtAD3anq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA141F00893;
	Fri, 29 May 2026 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053258;
	bh=8MkRwn6UnTQGwiPU+AIFfHPCH3XrZXZwjUF3PQrmdV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CtAD3anqVGUJJVcjcdwzBnm0cB5GSTDNX2Olp7SmeD8yR2RbZRuOCBJH8lwe/V26o
	 iCuDQR56c7MXT+UlbvI7d/KcORaWa3/6gKzXWhgycFkFXsJtTGJagHxzHFKS9X2i8Z
	 kYImfl2IbSNFm4xd6L85or8FTcSH045oiGue3Yd+zO5SOxsbixiULPfgHSw/Qlpbyw
	 PAYm6BopcmR/hWTz3yIRSUgQ8zqFCQKFtjAGUmRJj4snDHVzOgBL5iaWhQN0BLgTa+
	 vjmn4LNKwj/WRhAAa0Hrxz/0XNpR0ZkUMTSigAxmzqv9HVp8XuQxP6jqcn55+fdY9M
	 d7crqESvG5CJw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v22 02/20] tls: init mixed SW/TOE proto to prevent NULL call
Date: Fri, 29 May 2026 19:13:44 +0800
Message-ID: <4b3d22717387a6a8efb1bd948f4a6e6f8648eff2.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
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
 net/tls/tls_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 51ae8925d891..6d1272dc3c34 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -965,6 +965,9 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 #ifdef CONFIG_TLS_TOE
 	ops[TLS_HW_RECORD][TLS_HW_RECORD] = *base;
+
+	ops[TLS_SW][TLS_HW_RECORD] = ops[TLS_SW][TLS_SW];
+	ops[TLS_HW_RECORD][TLS_SW] = ops[TLS_BASE][TLS_SW];
 #endif
 }
 
@@ -1041,6 +1044,11 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 	prot[TLS_HW_RECORD][TLS_HW_RECORD] = *base;
 	prot[TLS_HW_RECORD][TLS_HW_RECORD].hash		= tls_toe_hash;
 	prot[TLS_HW_RECORD][TLS_HW_RECORD].unhash	= tls_toe_unhash;
+
+	prot[TLS_SW][TLS_HW_RECORD] = prot[TLS_SW][TLS_SW];
+	prot[TLS_HW_RECORD][TLS_SW] = prot[TLS_BASE][TLS_SW];
+	prot[TLS_SW][TLS_HW_RECORD].hash = NULL;
+	prot[TLS_HW_RECORD][TLS_SW].unhash = NULL;
 #endif
 }
 
-- 
2.53.0


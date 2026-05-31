Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDB38F623
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239605; cv=none; b=G5j4MzvoJ1tlrJfV38FfAOHZTfDkSBmaMFrWf/Whst2TDwJiLvfpbrC4vxfXpn/z3Y24Pq75IAwMy9u3RtAgx+4w4pyLzkaHQXmsDdqdFDdKqjDXtFxxNsXQ7xnmS9/QYq0LeYirbbtFidFWf5B3+2uX5tQocrt+Ehm62BIuJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239605; c=relaxed/simple;
	bh=HDrK1qDMbcBPHnB/F5xX4si1f7gfI6iTgCS94VY6xjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kulms3kals5nehGPiQcdEtUZxxVdn/Qb/hPC9Mf5YuSoxLfdhBWI/Jv4PfpAoL3jruX4IO7RDnGqk6EGzbbY8xGr8IxZbQCBu3bQCtAQVLKQiGY3VgEpqsRX8aZUIGwqIFOt/EAQYCoESgh0yOI7Me4ti7aBNE5qv1IAGDdtobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qF3UDWp/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF3UDWp/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45efa80e0afso735951f8f.2
        for <mptcp@lists.linux.dev>; Sun, 31 May 2026 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780239600; x=1780844400; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0WMAu7ksHy8NjaFaPp0ygI7JxHIIKVNl9Xb2HItZvE=;
        b=qF3UDWp/vewDX87pKKP5dJRdxw2HQXruahGF1M127ejyOCHGXd2zYbnOxjvHNt1i4P
         sWjYyDxkVfI0Az3BI6f6mbIibY0K71RIW1IE/5KDslE9bllt5wwjoRA4qgBwVoDOw4nb
         DONSCP4aEdQAdFY5hfjN+tJRY9Bk0y3tWf3rarYf44pEhzsLcSqX6qtAoXw+mHqwMy/R
         9zpp4zHiDNVd7DQAYBXgysmXmfbP30VuNvouLU+uYHJvH/PhAZ12P9c8KiA39Ck6NXNc
         dX1fsnyTKn5NDoYnnwYQWA9iuplkvDwHZcFGby/G7bVJ7Gw2zAfAmkcc/ER5URAOv7UC
         COcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780239600; x=1780844400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0WMAu7ksHy8NjaFaPp0ygI7JxHIIKVNl9Xb2HItZvE=;
        b=Gc1mhATSsqfvnQaKCbuov383MOjcfzpMQPE5FmXwdGxeSoFMA+Q5jKN2pUOohpOYiP
         LgBwQgY7a8vXzGa2d0MD/ifVx8ub25FOHR46tFFKumC9NMop6FFZoTSsPhBxVoG0dY3o
         iUXLUBsuwYXR1+rJ1b/RnTvYAZahamPhL0IbgnXeEwkokMfzadjt4qXpmX5S9SJIhsr0
         Sv72wmJ1WbhtUguxNyTLmwHQ69Mxs8nXjbbgfOhw8NsXWELnSpeKsdNc2BNbssj4/Kwg
         59Fpzm2/R1UI5IA02neQX9WGzDtqkadbuLwRYrlv3dcNWEvqCwVWO0pwxE9hwu/3Vw8g
         8F3w==
X-Gm-Message-State: AOJu0Ywv3zk7GAdMQph4psrF0yD4SgnEs5IPrezzrEQzZeLsASZvGUfV
	nTMDMp02kx7mZRVXnUh8vpljr5NUtGwXOTIzh1MG9IIH/Cv2mDtlrd9HPXuuDA==
X-Gm-Gg: Acq92OEg69pNIFNXOZJ6bPEat2Gz3majcMVs1VDaF2+poocUrLVFEXsBAXueC+U1O7D
	ZurAmdntpoVlenoI31XICQaAo8E4fsBBGigimuLtMgIWLtgpgWHAS2ajKEX/IF2WhnqQPoc/yH4
	vcbs3J9FowObnFtNgbfWs8rbuutNFl+jyrb2xiEbHPS990npLcVJ1SWAfeSStx65LnK+ppzTRbA
	Wq3baHrawZSkDPymk0eYBju+dQf/5Lg3IqNhZJN5RMX2kIRfzHkTEmuOjQfczpbHHqMLG8OmaIo
	OO4Qy2IVe7NUliSc0NEV9yiiH4SC1f6yXxsB41TiCPxtnBve+A4mjnw1sUSBsH+XZ2bcP3jSUY7
	U1RKViJWQ+qBkGbDopiYblEWOPcJpWOZO40ylRc6SwExk/0RKu2g5LeA/vFHac2Ziu2p1tC5Ze/
	EtosBdap3LCaP2+UyQyPjdReBK7JGrfgxH3dFbm0LgUTcOS0WGCIFXwbYUEbU38N3/ukBO4H1sR
	2aGEkVAMBEiW/VbY1afCg==
X-Received: by 2002:adf:f2cf:0:b0:43b:5097:6f62 with SMTP id ffacd0b85a97d-45ef6b99e1amr10028763f8f.36.1780239599870;
        Sun, 31 May 2026 07:59:59 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm19133545f8f.34.2026.05.31.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 07:59:59 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v11 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Sun, 31 May 2026 15:59:50 +0100
Message-ID: <20260531145955.322337-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531145955.322337-1-devnexen@gmail.com>
References: <20260531145955.322337-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce MPTCP_INET_FLAGS_MASK and replace the per-flag
inet_assign_bit() calls in sync_socket_options() with a loop driven
by the mask that calls assign_bit() per set bit, preserving the
per-bit atomicity of the original. Further flags propagated by MPTCP
can be added by extending the mask rather than touching the call
site.

No functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..7be9a46cbdbe 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -16,6 +16,10 @@
 
 #define MIN_INFO_OPTLEN_SIZE		16
 #define MIN_FULL_INFO_OPTLEN_SIZE	40
+#define MPTCP_INET_FLAGS_MASK \
+	(BIT(INET_FLAGS_TRANSPARENT) | \
+	 BIT(INET_FLAGS_FREEBIND) | \
+	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT))
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -1551,6 +1555,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long mask = MPTCP_INET_FLAGS_MASK;
+	unsigned long src;
+	int b;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1597,9 +1604,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
-	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
-	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
-	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	src = READ_ONCE(inet_sk(sk)->inet_flags);
+
+	for_each_set_bit(b, &mask, BITS_PER_LONG)
+		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
+
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 }
 
-- 
2.53.0


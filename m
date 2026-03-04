Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0353A8759
	for <mptcp@lists.linux.dev>; Wed,  4 Mar 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622930; cv=none; b=XRXoMF3qO2BnCkBHbKDizTNVCwfV7GUPZ97hd6xc1BRGCwngInoDMOUP7uFb7BI5cBWtHvxQ3TPS3Db2WSvlw54/ddng8itKPmwkqfKp/WFGXuJKWUJS1vM5o4VbXb7ji3trnHW9P2NzfFYYrhWDmnHVBiYQpw6kG2FQOa7j1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622930; c=relaxed/simple;
	bh=Fm9MITMvzrN1bUK+Cme/hMncR+Mx97/eQMgmDiY3OnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnYeLOvsxrWD932BfcKnpCdd8HP+TRNq/jnEjEz/d9e/YqZdawBsQCnO36GpSWFsNV3nIpodtOuo7KzIeQ/FIltsXiq980z1f+oW9ddsPDq1zjFncnzvfNyL6ToiPOFKEGnQaH57UR79EFxP+8sQyvFKj8Y7TNDMLwWLH3CevUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhXh6Yit; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhXh6Yit"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70ece855e2so2756054a12.0
        for <mptcp@lists.linux.dev>; Wed, 04 Mar 2026 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772622928; x=1773227728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+N0PSv0aNw5FsNqlrwbndBAJxWxb/es8/Rr+uh7lYSE=;
        b=KhXh6Yitj8c/5E3N0fsP4vsna8qh6ZFda/ZsrqQLYSA+BHKv7vQ2xC9PFFSl/Z0dNY
         b2cLheHk0coi5slB/JowexVPRRcStEWe6C8x/NFyLOo72UKhh/iAnBLa2IuybbIUO3gF
         NJBNfwyyn51jBhAYXTC6EcC5HC+KyVJXOLt4zm8J6zpdf0FdFilenWfCX6wSpJuemBtQ
         XowmtOvacs0XIrAZiy0jJ2aErE4RX14BL5RRAGDGChLeNRU9zhS353CtbCV0XSl56TEP
         NTt3mDN99EebMC/uQqz/84IpssA0EXoKPoWfhU0G09oLe3FDU6vhbv2ZLRoMUv7ulxTY
         6Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772622928; x=1773227728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N0PSv0aNw5FsNqlrwbndBAJxWxb/es8/Rr+uh7lYSE=;
        b=k3Mra6hxzc5WIXEP6i6qycnVjGdD+P8Rr/pGKzSxtff4HH3Bu7FeJ4kPQg43/RBRex
         UIkz5Px3DgpyfDVas1mTB9F2jckjNkg5ZTqY1LvFsBDhXcPCppH3IgQW8M0czcnVASIR
         +HCOJ2bdgVE28pJuthJqHX678tM0bXN0TbPafelZaPP5JyflRS+AnZrVGYRDGCVtjh1r
         7mu9WfVoJIGbun24CytWgqPhVA67XLLdmbyLZHbJp7DhgbIUXOWOPHqIvK8Hw6hhpaGh
         oIweadvbasvM/Vulrj/LtY1/5lEQolc4xrCc7+I/aRyMianctYmZZsspSbkUvAAFxw5R
         kU1g==
X-Forwarded-Encrypted: i=1; AJvYcCXLJEZ4Rs+wGBbsx+wRTeFyifdz8iqm2bLpd7DhRt77v1ZeQmWXIh9W6rCfIAsYC0mXWinqTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygq/Ldb9qos38/0Zfbm5t6dWHY55XzPAU7jXDEzNdywaPk7yUS
	A6Qc9lOIj7w0X0UQ1qrA6mboEEFrNBDIXgjNmR/n0RQeA/HgVSarT9IJ
X-Gm-Gg: ATEYQzxJWRWQv5zs/nBmh2xVIIF0bUjTZi2es+jq28vLxFhHsJ3aVoPre6g5+y9ofBt
	0ZdWNKJBVAi1l+gd5yeworMC+/dyHLw6AzTw+UgyfLOCqn9WsoE2err/Ci0QFJu6YHhpuWmCQzr
	skFIM3TpCzplWQROhtLoWZEUKH9Po2q/TxOKj6cMccN3XE/rfn/sua/PQOdFOSnGaplz2GG/rpo
	iVPlRnEn1yW+3zLtO0DqHpyPhgSkOWGrdXD86v0lANzICMskujhRkwL7IhG0JcNfMMFiXXmnuZH
	IgOYLPTk2P8CuC4U5JQEpjis4ID15tvcbRIoBK/Bd0Z2ql5XX3ZpuarWHuzH735pQu+z3uojZ8W
	yL6bC3NT6PKstT5yR0pDcHAYw3TX7EvUsPoZL5n8Sxdn4Ojc0jFfO05jTK/XxYwU9se1Ec+WAQ/
	xl4iuiI5RoXrK4jHzCj+flIHa67m5VKDEO34FClEr9ZZFRmZLRbl/fRsGQlclH3DXX+qdf1l+rV
	msoAJP70GgU
X-Received: by 2002:a17:902:ce0a:b0:2ad:b213:feba with SMTP id d9443c01a7336-2ae6adcbc04mr14171985ad.5.1772622928153;
        Wed, 04 Mar 2026 03:15:28 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm127226495ad.44.2026.03.04.03.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:15:27 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Wed,  4 Mar 2026 20:15:17 +0900
Message-Id: <20260304111517.2088694-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use struct_group() to group the three fields in tcp_out_options that are
read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
(mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
with a targeted memset of only that group.

struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
CONFIG_MPTCP=y (typical distro config). Every remaining field is either
assigned before first use by tcp_established_options()/tcp_syn_options(),
or gated behind its OPTION_* flag in tcp_options_write(). This memset
runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
bytes to 4 bytes reduces per-packet overhead on the hot path.

Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=y):

  Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
  After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)

Also add opts->options = 0 at the top of tcp_syn_options(), which
already used |= without a prior clear. tcp_established_options() already
clears opts->options at its top.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
---
 net/ipv4/tcp_output.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118d..63ee037f46e50 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -429,14 +429,19 @@ static void smc_options_write(__be32 *ptr, u16 *options)
 }

 struct tcp_out_options {
+	/* Following group is cleared in __tcp_transmit_skb() */
+	struct_group(cleared,
+		u16 mss;		/* 0 to disable */
+		u8 bpf_opt_len;		/* length of BPF hdr option */
+		u8 num_sack_blocks;	/* number of SACK blocks to include */
+	);
+
+	/* Caution: following fields are not cleared in __tcp_transmit_skb() */
 	u16 options;		/* bit field of OPTION_* */
-	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
-	u8 num_sack_blocks;	/* number of SACK blocks to include */
 	u8 num_accecn_fields:7,	/* number of AccECN fields needed */
 	   use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
 	u8 hash_size;		/* bytes in hash_location */
-	u8 bpf_opt_len;		/* length of BPF hdr option */
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
@@ -965,6 +970,8 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	struct tcp_fastopen_request *fastopen = tp->fastopen_req;
 	bool timestamps;

+	opts->options = 0;
+
 	/* Better than switch (key.type) as it has static branches */
 	if (tcp_key_is_md5(key)) {
 		timestamps = false;
@@ -1549,7 +1556,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,

 	inet = inet_sk(sk);
 	tcb = TCP_SKB_CB(skb);
-	memset(&opts, 0, sizeof(opts));
+	memset(&opts.cleared, 0, sizeof(opts.cleared));

 	tcp_get_current_key(sk, &key);
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {

base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
--
2.34.1

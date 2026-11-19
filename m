Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116123;
	b=aHIN9lSdu8KTkYDky3eoQl/lTs227OrwUkTqn3WJEw/Mp35DPFCNIxX92z1nQFGfs2TZ
	 nj7Yhi1NW4O8wsq2tIfpCMZZq7WS2o7FPiIVMOMpShpFlWH/UXz9qUhBF1hrALpIztZ6Q
	 C/CWe4aux/G0I9Tv1bXPO6p4tkXeQZAe/B/0XDCFrOUXEm8kN2bC23eOo8nN1xzikoZ11
	 qQ8hiKwjBGwpDEvr+sqwxv3pXU7XvaMi/XFCJULP6x3Rd5OBWvzR+F/0TdIIrUYYA1Fup
	 mqkplzKZvl1eF0WpIDycW3OQanwf45F2oY8Z9S6JfXB8eC0Wv7yg5gAmDLwY9aOOd6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gIWylxu69Ioq+u8Mm1LXBIh3r/He82QwlSQoOVn3GZY=;
	b=NVVtVICpmYi1SyVNs9wkaWhnGlnIGJF6L5RX9ta+h4b4U92sRwZYVDiI1ECG6Rs6/VCK
	 sJdW17ezJPBbII03HbS+QMoaqHLe4Yvyans7PyAdbD/YKxt9ixFKqGPADvxP1Zk2zyVti
	 EPh3seZ8M9OPcvp1c21QtxrdrUXnul71pEVW/+TBO+pp0Dsv/aSjl+1LfDJXipujg1Uwb
	 fuh3NfSzntQkT3o2i+6jMPBIJ5/3f9N5s+7gx/6dmZKoTXzqZSt8AJZjTQ2odq3md3Uzi
	 V27zunP0bpq4NNoy/XQmskAhqJa9OvR6Y/x/O5H/dCx4AsSCyhWVN7JN9I9iXK72DMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eqRRDtni;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBF6606A32C
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 19:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEBF6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eqRRDtni
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-49337a224a8so19547f8f.3
        for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 11:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116121; x=1795720921; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIWylxu69Ioq+u8Mm1LXBIh3r/He82QwlSQoOVn3GZY=;
        b=eqRRDtnih2s7Hgkfo5hTIa3hgTxx80TP/PXUS+4PUEZ7K7pIW3skbjX1sgOLkWB7oQ
         qIBNvnqZ7s1FMVJ1FImKz1QI11GoQZLbx3UHdgJahgwoNYIyQER7NRpjxU+iS9wtZasJ
         oF0KbLONgyB56vpx/Sx7flzGPN3dnhdnrEONrpJa1DB3UvWaftobbb4pWHPjC7LEwO6I
         nbiChV+2231onAna826KQToIBTxVWst+e/DcPofKrEocQvV8Gap7K3LmswwnO9UftpSA
         JXWOBzFn8ucVDCf7FKV4GfhBf7HfxTNcvMongmK4OT6epc2wGTkEIgJPJQPx59Bmws7M
         OlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116121; x=1795720921;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIWylxu69Ioq+u8Mm1LXBIh3r/He82QwlSQoOVn3GZY=;
        b=dDWAWIc9ta++JAVnGh4nMPZQnwZKrsOODF98CI/oCXP35NiKkZ5pTL91N5MpMC7UeI
         1MsQGbfqkEXThokgUsSOpDiALOndJ3czbZnlJhbuoMF/n6Ffiap4PBes5+PXARHStIi4
         Cu3oPItxRKIg81X5c2T4bEf60EhdGJwbaMzAYnzhCkZFRIbcMLj4Znd/yGKVsOMzHNFr
         R1nYoQcdN4u92J7b3BcTxEdW1NcUmaF0XttB4UV75z/+TszJ2vH/6IrTuxEgzMfVOyub
         bADomIQqY/dhfnb04g31BSRIRMFp88hN1+4gTYiqZP6LyNCVM5Be0SPjL2eMtcoqgq23
         rnEA==
X-Forwarded-Encrypted: i=1; AL+hErHNd0Ldssr5JAkR8Z0jD0hQfSsYRQRPh/ahigbaxBcSFoc90c/RBwmuDzhmmrl83JMuyDD5lQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Sw34/ILRzUQvSW6UtF3HRqQfW6HepeKUm0XRr16k8IdmYUsUu
	vk2vF8aq5ElqifcCN7RJlCr9P4mLwSNgkWsE1vtB7BYZApe121vTZio0jWqKd5oOK78y39xzpQ=
	=
X-Received: from wrmt2.prod.google.com ([2002:adf:e442:0:b0:48e:4e20:1349])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:4b0f:b0:48e:d7c:4bc8
 with SMTP id ffacd0b85a97d-4abad6a1782mr866576f8f.7.1795116120877; Thu, 19
 Nov 2026 11:22:00 -0800 (PST)
Date: Thu, 19 Nov 2026 20:21:59 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192159.2646113-1-dmnk@google.com>
Subject: [PATCH mptcp-net] mptcp: gate diag sequence counters on CAP_NET_ADMIN
From: Dominik Maier <dmnk@google.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

In net/mptcp/diag.c, subflow_get_info() restricts MPTCP sequence-related
subflow attributes (rel_write_seq, map_seq, map_subflow_seq, ssn_offset)
to callers holding CAP_NET_ADMIN in the network namespace.

However, mptcp_diag_get_info() unconditionally exports mptcpi_write_seq,
mptcpi_snd_una, and mptcpi_rcv_nxt via INET_DIAG_INFO because
.idiag_get_info does not receive the caller's net_admin status. Any
unprivileged local user can therefore dump or query cross-UID MPTCP
sockets by token via SOCK_DIAG_BY_FAMILY and read live 64-bit MPTCP Data
Sequence Numbers.

Emit INET_DIAG_INFO from an .idiag_get_aux callback in mptcp_diag (which
already receives net_admin from inet_sk_diag_fill(), while msk never
sets icsk_ca_ops so netlink attribute ordering is unchanged) and zero
mptcpi_write_seq, mptcpi_snd_una, and mptcpi_rcv_nxt when !net_admin.
getsockopt(SOL_MPTCP, MPTCP_INFO) for the socket owner and token-based
lookup in mptcp_diag_dump_one() remain unchanged.

This issue was discovered with an AI-assisted code review tool (ARTIST)
and reproduced in QEMU/KVM on an unmodified v7.4-rc3 kernel without
kernel modifications or error injection; a standalone reproducer is
available on request. This revised .idiag_get_aux patch was
compile-tested with -Werror and checked with checkpatch.pl --strict; it
has not yet been runtime-tested against the reproducer or the MPTCP diag
selftests.

Fixes: ac3b45f60954 ("mptcp: add MPTCP socket diag interface")
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Maier <dmnk@google.com>
---
 net/mptcp/mptcp_diag.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d0..62d8f1f 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -193,10 +193,9 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 				void *_info)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_info *info = _info;
 
 	r->idiag_rqueue = sk_rmem_alloc_get(sk) +
-			  READ_ONCE(mptcp_sk(sk)->backlog_len);
+			  READ_ONCE(msk->backlog_len);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
 
 	if (inet_sk_state_load(sk) == TCP_LISTEN) {
@@ -210,11 +209,29 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 			r->idiag_wqueue = READ_ONCE(lsk->sk_max_ack_backlog);
 		}
 	}
+}
 
-	if (!info)
-		return;
+static int mptcp_diag_get_aux(struct sock *sk, bool net_admin,
+			      struct sk_buff *skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_info *info;
+	struct nlattr *attr;
 
+	attr = nla_reserve_64bit(skb, INET_DIAG_INFO,
+				 sizeof(struct mptcp_info), INET_DIAG_PAD);
+	if (!attr)
+		return -EMSGSIZE;
+
+	info = nla_data(attr);
 	mptcp_diag_fill_info(msk, info);
+	/* Only export seq related counters to user with CAP_NET_ADMIN */
+	if (!net_admin) {
+		info->mptcpi_write_seq = 0;
+		info->mptcpi_snd_una = 0;
+		info->mptcpi_rcv_nxt = 0;
+	}
+	return 0;
 }
 
 static const struct inet_diag_handler mptcp_diag_handler = {
@@ -222,8 +239,9 @@ static const struct inet_diag_handler mptcp_diag_handler = {
 	.dump		 = mptcp_diag_dump,
 	.dump_one	 = mptcp_diag_dump_one,
 	.idiag_get_info  = mptcp_diag_get_info,
+	.idiag_get_aux	 = mptcp_diag_get_aux,
 	.idiag_type	 = IPPROTO_MPTCP,
-	.idiag_info_size = sizeof(struct mptcp_info),
+	.idiag_info_size = 0,
 };
 
 static int __init mptcp_diag_init(void)
-- 
2.56.1.750.gf70dc682cf-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318678;
	b=ytcVReQVgrXVLKxMgSpvdMp4BBzEfR3ad0+h9/ocBOx9bpYXbt2BQQTkiZfPxOiwuzgb
	 JHW32ut28YkPRqRijFBz3RQMAAJ7aqxwp1ZrO2/6ymmRqEfrniIka4p3eNs1cuHmeHbgp
	 LvWzVGiE2bAMxXuk34DeDyeDZ7pEM6JqSs5/Zf9hKocapmdsjnjXwXYn6gcg262nliRA+
	 JM6+ebRpi4QtC8BbJXfFgO0OSanJO2TFg6fyRpwciiwX6PilVNyyXbLLM5za4xufbjsOX
	 jywyGCbELA1Cl8CwIi0OIj8jAFzWemg02niNIZoWizB3/ZpAiksrjkdTg8Lg/Cokxuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318678;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sD0M+vKgWeFaSJtWMQoKW7Y4KLM+Kz8QQh2wr2vp7SY=;
	b=4t+X+vTF+Ppiij7/PV9ARuFGthK+s/rDIaeh270kS1S+LYwPFVwKeXnU61acldNsiBUV
	 Xy8fkjOsGMATX7N0XPL2USkXY/dHKNgbP2vFXXduJWecTxttR3wFBCSWzX05QAgl/iPkO
	 qwqlO3AGmSVEv1yQqdrIT1SqnikUMi1l8jEfr4OJn7eD/rqPLMYllLjIP+AH+CBXX2xt5
	 EYvjAOcFJNqBa52nTX68ANKTH0QCTft/EqcGVMF3g3aa06aLusSNz+D5C7umoH8E6B2AK
	 NWlf69lTlxAYRb5IhnmqozuSm3zWyEZ3ChPa6JJ6VuvrzY9712b39LcZcKhYryq1n3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kptbQKs3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BF606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kptbQKs3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9AE1F000D0
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318678;
	bh=sD0M+vKgWeFaSJtWMQoKW7Y4KLM+Kz8QQh2wr2vp7SY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=kptbQKs3g2MhnK2fSHz0wPDKDR4M6xqAPQqT0CglUd4/tSrw79oPwb+1elBybCHza
	 pllMWrBLbELgicBkpUCZ6eRR+XiwPGiSka6qZCIyZiZyQOJ5gJd+ahevBMBk1EpVxf
	 lnav/UrOE20EWvETl94A/xwYJ+769ogTApI1BhUe475BlKgNZtMyUkk3zubP7b3rIY
	 HUXwXRd9c4dlne5MLXFLpRRhxqMOXvR5V/vAaflBqnAVjZfubp/wznC3zVq65S6W+P
	 PjXA+/kWgYOA3dayOV4VmIfTKwLrM31eHlfKPM+KN9uqUD2ZY0wOq0Dc22tt7/zEo/
	 GX1LGhDCLaHEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/4] mptcp: add missing memory barriers for rcv_data_fin_seq
Date: Sun, 22 Nov 2026 11:37:47 +0800
Message-ID: <da8ae9e6c48df602b08475d151a87841ad632400.1795318567.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795318567.git.tanggeliang@kylinos.cn>
References: <cover.1795318567.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_update_rcv_data_fin() writes rcv_data_fin_seq before setting
rcv_data_fin, but there is no write barrier to ensure the ordering
is visible to concurrent readers.

mptcp_pending_data_fin() checks rcv_data_fin and then reads
rcv_data_fin_seq, but has no read barrier. On weakly-ordered
architectures, the reader could observe rcv_data_fin == 1 with a
stale (or zero) rcv_data_fin_seq, causing mptcp_check_data_fin()
to either process the DATA_FIN prematurely or skip it entirely.

Add smp_wmb() in mptcp_update_rcv_data_fin() between the two writes
and a matching smp_rmb() in mptcp_pending_data_fin() between the
two reads.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/options.c  | 1 +
 net/mptcp/protocol.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6365e180d9a0..2b04f083585c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1192,6 +1192,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
 		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
+	smp_wmb(); /* ensure rcv_data_fin_seq is visible before rcv_data_fin */
 	WRITE_ONCE(msk->rcv_data_fin, 1);
 
 	return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5ade9c25d0fb..ac7ee8deedc7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -567,8 +567,10 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	if (READ_ONCE(msk->rcv_data_fin) &&
 	    ((1 << inet_sk_state_load(sk)) &
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
-		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
+		u64 rcv_data_fin_seq;
 
+		smp_rmb(); /* pair with smp_wmb in mptcp_update_rcv_data_fin */
+		rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
-- 
2.55.0


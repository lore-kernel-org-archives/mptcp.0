Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864113;
	b=g6rst/7ZPkr8Ngk0Cib654FcSdo75Yjhkwn2zCcnSwFBagyzYg8vpniBx6KAJGqjhJ8s
	 kQT9MGMWKmh3nj+viKI6C9huoaPluKRQCzLvQbWBwf7KcJ7f8w/HIINlFziTKYqre2ZAo
	 DAOHM9sXKOS2ymxZvD6p6f/YK1c62eSGwzK3BOylwO6ec9cN2AsYHZBmADoFhv/BayeB5
	 QxCetaXmD95GjQbd1l0Zqqx3rQ6SH/CoVrag2aunkiuPiWpMol2FjfgIioUXoFrxepbKL
	 MKKJvBsIxmS7BnhZ9MPmI/6tWiwmYyUCLcCncCB75Ox5eYEOUimMlf93KUa9pFEscSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864113;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LRmusSFKVzJ9xPiQbleBjmjnEN9q0AN4HZc4J/br7ws=;
	b=XgtfWebgaoyj0ydqjV3vVlSje5hdFFM1fZ29CA9l+sj66ulDz7O2vhUGtFQfJsLOs5CT
	 IBruMi6xh8qojzQN27C+SRyrtQiwco6lQZTquyzS+wCfdmEu1ZAazdts7yfLSdyNiX/Pk
	 U8v5VxJp43PdyFbGVLm1Uy2F13TFYWqqbCKpDU9w/3pooE56t4Z8pEzwlCG8PqcCRRFaD
	 BG55KdJJZ1mliWpdiTIx9tlL0eSTYfVu+NP3q04Eqm44oSF2JwDV4QCWARNkTG9M/uSxZ
	 dN8UaFxGI+Q99Ro0C6O14H+1buITbxrLPLj4mSjMXLbIUuZPUcY30pQpX7eCvH/BIDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZwEkeMH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01675606A32A
	for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZwEkeMH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFBE1F000C1;
	Sat, 28 Nov 2026 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795864112;
	bh=LRmusSFKVzJ9xPiQbleBjmjnEN9q0AN4HZc4J/br7ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZwEkeMHpTLpcorssPOMvA8WfkJg1/G/PxfCqB+FwYR5NDn25jyP4kY1hyyGHW9IV
	 Bx8v/8nVtjbT6lQ1vEeF27u3mL8XocdWMSsxO5DNWw+0qA+2maD9nbufQJqstXYoC2
	 F0x0WWU79YZM17yU0lG2+u1+O6Yqm9rzBFttJDJVeC4wisETG77MGfnQfLzJ9uh+lc
	 39pi70rTWKA6T+bpwFV567nWZV2LXx8XIZezNbv0oplG8GYHfilbWuGANOxW1dhJ5u
	 d/Z1ox7LnKgyVd9xbdyAdA6fSp9qYQjCQq8NH7mr3n8KN9CNfzObuC2vRw1/aPz+/P
	 YZjt57+TwfO5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v4 1/4] mptcp: add missing memory barriers for rcv_data_fin_seq
Date: Sat, 28 Nov 2026 19:08:03 +0800
Message-ID: <4c71ab5537dff044b712a1304e335463c602c661.1795863454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795863454.git.tanggeliang@kylinos.cn>
References: <cover.1795863454.git.tanggeliang@kylinos.cn>
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
index 05b9c66aaed6..7c5e748105ea 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1204,6 +1204,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
 		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
+	smp_wmb(); /* ensure rcv_data_fin_seq is visible before rcv_data_fin */
 	WRITE_ONCE(msk->rcv_data_fin, 1);
 
 	return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e27eddcfa758..4dad5da12680 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -573,8 +573,10 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
 	if (READ_ONCE(msk->rcv_data_fin) &&
 	    ((1 << inet_sk_state_load(sk)) &
 	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
-		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
+		u64 rcv_data_fin_seq;
 
+		smp_rmb(); /* pair with smp_wmb in mptcp_update_rcv_data_fin */
+		rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
 		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
 			if (seq)
 				*seq = rcv_data_fin_seq;
-- 
2.55.0


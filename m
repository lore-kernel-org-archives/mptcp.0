Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2B39D3EB
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044472; cv=none; b=ETd8J0cofRDTHtkQ2hw0USU+p6VL3PDbFYIW5vKxuS0BW76luh352wu/2ZOPHCht4n1ukUt4V17Ww1iub2sJj2NqHa2ZQ7rcwehAwWtlvRttqfvVHETexCi9Q3GYxe5zyIltZ7f+fsIso76UQX60Qo9vExfzDEI7jcnPq2dTYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044472; c=relaxed/simple;
	bh=MPmouoFMWLVmbLhDNE3+RuQC16P2tCoqBytFnr2sTxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6lKzwplI/il3EGLmvtHu+rCXHegIq4Cd2KlA6AiUE+2dT3B4i7OVvhbYI4lPVoWkjJjuT3Yrp/z6a+EWZgnEpBmu7LXwPJQuf+OHzz0EE0FssUrsZ+mMglhW0LuO2B8C4CTxQc6lfURWQX/g8XWKJUsAFNagG0vip1/hXd1ffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N8Slf/0x; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N8Slf/0x"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=MPmouoFMWLVmbLhDNE3+RuQC16P2tCoqBytFnr2sTxQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787044468; v=1; x=1787649268;
 b=N8Slf/0xG2EpQW9xO48YMhsxpJf/FTQGqiARUnZ8KFAQ8wM2Znv3sP+AAA3u6YooRRYeLUtJ
 btjXoiP6R3ouBMWSV9elR0UbgUudw4jMx7CW8BASbVeTWCgonM5gKpi6Qun5NGLJF5CeoIRzIEW
 oUeY58vDMa/wmge94H4u8qqo=
X-Envelope-To: mptcp@lists.linux.dev
Received: from localhost.localdomain (240a:4281:fe00:1ace:7fcd:c486:d361:c952)
	by smtp.migadu.com with ESMTPS id 3a08fa730a291e0e;
	Tue, 18 Aug 2026 09:14:28 +0000
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-next RFC v4 2/2] mptcp: send MP_FAIL and infinite mapping on the same ACK
Date: Tue, 18 Aug 2026 17:14:17 +0800
Message-Id: <20260818091417.2200986-3-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

On a single subflow, accepting MP_FAIL must leave MPTCP mode at once
(RFC8684 §3.7). Emit the infinite mapping on the MP_FAIL reply ACK,
then call mptcp_try_fallback() immediately after.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/options.c  | 33 ++++++++++++++++++++++++++++++++-
 net/mptcp/pm.c       |  5 +++++
 net/mptcp/protocol.c |  8 +-------
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 97da22668dbe..ecf77e77d2de 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -638,7 +638,29 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
-	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
+	if (unlikely(subflow->send_infinite_map)) {
+		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
+
+		if (opts->csum_reqd)
+			map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;
+
+		if (mpext) {
+			opts->ext_copy = *mpext;
+			opts->ext_copy.infinite_map = 1;
+			opts->ext_copy.data_len = 0;
+		} else {
+			opts->ext_copy.use_map = 1;
+			opts->ext_copy.dsn64 = 1;
+			opts->ext_copy.infinite_map = 1;
+			opts->ext_copy.data_len = 0;
+			opts->ext_copy.data_seq = READ_ONCE(msk->snd_nxt);
+			opts->ext_copy.subflow_seq = subflow->rel_write_seq;
+		}
+
+		dss_size = map_size;
+		opts->suboptions = OPTION_MPTCP_DSS;
+		ret = true;
+	} else if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
 		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
 
 		if (mpext) {
@@ -1566,6 +1588,15 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
 			ptr += 1;
+
+			if (unlikely(mpext->infinite_map)) {
+				subflow = mptcp_subflow_ctx(ssk);
+				if (subflow->send_infinite_map) {
+					subflow->send_infinite_map = 0;
+					MPTCP_INC_STATS(sock_net(ssk),
+							MPTCP_MIB_INFINITEMAPTX);
+				}
+			}
 		}
 
 		/* We might need to add MP_FAIL options in rare cases */
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba7c6f80a183..69701ac7e436 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -895,6 +895,11 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		pr_debug("MP_FAIL response received\n");
 		WRITE_ONCE(subflow->fail_tout, 0);
 	}
+
+	if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
+		mptcp_subflow_reset(sk);
+	}
 }
 
 static int mptcp_add_addr_len(int family, bool echo, bool port)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f879b1061f2d..abe45a31ca5f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,13 +1417,7 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
-
-	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
-		mptcp_subflow_reset(ssk);
-		return;
-	}
-
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 }
 
-- 
2.25.1


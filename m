Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB93FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:50 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id n18so15164737pgm.12
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/Nh0mUkMfSp5wC9uccppV20cTh8J8w06paeI+Ik/IQ=;
        b=F7ttpSB3USTI6/Ksz8B22w4JTvgcYYfR44Pdsxy9p18TRtlCl0uOc6Dokt0L2lLkYs
         MLbhH3J08UXRsMonMXMVM4r6dShmwMe+8dfgcg3FEIa8lGweUBDd01hcKko15czOVD6k
         mqziFOihmQP/cwDCuytskADuhbf6kJSk/qbY8WkVPd4IGuDtDsSzCh5ZicqY/Csd1Tk2
         wZ4qKTFttJCbLE1nVZt6aHcT5o9QeeFY7Qvq8IArDHcm4bHbLnO+wuq9e9t8NvWPppPZ
         KkXAAW9xpy/mVaF9art8y/ev+a2mpSmOm8XzDPuKxK7YK05ICSgDm7bJIR27hal9A6Ax
         0eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/Nh0mUkMfSp5wC9uccppV20cTh8J8w06paeI+Ik/IQ=;
        b=tqGmXwqPg+6y5CuEL83z2VrCCJYb4UDut9GC8hhqJGeCzJCYtHuXGw92sEWU68hVDi
         ZuoX2T5n7Sq20bLapJuHiKaFIO5OTPkXIkjoBopKPYSPIBOg7CSbWDeYAGqC+uQ+QJ55
         anlV0cKAPlsJB8oCd1+Bwy12amZ7uh+rYL8ki7TPNh0/aVNUb7PgbPQiomyMzaOXUcDY
         woJQSg1bRfX2cFYyz9ZlCjUP4t3BZ1BMLGPlNxgYdqq5jDmIjo8t9GsYNoQx48nqM8o8
         ZKRZi4AvUBr0aC5Y3RoeO7Rx37IdRH5gyxOEVPiEdXvZHTs+EnLUEVZ2j9Wn5upqcprD
         QtOA==
X-Gm-Message-State: AOAM532cHVHLjsT/RQzkknFfLeJ9nH3eHfSopEME7mdbn/TQZGntSg4V
	WDRJ+xTap8EftU0zDso25moei9uZtWI=
X-Google-Smtp-Source: ABdhPJw24JREICmeRtoqlNjBrPyzsP4nE32aotIdIqwKRZ4OnS4yG11z3Z59NctQnY794xQ8tOg3Kg==
X-Received: by 2002:a63:f913:: with SMTP id h19mr12734111pgi.351.1632666590238;
        Sun, 26 Sep 2021 07:29:50 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:50 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v5 3/8] mptcp: infinite mapping sending
Date: Sun, 26 Sep 2021 22:29:33 +0800
Message-Id: <ccd77c87a8a73c7ecac8be52e894568147deeeb3.1632666254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632666254.git.geliangtang@gmail.com>
References: <cover.1632666254.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the infinite mapping sending logic.

Added a new flag send_infinite_map in struct mptcp_subflow_context. Set
it true when a single contiguous subflow is in use in
mptcp_pm_mp_fail_received.

In mptcp_sendmsg_frag, if this flag is true, call the new function
mptcp_update_infinite_map to set the infinite mapping.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  |  2 +-
 net/mptcp/pm.c       |  5 +++++
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 net/mptcp/protocol.h | 12 ++++++++++++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index f83fa48408b3..29e930540ea2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -35,7 +35,8 @@ struct mptcp_ext {
 			frozen:1,
 			reset_transient:1;
 	u8		reset_reason:4,
-			csum_reqd:1;
+			csum_reqd:1,
+			infinite_map:1;
 };
 
 #define MPTCP_RM_IDS_MAX	8
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 422f4acfb3e6..f4591421ed22 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -816,7 +816,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	opts->suboptions = 0;
 
-	if (unlikely(__mptcp_check_fallback(msk)))
+	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
 		return false;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..27d43a613e9a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,7 +251,12 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
 	pr_debug("fail_seq=%llu", fail_seq);
+
+	if (!mptcp_has_another_subflow(sk) && mptcp_is_data_contiguous(sk))
+		subflow->send_infinite_map = 1;
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1cf43073845a..60953b61b3c9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1277,6 +1277,23 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
 }
 
+static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
+				      struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->infinite_map = 1;
+	mpext->data_seq = READ_ONCE(msk->last_fully_acked_dss_start_seq);
+	mpext->subflow_seq = 0;
+	mpext->data_len = 0;
+	mpext->csum = 0;
+
+	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
+	pr_fallback(msk);
+	__mptcp_do_fallback(msk);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1409,6 +1426,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
+		mptcp_update_infinite_map(msk, ssk, mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e9064fec0ed2..005c18e81e18 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -433,6 +433,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		send_infinite_map : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -876,6 +877,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
 
+static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
+{
+	struct mptcp_ext *mpext;
+
+	mpext = skb ? mptcp_get_ext(skb) : NULL;
+	if (mpext && mpext->infinite_map)
+		return true;
+
+	return false;
+}
+
 static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-- 
2.31.1


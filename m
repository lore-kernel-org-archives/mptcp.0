Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7D72
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 01:12:55 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id z18so726635plg.8
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 18:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OD6Zu4IZHo3ycDMZl46myA336Gy5bRX35HQP+kRfulw=;
        b=p9HPqPQpUHZBhaPf3NST1vAeoDU5bkK84EUPyx9bR/N8TVIkiuYsi1X5vTaaRjOw1L
         A+/4ceiXOGT9SJV/aGkla8lcq71MnXLOXCJfQdRNHMutqVWcQMWqeWEOBlTFIIIMm1gv
         VuuH55j6rY+83ihLB1inW6lcfKGsSIFsbVTYi8/rwcMCjRPk0h5qq6isJxZmzeZDdhPy
         ci20vBpGSCkQ84o3eUEjd1mn0IV3V39tfcRax/nrymrDOMynCDgGc8shrxxzR5exaN+d
         K6jshSeKc7tLk7NJ52/tH1cevfNss9vGfO/rTIqeQBFeocC1JTsCGTiIasQxPkoUCzsO
         7cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OD6Zu4IZHo3ycDMZl46myA336Gy5bRX35HQP+kRfulw=;
        b=I+2VdOVueV8u4Afptbw4mDrdwPCkLrhr1mtQt9RZ8zQauqlT0IM/ualKxRxu5Mpi5W
         UYRJwbLTB21EdOnQ9qWPHiQziFFS4ItH8ys3yX8mQbxb33kwgo9cw+YfUM3ekFba3vVY
         1lHy0mX/Nlj2whaG6f2Z+1PlNHyfravBiNyhKhgiIUCu+QJKl9bhV0eeOmUG4DbHb+JQ
         gsYBdr1zGEM+3zCxKW3gxxMh3UqAtCpUKRETxdEyGubg9NQXkLpEenQOMyrLR8gCTiAk
         nqmnetuwTKb8YrXElkRHdRZO8n2z3lhnm4jgJtLlEAvf+z16v1zY6STM8y3x2vGqn2tZ
         gpIA==
X-Gm-Message-State: AOAM533GgxlA/Dfa8j2LxNanVkICrzzvtP7zHHbQ3ln+4PArPwwLuRJx
	S+6CA3tBEHLithQOmmPOXF6tXpeIeFM=
X-Google-Smtp-Source: ABdhPJxMGMxx5R7fmp5k+FLfP8cBV2+3edAssqOtJsxgC0ZisKemEGyHqa0nbg6Hrg7U+fs334kxLg==
X-Received: by 2002:a17:90a:4e81:: with SMTP id o1mr19811872pjh.7.1620349974758;
        Thu, 06 May 2021 18:12:54 -0700 (PDT)
Received: from localhost ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id g29sm3279584pfq.148.2021.05.06.18.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:12:54 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add csum_reqd in mptcp_options_received"
Date: Fri,  7 May 2021 09:12:48 +0800
Message-Id: <9d886bb5015a687a46287accd3a6f1111233eda7.1620349765.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com>
References: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Init csum_reqd in mptcp_get_options, keep mptcp_parse_option unchanged.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4a74b8bb737f..527affbbeea9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -24,8 +24,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	u8 subtype = *ptr >> 4;
 	int expected_opsize;
 	u8 version;
@@ -74,7 +72,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * negotiated, the receiver MUST close the subflow with a RST as
 		 * it is considered broken."
 		 */
-		mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
 			mp_opt->csum_reqd = 1;
 
@@ -329,6 +326,8 @@ void mptcp_get_options(const struct sock *sk,
 		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	const struct tcphdr *th = tcp_hdr(skb);
 	const unsigned char *ptr;
 	int length;
@@ -344,7 +343,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->dss = 0;
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
-	mp_opt->csum_reqd = 0;
+	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
-- 
2.31.1


Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783156D18
	for <mptcp@lists.linux.dev>; Tue,  6 Apr 2021 10:03:58 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id a6so3874379pls.1
        for <mptcp@lists.linux.dev>; Tue, 06 Apr 2021 03:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOOk4YTeWVo6aUqRMJGnlv6V7jk8tV5Ro4yjeDpxdgo=;
        b=VCi7ql2YksZqs8ngCjv9AdQCX1TGCtnf6ALoVlMhQESSoUQtmPX7vrzTEdtSPDPOW4
         QBmWrhwS6YIWfJoYh0qW2VhW9SkbWV2HuSq2C+eAF5h/L+5scqbAz+S1EC8XZGHg1B1a
         mBf0HA9EPJ/B4yZQP8h0Q7ZbLH2cXEdAcARvV4TGPHu2ZDLVv76sVOJHqdAU8S1xIol3
         SM5rWvdSuBIpJcArHVUYAVKjn2ODchkfcz4Wx+RuxDDLKbYubD4ORDrAv9VWXCZDCVAI
         lUme4MJDHyIY7OGGkn9w63lqGZ/NeRsu9JpxPWVnKbm/UW9mCYHtff9bRrnz7X8+IWsw
         HvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOOk4YTeWVo6aUqRMJGnlv6V7jk8tV5Ro4yjeDpxdgo=;
        b=hkoOVCR/ehIP4izlecQm92K9nlc0MwlegyM+UHxcCo8ob8GYyBAKp7B4UaVVmmcE05
         D0WtfQTMwN+reHcTtCqbzXh98yMumngEb2lXJcNaidWKYIrY21vAoC+b4sdyv3GbP5SH
         X4upoODuagmgQEWsFeyp3NgD8FRYYv3T6xyTtsnK8QzEwRMzkc/c+PBs8zFS9sYvJ7hv
         IRNGSD5SlAmyZAU3hclborriZl2kyAdJuI1BrT/HW+XUbwAYb15uP5ECWrPOiQMJTZ8Z
         gGEfOFUbCCY9R0fPweLvZP1tKogHOPjaNXFQyAfesreUkzJmyqMpSITTy7xiNXYOlk5A
         t5lg==
X-Gm-Message-State: AOAM532Dsee0jx0umuXKbja82bGF0CbNSBGepwQw+Wcospq+16fFNOxI
	9H5Z0/vq6wYSRrpo9k5QmLZr06OBg0B5BA==
X-Google-Smtp-Source: ABdhPJyGdcCUtFfaAbPrusCb8KWiLkd1WZO11iYudu17fj5BjVbwj9upgiAI+uLNd0AZlMKA9qeXIA==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr3589786pjb.188.1617703437732;
        Tue, 06 Apr 2021 03:03:57 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id lw16sm1991051pjb.41.2021.04.06.03.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:03:57 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 2/2] mptcp: use mptcp_for_each_subflow in mptcp_close
Date: Tue,  6 Apr 2021 18:03:44 +0800
Message-Id: <ce612a158a171e421dda4f08bcb99894bb7c2991.1617703144.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com>
References: <cover.1617703144.git.geliangtang@gmail.com> <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch used the macro helper mptcp_for_each_subflow() instead of
list_for_each_entry() in mptcp_close.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d895c3c8746..3b7d1df8d019 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2581,7 +2581,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 cleanup:
 	/* orphan all the subflows */
 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
-	list_for_each_entry(subflow, &mptcp_sk(sk)->conn_list, node) {
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
-- 
2.30.2


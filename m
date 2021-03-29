Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F171
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:40 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id o2so4191906plg.1
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TX3B23KiBV5NZpRXgqLYpr6e5UdJgNsg49JP0ojnva8=;
        b=K5mmJS9c7CggLsA74t+6+I7/t2uPXHH8ghZ0YXsyYtU60PNnZKnsdq4tKExWlNIlj3
         BH8JUvBkpWh7bIxSIX1HegK2V1MvlPIafN++utN1E2h9sdONMFMEJWtznBAez+0njzhU
         2SzUW9JUVaHT9JFOOZ/38xwU6f2tn3XDu0NVu2MmHZfjv1i1iZ6Y/Z7KhTfAUUT+yrkB
         cz840aHFyzli1gGH0xMs0nhXmCVuvAeiMA1EdHCaXfKKxJ74npH+HMHGKR7cvgaP0Qhl
         1Shd4lXooWzGvkBdOntwwVfKBPl0hPefq/hD65TLXKUqjeMgB1djr8WGEiO9Ysqlxp/N
         HMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TX3B23KiBV5NZpRXgqLYpr6e5UdJgNsg49JP0ojnva8=;
        b=Prps34Goxl4Lkp0Woo+pIez3ZErriPLNyjw/AEKihUYesDrNrr2BOZd4izUju7L/fm
         FjN5d2Lpa6CMAz5QCCXNeya9rzF1gginsZCQdShEDE6YJR0cG/kjsKgfMkOOQuu4UoF1
         G6V/YXbNbaukm0i/h3zz4anGKQz3Jd7QiuLSKF+MllyoI9h8nV2CFqRYEIvdz/mwbDbY
         z5jXKfYJAXb+ONMj3BzJndDUlHFBtxdZzuUH5NUjZ8kEcy7UmFtBfcNmR3Q4o6/SES/y
         whTHpgLDZ+ONzYQs5zFd4c0j3e/wIdXNfRYrx1Qd67onqA7fVJzA4d6HOdsohGwymz3f
         kH3w==
X-Gm-Message-State: AOAM530Z0ZqZ+yhzM4JRRqwBtxdkwhdN53TlVOPzU43SCUoIyTw9ncLa
	QFhe/F1Pumk83dEH2Qs6VLoS4Hph2TePAQ==
X-Google-Smtp-Source: ABdhPJxxNNxvR/in2iA1EfCPM1EbvGEloz0NtjrX6fL221Fp8nSQeLPMrp85HdR6GqCcgdonOOoKew==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr26156796pjv.129.1617014499508;
        Mon, 29 Mar 2021 03:41:39 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id ds3sm15056654pjb.23.2021.03.29.03.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:39 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 14/16] mptcp: add trace event for data checksum
Date: Mon, 29 Mar 2021 18:40:45 +0800
Message-Id: <c231d3aa6b38374c1e28709e4d4b94e179c6e13c.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <5364f608199436bf7125d8f89a4fefcaad2b5eb3.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com>
 <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com>
 <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com>
 <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com>
 <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com>
 <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com>
 <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com>
 <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com>
 <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com>
 <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
 <95dff6615e84496cab649de3d74917790f6a571f.1617014019.git.geliangtang@gmail.com>
 <44262de5d6a76c02e585ba148117af9b81355d0d.1617014019.git.geliangtang@gmail.com>
 <5364f608199436bf7125d8f89a4fefcaad2b5eb3.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the trace event for the data checksum. Add the tracepoints
in mptcp_generate_data_checksum and mptcp_validate_data_checksum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 38 ++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         |  4 ++++
 2 files changed, 42 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 5571c45c61f2..ebfcc1a6fe3d 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -145,6 +145,44 @@ TRACE_EVENT(subflow_check_data_avail,
 		  __entry->skb)
 );
 
+DECLARE_EVENT_CLASS(mptcp_event_data_checksum,
+
+	TP_PROTO(struct csum_pseudo_header *header, __sum16 csum),
+
+	TP_ARGS(header, csum),
+
+	TP_STRUCT__entry(
+		__field(u64, data_seq)
+		__field(u32, subflow_seq)
+		__field(u16, data_len)
+		__field(u16, data_csum)
+		__field(u16, csum)
+	),
+
+	TP_fast_assign(
+		__entry->data_seq = header->data_seq;
+		__entry->subflow_seq = header->subflow_seq;
+		__entry->data_len = header->data_len;
+		__entry->data_csum = (__force u16)header->csum;
+		__entry->csum = (__force u16)csum;
+	),
+
+	TP_printk("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
+		  __entry->data_seq, __entry->subflow_seq, __entry->data_len,
+		  __entry->csum)
+);
+
+DEFINE_EVENT(mptcp_event_data_checksum, mptcp_generate_data_checksum,
+	TP_PROTO(struct csum_pseudo_header *header, __sum16 csum),
+	TP_ARGS(header, csum));
+
+DEFINE_EVENT_PRINT(mptcp_event_data_checksum, mptcp_validate_data_checksum,
+	TP_PROTO(struct csum_pseudo_header *header, __sum16 csum),
+	TP_ARGS(header, csum),
+	TP_printk("data_seq=%llu subflow_seq=%u data_len=%u csum=%u, checksum %s!",
+		  __entry->data_seq, __entry->subflow_seq, __entry->data_len,
+		  __entry->data_csum, __entry->csum ? "error" : "done"));
+
 #endif /* _TRACE_MPTCP_H */
 
 /* This part must be outside protection */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e414ff940727..0fe9c29bcda8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -552,6 +552,8 @@ static bool mptcp_validate_data_checksum(struct sock *ssk)
 
 	csum = csum_partial(&header, sizeof(header), subflow->data_csum);
 
+	trace_mptcp_validate_data_checksum(&header, csum_fold(csum));
+
 	if (csum_fold(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCSUMERR);
 		return false;
@@ -1307,6 +1309,8 @@ static __sum16 mptcp_generate_data_checksum(struct sk_buff *skb)
 	csum = skb_checksum(skb, 0, skb->len, 0);
 	csum = csum_partial(&header, sizeof(header), csum);
 
+	trace_mptcp_generate_data_checksum(&header, csum_fold(csum));
+
 	return csum_fold(csum);
 }
 
-- 
2.30.2


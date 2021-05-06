Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70472
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 07:49:04 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so3008384pjb.2
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 00:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrJCLWcUUTE5lSzPNPZ98ImnHUQOo5rNO3Jw9T7CyG0=;
        b=mThU4OhA56XN3WZ2J7CFG6XlrweSUJyJpcLOAFynPno6FpchowY7WN857icx6w5R4X
         LYaWY4sEkXWNAefYkCSJ94BnUiHIcKiDiTJs9hpWr2o0WbqLZocTsyWIT8DRutXgG0jc
         pNRi6vBxvtHwmqegbgYO3b8MDah3O0r9PwM+T0fIY22uNcCW88Rv8CNT5yUzXqcztvTK
         JDoR8d2+Dsvs4QwT7PGy5m1mRptHNf48BPyMt6+gSG5iy5rvTv4CHpSR/AxuX62IuTuM
         0g1H41Otc+7yXaKMGVfXy0St4zRBvLL2ew/xg5KMmoT69xw2vuZzCIGIrq/KxI5n1FYU
         5/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrJCLWcUUTE5lSzPNPZ98ImnHUQOo5rNO3Jw9T7CyG0=;
        b=dAC972lHoKeSdCV9E0Y3gfWCcRcZOP/FYZexwwbAaMepDKWLAJNoWGVzEYQLf6hGI3
         fDg+5wt3g0yqS6ce731QgmSml5KXaLv4lsSwjhwHHBNGZ5qmHnXJ5kPOagXU58K/vGsK
         ARlyaqJHNOhit+/divYg2A97Aa1+qyEr4b6Enr2nHsh/fPSS9emzUFPJ69zNFHnDCUdR
         gj+RzKPKisW2uJORrhRNkjNr0ARkZwobKwSzD7sw3QuD8BGoE5yKHCAQ9BnrA3uKT7LB
         lMBv4JBgeuLwX9+CHEtpJjQUJwGKz2C0/924qSvU8PC/K+mGuJBsT6U73mgs/uoY4KrC
         oHlw==
X-Gm-Message-State: AOAM5338VEkmf3rLw63SzRXBB2UeKthBhZ9SqAs1QExBaMGtYcMwSPbA
	qoNhsoK0FDz+/hT19ERzrckpg+ixkW4=
X-Google-Smtp-Source: ABdhPJzxmoBYNFpb/VF0ArWYeMopVHO2U1eTFD2hK4T+xegtbUaUqn4KcbFYTngbDpOwj/lNGc2AVA==
X-Received: by 2002:a17:90a:de0d:: with SMTP id m13mr16297624pjv.9.1620287344137;
        Thu, 06 May 2021 00:49:04 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s21sm1310285pjn.29.2021.05.06.00.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:49:03 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 4/5] mptcp: dump csum fields in mptcp_dump_mpext
Date: Thu,  6 May 2021 15:48:45 +0800
Message-Id: <af98fe46c5b1d2737f02868fddb6d08e84d220c3.1620286893.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <0e4f818d6894959b07da34e2d190ec2a7aaba51e.1620286893.git.geliangtang@gmail.com>
References: <cover.1620286893.git.geliangtang@gmail.com> <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com> <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com> <0e4f818d6894959b07da34e2d190ec2a7aaba51e.1620286893.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mptcp_dump_mpext, dump the csum fields, csum and csum_reqd in struct
mptcp_dump_mpext too.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/trace/events/mptcp.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 775a46d0b0f0..c853849692af 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -73,6 +73,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__field(u64, data_seq)
 		__field(u32, subflow_seq)
 		__field(u16, data_len)
+		__field(u16, csum)
 		__field(u8, use_map)
 		__field(u8, dsn64)
 		__field(u8, data_fin)
@@ -82,6 +83,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__field(u8, frozen)
 		__field(u8, reset_transient)
 		__field(u8, reset_reason)
+		__field(u8, csum_reqd)
 	),
 
 	TP_fast_assign(
@@ -89,6 +91,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__entry->data_seq = mpext->data_seq;
 		__entry->subflow_seq = mpext->subflow_seq;
 		__entry->data_len = mpext->data_len;
+		__entry->csum = (__force u16)mpext->csum;
 		__entry->use_map = mpext->use_map;
 		__entry->dsn64 = mpext->dsn64;
 		__entry->data_fin = mpext->data_fin;
@@ -98,16 +101,18 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__entry->frozen = mpext->frozen;
 		__entry->reset_transient = mpext->reset_transient;
 		__entry->reset_reason = mpext->reset_reason;
+		__entry->csum_reqd = mpext->csum_reqd;
 	),
 
-	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u",
+	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u csum=%u use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u csum_reqd=%u",
 		  __entry->data_ack, __entry->data_seq,
 		  __entry->subflow_seq, __entry->data_len,
-		  __entry->use_map, __entry->dsn64,
-		  __entry->data_fin, __entry->use_ack,
-		  __entry->ack64, __entry->mpc_map,
-		  __entry->frozen, __entry->reset_transient,
-		  __entry->reset_reason)
+		  __entry->csum, __entry->use_map,
+		  __entry->dsn64, __entry->data_fin,
+		  __entry->use_ack, __entry->ack64,
+		  __entry->mpc_map, __entry->frozen,
+		  __entry->reset_transient, __entry->reset_reason,
+		  __entry->csum_reqd)
 );
 
 DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
-- 
2.31.1


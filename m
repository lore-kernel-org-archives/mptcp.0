Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929471
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:32:22 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so2773563pjb.4
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrJCLWcUUTE5lSzPNPZ98ImnHUQOo5rNO3Jw9T7CyG0=;
        b=YT2BHrN6M48mDWcmobTSBbAsCe6wlJEHZyVyAxk6kRpg2vsoZ/HNWKuwYKQlXyrd69
         uyUCQ/1LxU5TVY/hJyMcRHdQpi4FPHrCSOmmt2WQJdZ9bA5zcpOpGwPQ7oXexeQto49y
         A04vUgU3W547+7c4zzTUsC59YFH2MPVxcKYFG0SUgXc9dBek86qnEuopT3IDV+tJQA5L
         dEufs9mlwsmOoenxltJabOhjXUvqPnCoDrROKb/nxE1kd4Xjz/7XWJ4AzKEYyzLgH1kb
         RKIqpLY8jkeMqtiHV9MPf4OWdykw3p7rBeIEVj3EgHjRLM9ZpeVfPc5ttt/O5g51DKNX
         roaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrJCLWcUUTE5lSzPNPZ98ImnHUQOo5rNO3Jw9T7CyG0=;
        b=JmHiKQSBdwprUZ8pXxJjXiXPQN3/e6vhMqJsJYTutNWe4+/Y8W90EUdDg73XkOXTQM
         MPznsmTdRpZKL+3NqL3OUukrJMUSzD1arZQZ0paE6pWazB9juonKCzzigW8GGf8mPolJ
         OoF4gp1h/XL5JCzulNGyc/p76lvTpxDe/Ld8pV9BbvwcUZn5YyX6kGBcQMMfdMM0A1X3
         EsTtTIkcYIMPMKjIxm0oNdnXJAwMUra901HH5Tehlm0a6oXx1k1Cs3Mpd6kughEkgGGa
         mqYs7CtX4wIB0OYviTKYCgLNlH1CCafplf6ABLKl/5upR/o0xAYKmjvXMltlU1DyykF5
         XFJA==
X-Gm-Message-State: AOAM532bkUDhUBRAn9wK59OyhP6CAWeFLP87PXPeCJCe/k2LNdScN2nw
	i40xjcskyLsGHtC2cDxajapBzfzYatI=
X-Google-Smtp-Source: ABdhPJyUE2QnY/kI63LF4HBXse13+5QNXiXl8ljqwf2Vj8y0QtUcKgchRSwQ84RBjTZwx5LzfeJdXQ==
X-Received: by 2002:a17:90a:a007:: with SMTP id q7mr15456840pjp.156.1620275542091;
        Wed, 05 May 2021 21:32:22 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id w2sm759240pfb.174.2021.05.05.21.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:32:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 3/3] mptcp: dump csum fields in mptcp_dump_mpext
Date: Thu,  6 May 2021 12:32:11 +0800
Message-Id: <72fbd79f76278e33ff349af7a04c2789e824f2d7.1620275257.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <89dab04f93300a924df81d1ab7399380b4d54087.1620275257.git.geliangtang@gmail.com>
References: <cover.1620275257.git.geliangtang@gmail.com> <49d4717df8568a70b4bb6d3827046cd5a771b14e.1620275257.git.geliangtang@gmail.com> <89dab04f93300a924df81d1ab7399380b4d54087.1620275257.git.geliangtang@gmail.com>
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


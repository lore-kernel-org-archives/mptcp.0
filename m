Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5E34750F
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786258; cv=none; b=MNUG02McyliXu8yp8hEw8vLy8maomBlDZv5C6++csRqr2gQ+lNas4cSDOyIPHUuhdWyPbGJQthH5JJRzeMC5VaVAZsVF8nbzPVYkU23HLFZZQmoskoLq3YYCOAwE8sHNLOVWmC00rCbnPDj332l0L0pBK0kSOcglm+rpBty7rTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786258; c=relaxed/simple;
	bh=x4o9+7f63AVkiC0NTDRiOlpP3AOwo0ZIvj3NHB3RDAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsjDYUlWgOyGjnrQV6iBfm8vGXGrAiLGs3pS5wRTW1IXmvVQBy5nqjxbqBCaz4fzx7m/Qz8a7DHlhmSKYwdvLWDDGUoDbBW0UMfUi3iBWzn721uvMTFZ59mwT0ZBrtB7MVWqmVH3r0DT1wJ9VUg/dZcoCAJCSfNfn6Agj+Dxngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVW00Nmn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVW00Nmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052F51F000E9;
	Tue, 26 May 2026 09:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779786257;
	bh=LND7NaBlLpOaZyIZvSyA2WwuDkNDcoMmFl/s1+zpysE=;
	h=From:To:Cc:Subject:Date;
	b=SVW00Nmnb8puY9XnB3xVrKwPOYnTvHnPm9sy/vD+nkpg96EKAQ3T2DtThYu80ia6/
	 HJHPJo6dgz6zxRpS7fM/5Zi938MDngA/Pdhv4ot3noi74mD06303peBoSvRVAPkjnn
	 8m4OZlDupgo7jQJn01raeONv/8k9ggkSWX2UG9v9O126aX3vBTgmJNpZoiQww5hNBl
	 Ma+Oq5IZvSR3mmvwgNRcDnvOzUL7dPg0r/S5wfqC9XT+p+awZopfUU9h0SdblQSGdX
	 K0bGD/Db1jJ66oK1FgYX2/oEWMCtsEl5XARotZS3UQeWSCpVRBxD6aMsl/L2u2Sl2m
	 Uh+qnYKlgtsxA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next] mptcp: remove unused data_ack from struct mptcp_ext
Date: Tue, 26 May 2026 17:04:12 +0800
Message-ID: <59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The data_ack and data_ack32 fields in struct mptcp_ext are no longer used
anywhere. Remove them from the structure and update mptcp_dump_mpext()
trace helper accordingly. Drop the data_ack field from the trace entry
and the corresponding output in TP_printk().

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Based-on: <cover.1779485511.git.pabeni@redhat.com>
---
 include/net/mptcp.h          | 4 ----
 include/trace/events/mptcp.h | 6 ++----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 02564eceeb7e..75a30c70c6e1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -19,10 +19,6 @@ struct seq_file;
 
 /* MPTCP sk_buff extension data */
 struct mptcp_ext {
-	union {
-		u64	data_ack;
-		u32	data_ack32;
-	};
 	u64		data_seq;
 	u32		subflow_seq;
 	u16		data_len;
diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 04521acba483..22882bd03459 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -75,7 +75,6 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 	TP_ARGS(mpext),
 
 	TP_STRUCT__entry(
-		__field(u64, data_ack)
 		__field(u64, data_seq)
 		__field(u32, subflow_seq)
 		__field(u16, data_len)
@@ -94,7 +93,6 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 	),
 
 	TP_fast_assign(
-		__entry->data_ack = mpext->ack64 ? mpext->data_ack : mpext->data_ack32;
 		__entry->data_seq = mpext->data_seq;
 		__entry->subflow_seq = mpext->subflow_seq;
 		__entry->data_len = mpext->data_len;
@@ -112,8 +110,8 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__entry->infinite_map = mpext->infinite_map;
 	),
 
-	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u csum=%x use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u csum_reqd=%u infinite_map=%u",
-		  __entry->data_ack, __entry->data_seq,
+	TP_printk("data_seq=%llu subflow_seq=%u data_len=%u csum=%x use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u csum_reqd=%u infinite_map=%u",
+		  __entry->data_seq,
 		  __entry->subflow_seq, __entry->data_len,
 		  __entry->csum, __entry->use_map,
 		  __entry->dsn64, __entry->data_fin,
-- 
2.53.0


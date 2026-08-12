Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BA46EC69;
	Wed, 12 Aug 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546575; cv=none; b=llI1WSe7H+7/+KVO8xcpJz3eUb/W3VPZ2Z5s9bLE2XU1DnfgTKv8QffM6NKzhwAicY1VcJc+Ont1lQx639iTxuTHAxuQHff+7+QdKk30PLhEvukAO8831omNPLwSKcGoLyhWtOL/AeP+SsW7FfmxGMqvyEZZmmHLkLJQOG+MPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546575; c=relaxed/simple;
	bh=2QzIb/jNE1OcHLnHPrfA7nX9AqIAo1yYkGQwq3UFsGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuJ1nC91ouaojpuYF4yn02Nn5NlETovDgcwfnPKTA0fTFonq36RTu46i2xfOW4WVfSzdRjxplT2zs/2sY4BgPu9Us5bfPX02dmN9QVSbnRe86+usJ7NO1Iwz66BKBKLzD6tolIk7DD8WMfogg0LLBCJIirXTVupNXmzEIcFIzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcF2Ntme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcF2Ntme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688EC1F00ADB;
	Wed, 12 Aug 2026 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546562;
	bh=qLUPtfFf9FhflLXSbkntjMYPfWGrc/D4NeOfLtwZGug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dcF2Ntmel4kXMZdYiAKCeCcveNaojBLGqs+0ejME4vXB2rVSXG9vmfmw04sLsBKpv
	 dMbdTOWIIVjrgAdc2Tms2FMD+lBFeEJv5C82y8ihri7kvwzrhGGccnMhH6AHi/7Vf/
	 CwPuThUUhTm7zhQgluWexA193uec/4RGf9UZv+osFMECN8bFg8wXlKb7LIe2hV86f0
	 wzi1kKduR0FAVOxwuZfcQWckjltXMwrY65SC1uyGiLM6lWcEabHuTZgaQm8fqBhvwd
	 e2sOzJkKub2BmPLW9fpN5h4zrVEe0jaX/rzbcmUTYQ+ubLbeguEZMzDDd+pD9ZuUPr
	 td8hdHsAreIlg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:37 +0200
Subject: [PATCH net-next 02/11] mptcp: remove unused data_ack from struct
 mptcp_ext
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-2-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2561; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RWzRcFuSIbEV/td2eQo1OegNXZesOq80bWBdbOKhYO0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOov3Mpj1NBjUSfnKruS1naLm/v7QtanrPt34NiFth
 ZTYVE3njlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInwtTD8U3/M1xHT3HXvu6PS
 h8vTbtbO9Xhy1I07a9l1s5frnU6aizD8s3kglflj3aHFS55v6GI2jEjfcv+TUExlrPS3yVc/3Jk
 uxAoA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The data_ack and data_ack32 fields in struct mptcp_ext are no longer used
anywhere. Remove them from the structure and update mptcp_dump_mpext()
trace helper accordingly. Drop the data_ack field from the trace entry
and the corresponding output in TP_printk().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
---
 include/net/mptcp.h          | 4 ----
 include/trace/events/mptcp.h | 6 ++----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 71b9fc5a5796..485d55b66ea6 100644
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


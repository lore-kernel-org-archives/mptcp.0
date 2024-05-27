Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90C15ECE9
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815879; cv=none; b=ZynIsSHNeaCktgsZD/LSAhi7qf5Ngn82/RccgLNMoX2fPb9vex9D/jExGKKqVBIiCiQqVME/fTu6KRoZf9lHpH91qtbR6rOvY93uVPAjZJfyFzaOa2S8iZvXoZotLTYGiTyLaWnV6FH5On+Mn9I+zyjCLwqBnHpIUl5ODU2vw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815879; c=relaxed/simple;
	bh=mTIvgjgeufaXJBPxpbHks25Awe2EZeO7qcC/JQFYLXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D90i+UJgAjPkjoFYkGnqcNNi3MZLrU/Vcqf4zmcCNJgfAUdpZ8MCU0m+czfDWIspaNGvTKILKsXovK6wHp2cA/lLmHECdf3dlLsd9Uv85XRaXj2xu8xj3H9zzUIoMssxi33aO5IYjplGir6EoUdpmxAOX61zWQ2O/KrqO0f3ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEWETFWN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEWETFWN"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45dso3194001a12.1
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716815875; x=1717420675; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQkxxq0c8rMh99uZ/nUkNpm/TLGGhNJACzy359Jwrjk=;
        b=XEWETFWN6FDYEvOKQbY9b+8b/V+qnZSR+Fz5WN319ayyYvHx39joJ3fcuAZlVUc+r/
         S4pOdpGeu/ATN/WMkpTnwCk9zFkNG2a8isloKCjMoTMWD7LO19GnMgDT6RbgXU7jljmO
         NTKvorvkrJGjGjAQfNFBcFsdSaoNUivHu3TvNcOCn72RSjsysFPaIqz5rfuK+NP+AsTD
         P8NdwFyhr/VE92/a+Uz5NeHyAP/4s5El3MVUdR/NpZ4Gp+g1U+YIisybj0lLr5t/AOZA
         4uVr9t7STcjeRrxzWc0FWEEsgJVMjB3fhP+WLukt+0OzckRe2HxI4nTZXvq1U4mo/fko
         KmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815875; x=1717420675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQkxxq0c8rMh99uZ/nUkNpm/TLGGhNJACzy359Jwrjk=;
        b=VSnY4T2+kZx/5Q6DEi5YCdsZMIRhI3Oj3nqrl1yU2DMTuzO0Ky77yXdVx/ZhDnm/3H
         QXUFLcBiLzuTke0UthipO57T4wl3OU+j9DHRiwQXtSwRj7UslQhSQFNJIIJiRqmbO6zl
         SnMmA0zGkc0176BSKxw3PRa3ymMfotqk8dHlPBEHDpXJWctCT8QPXvrBDeI+XvsFivFc
         DjgJxvg6cDJGFfRHO9oeDGW3b3fIND3lBdxJY4OdAQU0oQvUPWKSTKX9ZYkhAKIBUbnu
         gztuSDEZUNLH+w7nIZ6fWo/8O4nHr8Tp2uLxR0EnlSm4y/vvrwUMuU1ErhvB+eYp7I50
         cxFw==
X-Gm-Message-State: AOJu0Yzongc4qonYyM5yNbeALKpupqQryQ0hbaCFLXuvwlVi899+j38w
	nF2lHeTtv/z4IRULuFwssnlfhipotDEfnazWO8okmHp3QpyeXK9j
X-Google-Smtp-Source: AGHT+IHiMFISAFPZ7XT+D55a2NJQevxXt1jaYqWbe/5JdBBcfFMxsfPUIG12C5jjVKUPMCQn5AJaBw==
X-Received: by 2002:a50:a412:0:b0:578:6361:1364 with SMTP id 4fb4d7f45d1cf-5786361172emr4856152a12.21.1716815875470;
        Mon, 27 May 2024 06:17:55 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785240d1f9sm5799272a12.51.2024.05.27.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:17:55 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Date: Mon, 27 May 2024 13:17:53 +0000
Subject: [PATCH mptcp-next RFC 2/4] mptcp: use new push callback to
 schedule chunks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sched_per_packet-v1-2-09a41d405f7c@gmail.com>
References: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
In-Reply-To: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716815873; l=3822;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=mTIvgjgeufaXJBPxpbHks25Awe2EZeO7qcC/JQFYLXE=;
 b=T68v/b+vqvJRegQidm7L7BthLGMa/83R4RWhggvL/lkDMKdemKCjqQmw9vVcLxILhzlts3IFE
 5xLC6ohEkDqC9mjg+cJucEbx4WR/q80yWTFvF63nUt/gCaLq0MdHmuE
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

This commit modifies the subflow push pending function to call for
each data that will be sent over this subflow.

Only send the amount of data defined by the scheduler. If it sets
MPTCP_SCHED_FLAG_RESCHEDULE, the function will ignore further data to
be sent. This will cause the get_subflow function to be called again.

The previous behavior is maintained if the push function isn't defined
by the scheduler.

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
 net/mptcp/protocol.c | 14 ++++++++++----
 net/mptcp/protocol.h |  9 +++++++++
 net/mptcp/sched.c    | 20 ++++++++++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f8f32cd31d3..abfd5b6748f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1526,12 +1526,15 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
+	u16 sflags = 0;
+
+	while ((dfrag = mptcp_send_head(sk)) && !(sflags & MPTCP_SCHED_FLAG_RESCHEDULE)) {
+		u16 limit = mptcp_sched_push(msk, ssk, dfrag, &sflags);
 
-	while ((dfrag = mptcp_send_head(sk))) {
 		info->sent = dfrag->already_sent;
-		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
+		info->limit = limit ? info->sent + min_t(u16, limit, len) : dfrag->data_len;
+		while (len > 0 && info->sent < info->limit) {
 			int ret = 0;
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
@@ -1546,7 +1549,10 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		/* if the whole data has been sent, move to next data segment: */
+		if (len <= 0)
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19d60b6d5b45..5e4d62bed142 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -742,6 +742,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
+u16 __mptcp_sched_push(struct mptcp_sock *msk, struct sock *ssk,
+		       struct mptcp_data_frag *dfrag, u16 *flags);
+static inline u16 mptcp_sched_push(struct mptcp_sock *msk, struct sock *ssk,
+				   struct mptcp_data_frag *dfrag, u16 *flags) {
+	if (likely(!msk->sched || !msk->sched->push))
+		return 0;
+
+	return __mptcp_sched_push(msk, ssk, dfrag, flags);
+}
 
 static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8def10abd60e..d6ff82bde641 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -193,6 +193,26 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	return msk->sched->get_subflow(msk, &data);
 }
 
+/* This is called before the data has been sent on a subflow. It returns flags
+ * that defines what the scheduler should do with the ongoing data.
+ */
+u16 __mptcp_sched_push(struct mptcp_sock *msk, struct sock *ssk,
+		       struct mptcp_data_frag *dfrag, u16 *flags)
+{
+	struct mptcp_sched_chunk chunk = {
+		.data_seq = dfrag->data_seq + dfrag->already_sent,
+		.limit = 0,
+		.flags = 0,
+	};
+
+	msk_owned_by_me(msk);
+
+	msk->sched->push(msk, mptcp_subflow_ctx(ssk), &chunk);
+	*flags = chunk.flags;
+
+	return chunk.limit;
+}
+
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;

-- 
2.43.0


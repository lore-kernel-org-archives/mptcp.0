Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C313DD84D
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791854; cv=none; b=gdJniiA+gLEdKLBdBXePNmPdCH7Ld9msgS+cQ1TYzuOin8NcEoK2IDD3u5VwUP3ivqa60RDQsRwJk1SKrod/aDtjrk20sFum2VrnaSQY0dk5rVfyK4N38OzJg9gpWSKlmFKJxXYury8Ek7XVBm+e5zVgHHoGCRIo7iEHqLN1TbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791854; c=relaxed/simple;
	bh=H/Mz2i0syySW1Uy9/x256TmGfPQMWqPEu/Q7hTbgUaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js/T6RdN2q/V27SJ59avQxFwdaf0Yb27iCzxCvv6ZgAITTxD7mRoLD2FXQUlcelHHuriB57i9QXjBFqUnZDMGPLSQYD2vQPg8dnrKWySePcEWdqjKpF9n/XB+GNhjZHkRwzzxRWWg/3JriyKTj/TC+Q+23Zc0ND70SYD+Za5Ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dewrPVJA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dewrPVJA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2be1dd4af34so92278475ad.1
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 03:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791852; x=1780396652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bFBDMHQ2xnnq5Em+OcEsJJ3acIhW+A2ffW1a7UlO3A=;
        b=dewrPVJA4+1xIHiP5+rM5YSwgcOI/OLOehjY+esO6REwKWVDTEbBlz5BhKNwHYVdQ3
         SjdDubL44Tb199/zypz0sH1J7FRBhgWdIzg3QBt1hUxgqonm5vo73R9VVV1tG2UqkRMv
         0QRLEZFw7dNprgUc3pQAUYfVlshDPMSpgCHSVQodoJGrU4VOvQNHa7cwiV42qbr0QS2M
         aYnFoXsKp6h+1Hu0p1RCKvuZ5IruBhQlt9OjJAFG3drTYhY+snLOArZFJYdBSX2HH23J
         zjtbG4MqDcxWEoqCObgxkEOHtdF3yoFOWG8HcdYzhX6q1FB/gjWubof5lVTzO6EbaqCz
         1OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791852; x=1780396652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bFBDMHQ2xnnq5Em+OcEsJJ3acIhW+A2ffW1a7UlO3A=;
        b=WKeQcbMbniuvQQtHkUn55t/ezHVNZXJnVC362WhYwu+fiYGfUssYrO5BdA65GTlPXb
         L9iuj+JIDuskgyatz/eNl7SZGSkjCD+YopP0Z8CL/iv5j6QDXT8q2awwgMWsTE2Q5BXm
         oWw/fe1JlQi80shtj7cAWk0V/JKtwzaY8k73KjyiIYYo7raPFYSBE60uJAHdfc0y4dNf
         sqnWSKsCF68RkNJSaIs1VTVfALYm4tyrX2dhIgK+t4XPAeHk7IjHjaOgiQ3xvZqRgG9M
         zPbn990tvkJFMQyfZDnfNu81vcfc+pygYu8U+1KXSB3VIPngG2jYGkUolKe5BGmMnlT6
         M6Xw==
X-Gm-Message-State: AOJu0YxpnZGveoEosIidMO46i0520r7RVPGyh74QuRbat51SOgT1D9zc
	b/+K2Z2WUFS9bjCmsev/2y/LHSp1fHyLNspr0CWN8QK5+AXBI47EODiQzACgv4hwq4M=
X-Gm-Gg: Acq92OEWDrFnapOrDgKeb4Ol6NS/MH4gg4XxWzBP0cWx33cVRu3worgi5zIj77rhrGk
	zvXqZC9GOpQFC8UASPFhgyYaR7h3jcjEPfeTeq29FUNlUDCBVqWx90qhtqsQCGIs87jVpzn5J3/
	t5FsKb8PZcAIkmx07Pbz6jCEoaRxnLw+l1xacWcMrFB7pZlUEfChIosf0ZrLEkCnBXi71NsMNjE
	pO2B8/Ll+0hqrQnuXHh5QtmXvH8UKIpL2A2aEturxiyhVhN4IJ2bwnNIxPHLUOtrsnbZv+HZTSb
	HQDF8kccRXqfWvvrqnOtZ28FdBYU4wq1pQzclJUXMG5ApsFYZxz8kkbd147VAaII6vdBYSEmWuc
	3ZIdZgzxGY2qOFH+/zXoA5S38KQF/k4yBp/8FWGkMNL/0YzySusbbD2ZkyRZWQ3DCeQ2QUwOEvO
	/zNnpCV/Hfw0/OYw4ut8MTdOUGauCz+QbEPg==
X-Received: by 2002:a17:903:2b0e:b0:2bc:7c62:187 with SMTP id d9443c01a7336-2beb06133f5mr208147975ad.29.1779791852306;
        Tue, 26 May 2026 03:37:32 -0700 (PDT)
Received: from iotshare.. ([183.159.55.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c49b2sm115615235ad.60.2026.05.26.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:37:31 -0700 (PDT)
From: Li Xiasong <xiasonglee@gmail.com>
X-Google-Original-From: Li Xiasong <xiasong.lee@gmail.com>
To: mptcp@lists.linux.dev
Cc: lixiasong1@huawei.com
Subject: [PATCH mptcp-net 1/2] net: add sk_shutdown_timer_sync() helper
Date: Tue, 26 May 2026 10:36:46 +0000
Message-ID: <20260526103647.732350-2-xiasong.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526103647.732350-1-xiasong.lee@gmail.com>
References: <20260526103647.732350-1-xiasong.lee@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Xiasong <lixiasong1@huawei.com>

Add sk_shutdown_timer_sync(), a socket-timer helper wrapping
timer_shutdown_sync() with the same sk reference accounting used by
sk_stop_timer() and sk_stop_timer_sync().

When a pending timer is removed, the helper drops the corresponding sk
reference via __sock_put(). This provides a safe shutdown primitive for
final teardown paths where timer re-arming must be prevented.

Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 include/net/sock.h | 5 +++++
 net/core/sock.c    | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index dccd3738c368..2de205e88271 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2496,6 +2496,11 @@ void sk_stop_timer(struct sock *sk, struct timer_list *timer);
 
 void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer);
 
+/* Synchronously stop and permanently disable a socket timer.
+ * Drop @sk ref if a pending timer was removed.
+ */
+void sk_shutdown_timer_sync(struct sock *sk, struct timer_list *timer);
+
 int __sk_queue_drop_skb(struct sock *sk, struct sk_buff_head *sk_queue,
 			struct sk_buff *skb, unsigned int flags,
 			void (*destructor)(struct sock *sk,
diff --git a/net/core/sock.c b/net/core/sock.c
index b37b664b6eb9..4670bc3e6a41 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3696,6 +3696,13 @@ void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer)
 }
 EXPORT_SYMBOL(sk_stop_timer_sync);
 
+void sk_shutdown_timer_sync(struct sock *sk, struct timer_list *timer)
+{
+	if (timer_shutdown_sync(timer))
+		__sock_put(sk);
+}
+EXPORT_SYMBOL(sk_shutdown_timer_sync);
+
 void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 {
 	sk_init_common(sk);
-- 
2.43.0


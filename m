Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E4622
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 05:49:58 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id 78so583622pgb.13
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Od8vlbvdGvw6tFFE7lFBLFduZJ5kHFM8WxOulBUpwq8=;
        b=BHOgpfwFyzMueB1W/8/vwU6DN4Vr7KSEXqWBurthSJAxxF4HeVCeBtRcSb9DwHkz+U
         syfA0d2fLBLKD8lW78dPVF/Bl5QPWCbo4vtR+2IXx+ZE8/8mScmFXW1tfPEUMH2I0hBl
         TLpycTxpLmDWqWXAtGNjUu2KCW0uxF17hkvvHW7+y5ZQEftmxhEUSXOpxjE72PV6P29e
         YO1uG6D4Yg+4rysBIn6zxvPMrconVlEvWFbzIeMU0CEYM+B5cVCu8QkHtkdkoeKWciLz
         Qd+aZLixm2nPZtdOj3XpNKFxRXONfMVRVhAHnVOZjPaJJjEQV0+IBpFTdUHSjveR55vC
         tPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Od8vlbvdGvw6tFFE7lFBLFduZJ5kHFM8WxOulBUpwq8=;
        b=R7lsTYRSe763M9TgR78zfEz6ZkK9Ch8D5Wz6I//PjKWxVaVsQcj3IMTrpnIfuI8+Cg
         /4NZm8tWt8wp61RVJovbR++1+dfmaiyPBve+2jo79zF+w2wT4gDPDBd5GaLr7kXEe6JB
         XYvYgrZOEj4HLPYZnyGFLN8kR680XbB0/DsE/FDODSs675v/NueEAVF4lSCiWtzuVNA+
         R3yWG4FNuRUyloo9qJZkXnF1ZLOcN4r5LFtErYQ1pncigdoerLBmuvqDM7LjhKdv6Q3v
         FR+lIN4421HBWa+jDZrUdViWtQZ91hTsjNXnxU/xyvkw/IYBytrwXZs1frkT80N4DsMw
         B0tw==
X-Gm-Message-State: ACgBeo0HIgGU2GPrKmEzGO5w3xIf4FhfsZAhLetoT0SVpnAYZLbWPPMB
	1nb5Toi9JVAzMjEJn++8yzsM6osmjMs=
X-Google-Smtp-Source: AA6agR7bYHk/e+STqtwTzovJUg7diI3QX+VlKkuKAVjBGvvUKmBgkYUvd7VE7TladquNChfpC8p+2g==
X-Received: by 2002:a05:6a00:174b:b0:52f:c4d1:d12d with SMTP id j11-20020a056a00174b00b0052fc4d1d12dmr12411565pfc.41.1662702598284;
        Thu, 08 Sep 2022 22:49:58 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b0016cf3f124e1sm492646plh.234.2022.09.08.22.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 22:49:58 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>,
	Jiang Biao <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH net v4 2/3] net: mptcp: move mptcp_cancel_work() to protocol.h
Date: Fri,  9 Sep 2022 13:49:31 +0800
Message-Id: <20220909054932.246221-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220909054932.246221-1-imagedong@tencent.com>
References: <20220909054932.246221-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

mptcp_cancel_work() is simple enough and we can make it as inline and
move it to protocol.h. mptcp_cancel_work() will be used in subflow.c
in the next commit.

Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Reviewed-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/protocol.c | 8 --------
 net/mptcp/protocol.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1cfb4f1ff4e4..d6eb033e93b9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2656,14 +2656,6 @@ static void __mptcp_clear_xmit(struct sock *sk)
 		dfrag_clear(sk, dfrag);
 }
 
-static void mptcp_cancel_work(struct sock *sk)
-{
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	if (cancel_work_sync(&msk->work))
-		__sock_put(sk);
-}
-
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 {
 	lock_sock(ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f123d450c76..9de891373959 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -378,6 +378,14 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
 }
 
+static inline void mptcp_cancel_work(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (cancel_work_sync(&msk->work))
+		__sock_put(sk);
+}
+
 struct csum_pseudo_header {
 	__be64 data_seq;
 	__be32 subflow_seq;
-- 
2.37.2


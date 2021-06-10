Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D772
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 09:13:49 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so3356583pjp.4
        for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 02:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKWLpd+1ysbicw8ok2R6Lo0tB8LvBCpWEoXfNVa/ZjQ=;
        b=STu2+Qz+nBNwuOKUvNNx6Ppa360DcDl2m25CWoArFzxxy8m8E/b4BmGRcDxwg0983h
         rgVtkE2jwHR7EYOYIDlzSDpRD+oybINr5GS0WLDD/0MGDCXDpAwDfQI0oIhzQHvARoZM
         LwFz6wQYR+dek6ZAEhBxhilKqTFLJpONrfDugSIM7IsmPSus8fBctdSnT6xdi+nOSkqM
         Ft4ZyaHCuqpOH4cQG/WrSRMCY9mZIwCJrHiVZQ9ZGCCl8JjOJr4h2PyCtyC2joHrebWA
         CwNL6ILkYc8f8fpxsw48D2dQrzVaeZoaRX6q2DDh//48yfqRD/hDrNMcal4LKcksSFqK
         FB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKWLpd+1ysbicw8ok2R6Lo0tB8LvBCpWEoXfNVa/ZjQ=;
        b=BmsHQQPfndHAVZi1XtIIa3/knBADIeMe8EfnA+B+wiQ8+jtn1SybW86hcRu4omqcLF
         5MHfimlbAtTxTA7gbXbWc+UfnFZ74X3tgFtInzZY1Z3zd7s25MpzgCRmFcfGHkmTjQYh
         lveS5G2QR3mq946TfjUcunRKU+/6c2wqLUyYY/G11vZmSQRtZyl34uEpY9dynbwsJuVR
         mtUhN04yJWyies8XRXrAmD5a9LvO5oWo0bTejn3OCYUSA778T0tyqxmGm+nKqd3ALHCM
         5yC7u++bSZG1sAeN/lBxHd36VgG2kf6XMto42Og54SvXU80kqqcutRthHE84VtlaZUaK
         Idig==
X-Gm-Message-State: AOAM531vFcU549UaVZIPP7hvEbzIas3i5VZ/QiFS/1Oem15MqGBdkxPw
	sT8IxCri8D+Ubi3odGICLtp4UZWyy8unJg==
X-Google-Smtp-Source: ABdhPJyBMzSNWV9+nDeywVO0DQjIKnIZjGkhAk0KM86MbeLOK3fxEdKpDkradVNy3zXFHhG/48uEbw==
X-Received: by 2002:a17:90b:ed3:: with SMTP id gz19mr2446925pjb.214.1623316428863;
        Thu, 10 Jun 2021 02:13:48 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id m191sm2015733pga.88.2021.06.10.02.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:13:48 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add deny_join_id0 in mptcp_options_received"
Date: Thu, 10 Jun 2021 17:13:35 +0800
Message-Id: <6670b769c9c6129d810282c3c8bd65e3317b1578.1623316231.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the deny_join_id0 test into check_fully_established as Paolo
suggested.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d30008f0313..63c1e18d61d5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -910,6 +910,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		return false;
 	}
 
+	if (mp_opt->deny_join_id0)
+		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
+
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
 	mptcp_subflow_fully_established(subflow, mp_opt);
@@ -1051,8 +1054,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	}
 
 	mptcp_get_options(sk, skb, &mp_opt);
-	if (mp_opt.deny_join_id0)
-		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 
-- 
2.31.1


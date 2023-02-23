Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37032564
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 11:20:13 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id t15so10507989wrz.7
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 03:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytwl8Uf1FJtazs13lMzaCYQJ1Z0mJwiy3yXcLKeUEKw=;
        b=wuHl/2NAmbadodq0cQbjwqydjGGzrxt2GcCkJh9dNBoAp782AUvGCEpuf+bzwbWys6
         RQYnUmYivjLYLFhu6qpA+AgXmFYsQ+uJ5Ch0yalEG+55ppGQ4f9ea9+qYjQMNGfWpcyd
         e2nSkkEvD/z8WbXUDBqeZ55fpqDO2SSLU6bcRBJpRJCg5qolzEupCokOJOxH0JblrK8E
         svc0Dxx12p6wc5LacRSu6TWpucE71PigMLB4APGswMnxeHIFp1TGtML50dNNS9Js3T6w
         FgFLfASkvnNcYpqPO3OMpJLjJF8YlIrEQGzrtVZGkmYdy5z1D2M55kpNIGyOTvtecOc5
         04lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ytwl8Uf1FJtazs13lMzaCYQJ1Z0mJwiy3yXcLKeUEKw=;
        b=NRVqTx7PLFIoqv9xAoIFlvMEG3Jpvv4WHLSjsOALYfkzy5ydgO0gVFIlrLNsKJF/vE
         gdQSekfIzAcpOEbUQIAqIaIOWNFjMUxePgPfASXMQkaIXfkoA3BLPXbuYOPJ2egTeFfw
         6ccUBjzuhijKS+Ld5I/X4oFHTyxSwHYPv58repiC/6UBFeaqdFN9bAImERWLvBaJOMcV
         BtnSY9xpnlGnv9mK2NDfSkfBWNRO1q7hKAABv0F/EknhJd33ONSW2jQ6qVCD2XpBgTIw
         Yiamm9oFAjzQqMp/Isjc2FQzQuiEWf+/yEFv1tNFqqoVx9mR5GW/xajlgrbGCReRtI0Z
         V+BQ==
X-Gm-Message-State: AO0yUKWqrNW7ELPP7uHHs8w2mKTRl7+QaGcGpFq9gcg9s0pvFAq25Uv4
	xGQq0GOyvX6/e5cHBz+tdDSkQA==
X-Google-Smtp-Source: AK7set/NrelozWjqRbv2TrnRzltl3KvZwBju1Ea0w5BHmc44Zz7nNRK6BSDp/41AGeVz5OWIAzywmA==
X-Received: by 2002:adf:cd8c:0:b0:2c5:4f2d:d9b4 with SMTP id q12-20020adfcd8c000000b002c54f2dd9b4mr8933483wrj.58.1677151211440;
        Thu, 23 Feb 2023 03:20:11 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm11079512wrp.44.2023.02.23.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 03:20:11 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 23 Feb 2023 12:20:08 +0100
Subject: [PATCH mptcp-net] mptcp: do not fill info not used by the PM in
 used
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-mptcp-diag-info-limits-in-kernel-pm-v1-1-699561f9f9f4@tessares.net>
X-B4-Tracking: v=1; b=H4sIAOdL92MC/yWOywrCMBBFf6XM2sE2wQr+irjIY9IONtOQRBFK/
 91Ud/dw4XA2KJSZCty6DTK9ufAqDYZTB242MhGybwyqV7pXSmNM1SX0bCZkCSsuHLmWtvFJWWj
 BFHG82KDteB208tBM1hRCm424+XDV8yuVmsnE40yZAn9+CXf424UqPPb9C8sG1jydAAAA
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=63abynn6P2YMPag/1MLy+SRqT5wQGnLtnAgwJvxFLsw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj90vqctDu5eQVlcf58SR/DvASCZ23dihqzmggZ
 hF5Zib8DfeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY/dL6gAKCRD2t4JPQmmg
 c+gQEADA7S3OSp13GTlHtmAU255e/rUdN50opakGGKBUzq7Z6xEDRpP5HZ5nS0wZcARP4PbXNcR
 1xmBQBkKG36GQqk37SX0sF9nnDzR9pypyF+YpULPnWU4wWJT8iFYfH0oAF4bsVK32CI8SCPCZ64
 bcuX0XX/8agpvErOao0iijOTpyHQ4NyPch0ynDNcJcGVF3FXb+li5S1cW8XfwX6AjvPvE7OrjVO
 Y73VTT9w59UGtjpMVoH6InFV8Gn0AvUMkM4IjSRVOgP59uFh5dBQo7cLkb5+6Qv8N9nBwUbaGhj
 /GxeFgathe4kQgVuNN5BevAKZYLJ0vyRqauNuDMe9d+S4ZS9A41wfrcU77FW7ZlosY0xdOX+FZE
 d/IszJj5sXknmV9BaV1FJiE+ivNmug9KdMIf7vr3PXQm4efz6XrJWwQo/IZfu9wvvGEW/gvwdvh
 JNWX37g3SPDif9sbP3P9VnMBtog8+uD5+u8ewG7aDtY/mYCwaJvMzsExVUfhzSNqHZSdTi3oUqn
 Bf2xsVf0GRU8Bg6y5t6g7JOYSvo0px0On7NTbEkNLUIuUkatbiDDchy95SPyb4WbaRBXKQJ+0qy
 mq2YHodT4lGnXdFEPhoipmgutQEJXABV3DU2Wid+6uMbsnh//Yel/IBSZAVnmP5m4s9imBO/li6
 JmkQIgxozc+i59Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Only the in-kernel PM uses the number of address and subflow limits
allowed per connection.

It then makes more sense not to display such info when other PMs are
used not to confuse the userspace by showing limits not being used.

While at it, we can get rid of the "val" variable and add indentations
instead.

Fixes: 3fd4c2a2d672 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f7842a0b6536..fa1e72235f28 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -889,7 +889,6 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	u32 flags = 0;
-	u8 val;
 
 	memset(info, 0, sizeof(*info));
 
@@ -897,12 +896,19 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_add_addr_signal = READ_ONCE(msk->pm.add_addr_signaled);
 	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
 	info->mptcpi_local_addr_used = READ_ONCE(msk->pm.local_addr_used);
-	info->mptcpi_subflows_max = mptcp_pm_get_subflows_max(msk);
-	val = mptcp_pm_get_add_addr_signal_max(msk);
-	info->mptcpi_add_addr_signal_max = val;
-	val = mptcp_pm_get_add_addr_accept_max(msk);
-	info->mptcpi_add_addr_accepted_max = val;
-	info->mptcpi_local_addr_max = mptcp_pm_get_local_addr_max(msk);
+
+	/* The following limits only make sense for the in-kernel PM */
+	if (mptcp_pm_is_kernel(msk)) {
+		info->mptcpi_subflows_max =
+			mptcp_pm_get_subflows_max(msk);
+		info->mptcpi_add_addr_signal_max =
+			mptcp_pm_get_add_addr_signal_max(msk);
+		info->mptcpi_add_addr_accepted_max =
+			mptcp_pm_get_add_addr_accept_max(msk);
+		info->mptcpi_local_addr_max =
+			mptcp_pm_get_local_addr_max(msk);
+	}
+
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
 		flags |= MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))

---
base-commit: 7264bacd354401e60be232ea28eb4a8a249937e4
change-id: 20230223-mptcp-diag-info-limits-in-kernel-pm-65bf3b67132d

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>


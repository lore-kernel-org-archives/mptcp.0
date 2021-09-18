Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E872
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:39 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id g14so11383991pfm.1
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIUuvixQDyQPRkmzFLt6CKToocq/GjmTzgW70ffvtjw=;
        b=fPEuclTtUQUQVR5UfEWA/O4riyI3VJ/wi9eJZJeGOYcSqQcF8R7o+PA0kUsF1wUSlo
         ye5cz5ON8uKbxXxc8ojFMGTArbvLfYUUkkD7j3SLJUAtZ/wqGl8MoKneKpqdjfAlo61C
         45QUb7Ly8uC4z8/UxBfzD2LB6trV8rm6ULhJJighyO2WxI0pDgc3ucaFOGLG84ZyfAII
         Ffq/GQj+Vdv6haoBFgVm/XBOYBD+9fSZe7cxW7AnpIQmydBWGhw7UVjfveiGxYVz+WL0
         cncXIgXYNf6gnEm36fX6Z99Lh5jxa7mpXE+M1WeFYk27nnKgixsQlNWznQ/T2lErsXaC
         K5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIUuvixQDyQPRkmzFLt6CKToocq/GjmTzgW70ffvtjw=;
        b=wnAVxBjzFzep0n0c/kbEkocSPEvHhs5YBXVIbhFDDX/edDFQldavl8sqZ8u5r51xb2
         1qx2lRrROVfNWV33J5DoNl4rRc1bnTD8yBLdh1t9ytGgTIwToCkgT3SU7Y1hGlqEhbuy
         KPtBkh2nqRpswV6PSmvP5RNlOCGwnSUMOoSYd7qnc31pDb5SnhGC2Zk1IX8orQ+LpWWr
         JLkPI5MuUZq94Wx06FijxHyaWhHvPeZe2V/UIqvxUDE+R2xTxNXZFN3gU///m2c1DbJ7
         iy+2z8A1IrlUVrcAvAZsM0PAY7//YOjGjFk4blpmXmf7/T5gG9Hi34KiXDnaPwLPx2Lp
         pXiw==
X-Gm-Message-State: AOAM530kNwRdx/d4wQe2qa7W0ttmgXxTtj2jXwdiWIBI+V4njn+IC2ZS
	i3DvwLX6Ft724ieYCCRD/uGnuJoyIFM=
X-Google-Smtp-Source: ABdhPJzTayxKMS172sArniUxa0d2JG6Uk8uU+u5E3g5Q+dhPHKsboCHtHuon3oQ9IQ/MFxPQXIibpQ==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr13561519pgm.56.1631949758837;
        Sat, 18 Sep 2021 00:22:38 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:38 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 5/8] mptcp: infinite mapping receiving
Date: Sat, 18 Sep 2021 15:22:20 +0800
Message-Id: <eb481f8f346984367adf1fbb37b15f13b0280b60.1631949480.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631949480.git.geliangtang@gmail.com>
References: <cover.1631949480.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the infinite mapping receiving logic. When the infinite
mapping is received, set the map_data_len of the subflow to 0.

In subflow_check_data_avail, only reset the subflow when the map_data_len
of the subflow is non-zero.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 89173f70707e..fd44996a7b9a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -968,6 +968,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	data_len = mpext->data_len;
 	if (data_len == 0) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
+		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
 	}
 
@@ -1180,7 +1181,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (subflow->mp_join || subflow->fully_established) {
+		if ((subflow->mp_join || subflow->fully_established) && subflow->map_data_len) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
-- 
2.31.1


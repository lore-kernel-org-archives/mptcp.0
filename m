Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07E3FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:30 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id r2so1499712pgl.10
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=usGLNHapEGqI0MbD8ehVTyV2St5+TU0bTMCbDp6z4R8=;
        b=iMTik4vzmXfXT9oPtBm74CHmN7O4ygrAC/jWQTf3uabWP/85KMyVrTVeuFJWvuwqi/
         kffOYmSn92K8ajxCb3I22CJq/dxLttHxmDZFah6CZpNnzLe9YCKPf/yOhzbyUl+pKGti
         fHEZKxYaIXT5AJ6AAgmIR+j6CUsAdVf81lu8C/Uuvyjsd99NJOp01fi902c8MuUeW690
         AgK4uuOSLV0fr51hgxtz5lzGMauvX+hbcX8TANMedgOH7aysqmSOdcLZpV6bJIYBck0o
         Z/3m/OPDHEWC+Q6ic9IORq2TEceVWZKnaMOAYKJMDpkPBcfZbY3rY3trJYP9wDm17yvg
         RMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=usGLNHapEGqI0MbD8ehVTyV2St5+TU0bTMCbDp6z4R8=;
        b=Z55REg2mI8wpr468Ch990MC34srjgM5SBQSk1eqLJY+gas4j4GoAXI8Fb4Z3aCk6Y5
         Bree221597jgkoMC0aNoz4uUZ/nyeKyF3YE/txwMQ+UAWsqyMupVd41cittqkZHiCBT/
         UsHlHm6gA6gvCIwyRbfM7Wd+uqsWYyLWCH2tElW1R8sCfZa2neuZUZTERN03nJGgRuIQ
         GtbU/ccb0KEYEhM64qda1Fe4F88O8X14PS9fMwWUpdWaxGCsj2jfRUoqc5HQ53/MSeST
         vEJSob5WRGT9+l/WvCvE0fmZrb4GnsZHh83bNn4g/pQgl3VO1Cp2RYi75a87zX0wHMIk
         UBZA==
X-Gm-Message-State: AOAM530W5FYVO4zVlrjWp7kTOriRHkoCCk/7RkoSGpHj+nn2ow6wGbGW
	WlY/644BIrHzYUKt7JewP4kc5ods7OI=
X-Google-Smtp-Source: ABdhPJwYjegcbMHiC3vn8Nhpg8fixtloRJH/GY5/WB5WakYsyFkz8pI5XKOnYUfvSdXhuYlOIxOhXw==
X-Received: by 2002:a63:f62:: with SMTP id 34mr2270537pgp.159.1631188289649;
        Thu, 09 Sep 2021 04:51:29 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:29 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 6/9] mptcp: infinite mapping receiving
Date: Thu,  9 Sep 2021 19:51:08 +0800
Message-Id: <945fdaa82c817feb705da45d0b1597c7d8a5533b.1631188109.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the infinite mapping receiving logic. When the infinite
mapping is received. invoke __mptcp_do_infinite to set the
MPTCP_INFINITE_DONE flag and return MAPPING_INFINITE.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/subflow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ad8efe56eab6..bf535cc46c5c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -972,7 +972,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	data_len = mpext->data_len;
 	if (data_len == 0) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		return MAPPING_INVALID;
+		pr_infinite(msk);
+		__mptcp_do_infinite(msk);
+		return MAPPING_INFINITE;
 	}
 
 	if (mpext->data_fin == 1) {
-- 
2.31.1


Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC93FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:24 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id n18so1494531pgm.12
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rZofg3zZ4rObox/1x3Gt/v2FA9F+9fmvC9V3SByl5Y=;
        b=eJiA8yKgxrGsuLcilIotHEYPqixqwcFHP1n51ELa5Vy67Dlm2Oy3/OM4+pmjETs2Zh
         fyxvtlrrxZJtqL7hHKMjfaFahG1ed1vgrp0/4zs1cAoVXszyfEghW83z7iRr4Pvexbvv
         oZSf9gguNuB2BQrNmKuXOTogkOrcgdqKv7BXsS5iEJXgCNphjpa2s3hts0zJnGyrsLiI
         tEKYwTWJIHSX50tBBNtzRzFoOdw7tO27vKcYLKV3IAgVHFaBI+5nvHcTHjGrK3+YoJn7
         6duNZt6E3oTyQgi2lP4aDyYco/1O1JwuXXI98WmudM0HYfZhMmfF1UQdATUUn/zNNQhW
         kosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rZofg3zZ4rObox/1x3Gt/v2FA9F+9fmvC9V3SByl5Y=;
        b=uw3iInxZ3WjqKNvRHB+CcQ7Sfn0tpglVEgnGIS7HyttwIrv15Nc8JGX9hD/aXJ0oUT
         kKAi4ImmxVYBQvFhjOAz7BH9Ac9ggrCMuPTETqUFZYGH/GKOjMNx/Vto89WW0zpbTCaj
         aCKq6piL6vcqVJUTxDLwfxXe1qxMGRE/1pzfjQRVsZ9kquzJnj08ofXmtu1fGs3MthJ1
         bnLES7k+A9osrP9NLToKvk+tpk54f/MxLvOdXnNyOikfM0/i5Pq0q3hKYLPVkjwVcOXQ
         tv7BGRxDpBLaT7MXaQqG7AwO1Pem7BX4oo7H8hMd2MZKTKG/tgpqd2FrZo4N/4p6eifa
         nZ4w==
X-Gm-Message-State: AOAM530Asl3GEhvKmL87bJQNnQJgya3jkhtvBxyz5gUYnHtIC8cihFY8
	ThCjlnvOwFz0Gk31SA5Dn+YzQJL/FwQ=
X-Google-Smtp-Source: ABdhPJxWvx1dQeotfej9FEPlbmNDK0yVlk6ysp6suH8R5wH4RplMAMnbqbj4f6mmkMbqDolScwDEFw==
X-Received: by 2002:a63:215c:: with SMTP id s28mr2313107pgm.99.1631188283951;
        Thu, 09 Sep 2021 04:51:23 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:23 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 3/9] mptcp: add MAPPING_INFINITE mapping status
Date: Thu,  9 Sep 2021 19:51:05 +0800
Message-Id: <592427b5a91d5e64e4b96c4c8b8d06264197f1c4.1631188109.git.geliangtang@xiaomi.com>
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

This patch added a new mapping status named MAPPING_INFINITE. If the
MPTCP_INFINITE_DONE flag is set in get_mapping_status, return this new
status. And in subflow_check_data_avail, if this status is set, goto the
'infinite' lable to fallback.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/subflow.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 951aafb6021e..ad8efe56eab6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -798,6 +798,7 @@ enum mapping_status {
 	MAPPING_INVALID,
 	MAPPING_EMPTY,
 	MAPPING_DATA_FIN,
+	MAPPING_INFINITE,
 	MAPPING_DUMMY
 };
 
@@ -938,6 +939,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (!skb)
 		return MAPPING_EMPTY;
 
+	if (mptcp_check_infinite(ssk))
+		return MAPPING_INFINITE;
+
 	if (mptcp_check_fallback(ssk))
 		return MAPPING_DUMMY;
 
@@ -1121,6 +1125,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
+		if (unlikely(status == MAPPING_INFINITE))
+			goto infinite;
+
 		if (unlikely(status == MAPPING_INVALID))
 			goto fallback;
 
@@ -1192,6 +1199,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		return false;
 	}
 
+infinite:
 	__mptcp_do_fallback(msk);
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
-- 
2.31.1


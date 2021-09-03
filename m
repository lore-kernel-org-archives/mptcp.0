Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41B2FAE
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 08:15:28 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id 18so3709430pfh.9
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWkgtNDpnyExH13Hh1PginhvBOJh7Fa7+LbLl4HfK3s=;
        b=KrLPK8giKxGGAZiQedOtJWSyubk+yJrxB+NV7wImo39rlOGFARirSa61km/W75BMp5
         oNGzv1OJMho1G8wLu/8XvJoaRQ3ZQ/BJ+iDRHws49m72ZmKxIq1mzzbAo8Jgp+3vTMgJ
         ohELz0JM17mu8cI15XYKyYP1dq9hxKhhsrHJRPBmxFHeevKxTwhea0sAaYTbqSJx6onB
         KAW5HUCZk6T9jCGyXFJcVKEkeejLWJ47xLfUaWs2pkAz5AFEZZnL0+wpk19BlPooVeEQ
         CMvt5oYcIGTqPDYVZZQ0DxO//+l57HykeXHJl9wUYcQoRMIVV3Kk5GzhVFQfuBrLW5dz
         +L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWkgtNDpnyExH13Hh1PginhvBOJh7Fa7+LbLl4HfK3s=;
        b=cN+XraMJ/QJNXjGJD1sTwDSSuYiXMNNdxfasqpVPdyzpq5ABtfwsjqanlSEDpakORc
         1U9U494tErTnJ1zdN7WdUgjVzLrS6hYfG38anLPb3zZevVL4fT7/rwzVX88sGiyhJThi
         09wZJ6wHNryngXS/uR6T/LZ2MoQFlm5ALWAyDLd8b98WGOGTPfwNsYvIGwLkumUMRKaU
         3e5fyLoNDO+SnAOLjdr7NIoXH2m7knt6CmFQLcMsqOG7UlJxVK9dvc/Lgd1BWU4yw6qq
         zTPIVuDP3JmaVHeJqu7TlihzRQmSL3dl01wZ4Z23TiMscs+Z19JunsypCSqCvqLHr8Ya
         3wvA==
X-Gm-Message-State: AOAM5317EPiMYwrJnnuJSc5UvfHQ2wWfBtr7mLLqnDyAqsI4zg6hNjEk
	I59aaTgje66KiPBiFXp5Ns1PNd2IzTg=
X-Google-Smtp-Source: ABdhPJzuptyB52kqVnIu6IcFxDE/glb57jwkZFMjqFsMFERG4RU+wssVnRetciljjCPKHfAnix9rPA==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr2518839pgq.300.1630656927787;
        Fri, 03 Sep 2021 01:15:27 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id j6sm5254452pgq.0.2021.09.03.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 01:15:27 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH RFC 3/5] mptcp: infinite mapping receiving
Date: Fri,  3 Sep 2021 16:15:11 +0800
Message-Id: <3a3eda61ce3b885b2c43cbe63320ecf068bf8267.1630656206.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <7d43c0b1c5f336641d9c8edef80cd0e37b93b668.1630656206.git.geliangtang@xiaomi.com>
References: <cover.1630656206.git.geliangtang@xiaomi.com> <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com> <7d43c0b1c5f336641d9c8edef80cd0e37b93b668.1630656206.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the infinite mapping receiving logic.

Added a new struct member infinite_mapping_received in struct
mptcp_subflow_context, set it true when the infinite mapping is
received. And added another new struct member infinite_rcv_seq to save
the received infinite mapping sequence number.

In subflow_check_data_avail, if the infinite_mapping_received flag is
set, fallback to a regular TCP.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 33400fcdf1b1..ad26e7c0a18c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -433,6 +433,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		infinite_mapping_received : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -449,6 +450,7 @@ struct mptcp_subflow_context {
 	u8	reset_transient:1;
 	u8	reset_reason:4;
 	u8	stale_count;
+	u64	infinite_rcv_seq;
 
 	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index dfcd84abc13e..95ea01694bb3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -967,7 +967,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 
 	data_len = mpext->data_len;
 	if (data_len == 0) {
+		pr_debug("infinite mapping received, data_seq=%llu", mpext->data_seq);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
+		subflow->infinite_mapping_received = 1;
+		subflow->infinite_rcv_seq = mpext->data_seq;
 		return MAPPING_INVALID;
 	}
 
@@ -1179,6 +1182,20 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		return true;
 	}
 
+	if (subflow->infinite_mapping_received) {
+		pr_fallback(msk);
+		__mptcp_do_fallback(msk);
+		skb = skb_peek(&ssk->sk_receive_queue);
+		subflow->map_valid = 1;
+		subflow->map_seq = subflow->infinite_rcv_seq;
+		subflow->map_data_len = skb->len;
+		subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+		subflow->infinite_mapping_received = 0;
+		subflow->infinite_rcv_seq = 0;
+		return true;
+	}
+
 	if (subflow->mp_join || subflow->fully_established) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
-- 
2.31.1


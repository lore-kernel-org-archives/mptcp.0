Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802F3FC0
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:58:19 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so3791437pjr.1
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbR46yEwetFmr74l5qKWaXcQ1UG6B9A96OmGxbAsp+o=;
        b=EbAXcCQyGZkW1eTrx6hA5ZWski00dP7oW4O3iP9EhaQPLJvUTHQbVOJntpPNCo8IkF
         OeFLIiBeOB6GxXGeZLKfuAt3jvaefGz7T3nko8TzyAGCGT4m2PrwgrGBh2l53/sL8sLu
         e1u7PVHLzPyGY3DffM2P4QJmG7+NG/s3WMIJhoIi8QCzW15bfPC9DhCWW93NRFU4+Anp
         6z8oP+Ulei0iWC/mcnDSDHv3S+yJrxNiXwQMqmMeZRYd6qAKCFhHkOmKIAmwXm4HYzmE
         18PA1EaFXxOP1vYguh5M6n3QMaObOFlzQQC8sMft9z5U5RhlhWls7uQ345eVSrxgYusg
         oSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbR46yEwetFmr74l5qKWaXcQ1UG6B9A96OmGxbAsp+o=;
        b=DpKSDSV94T3Xq4ub+MismtJq85xSPcD2aTJWL01Le5br0H9chT2eJoNwIyN52rRokv
         8MiR7JcnFSbHI7+w1EpuObu1L9T7V42YsyRESE/RGOg+uqpZaOO/5GjKa9GB01LlxMy2
         jC5QxwNuNZUqU2CWdJ4LYwDH4NA/D92QQeqmDKvssiz4ZwVnwrf5ku/jNwKQ21chu2Jl
         rZklUndAASqY/RN0AuavJAgNBga/g9v6Zqi1fZRcJJekDpZt+gF1Ken9SjXib6V8WWUl
         Tu762H+hNJdeC6Q7XTThuHp4g/d7Oe/8ZRfg427ZhJH/MIN3UAgeg0y5c0mOKOlcBkv/
         FcxA==
X-Gm-Message-State: AOAM533JfqYvJsgxN+7fENbEcKIT+gOxJH8LGjYLVl70i+N+DVeN01lw
	5niKv0aWL7e7jG6XvrEuRr+u4Od80yU=
X-Google-Smtp-Source: ABdhPJxEWCmkz/FTKK66MQGKkHB6pVa9sd089KzSAOhvWZAmWahpi0h5D5SQWy5uOYODSQU3sk/wXw==
X-Received: by 2002:a17:90b:ec9:: with SMTP id gz9mr12642609pjb.24.1630915098998;
        Mon, 06 Sep 2021 00:58:18 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c24sm6895702pfd.145.2021.09.06.00.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:58:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next 4/6] mptcp: add a mib for the infinite mapping sending
Date: Mon,  6 Sep 2021 15:58:05 +0800
Message-Id: <792d3d4c024442df1eeac2d24e200ec34ac47cbd.1630914699.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630914699.git.geliangtang@xiaomi.com>
References: <cover.1630914699.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a new mib named MPTCP_MIB_INFINITEMAPTX, increase it
when a infinite mapping has been sent out.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index b21ff9be04c6..ab55afdcae22 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -24,6 +24,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index ecd3d8b117e0..7901f1338d15 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -17,6 +17,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3082eb367df2..b14023301975 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1276,6 +1276,8 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 
 static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	if (!mpext)
 		return;
 
@@ -1283,6 +1285,7 @@ static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_e
 	if (READ_ONCE(msk->csum_enabled))
 		mpext->csum = 0;
 
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_INFINITEMAPTX);
 	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
 }
 
-- 
2.31.1


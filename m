Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1272
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:41 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id 5so7673424plo.5
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+qxyKPW8ZC4W3uJszHT4yzV3jvmjQG08/9CQjKZ5/w=;
        b=XuAGYAIwgIV9Xx1CwuhfMvU7iK2aw0tE748E8XO4syuxcZeaRJxju+pS9kgcG+4nmF
         hZHTHiH8KY0wsyp836gTcyjRShl9tR93ZkCWV5CweoDp7A4bWm8v2/OMYKnATlB6In0g
         ONEAJqjkFZFA3TiXBilmcTI6Kxjd7qR5UKjajHIgMomYYam/nMKC468Gk+I/z8I7KrcQ
         irYIT7sA4zK7C2gEUu0Iv6NKZinI/sbjpzvxVj1Iobb7lkYfgRYxCqtbGRoGqSrZvCUr
         TDs4L+1exx6NEupU2d+bCZyfWxGk/fLENpyYPGKXzuhlzb8HEodKsT5PosuBUXwzIeHw
         AUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+qxyKPW8ZC4W3uJszHT4yzV3jvmjQG08/9CQjKZ5/w=;
        b=fru3AzdkGs31q2g7szcRCbEwvYGd9Tl4pU0puOqbEv8+Tv7ePs8fgdfFu2H83gqr1M
         E4GaiP1OAM17dwMqvqMJ6qSN23bZ9JMcomALb5ollvsTUJU71iDkkikiuTHOfVlrLlyK
         CbpQE7rN72qXRPY+bT15GBrKXvzYERLMIWqKcmgyAH0bwyNL/N/769rI1mCw3+6Zc4Rb
         y/JEp2bYcVCfIBFQ6EGZZHF3H0ZBUO7h1NIDEhuNxI5fWwjUrK1PkMr4vNU/fnPElpQk
         USYdODUzgCaLbLlBfOJr2RXKzIpnhWVXmsdDDfUOX+QMxsaMBiS8myD4IsuaElm/7NH6
         wCcw==
X-Gm-Message-State: AOAM531fNhQD0+WDb4vEA0GBDN0E6bnwerhBDS5TQhA3gxQACJKX1yDv
	9lTRmIf4LUCHNppkWlLFb7elUGR+7ZY=
X-Google-Smtp-Source: ABdhPJyOtvxLzJCpICQaKr1sfqxuDbUEWO4ss9XwsMBgeZoAG9lUsgqZa7wIG38GXkJjqIQYV7LeKw==
X-Received: by 2002:a17:90a:5511:: with SMTP id b17mr16938354pji.222.1631949760541;
        Sat, 18 Sep 2021 00:22:40 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:40 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 6/8] mptcp: add mib for infinite map sending
Date: Sat, 18 Sep 2021 15:22:21 +0800
Message-Id: <e7b29aa5b49e9728c8e83d46322253799491227e.1631949480.git.geliangtang@gmail.com>
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

This patch added a new mib named MPTCP_MIB_INFINITEMAPTX, increase it
when a infinite mapping has been sent out.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 1 +
 3 files changed, 3 insertions(+)

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
index ffef7e1f061b..d035119b41cb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1291,6 +1291,7 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
 	mpext->data_len = 0;
 	mpext->csum = 0;
 
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
 	__mptcp_do_fallback(msk);
-- 
2.31.1


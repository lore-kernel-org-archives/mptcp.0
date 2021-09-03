Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD622FAE
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 08:15:30 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id u6so3752656pfi.0
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJkLgOCoLJ4zw2xOzlXKs1iw7sdJh1E21hL80qTUNj0=;
        b=fC25G8dYC+R4P7PqV3PzwhR136XOnFxSmlw5yK5HIE15qrOT4Z6LIDhMgUBvUHNLcz
         sYo+xW0fR+azhqmvXktKdOEKmuP9NBVh57f0lS2Fep2Hxx9XEXOf3TBEHas8YL0FQls/
         HEsr3jsGfshbtnn/MDG5zRcm70jyl1qc2/QT63zm/jKkkXMDHiaLppfKj+xKu9ciCcWu
         gy+8B8AZObArL1SQGmmIz9YfKDAs+qee+Kxj3IQ9q2DwC4Lt3PMvwWrN+LIiU+c++J20
         Hdrqw9x6bR/bemI5pDVRkhTb2eWyy1Dt/aqKPGvRx+1eGo4moZVODtCEsCWIP5cNuP9C
         q3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJkLgOCoLJ4zw2xOzlXKs1iw7sdJh1E21hL80qTUNj0=;
        b=babH4zt95rvkpQ8X7i+muEIpTcdvNgO3KjkqXtQg+IVstoq5JXZZXZuH0koiVT6VwQ
         wvVRyS3ybq6i6xbPWSwzoyYcNFTniqntWpQklxUAWEojUt1M27ns6BLlcfBvLfVWEOEq
         SuKmiqGvcLa67O2lq2LFJOn/Qn0SMh4kQUE6HW1sJlsFKCC0oyY1ybO4mi5euyUlcSFu
         pkdnhJyzRROljqNHFITp13fG4/yEQSFH5l2oEchJNUSj0HSThrDg6qB3HfKYOdlBMbJi
         kemyxSKVtfovtMX11SHEv8h69Sk/mupGJCaGIfNQjpZAJZmeoFxpBakiGzlWYYxXMTsL
         dLBQ==
X-Gm-Message-State: AOAM532n/KbF8UgoeXzsLpkXFOqXksTImnihcqjwZZHzChvamwkHreCf
	4FM+LELJeV/GMpotm9JOqtx7ngqQAkU=
X-Google-Smtp-Source: ABdhPJyc0iTpTxQh6I3+VqXgARwPQNJ9ZKFgZY7KfpLqFAbu4RWRZIEwBl6KWn7nO/0pvtcwnCxvfg==
X-Received: by 2002:a63:3245:: with SMTP id y66mr2467293pgy.443.1630656930194;
        Fri, 03 Sep 2021 01:15:30 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id j6sm5254452pgq.0.2021.09.03.01.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 01:15:29 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH RFC 4/5] mptcp: add a mib for the infinite mapping sending
Date: Fri,  3 Sep 2021 16:15:12 +0800
Message-Id: <8c484be5b9db1c3b81690bdba044042f57bf14b1.1630656206.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <3a3eda61ce3b885b2c43cbe63320ecf068bf8267.1630656206.git.geliangtang@xiaomi.com>
References: <cover.1630656206.git.geliangtang@xiaomi.com> <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com> <7d43c0b1c5f336641d9c8edef80cd0e37b93b668.1630656206.git.geliangtang@xiaomi.com> <3a3eda61ce3b885b2c43cbe63320ecf068bf8267.1630656206.git.geliangtang@xiaomi.com>
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
index dd7738a6b7f5..4987909991cd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1284,6 +1284,8 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 
 static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	if (!mpext)
 		return;
 
@@ -1292,6 +1294,7 @@ static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_e
 	if (READ_ONCE(msk->csum_enabled))
 		mpext->csum = 0;
 
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_INFINITEMAPTX);
 	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
 
 	pr_debug("infinite mapping: data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
-- 
2.31.1


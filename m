Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69F3FCB
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:23 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id u1-20020a17090ae00100b0019ec31d3ba2so3583754pjy.1
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tuwqbiF6/k1+Q/wz49ROuB/yxwKpmTAnGTACC3OY5y8=;
        b=GLdcZmQGcmOf6OuP0GUlg4XQ4dGtxLmVsejTD6rL7OwimFTr0ls8k08rV11ShBnmJA
         8fkQKS5cEHGliTJ+HbQHMZcXFZhcAFdcgTWvuC+n23pOtnTHTPS+7M1kOtpg1tj0xhC+
         tZvc+w29oiMWOE8s/beYFtBQ6kM2ppGO6V6a5y+pu63q3L5AbuXdjZBxMXqcYXM6vKBq
         /Bh02viu9xZ9Akjcf41yRCSaCdbEmHL9nmUaAXqGkuJ4Vhi1ph1f/jwKRj/Iwj/7O0WG
         JtHsi+ukIadHeCf+hHbypnXBoxYeHy+2gUi/77MgyK6teUqutO9fFrVy2//FEtVW/1e1
         KnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuwqbiF6/k1+Q/wz49ROuB/yxwKpmTAnGTACC3OY5y8=;
        b=6mZi07tALDVkm3mX3HMNkJKZU2irZTCgkEW9hv5QxFpzPrNwz9rkj0me9osvZ15UhP
         bL6H9BmUguIA1q3nR3gd1GgLp77gCbYMnuZKxpIIc++VZbKCSLyXxTn7bzz+7U9jMTfX
         m0lf1JLivKugVE4pEQQFXAA/iQhgK8qWO+VZyvOcktuq7D0qP6zMdX54QHEOFawQbjNk
         xm01lWjHNYAdLMmnqKiIygZdQ3XjW3JCr6aAkiibZ6S5PoQrSlUTWkWbESI/1LwTrHoM
         G3AtzDfxPtp8sjtINiehqowUdEpUQXgM0jdYtCvJ+1zeKCZM94InDHCDKUJO1NZwXcn+
         50+w==
X-Gm-Message-State: AOAM5330pPuHwho4OnjPpL1RgTMSHVP15/OdBeDi1TH0kVacegaYeKm5
	PoymEZ0oQGrdQses2igpz7NSK9xABB21Iw==
X-Google-Smtp-Source: ABdhPJxRkpCzjwD+O5LY6U/nukuxEn81U2cNcQnR5ex+pi6CC1DKGl6d8BK49/78v2PjSLUc2WQakw==
X-Received: by 2002:a17:90a:d701:: with SMTP id y1mr4772434pju.213.1632900923369;
        Wed, 29 Sep 2021 00:35:23 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:23 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v6 7/9] mptcp: add mib for infinite map sending
Date: Wed, 29 Sep 2021 15:35:05 +0800
Message-Id: <1092ae72c80b5607995dc42b564c72270841ede9.1632900306.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632900306.git.geliangtang@gmail.com>
References: <cover.1632900306.git.geliangtang@gmail.com>
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
index 5b73493c75c5..5122c4ea4350 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1286,6 +1286,7 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
 	mpext->data_len = 0;
 	mpext->csum = 0;
 
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
 	__mptcp_do_fallback(msk);
-- 
2.31.1


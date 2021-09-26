Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BB3FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:55 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id t9so1771580pju.5
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mh7ETeQHHVy6RSbJvJ3ZPRl552Rp7l2WLEaocUQ7xbg=;
        b=pEwAWeiCVB7soPG9lvidF500uSXJiiUcPgo0/brXQUVmxQzvgXl6Tz8+lHvXAVh6Rr
         fHHQulK6hh4oGV19Ytji2a5Wps9SE45KI54ZRhUBr7V2QF5vDLS7j0JTt/i/ktFq3Bap
         WVdoKfiI23n9y2ZXdxfoUTKH8WwGDRH/Qsnoe8rFpNY0oyD7MIw42FdbzT0mdKSwMHiF
         Ky9qEHIfllxuOvDsQYB6yLDy1qLVF++jgEXcpHOq/PDLlpEceRiq+7nqHVsDXgX6A2Si
         sdVYsEl8uryYz7KQIdhMP+Z3MWFOBhbXKMMDic3bKFiNCcT6wwXNgFovFdu6YJo5yGny
         X1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mh7ETeQHHVy6RSbJvJ3ZPRl552Rp7l2WLEaocUQ7xbg=;
        b=an8kHqcDjByaYLpJby56f6+vofd19bhaeqcHj/emVBVLe8b6b/v8++VNkwIspEZdU2
         eti1Ql82YcJEDbC3vWQB0FLDidVowuVIzQqIxgERCjL+UviDqSrZbpgUIu0gsRVzAVVp
         ASCPpkZ9FqlmyhhLBkrnswqcUM+oc7bgrZuVELUJOikSQQizEet+pz2oQb3i/7l2l6HT
         t3m4m7+BqZePBHt/nivpDkMI60wbYOSFETCfszgaqb2JjSPvKgL5S8WU/Tkpg4yy1n9L
         DelDt9EVOKGZo06ddk0vYR3uraYKD6Ri0y2dJMKo/TkfmZW6KxNUiWFeH4yp2MSczUCK
         kyog==
X-Gm-Message-State: AOAM532IR3jkLwMHmwrZqMJseVtLwrHf6mSi8nCObhKCyXQLU/+d7lJt
	heuiVYYShxueAoPpWnw6JkJJduDn60w=
X-Google-Smtp-Source: ABdhPJwRifpZeM+SJANgVE6FuZsPWsxC5aIufOkGEcBWM4sR3IPOySwMMny9SQC4myxnkbo4NECznw==
X-Received: by 2002:a17:902:7c90:b0:13d:9572:86b6 with SMTP id y16-20020a1709027c9000b0013d957286b6mr18216778pll.72.1632666594580;
        Sun, 26 Sep 2021 07:29:54 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:54 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v5 6/8] mptcp: add mib for infinite map sending
Date: Sun, 26 Sep 2021 22:29:36 +0800
Message-Id: <9186ba3a1b31f5ef9cf9c5a171bdafdccaa9fde3.1632666254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632666254.git.geliangtang@gmail.com>
References: <cover.1632666254.git.geliangtang@gmail.com>
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
index 60953b61b3c9..c735adc6b835 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1289,6 +1289,7 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
 	mpext->data_len = 0;
 	mpext->csum = 0;
 
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
 	__mptcp_do_fallback(msk);
-- 
2.31.1


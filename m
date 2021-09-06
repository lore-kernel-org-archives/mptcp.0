Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FEB3FC0
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:58:17 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so4023808pjt.0
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPVAbN2Pszc3GxBgz5n1fPb7njB/Un/qvtIVtcEAhC0=;
        b=PSFskLf+7iwKXqd/eG/hjs67AGCa8crtyrMfbIEOY2TQvEvu2aKr0qc1/Bp9iLBtgl
         7k0QBS3kvv+fLZexSIAITrMyqlDIMcl1VBlVKDBguisuMwV6pKPJYggZ3K58vPf1tGTs
         7NgFxC+Ylgq+1O4Y0pBindq6F0x2aT6JPOoTfKwVE9DPfqhwn2LeOdkrscISgT3b5vQZ
         D0jY+PBBoA1VAXw+x34IKKaGFcEuNRTUdTqWJOkA3xlD9CzZCytXtVRO5oshxIB4KtYf
         FJmSWkAn0Fsr5q8Iq7aarAvpMiHzW0iOOcYMfdigyejdjYiTQ38gjaXOko1nWEWGdqhF
         2Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPVAbN2Pszc3GxBgz5n1fPb7njB/Un/qvtIVtcEAhC0=;
        b=RggTEehoYH+hRxtS98C3xk07qX/sldkLHWzcTvfDvfgKvuNEygSgRzX4YGDNuj/5LR
         D9ae9+VwxwoDvGQ28vSQMtEDteB6cFoT0g8VX5yvNij0pLKVMJXDJtw0Sizi+WRZcyii
         OOuqaKhezg3c+Ay+udqpe7aGEz+LH0/PKWx8dIlGGVIQqM7SigJ4+KN5h+gTx5+c6q/D
         cEJ0k/MB3/xTbc9oeG/wRfY30LbTuBTPH4hWN1aXPdhz6YnaM0ooLczHnZq1hBdRLtWO
         P2Mg/yz9pZeTBAl28CUPU4ivj1z3f01P1pXWw661ByTpUDw4Qbeq7kGYG0MJru4HGFDU
         t5Og==
X-Gm-Message-State: AOAM532PG4GxKoBJxKPwU27jxUJShcoKUMEX3zsa+u8yZbiYz7DTTK4r
	W399nZA4OGIa2DVHpSskFCh+LEA2Ug4=
X-Google-Smtp-Source: ABdhPJwhcuJKEqTlfYTCWs6P/xMO2kJ1dUBCpBHKb0tiJ2H8pbDtK8jh95xBC7dEUseVWzYDeWj6Qg==
X-Received: by 2002:a17:90a:5513:: with SMTP id b19mr13036973pji.16.1630915097249;
        Mon, 06 Sep 2021 00:58:17 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c24sm6895702pfd.145.2021.09.06.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:58:17 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next 3/6] mptcp: infinite mapping receiving
Date: Mon,  6 Sep 2021 15:58:04 +0800
Message-Id: <dd69eaf87e848b1de94526a456215411184cc183.1630914699.git.geliangtang@xiaomi.com>
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

This patch added the infinite mapping receiving logic.

Added a new struct member infinite_mapping_rcv in struct
mptcp_subflow_context, set it true when the infinite mapping is
received.

In subflow_check_data_avail, if the infinite_mapping_rcv flag is
set, don't reset this subflow.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a058af61cf7c..b92b02c2ba61 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -435,6 +435,7 @@ struct mptcp_subflow_context {
 		send_mp_prio : 1,
 		send_mp_fail : 1,
 		infinite_mapping_snd : 1,
+		infinite_mapping_rcv : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 87f42ba7c09c..e7ede61c712a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -968,6 +968,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	data_len = mpext->data_len;
 	if (data_len == 0) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
+		subflow->infinite_mapping_rcv = 1;
 		return MAPPING_INVALID;
 	}
 
@@ -1181,7 +1182,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 	if (subflow->mp_join ||
 	    (subflow->fully_established &&
-	     !subflow->infinite_mapping_snd)) {
+	     !(subflow->infinite_mapping_snd || subflow->infinite_mapping_rcv))) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
 		 */
@@ -1201,6 +1202,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
 	WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+	subflow->infinite_mapping_rcv = 0;
 	return true;
 }
 
-- 
2.31.1


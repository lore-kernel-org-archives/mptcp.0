Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8853E00B8
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454195; cv=none; b=EnC9FDH01BHgw3GUOzioLlCenfIKgWMIAPkOHoXVTDytNasQux6nNrI5BSxpgG3NsFag3PJrBtWXXjWA+fLqtsYqDumFE4K2JPFwGBtirobyb2jgT3ntMRsL27gvLBQD348nTHyNdlofLMneVaM/oZoH+TgEtc5L8k63bf4c7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454195; c=relaxed/simple;
	bh=UGd+kjwZ7wLqKrdkmrx/xsOpXTlQdSYek/Xxji0Jj+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rYlXOqwrN2fpD4e/MFA2B/wgLRhYuIgcuA8vQAPzZcqqv9PjqKQ7SI31C8UBQ9KNf3YFcJuWjgI2GVkiVyiGMlIomhgHt5Uyadmb6rWBw9IhUAF20HxVrzAv2uX71LL5jfChpcMOeLar4oUaY6VtKJO8b6hSp6DCucemAuWleew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVHUfXWx; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVHUfXWx"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b6dad2382so6404351eec.0
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791454194; x=1792058994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXNayWQZtrxImfBFLGBlgxTe4JKCGS+pfnkyA+c+fwU=;
        b=kVHUfXWx3rEG+BmwQMtKKmwLQxU/paPt1woPdM3mSPL4RXTboP0Sn0yS9BNmtLi6qb
         l6tmboB6hzJAIKlyU0idkqvRXV0JvgB9uymMaPleHfXMlueU10PrkSX5lXa2aY1aXkcu
         7wDenj24OWX411eIcYHGMSTMAH/dyLRMDDQd32s1WCrpD5xe6K6jM6IV19s/pvmD+R02
         XfoqnEluD3E+YAorvd0OjzlDpmkqlLNDoVDXR4I2b9awQBdOLgNJ8gfQrPmx1jGM2WS1
         UKgC/WOxv/awLTWNthPmu5+dKdRW2IOksu3y39sLDY3QDuyeJ5OMwkGaWtafFrJgKY1G
         3itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454194; x=1792058994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXNayWQZtrxImfBFLGBlgxTe4JKCGS+pfnkyA+c+fwU=;
        b=DI99yEeBD/fpPvdoVR94gfrFtIHNWd+KaX9KJCJEeq/o5MeHRaXLxGUcwEHa/yBbzU
         u2+Mc3Csp32ARcO+MLLJwJjrFU4XrpVsE3SniHvLFsWniftOH4BNdM8iaydrrO5MU+s0
         bOcEyrnO9GfLS3wDDCN1KeaRz2NYC34xafExeTWB0xSpyBTdyuwJOdLhUM4CwM47vGje
         nAalWJr2uqB5n9uWHT1b5eihrCZ6Fm/VnMpY4yJ29Id06Wj5+r6LiFo5it8BFS6XU+4p
         8YIA943G42W/ZlgRml2DSy1851260VNkIwkaJUzkBVz6URGKHVZkQgyZuNu1vYvDnit2
         VSsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTMV0A/SRCmJR4PduxrkI4ZLZQ0/rlSPVsF4ULuinhrIS6QEJ6eQkgWOAaSw/yYnBkESo2Tw==@lists.linux.dev
X-Gm-Message-State: AFuF++lMo4qnTr8PXJ1uMdsdLiPvtJKUIIZb/gqYzRxe89WEKn65U8xf
	y1/nmJrl6+SqiRsr2tS9MFCm9T0eB2W4vrdbaG/8jDGUCMEysUId9FGs
X-Gm-Gg: AYBFou3IH34ufPYyxq/bM86XmW39scBQc9v4MuvSoRQE1lZLsh99aZQqdmtjVZEDYjb
	Pntsc6ycpXMdgW/YIolH51nkktB3BeUA0b42XoojWv9wyQuAY0lF7zBbqE2Vq310MWEWRlkDKb0
	fr5LThuc6FO5syOkYlbTiS6UADmMca3BRYYCLvESZ9ud75WlOKtOgNEOsjlo9ljvF2TpKjktEqU
	wodK+lZ1VdNK/mWk8HOqnzevuDzCEZnm5gEPT3ySzn587touQ2Z6bDoshxJjoMiG+ZhYIUFl3P1
	zAniz+b8GguyArkD75RqFcCa1jelxu3y+DkcbP2v88TRtRppFc1U2uzS+Y3Y0ZgaCPu2d9LLg6X
	2xLP2Rw18O1t971mdLdeDBF4LFCrvsv1sKb4z2un+ciDC4CWoMsH/z5zG5KkKIzgCYiTS8+9IR/
	F+wXHY34Rwmuj7sTPrwFQGLw7CUgeWdqBn9y+V7Z8QqimrcysWSYbD6NeFy68q4PchIf6oi07z1
	fJ0X+Qcu52+4Xh+OFE=
X-Received: by 2002:a05:701b:451a:10b0:158:7ea9:4a5c with SMTP id a92af1059eb24-1620637efafmr5613674c88.27.1791454193686;
        Thu, 08 Oct 2026 03:09:53 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515abb5389sm16487581eec.2.2026.10.08.03.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:09:52 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Petar Sakic <petar.sakic@ink.fish>,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH v2] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 15:39:41 +0530
Message-Id: <20261008100941.104715-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (after
consuming the client's SYN data but before the MP_CAPABLE third ACK
arrives), __mptcp_subflow_active() refuses transmission and the data
is queued into the msk write queue.

When the MPC third ACK arrives, the subflow transitions to
TCP_ESTABLISHED, but because the third ACK carries no DSS data,
the queued bytes remain stranded until the peer sends more data.

Fix this in subflow_state_change() by checking if the subflow was doing
passive TFO (subflow->is_mptfo) and has reached TCP_ESTABLISHED. Acquire
mptcp_data_lock() and call __mptcp_check_push() to flush queued bytes,
clearing is_mptfo so subsequent state transitions are ignored.

Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 net/mptcp/options.c | 7 +++++++
 net/mptcp/subflow.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ce0de02f5..d5238fa11 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1042,6 +1042,13 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	/* Passive TFO: the application may have written data while the
+	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+	 * it then and nothing else spools the msk write queue when the
+	 * MPC third ack (no DSS) arrives. Push it now.
+	 */
+	if (subflow->is_mptfo)
+		__mptcp_check_push((struct sock *)msk, ssk);
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f0a6725d2..c71122842 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1894,6 +1894,13 @@ static void subflow_state_change(struct sock *sk)
 	if (subflow->resetting)
 		return;
 
+	if (subflow->is_mptfo && sk->sk_state == TCP_ESTABLISHED) {
+		subflow->is_mptfo = 0;
+		mptcp_data_lock(parent);
+		__mptcp_check_push(parent, sk);
+		mptcp_data_unlock(parent);
+	}
+
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
-- 
2.34.1


Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566625B30D
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166979; cv=none; b=AFy9pfAPZyhBaRs8blYbfTL3h31Zz+FzdfF4UuHh0UPd3yCmqcAMYrJJQA8BpcYTcq/1m3lacW/P8E18HBi5FKlD5Co/JYgKGIi08MTA12BGoXRNZjXC3TfCiVRWmNhP+maVv1Xyh0N7l7MJnIU1iHGXRo7dMgXKeivU/7rzJYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166979; c=relaxed/simple;
	bh=GlQmSG85GKHRESZal+wczobmyoFTBDGWaHax1jL9Nh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=en2ivYikLDAbk0yvZx7jGWD0ZlFWF2LxjzMsAIOBwnRwHsjoIvN6ViHDPjA+LzvobH9rGf9Fn1ovK9ZrcQTJ8oXwXrOwvYoEIhUHKrEcZk0MIN7LJ0R1pt+vvqDAtSJVQtZt0nMI13GnN0gAlDPRCNtHObFixvmoeIM2OQH/3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiSROnaf; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiSROnaf"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso53012eec.1
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166973; x=1792771773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GEXJ/7oIe+vgSFp5wt43v089BijwhV5FJLNcbB0aq8=;
        b=KiSROnafF+LStEUUvZIRydQsYISBCDXxOJWPR9sj/Ws8K9LE4k52hIapDhA8ymFBoh
         EXkZb/jvd7yrm5Ia303sSUVmrVwAk6xFnBTz5YMe58tEHBS3zlXb1SlVMdFuWpTzEorb
         aLui8Wc1xdZVHPq1mcs7IdFkd2KQMkjwYExnX7RQcHHO28xlT1IaG0DjMKAn5l8QrKVi
         8Kpd0xZdcy3Cog9B9ViYH8OmO9vtTGanP9CnfL1ioV1NMpfdbaEPF5DViWcXfgroFts8
         m+D8tll+z/Vov7duoElCEM2qJT0lxPkfZ7Tqc4tYhCP7kK3XRc7qUo6jSj0S4+wLSPMz
         zbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166973; x=1792771773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GEXJ/7oIe+vgSFp5wt43v089BijwhV5FJLNcbB0aq8=;
        b=W4MEF1NHVYKQKSp+Z4+oF2RVSONCsESM3321qpsn+XZykp7xVp15d732oGhR3MpdLn
         iPDcmAAPDyQsp6ezWyDQl3h2o/P4e5UDCW4zAkSTHNvDr1ryQ61PXNBFlnreAaTdoklq
         BevZQ9JmWP8czXyNvm+UUqzI+6nr1VVgSqa9oB8OnSEo4My+9MHjCWggl6KEqIsi3xZn
         9XJ4GF3NIeII3HXY/9h98DhNEdTBCm468qD8hEX2qUj1c7DghLN964BIlX1c3NZgQZjL
         vr801T8J6Wn+8fyBzfLTpthftU4ioE++7FrGwMcbjbLP6xYMuUnc9JghRPYYsjoTcbRU
         3U8A==
X-Gm-Message-State: AFq9FYI2+BV+wHY6Nl2zlOu4oCBugGz/wRwsiWLJRffcNABwPnLqHPOp
	kdXysAmtTKXOV0tIv3F+dL4mwxJ4HDSiIabGeAFoR9eoBTTJ6G1hHAnjnS+leQ==
X-Gm-Gg: AYBFou2Yz7E8oLzjQZjHG4LpE/Lnph35E94VL7ucriz2DyJMhb8+v2XgHsmKuZ0+yX2
	CYeYLTdRK0SPmzmSNmaG5ZI+OJUrAEhI3sr7IcMAug3GddwOURvSwLtJwkABicTHcQsDlC0jBNW
	XtovtN73Roug4egb3SeP+8paN8xUFXzMhTWZVbT3A2PQio+M/pTXtkUC0ujXxpepgzaOciJBNTa
	yK8y1E54zeZBA8h3dHXPKMMiS5YrM4KKex2nVGL3OZ9x+V4Y2/Q4Oz8kvSDv2utEayrGoZylgS4
	BdrVflU1Y2BCSh81Ktdg4oth8tj09jY1MBLD7FCPsxwWFJQxplaZ0F78fZ6D2vh94PHWzgHe/mK
	pzYSo9Bg1Xf0kP+p7ZKSrsxYwWh2kpMP9UzlKOO0GsX7Y2EkAAqQ/oct+cUISE+bWo5q3IV2pgq
	muPaN77uioKMsIHuv+vOJymxTzunUTuhhda/fISSaF8ZSeZ3BrQzGvTRb3ZaWk1oNROxk+zxOCn
	hRi9qo8uSdrmf7dKOuce37ZI8vFsXoacJyS0+TrZ33qHAR7lswnNObWRRmVrpoeNMMfgFEIzIWe
	CLWkR9i/EtWIu6ONyrX32RK9biKPWyjburN+5r5m6V0=
X-Received: by 2002:a05:7300:ce0d:b0:34c:5831:8a19 with SMTP id 5a478bee46e88-361a361222emr223652eec.40.1792166972684;
        Fri, 16 Oct 2026 09:09:32 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm9099098eec.6.2026.10.16.09.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:09:32 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v5 1/7] selftests: mptcp: connect: retry write() on EAGAIN
Date: Fri, 16 Oct 2026 16:09:20 +0000
Message-Id: <20261016160926.1155262-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_connect treats any write() error as fatal. But write() can fail
with EAGAIN even after poll() said the socket was writable: the MPTCP
send buffer shrinks when a subflow is closed.

The tool then exits and the transfer fails on both sides. Instead, go
back to poll() and wait for more space. If a poll timeout is set, still
fail after as many retries, 1ms apart: poll() does not check every
cause of EAGAIN.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v5:
     - no change
    v4:
     - count the EAGAIN retries, not ms (Sashiko)
     - no limit when there is no poll timeout, -t 0 (Sashiko)
    v3:
     - do not wait forever on EAGAIN (Sashiko)
     - wrap lines over 80 columns
    v2:
     - Fixes tag

 .../testing/selftests/net/mptcp/mptcp_connect.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..b9fd0bdab748 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -638,6 +638,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		.events = POLLIN | POLLOUT,
 	};
 	unsigned int total_wlen = 0, total_rlen = 0;
+	int eagain_cnt = 0;
 
 	set_nonblock(peerfd, true);
 
@@ -711,6 +712,21 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
+					/* POLLOUT does not guarantee that
+					 * the next write will not block:
+					 * the MPTCP send buffer can shrink
+					 * in between, e.g. when a subflow
+					 * is closed. Wait for more space,
+					 * but not forever: poll() does not
+					 * check every cause of EAGAIN.
+					 */
+					if (errno == EAGAIN &&
+					    (poll_timeout < 0 ||
+					     ++eagain_cnt <= poll_timeout)) {
+						usleep(1000);
+						continue;
+					}
+
 					/* expected reset, continue to read */
 					if (cfg_rcv_trunc &&
 					    (errno == ECONNRESET ||
@@ -723,6 +739,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 					return 111;
 				}
 
+				eagain_cnt = 0;
 				winfo->off += bw;
 				winfo->len -= bw;
 				total_wlen += bw;
-- 
2.25.1


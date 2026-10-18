Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE83F329A
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297085; cv=none; b=utRXcOdn7doP9yUoOldb18s9s6lsAuje9TkY5nttl/PWUCz9wCNTToDEarSjjmbuWX0QcgvDGYyzmfeKV4vFVeRNaq01+8taMeHPbbSN5bQpUI2M1bSHdmRrnWFLjHRWBn2zSqJct79dCxOPc0UNtS/I8p6ZIQo03LdFcQzXQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297085; c=relaxed/simple;
	bh=KgysN2nmrZ3o85Jl0fxlWEbZoXFgUCPDw7210WZVcI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiO5xGNJiE7g5AZcosWfzaBMfu37i4qPFDi1IoiwLmL2fl/sa0xOkUF7Q42aYPMXmRex8Pvqne+X4A0R8ZkpIvUbbS0ZD/niZl6ZpHdiyAcqtEAD8RBfvUPtQIsB2c9ZpJncLsE3qWhIbbSF/Pz+Dk1fFBpMRTgIm+EYVknhS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksu0NFhs; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksu0NFhs"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35ef6b49813so2131685eec.0
        for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297075; x=1792901875; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
        b=ksu0NFhsf+8tlhNnfLeckFO+h/VCAC/ZG/6eBZersZmuTj6ozo1OwAgwHhmFMgROPx
         aXhnXowW7PerSNg8bgvGjPZQaOIBTWMOz85tWKqakMm3ee5d9/iEEH/kLXuNTI2PimF3
         5EHb+UW2OhMh+U6db/08Dm2LovkTY9jAxhmvX2hcFmRcOskjvVPaTB768Y87a+0JH5wn
         n24x9EgworqUdpAaN8KHWmpZ7ussC9BeZzoqnxhytIwPN+2lC8ZFI/MIRf0EFkDMiFiF
         oFyqBbvVyoTxmzx8LgIlzfPaZUmYHP0Ri9mgUPLZc+tnL/EWfb85ly5pCztCaig6/KY+
         GTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297075; x=1792901875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
        b=EEsTK/UUzI9/H6XnC5xk4YRM/8kG64evD6iTQB23xtjyQYgjiPIAjEchRmxKx93MS9
         sJMfNXJZ1Uu3B5uX5j1vYWY8FHDwnP8GasEUrA+KRRw2o54eSeULAFnCiZDoi5VQM//S
         L5z/AUv2dMqQOfEil4Lq4YNvkRGRY1Vi+kw6POqOX7n+PhEZkohl+lIyCQ/zc6hSqgoH
         kxzdQ9CVScvc2gQuMv4tIt+w2fUcms10qS0F1PS6aQ2UM7+OsO6rvzYmSXVPzgDQs7x1
         ezd2YKqjx+wGHHd8QPNYdcK1wSl7294gCsSHBRRvGqtjlbIEQLYcdQz6fnonKAdgx9OF
         2T6w==
X-Gm-Message-State: AFq9FYKOBipZvt5GKfJVtBBzJqDQoKwaYIy8NYDsUZDgb+WWoAdwSuqe
	dm9LKQlWq9/RtnnUgYT/q23FHfihOZFVdw14JInE+gs86r3ZNVqfhGgWjsv3AQ==
X-Gm-Gg: AYBFou3PMpIi6P9FilToUI4qmsx5PK1D7p75Kj/LAUtz/ggitOL4DSSF3nbMMTB2PIL
	nhJY1/3QuGcAjwBEATxdjbNe0VlsMfzCmEUWFUqfwXmRZpohphD46k+JzqcaX1jrFy+25qmv6R4
	DXI9h5T8NE9hMiErMhW1ikSz23+oEHGnQS5LaUU7V45rdkUoyqWl2hCUpkEE/Abm2ltyc65Da/v
	D/FfLusBk/TV79175kdR/nKI3c5H7j626un0PVHs3hQRRcRyc8kgskBrDHAGxf6VX44K/FREoTE
	SySlNH7GIgMDpwz7pKwLZ/izYWeP0Mqc9z3Y9AUwoIVr904J1YB+m0O//R/MsaLHkFevtvNP9yx
	WZQSI7c0QDa7CH45HJBXsEwf7s9rMlExN9E/RO6q/TsW9NLauPJJkDwzbKHjcEFIU52ZPD1uFGR
	Xn6IwpBktTH+KZWHj7niJ7lv0lrIi8hqcTmzGJlW6BymabWErt9BP7AIDzd7iH2rfl65V9z7HWZ
	uNEwpgnvnsT4FxfnjU90jIAHAjxsRJKollMKViMs1lmjyegi8xl8XqFOAuWD5VtDdiSGAPYaYRl
	wiGqrtFnZknOAwJxjWGPZZaj0izIRnAYhPz3zG09NBIO7PL7ROdJww==
X-Received: by 2002:a05:701b:2712:b0:144:eb46:be0 with SMTP id a92af1059eb24-18511ad8634mr5981010c88.13.1792297074749;
        Sat, 17 Oct 2026 21:17:54 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fdfesm17867932c88.7.2026.10.17.21.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:17:54 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v6 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Sun, 18 Oct 2026 04:17:43 +0000
Message-Id: <20261018041748.1655711-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
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
    v6:
     - the comment says the limit only applies with a poll timeout (netdev
       Sashiko)
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

 .../selftests/net/mptcp/mptcp_connect.c        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..49017d00ab69 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -638,6 +638,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		.events = POLLIN | POLLOUT,
 	};
 	unsigned int total_wlen = 0, total_rlen = 0;
+	int eagain_cnt = 0;
 
 	set_nonblock(peerfd, true);
 
@@ -711,6 +712,22 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
+					/* POLLOUT does not guarantee that
+					 * the next write will not block:
+					 * the MPTCP send buffer can shrink
+					 * in between, e.g. when a subflow
+					 * is closed. Wait for more space,
+					 * but not forever if a poll timeout
+					 * is set: poll() does not check
+					 * every cause of EAGAIN.
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
@@ -723,6 +740,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 					return 111;
 				}
 
+				eagain_cnt = 0;
 				winfo->off += bw;
 				winfo->len -= bw;
 				total_wlen += bw;
-- 
2.25.1


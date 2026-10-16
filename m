Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347BC2C8
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129818; cv=none; b=ipL0SJCQhV8wruw5PYmiwDVNCOyVZ6bC/H18nZ8EeJbK/tt8WLE9ezySGVA6HQDZ37hJ0Bf2w5D/i9ejSRpLcTBcFBcQttkLbpKeB9QYOxCnjjMcJ72zB6KcSIQYYC26NdN6g+37SgFggMh/d2x8rgjvRrOkL/04Zk51rOQRf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129818; c=relaxed/simple;
	bh=F/BTTA9SkAYv1yMQURFmIiMPljrkVodAQsGHKNc6RiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cc5PP8ylZ2iyrPXifu+FcKftB2bQTVP+Aq1ccsAE75ddBBc2y7k4g5exIte8F3B69dCOLDadUy5N23VMSZM4H/45gbFvGpYkwoDk6rOLWe1Mu6dHIcaDoTxcY0ZJp6TYbhDT6iesGwZ5d0CLok74m3DTH/bWrv1dCSPS+WhnIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pq8KxYQU; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq8KxYQU"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35943f55c06so854428eec.0
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 22:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129817; x=1792734617; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLp8tu47UgVWdGUVMHviTtaVC4kZj9vpjfooTomUuio=;
        b=pq8KxYQUvfl4aCR+0964+pxULcqSZ3vHtnKvcDDevfuAKoY+rMxv/ivClbFNvSpluC
         u59gKRZmF8obDDHH1z8ccb3soWXDtWbyDH2dZjsEjXKHowDKI/VvtY9emtot736mWg3+
         b0KBcH5JuDRwrOAqi5NIz7OKhqcWs7nWh0IMcWEk2uEiCmSDZnF/0L40SOeWkf4p7zO6
         PJAO/NwuUNuPmy4/+bjBjIDsulx2vNRmz8pMCuMjPeXrWK7AbVikrBsL9jWudEnU60Xv
         Z8KDxn2WlKhc3RoKJTzebmfy8rI5Mq8Hq1i4WfL0LC9NV8JZdx4TsVuw4T0KnBRXuMGI
         zUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129817; x=1792734617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLp8tu47UgVWdGUVMHviTtaVC4kZj9vpjfooTomUuio=;
        b=d06pKeQWZkGmwXWWSSTspuMAKzOsub6LiNbtD1TwPFBeUM10G1NHXiMQVlr07Pkiys
         ltTrNVlZ1vW+SVg1vt0tZcfix2EJhhzqLeJiS0aGqEnT2mR3Gl5dOTclmtq5L3LXlV6u
         aZFWje9DbuJN9LNtSUgK5LAq0cv3g/mNl4TY9GecbZohAS/yfklVsZwdgRDF1h7B2qzG
         6QbaM+aFQgz5ew7Yelruz8DrVzZbeHIPtXJ5I8uzcdtd/nLW0UF1D96fa/bWKgI4sagG
         whGYxAhUK9gHFomJQ5BDh7emkxgjBqIYyJZwKpc0jbBjIhxUT0qWkOsVsnI1pVuOhAfO
         twTg==
X-Gm-Message-State: AFq9FYJLY1gUlvtqQ48YnDmYOKNO6wTYousroZ2mh38br0NpIjjdL05s
	3EoT64baN+y2tMXfuMyjg2MZmOTxOXj2Emd5xp8GQNwokCwHJCWFW8QtGXwx2Q==
X-Gm-Gg: AYBFou2ZJC+A03jBJYDspeiBLxzDzKAxhoyLFq4KrRtsYWQcFdhfaE565566YL6Vq4u
	rPvpYm8d6WsbNdmGH5xfj5vNo7IxI0HrD0HnmF+98BqMvMF6hJnFwAr0HLusp8hAPAUfu/p3lVF
	Hx7AsGRE37it9L+bBMo0yDjvuxrUzYaFMzk1vKfbPaujm5XoU+YA2EgTM8q4hQXzXJm4w1l7r9K
	Sewk7SY7BgX/u39xUauu34Eg8K9MmJHGuOllCKlIzoMMHbbySGfrgUZ5r2kHQpWdFo6+h3NrSZF
	bBBHpnA9bQRYYApRFDspA1HaNusdMla9V2gKiF8K9/3CKeWctloamU7ceubUVpVCpK8kNBFtstI
	GGnRJCcdrs5If0vUusM3XxbZN4AvJKJm/e1PwnhUdXyYxUdMKk58eJ3yTVk8oOtigCawbS+/5lo
	W60Cz8E2nbSq/umNNeFhS8mDIUOe0o1/O/9/27EjnNiNLTQ18D29Eeo9o0f1BILmEw09yoEvBy4
	yvYHkSCTcQuNCupdlxgEG5ux/QyzsKNtVh66CUoERqpyMDOydd0wnQpQeXxNyZes0CDsMCIVicP
	SVNuPRenGuzUpuZTZJzeiENbqol60T5fXjXbHGFvimw=
X-Received: by 2002:a05:7301:e2f:b0:359:3991:ce1a with SMTP id 5a478bee46e88-3602e698e80mr2721245eec.16.1792129816494;
        Thu, 15 Oct 2026 22:50:16 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm3928803eec.6.2026.10.15.22.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:50:16 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v4 1/3] selftests: mptcp: connect: retry write() on EAGAIN
Date: Fri, 16 Oct 2026 05:50:08 +0000
Message-Id: <20261016055010.980819-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
References: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
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


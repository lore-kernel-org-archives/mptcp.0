Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936156;
	b=hc0PWsxGOi0lGQrIcJkqYyCPg9QQgBd1zpG777O6KgoP3dWK3YO29+T/R0CctqUYIdmm
	 JKCeIspbRKy0mEViucMfcgmDmpUtM/E+ZtQgj+BQhbvTsxdzMRWbiFYAl667w/l6a3Yge
	 cVwb/2KOHm+Ij83m8mC83nILu5lF2U8oB0GvmFJp1aV+Gs5tzf0r94yCz052zfwaC9Jse
	 +lPMAV75lL1LCarUR9t8iT3SnayXDvnwvtmjf29nfFJRug0/rk9K6uowNkDKGYDQC+tLC
	 U0U4Xx6HjAKAq2ReDlGd3LGShsQmI9pQnHeA9/OljFxw2XAta0hdGtbryY9cpM2lq7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
	b=ceoEDy3e22JiwNBVE5+V/WlNASxxghCF4d5J4Ux/Ks8doxZXBaxYXVTVzgBisEodyJE7
	 ccMxsWsH8OCJCuXPAiINjDiLRoPXwVCvL6wUFzoYTdcFd1z+zDlcOEY0TybHKBX+iTJay
	 Xwi7C8Wj3pWicC6k1I4TtrW2nPkdABfSY+wffnSP+IYxgJ40HvcCk2qqlfWr/0vb/5bJ9
	 TWVVA3C4dyL7HFfm+77/vP4Z/RB0CZlwCWXMGWta/RdK8nwn6Ssvjnt9OjyWCndAv9rZc
	 Kdg0RXP1lOR6kjSZGxz4Tj4VlA7y/wGisPASt+qKiAMBX/3lugPLtBtXNOKtuIhnQCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dh7bl+iR;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF74606A31B
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 13:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF74606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dh7bl+iR
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-369f33df08eso1288536eec.0
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936155; x=1793540955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
        b=dh7bl+iR9P2rdzphVp7vWnjz/3eMWIziizvJf0wTHON+QtNpQ8+1YAZcTPOjM/5nYo
         TEdHZ3dQjc4Gp4z4hXNbXb70Jj8wcVmqksbjga6wwbHxo9VXHqq4ZjNBCO2m87KWWprY
         5ng4PV6zHBZfgEiTCEw8Zj5RLF9xbEML1BRstw/qsn963zbOPXsXtJdbE08fwrr0ziD8
         KtI4Z7HnLBI/heqf+CX09QUSjjHe2kerwUeOE3qzHA6J4Xn3JIyuOXvenwduNAuFS8oI
         bcok9fiXbG3Atav+ZJdH7/Ir9T+8+Iu6G8fw7cmgU8J2UUwRlxwhkoekEnpGEwfSqEiV
         eZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936155; x=1793540955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
        b=kTO8eevQnyA8oYn5boYy8yv9rjy/sB+RnVlOomCeqwtKI1Utgdakq1PhRnYLUmHPHA
         2AYvJ9S5gmFsgG+CAYGSzoQaVcRIvgveZO5nQtjdnRkDZdoCuNClDoAF7tw3bReBhDeO
         49RNgCavxPt/USS5/jnSkD60Yj4IhawwThxVPxxqQ2TynG6jo8HSIQCTybOlGAAsLHkU
         HzyI8SMlGMcZl8naz++D4nVWnIlFUHr1Y1SqT49x4hSNPfflgPc9MQn6YOToQLWpMPOZ
         BFaZW3VB/hf2ArPZtpCAwSRae3FwyNSt143KQ63XWi+dTigrqYIdrjA4wdBwYLykwRok
         jDRg==
X-Gm-Message-State: AFq9FYI9rCim5xTl0U3dH91KfJMNjfYraZSwmyfaDU1N3tbuGhzXPoEf
	icss/Tht6rzlU1TA7vCjz96eYHid8eS7GhwhnmRw6xmcfu3BhB53E3QXJqpYhg==
X-Gm-Gg: AYBFou3m/HRUs1fn233y0+TVtsnPTsc101OZDjjdi1J/QhUYSBCJi91rHf68AgTBunF
	GxjlnJpWcH+Y4OYpMNFtgFYPcEuLfiwvfmjlRaJq3GlsGmbIdE5ul1Drzzuch4XCkKD4jdFMXmh
	CK7MEiysqeDHgHvFN+ElGAqRylqjUrikmXun00MqPDPOYpAs2ou520MWubcINNH6n/P/EynwLbj
	6nGLZnN8BYBaU53VS9B3J4iG1uWjba71v1UFyqfpBV0wIG9wo9LA6ZgngiNHdH8f2clQZVWvZTn
	Kj6AxmB/ShiW9Vtw7PwkOL/YjCLyKasi5alarrmmIxouZtMkNJdwdxE+lDdvjmAziSpGJCTz3J5
	OdizclQ0y5dRZo90j703o90q1N1yKG/M2LDrwDYu7EhtP7Id5B7YqNM5wz43K+HiRM9U0QdO9QL
	I9nErdawV4dGDS/Sbi6GSEr7AgG3wl+Wh6YOv7JfTheopDSrGcCFLkoKFA1b9slAbkw3uDdUJ3+
	1DRz/LNaLuOWKgFV5h/ks4N2NRko83C0qaWmP4K8nS5lInwmRrU5dCJFLFQJQmzo6sSRb+vZ1qN
	/Zw8bk4HWu6RgGnHl0co8feh0NO9olBld9vyVCVpuEcUCAF6n8Hm4ZPaQqnxhX+8HG5INrCMTeZ
	ye2EOEEnVw9o6fGodmLI3l027
X-Received: by 2002:a05:7300:4706:b0:369:f05d:6c67 with SMTP id 5a478bee46e88-369f05d6ea9mr4395763eec.12.1792936155200;
        Sun, 25 Oct 2026 06:49:15 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm1188159eec.22.2026.10.25.06.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:49:14 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v9 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Sun, 25 Oct 2026 13:49:04 +0000
Message-Id: <20261025134909.2794368-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
References: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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


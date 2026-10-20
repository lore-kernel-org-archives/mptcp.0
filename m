Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466239;
	b=0Bu7wYlV1QLQ/1pjnyvZHxbg3Ea28qAUbeFuQyREu9PzNJILOTM1KFTww+cBTe+Oyz6o
	 RmMSCJGW+GChChMrsM68bvaGWv8jTBqWpB0Qjj61QVHkyKdFwDZEuvR1iJnG19qA7WY8Q
	 VzudjkICjPsWOrNb1EhBSmvjwHGBXv/SHsTMsM3O8etS+8kJx+sasMFhkDwEHlNG6NZnP
	 DGq5+22X5TcKBWT676aevOmW4DRGY8iXvh8GNpEuirDdbn3C1vwS68hrDUW4Xtf6y2NSW
	 R34XV6RD/6jVaEPRcsiJpAXqGf6rZSu68fvZuIAcCfLprYhdxQljvb3QJJBNZg0vKTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
	b=FBmafIaTKJ6Scz80lQd1nj5541H8zITgJ5tjrAT9lvgdnWYrTwv7zuPpzKFToxdHZT8I
	 q3jXhE4EU2o2mGdb5zt5YLW/kcME3lSyZCgaYEOrcVbtKZDGrtRt77tKLdaTFMYlNLa80
	 kWOxBpyoWM4iALiwmCrqjM2xU25jJZ73KZ8behISOS/QZrnivmxY79JOParW2WaAiZVXs
	 FNDyFDNuo91/ehM5MZTXcJOUHqdrLR8QbasQ8ZCgQdcOxs5Guc+iSVGo6ohA0wT5/GIVc
	 don75AANg7k+a+gXARdbl6fyE8K6lOFgd5AFqgDke8LGxmoXuZ3gP1Uob4ogi7E+/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s+lTuK8T;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BC606A31A
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 03:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 886BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s+lTuK8T
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35d0be18c71so328143eec.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466238; x=1793071038; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
        b=s+lTuK8TyGsDTJIZWdcjYB9tCb4/bZ/mX1hHF0qp2sv8ojdTrutXo2sATTYLLRgYXe
         mEjM1NTU+kggZraFyj5q4CCXNuDB441yacPGL+An22aupnT6YgS98fOpUWuX8OAb0npd
         uRyD9cXtcMdX1Wpai15UmbZYamTI5/6YYFqZeih0Sg3WAn/oxanLhG1S7S02/ju1+NvX
         CIKiFhq458ZTfjuUecYfJ3u38MUSE/Q1rKWq6/mTC5gZtW6EyD1ttJJO5X1vUBxVQS8J
         +FZE0bAISUWEYEShGxwGp6QyZmJEZ5GAjtgQl7Bo8FLaaq5t8TqpoBVmV9HIu6/Be9SP
         w5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466239; x=1793071039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KvEq34+Yf4dDq/T/EyGx6kouG+iVHJ1jZQO8J1NJeBI=;
        b=qFD6WyBgMuSnbuGanMWBdM9tX/esVFjznD9j7A1DN/ufr/dhbZS5BXyyVDLRxTOHge
         /atROJ4BljZP/f2SAe33vjlgXqL/6L5h754XFfJhlebLbawn2PKBgJbpvRKX+2Xk3nI5
         TShMmkdh3NV+r2ybvIU+Di3EmXRFvglJCkIZ3Q2n7nUFxEOO3IKzR5YW18pbDSwqfqhj
         aFYie9sIozNvdPlVAJk/+g58mIpQTHWYh51nGh2f+2S7Xgzp4KTbRHTW3FSQfSPYZzDY
         Qof4rqT61Zs3xatdSSYICVwhpRoPGzkhyLsOKqaCXKm/mOQOK6kaAI0nTp8ZUkPgdKNB
         T97w==
X-Gm-Message-State: AFq9FYLQhF83xBAVoo0hw2ApmmVpqIcLuUbVaDYSqkuVm3hKCKTRIG50
	/+pSzdhc1yxkx7fh6xUyU/9HccbjENVl0r5VhswADL1CINZar/Iz5f3GOcG8bw==
X-Gm-Gg: AYBFou0cmhz9DAeKoqmgaWIlAz0Zh+tGi5MuEEeSyaz/sNQ97naC86/Xl6tztC5XEpV
	Zy+GkBCOQm622S5OR+8Saho07fLvam1Q9PmKMWzdQDRhuUgt3wjmUKa+zYYNJmTevOd7n6H7Qxq
	VuSd/xZLtdn0Nj3qpkbs36bkZvDucqfm1L+1AiAHqDJSrc+zOTOzseWWJEyZooS+W2gi33PNx+r
	BUk2nDwVJJQfTCGu1yx6cZLCxaBlV9Oc4h2q6KjPn4gWuZXY51WclV5i4Hk5b/Xrmv1CUY6Uvso
	T/YuKRoxSCaEzPGQcsWKFi4l+SUoH6sn1nVIHky6JsWWegGqj82GRUYR8incCM9Gm3bJB7NtQNY
	2+B6Cx/PwCjctMOXZGFUxI+NLBMkjPEzpTCizOYUfdbCL+6bay2fQBJP8KbbuqzJFYP0G2jZdQv
	rX7A9KAcJZtwJiHhMwz9PNpccvHnQ3xTpcZPX/LiC1+M0sPBrYNlyHh7dj1tL2y9Vn4XawO0yh9
	PMsdUBfLch8QTm4mIb0nF8AtJuv0qwHGZjuPLqMrK1ctYnmqdrjQNzkTbftbvnyhUMbErNOBLhC
	hFVZkWS5zK+yIOL6seG0Mkbvu+PhebdpuPMVM8mo6O0=
X-Received: by 2002:a05:7023:905:b0:143:808b:b178 with SMTP id a92af1059eb24-18dc13f3f22mr1268546c88.26.1792466238163;
        Mon, 19 Oct 2026 20:17:18 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm38473608eec.21.2026.10.19.20.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:17:17 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v7 1/6] selftests: mptcp: connect: retry write() on EAGAIN
Date: Tue, 20 Oct 2026 03:17:06 +0000
Message-Id: <20261020031711.1896660-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
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


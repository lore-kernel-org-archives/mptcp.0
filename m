Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041B545DB2
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988438; cv=none; b=XkHfjE10Mw8RQ6WYbWo9kh2XA1VkXdu0cAAPc//Ze6m020svO5J7itz9L6aCOdveGRxsBFT85U11Gw2sV0DSTSu3PmkXdIa/rj24Eu5QURZoYD5sRh8nvlR5p+qtNwI+1vutWyTJqKS+cstjTvgh6V1BG20sxuPk/5UKHa95OMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988438; c=relaxed/simple;
	bh=pVt48CC94/NaejNT25qHB2vtvqzTbEe+Gr/A6gG792I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ay9os6ATc4msfQUlWy8ub97mHIAz0NSqGJYtw2vX/Ikd35hD8GvUsLPm/Gd86npW0NJOV4KO5bgzpQAWd0dx2zTA46MszPvCJDUTC2dwIsFRgMjshOziL2FTBhaoy9PbWO8kI3Z/p0cV34UyuyE6kFB3gCuMZF7rKvNncPzxoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc1y3l/Q; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc1y3l/Q"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so1746890eec.1
        for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988436; x=1792593236; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jaZZ2Je7Ko3TIq7T5nVmc2S7oeolCRfMbqqxEkAHg7c=;
        b=Gc1y3l/QjS6F+HS/Dg1e3kXTofaMMBL8IqrxCyvbxLlJsEvVJPVCpmuQbQxT2XympY
         ek4oKYcI+GerUjnLxLfhSps7W/aO0khuJcaB5wFISRmymczH66iZSvApp9jxzTNKFZRJ
         Slsrpn2WaDyuWOFnyo4JdvDS6cZ7+2cAWhzXXosx/3HTEOzTosgYV3wqQ8/7IJAIwfXs
         FXykv0bh01RGl931uu1C7wxvRIiMWCOxxQ2aiCwEqrk29MOs98Qr92cTPWjAxM/LpRUp
         o6yk8A5m4KcqoX5mzsrJ7B3KUlZ0IDBqRrdbl3ZSd7gkphS5qyCUIkPjlqCLwMmPioOV
         M12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988436; x=1792593236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jaZZ2Je7Ko3TIq7T5nVmc2S7oeolCRfMbqqxEkAHg7c=;
        b=hgJB0NNaQ2qKIbxbCthJF52OpbqBjzPFlAaYFptLdjWUEYiKxMyNkpD8gAiEkNOZa1
         dQb0/3gBGhF1qJpkaESeIErV/rIra4K9ifhfexkFPv4qitqPim+eiYnO0cXICn7SvhcM
         zISWuIx5nwrnn7leA1rEqi+XLY24NReNhbtZYv7boOD+BFYIEDRMLpJ/69kC5Rzkpedp
         OkPKBeajBuHmgvfgbhqspfROG+4MZFETqEyq/omcVo/BIH7Cy0Nb1+K+Vk2Y0eyTYIVV
         /DmJKzSwBHJ+InsDbkykn9QDVM2Zh3xdIu/a66U29vgIANuf4FGOH7Rgv94rEbxvfIWQ
         Hu+w==
X-Gm-Message-State: AFq9FYLvFWdl+1MmgFtC9wLEc6nOrrLE4OKWnuEdwqB5I5HnBEHbxT80
	gdXxKbE//GsEjoFMxfQHSBFPfvprcKw8bpDwinbWqVO+5BGtPO5S1nNuQeHqww==
X-Gm-Gg: AYBFou3ab2+qUMvdZ4+laRv1Su/laHagYjbN3kwF3x4K3skN/JXgqgS//oRdJrCgR/o
	yrIZbPjhOyA8BvJDpgqdo+BtB1MUUJwo+FBWCPJUqXVlyF+UbgiinjFfggphN8rRhc52+PQ/ceK
	OFf6g9Y6lnt2puyV2HAGM6/eKo1EDj+Sbj35JKAYDm/vbBDats4dS/QS3HTG6W40/Ew536FSvWS
	oMB47uHvVHsc0Rzknse0ECvB6Vizvv3z/3CckFBUbbqRgOnCKsDaZMrhme4PnGihOnLuBAtbw2o
	t1kMU+SF3IzM5jxPibsjy6qCqHqgXxVuX2vrN/SO8rb4OkXEhU6pkGaly7E9DZVOMoAgAWFX5ah
	4JXPlEAc0ehSyqwT85+ciQMevCCmnsa1gwyzjcWM5j0I5VG34ecykINl0/NZTAZCeUeNIKWGdvN
	Ar/2BpYvz1L6JrFkYAkj0jJlKbhSe9aL5IEZspGt+gd/eLY1mEeywhHNWi5Jc0konj1km2fAB/d
	yl1VxJRXFFq1LDkI7bgq0wIWR+NHDCQtJro0dN36qaElyOVB0viqUDzbqPacQgYDXe1votqpI2j
	pKSsbdT8ZE6YxnBW6eSHg9qmjEwKchSIBkOeLy94Onw=
X-Received: by 2002:a05:693c:20d1:20b0:35c:e696:2d4a with SMTP id 5a478bee46e88-35ce69632e9mr5660032eec.24.1791988435374;
        Wed, 14 Oct 2026 07:33:55 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm54997609eec.2.2026.10.14.07.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:33:54 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next v3 1/3] selftests: mptcp: connect: retry write() on EAGAIN
Date: Wed, 14 Oct 2026 14:33:47 +0000
Message-Id: <20261014143349.768138-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
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
back to poll() and wait for more space. If EAGAIN lasts longer than the
poll timeout, still fail: poll() does not check every cause of EAGAIN.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_connect.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..03fff859e4d1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -638,6 +638,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		.events = POLLIN | POLLOUT,
 	};
 	unsigned int total_wlen = 0, total_rlen = 0;
+	int eagain_ms = 0;
 
 	set_nonblock(peerfd, true);
 
@@ -711,6 +712,20 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
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
+					    ++eagain_ms <= poll_timeout) {
+						usleep(1000);
+						continue;
+					}
+
 					/* expected reset, continue to read */
 					if (cfg_rcv_trunc &&
 					    (errno == ECONNRESET ||
@@ -723,6 +738,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 					return 111;
 				}
 
+				eagain_ms = 0;
 				winfo->off += bw;
 				winfo->len -= bw;
 				total_wlen += bw;
-- 
2.25.1


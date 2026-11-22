Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308482;
	b=mSHkIc5ia47R6w/eL076HoUrYRY9UZihcPwVWZ9tOoK0XTr9mtI7j2MVc3jsPgmuxw2o
	 NO3nwXtAnj0LGU1goY+UaOVJ8MSv/Ut5UbAsbj/g9y+miSwOOMfgmUYMYQF/GeEQsxYBg
	 2tGEYBrbU1zVrM6xXw+Ex1ccQtf9oMnfjq6iV98VYpH+RzsT2cofz/Fcgf1W201p7+kWv
	 ffQtleFpORjYlnaRxRkx09xQf5uZ/dxA4L6m0rPwRqNg7XoyUMzSci48UAU8ab6U+FkNl
	 BhPmX1Ji/jZucCbqkbTMk+apRJtapdaxhVP4Ei4cqVMdLiPvpsc5AOx4sNLf0ieDTtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BBGufdg9g2md1iv9HZVv91zR7QaqbCx97+AmMRsiGf8=;
	b=iJmPS0fylp5wBQJEStmVA8CMk1hxp6NziyCK4fIRaa7vRaO6mZb4oE59ODLmhszb/Gk1
	 i3SqEHJee0RxeDWDkAB6DMcpcJ/e88nzlPAYB74LetCwV+i8g6eUJbpJuPMfV0FQMOE2Z
	 M4ZBkeIg3uKjy7Khtq7aOlIpZxP61EGQcH17Q458wKuOi7V70fFQRkidIc43Qo19NUWWy
	 SR+Bj/V/yotZ+3G+az0DQ/Lav/1nlfUcyZ/TmWxWa+qBgyXBUDW25xU+Za5y1k8XbpTZS
	 lOv2s3yU5I52pA/GU9BTsG8rLgtad5mZnP5qWRApkM0WF7wxIOSJECWKl4CO5WVi+Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0SckR25F;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C24606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 00:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C24606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0SckR25F
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-380b40312e2so4779209eec.1
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 16:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795308481; x=1795913281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBGufdg9g2md1iv9HZVv91zR7QaqbCx97+AmMRsiGf8=;
        b=0SckR25FjbQ51UT6lirnff0/BKMb4WlNbt+AbZH0yNfJeEq+aJsiwBeIDJ+tm1HDan
         yRVPT9HOVFm0lb5Jex0Nt33W3TbdLxD3wbWIwaiFmaNPFoXVsy+pDGk5o7VpbolnONt0
         3TKA/AkSXQgkuKjvwnwYMOmfn3Mfl/l7b2i63v+08hNL04vXAhVkFoJny2c2UtTNVgUF
         lx8cY5CViEthiNtukCGaH5CzSklM5VJdnMGc7Hmn+KkQQ8/cnFI+7lshPZxxj/RE40Vq
         W8SyBjzNZ0cqmDi9gLg3y3LAofb9xINXFIa3MC/yYLCWnQvakd8zO6gZ+BKNCXbif8Da
         z5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795308481; x=1795913281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBGufdg9g2md1iv9HZVv91zR7QaqbCx97+AmMRsiGf8=;
        b=2V+r1OBScT19tBaUJeVEeVXnEyWBy6n36iAeaWYxShgytaiexqxAQdT/F5gA+1mYCZ
         EINJhNXug2bZf105j8nTC8bJeUf3a5a7d8Mm6s7Km9IDyD4mRAXKohIakY/A/Nb1e9U1
         2jRjNlC3fEDMCuSC55BFnoi053BXAbN+XATxVwcxddTNdsOe3WHBEUOhrc6z0LX0H8ZV
         1dvM9cb9g/7ISYsH3kcfB6VCpy385EVMgfMu7TgyYqoaESKC9KdLYvjvHVKfLIvOPuIB
         8Bk6mTru3+NRy9qvwA8jbgrJZROR1Z7XmILj+Tjy6UoID/i9qPMla1Iw+wtLrYeUoFqT
         eTRw==
X-Gm-Message-State: APuU4Z86sZrTVfHscA8dbfuQ8YKPHECnJOiyPTytM4dXKosaI0DIfwOb
	3nRx7L1wIvz9KF9u5qVnhE3vb9Qg+y5hgovyD7MU4a88NyUBvoCmR8te1kjs2Q==
X-Gm-Gg: AZFdTZej7lKWmmX5m/ztKzpA51I0OJuaaYcfe27OOXIHwaZvItAD723GHYsd/eOmL2I
	qx5NJfs1z+3j8MMx94Ew2cCTMJ/ymW9JRnnK8ErYq2o52iKURWhSgNUurYOftmPW0qVSVerCkKk
	Ui695KleBzIO5FIxsh4p5J5daGp6pJR4q6K9gAqfFfXwK8GRfu/zSrbYYPzoxlKBJ/qjX62P7Tj
	zg2N25R0WgKUJhZWxpPjmEbhO/UjiLdztEtnCn/QpGvPvrulWwbDNTo6ofe+9L0GR6ExrFyZ2R9
	WOMvTqvkC+s5iaU+xCCPt24J85I4K+zAzyiArvsobKERGAgyzJDuZkJXV0Hrj/rYr9ZB2hk/oO+
	zKbpSlqwllTwvVVYAIWhMBDFx8ugwXtVdCBrBDi5c6Q03nWigh3YOfZNbFqcHbDS1URxBtvVmKu
	50EXYEOJoA5vSxNZLEz/vNZRlgx+WXjlOajthLhEy2aWJK9EvRosjYJ02wJkCP0JKICNhIHYneo
	5gCrvqACkfO3mCmbdrwy2u2J3NepIKSUdwLaZYJ9ucxi2pw1LbiMzK9a3T1xHb/RqjlfXKmFHFP
	Ivnbk7SlgWntBE76+uoD5cc3hBdEaWJNi86dNB4cdjTcyUrLJxuDp6ogVIBl1c86MZCtlq65ylS
	p4vh3EqF+hbf9hPyUJaYQnJyD+kZTbrBDLpGTfP+Aga0iqrocd4lPgS9rxia1wx/5WX/MQVIpAQ
	==
X-Received: by 2002:a05:7301:e0cd:b0:375:dbeb:b363 with SMTP id 5a478bee46e88-38570f221dcmr7941431eec.28.1795308481076;
        Sat, 21 Nov 2026 16:48:01 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm20219599eec.16.2026.11.21.16.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:48:00 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH mptcp-next v16 1/7] selftests: mptcp: connect: retry write() on EAGAIN
Date: Sun, 22 Nov 2026 00:47:48 +0000
Message-Id: <20261122004754.2276802-2-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
References: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
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
fail after as many 1 ms retries as the timeout in ms: poll() does not
check every cause of EAGAIN.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 .../selftests/net/mptcp/mptcp_connect.c        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 8c788977e594..aa819dae1721 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -651,6 +651,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		.events = POLLIN | POLLOUT,
 	};
 	unsigned int total_wlen = 0, total_rlen = 0;
+	int eagain_cnt = 0;
 
 	set_nonblock(peerfd, true);
 
@@ -725,6 +726,22 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
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
@@ -737,6 +754,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 					return 111;
 				}
 
+				eagain_cnt = 0;
 				winfo->off += bw;
 				winfo->len -= bw;
 				total_wlen += bw;
-- 
2.25.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113917;
	b=DtI0dVRGcAhI0nj5WIbPnRnXOyO9jUIIjGHkzJjyJNBP95DpfhybbKQ7QmZ8cu/Cs5zb
	 YYfJhEidnB3dwtE7wa1zAZE1X3sBKdV2dTHtVV8LZ6pH4wKicQjl7wnqNo2G1wVe8wX7L
	 mQr9r26+7Bb95Z4/QnaSZTfOJ9AkEDfSR5NkVcRzYuZVhGrmySAZHnPNg0Vb6cwFSfUGJ
	 SQxMGTrI0c0RChyu7lKPlsVmHQRHAsp+Hw4iQhCTVtUnd1ApkGW9pTNK/pdRYmg11D0i8
	 TAyfhpaop7nhkfSmIrCjbSObMPsj1ftghxLn/+a2ikc6BRPyjDq12yjCjlJcSPtoUiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cTGML049WcnDPPmM58b85ff7QPmnXyo2S9lKRE7+E50=;
	b=U+b1Wc+3srt3Lhwk1eX7ZcoTCt4AQqqaF82xMDT0YvDD3W1ZknKsvVigonb2oFIFJDn+
	 LKybni5f4uPnZ2mN1KpG2etlr7zJSciAcKgXZk1WIcWGZt2V2x98H6fIkZHf6P/U9myZs
	 sEOeIPnD7bS7MLtrKQFpJw/08tStVbRILsVzdlwRjR8fM6SL76CX2InisfgYxUTIqElxP
	 mBZdVKfAOzNph8mSHDDrGhLmUpFE1T9MUpfvYauKiQisf7C+7898wWsBi2WVKX/x4/k2W
	 RT++5+DY7pg1TCB+43KPSRCB0uh/B6Hhzuo2cDNZtUo410IHyOocPTqaKcqY2YYg36g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNWbUDgf;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743B606A331
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 18:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9743B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNWbUDgf
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so38364eec.0
        for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 10:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795113916; x=1795718716; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTGML049WcnDPPmM58b85ff7QPmnXyo2S9lKRE7+E50=;
        b=lNWbUDgfUVXu1enyuwz/pekP2bMRS6xua9QBhs/YMmbw9s3Wnw7lJPJ4Gqx5NFH/dz
         FpemDYJvvryqGddqdadnI8J16LgJ2Mbqbui09QumNgvHurwyt8agvtvWjDe9NusqiZ3M
         ZMDEuzBCRdtdJt2B8MbknldeARVeUHTTG69y59ouHGgZv359lKWUj282JVplmSPqx95s
         t7KowhX9PFNOuO0pvW8nfgUDWoaf9hG1Ucy6mDMYv3N08ggsdETKFueDxDfGqn8GZpNH
         7f2fCXf0jb5Vlm47xcTyDP5XTcDM00Akh3CgOTDGCzMcd9qvvZFLIyj4Bv6j2ydY1UtO
         R5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795113916; x=1795718716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTGML049WcnDPPmM58b85ff7QPmnXyo2S9lKRE7+E50=;
        b=SOVg1x19KvMrv0pyh7cTan5FaVBTjsWNq4upY5aqnbUGh+vXn0QfH/TNH5lHvU6ZGm
         z3LBLMNVDwDITuqWpI/K8ioN2CBUVXteXErP6wckh1k2pouX9lVcOv04/PMKGerLYwlI
         aeShSwx5Qf8lHZNgWl85ylZXa8KKedlnL4KxcDWWxKXb0CVujA2fRU4MlDAnKHzzmaU5
         ix4Yd04MGYO8005IxlPo9Fxa9L1IRCOk+8eHURvgoHb2b2pAfvNQWnD1jeFZBp1uxVxa
         Dm9cC1vtjWUxHUtS2SGXqxwi76T4UNe66Tv0JRsYYpVXFKlYd0yOkmWWfxKXOaR/D5J1
         oi/A==
X-Gm-Message-State: APuU4Z/BU0bAlpbhZHfXBulbNf57JRdt12yJGoS3lO30bjauz7+sAu/L
	H6vyz6j+z8SbDx43B/c4BVJD6Ei1wI6DXUFb9JQummwMxVJh7gKCJDvAyyZDBQ==
X-Gm-Gg: AZFdTZc0aOzii1sYd3vZR9kacSDpH9G8hPG+LqPfOVt5yO1F1JzCRIpKbadsY6agZr5
	+MCh3AfuJpNIaSpv5+YTUn3CcIn6kSNoxCXB1AKUQKe0xCESmLUR5MfznZVjpkpo3UtQWOG7PUe
	RdNDKrzMRmvCOVZLor8oamQ1S8muP1ytng0z3K/O3nMGD0O7S5c6lM1zt97jMr9D7j3XYX/GKrN
	todALa9ltMHtN7/PO2l3NhpRLcXYUEbTwPK4pklsZGVq53fmegVtneDFsCtLqGvmctKKd4FfhiT
	7N7j4ahNby16LTBDTIcf2bUf6vzzml+8Hxx3vsng2FnDwlZfajJr5P9eUdMdFz1x26MnMk/zyYF
	dBXCXgtHEAYipavfsVS5K4viun5lMLPsGcOWBmmdvtGS3Q/d2FJUQr0sYBe4qOeb/xerz5ehHyD
	2W9jNnwVnYQuMTIfTxofpIxCnOpnhReEPKKtNEMj7+O/OA1bcj0TzFsQPjh0r27ySqOD9wWwfah
	GEA3plsJrWaZZFWWNe5JAHr5atJBlAo6Aj7sw0m3dqZjluoXhbv37iQmxabr3hcZAcU2DwBKOrI
	PZeB27ZjqDT8iCT6Y6Er/5GI+DlHhxjqMRd7wUAeMZa3xZdfOQNegnpnp9Se6HEM/rfwNtiDpAW
	V85bS0EwAnRUoIYcclWfQUTvco0AulMFpxIVuJpTtv7avZxYiJYokL1GuzbW5orFa9KtcF+7GdB
	ZQ4JLe4vD+0RalJOICVe8=
X-Received: by 2002:a05:7301:6405:b0:381:a3bb:f945 with SMTP id 5a478bee46e88-38570254ec3mr268284eec.22.1795113915353;
        Thu, 19 Nov 2026 10:45:15 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm542607eec.25.2026.11.19.10.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 10:45:14 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH iproute2-next 2/2] mptcp: limits: add subflow_retries
Date: Thu, 19 Nov 2026 18:45:07 +0000
Message-Id: <20261119184507.1954726-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119184507.1954726-1-anilkaushikwireless@gmail.com>
References: <20261119184507.1954726-1-anilkaushikwireless@gmail.com>
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

The in-kernel path manager can create again a subflow closed after a
retransmission or keepalive timeout. The new subflow-retries limit sets
the number of SYN retries of such subflow, like the TCP_SYNCNT socket
option: 127 by default, also the maximum, and 0 to not re-create it.

Add it to "ip mptcp limits set" and show it in "ip mptcp limits show"
when the kernel reports it:

  # ip mptcp limits set subflow_retries 5
  # ip mptcp limits show
  add_addr_accepted 0 subflows 2 subflow_retries 5

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 ip/ipmptcp.c        | 21 ++++++++++++++++++++-
 man/man8/ip-mptcp.8 | 10 ++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 54976c08..92425a5f 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -30,6 +30,7 @@ static void usage(void)
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
+		"			    [ subflow_retries NR ]\n"
 		"	ip mptcp limits show\n"
 		"	ip mptcp monitor\n"
 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
@@ -362,9 +363,11 @@ static int mptcp_addr_flush(int argc, char **argv)
 static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
 {
 	bool set_rcv_add_addrs = false;
+	bool set_retries = false;
 	bool set_subflows = false;
 	__u32 rcv_add_addrs = 0;
 	__u32 subflows = 0;
+	__u32 retries = 0;
 
 	while (argc > 0) {
 		if (matches(*argv, "subflows") == 0) {
@@ -379,6 +382,12 @@ static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
 			if (get_u32(&rcv_add_addrs, *argv, 0))
 				invarg("invalid add_addr_accepted\n", *argv);
 			set_rcv_add_addrs = true;
+		} else if (matches(*argv, "subflow_retries") == 0) {
+			NEXT_ARG();
+
+			if (get_u32(&retries, *argv, 0))
+				invarg("invalid subflow_retries\n", *argv);
+			set_retries = true;
 		} else {
 			invarg("unknown limit", *argv);
 		}
@@ -390,7 +399,10 @@ static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
 			  rcv_add_addrs);
 	if (set_subflows)
 		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ATTR_SUBFLOWS, subflows);
-	return set_rcv_add_addrs || set_subflows;
+	if (set_retries)
+		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ATTR_SUBFLOW_RETRIES,
+			  retries);
+	return set_rcv_add_addrs || set_subflows || set_retries;
 }
 
 static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
@@ -424,6 +436,13 @@ static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
 		print_uint(PRINT_ANY, "subflows", "subflows %d ", val);
 	}
 
+	if (tb[MPTCP_PM_ATTR_SUBFLOW_RETRIES]) {
+		val = rta_getattr_u32(tb[MPTCP_PM_ATTR_SUBFLOW_RETRIES]);
+
+		print_uint(PRINT_ANY, "subflow_retries", "subflow_retries %d ",
+			   val);
+	}
+
 	print_nl();
 	close_json_object();
 
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index c03935dd..cacee416 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -92,6 +92,9 @@ ip-mptcp \- MPTCP path manager configuration
 .RB "[ "
 .B add_addr_accepted
 .IR  ADD_ADDR_ACCEPTED_NR " ]"
+.RB "[ "
+.B subflow_retries
+.IR SUBFLOW_RETRIES_NR " ]"
 
 .ti -8
 .BR "ip mptcp limits show"
@@ -268,6 +271,13 @@ In both cases the
 .IR SUBFLOW_NR
 limit is enforced.
 
+.TP
+.IR SUBFLOW_RETRIES_NR
+specifies the number of SYN retries used when the in-kernel path manager
+creates again a subflow closed after a retransmission or keepalive timeout,
+like the TCP_SYNCNT socket option. The default and maximum value is 127,
+about 4 hours with the default RTO settings. 0 disables the re-creation.
+
 .sp
 .PP
 .B monitor
-- 
2.25.1


Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FE392C46
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457813; cv=none; b=UfQW781UGs7vSCC4WkJS9wIowO2Z0lKPdB/4veMA8wZ+J3pzXftH53mtlO6mLfpAdEBGL1nlLwzIXFMsT0erf2lAge3GqRPwHEXeV0Wm4escsSxEURQTnbOse1qlw0nc3gOxioqkvseQq3JDZ7jhhc1kAHzds53QT0i8wqylI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457813; c=relaxed/simple;
	bh=OQ1sBuwp7i4mtiBMz3g9ZmE1aw++E1wr3jKq7s6Is9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7NsbKiHquXOkDoMOzVqGEi8oZKzUuUGt6k0Q1V0NLPw3xP6WZN+jUbHERvvEo4V9F4/bUEpEEtQr4eHFj6+1Juchw3j9B43tUqn0xpzzRhgcIIIxFJZEkZhwXvxLzgdBTjWsCwk9nAt0V5NNDVdhRU2dDZ5RYwUeYplZhutiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNatWXxu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNatWXxu"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso1585746a12.0
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791457811; x=1792062611; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ksAcPAYjWXgsbyCjE4ePPZl3/rW2axHKGjjtYG6aLyc=;
        b=nNatWXxu/G29P8lLVykACYfR0fzCQeBvmhS+aNMT6gPDHsy8vhTz126756yrUpOS2I
         CjVO0IrFUPO38TZSTfyl24NEf1LTUvo3gsHRafXoWvObVkQW8lFg+NUizEfoieYeBcyD
         fDO4aA7eKXql4D25/rqLIud/t7N5Vmm6CONILKGt5sOFRPjK+pGNRNJgGC2A9/o8A/Ry
         9s+59rLQiVni8DUeM4oo4jSU5FW2FvULCQPww14RVNvzi9LSp837jiAn/Md2zdXzgJOi
         hu3NEaOVa7BWXZF4XwXqDL3EWcXhhf+wu+d0KxfjfrA6QXwxLX5zcWWaBgcI+FMXmwSA
         d7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457811; x=1792062611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ksAcPAYjWXgsbyCjE4ePPZl3/rW2axHKGjjtYG6aLyc=;
        b=Qn6X48laEGoMUBxGKKE5yqDSk9QJhDZhuspF8TfqRnsLB9aO3wicLRW1eUNiO7092k
         M/MIelm6FEpQkr1B7wiqLjrJ1kkHDPqrpqQc5Cl3pwjJRs95NemG51aJIE4kq7xzztHB
         PALU2xdXYvwoxy1rPVIy0wi/D6DgxLKV8Lgqk+jdWoEVycYg0iz58Kahg9MDvjlAy6bj
         r0HpwMZH1xZk5DR2n3bB5w1IRNWO+9TZkeGpYBPSXaKUE155lu2sWVKt0JBZeKmzFTM2
         jlIlpHS6A0IhpmKg7K5mzEckFZi+jZv0ybP3QQviYJwwC+IJbt60O1a+JLEh60OmFozv
         jkcg==
X-Forwarded-Encrypted: i=1; AKwUvBzcexCGk/8gmHfjCr8N2GCZYb95eedR3hnnVeyz+e8ZM4D4+PVX/ujIqOlbQ3NNfGjwwFjTAQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nftXQY6KSx9OtuG+L3Ecv4ftfPBxMwT8ihEN/OYxPQJu41N5ph
	E+mZYqLyUwWters6qfSnHDSQPJcUMTZeLTpiSHMlJyzZodJ+MPYWOX2u
X-Gm-Gg: AYBFou1qz3y/zz79VXSdHIdPeYaIVdpPRXBHhBVYnW3taXQMowvACFWqvwgpFtd/GV/
	g9CFxp9u1B34WxQhSMxNlQet8qlgq1EX4lwBxnOtJV1mnP9Wi63Pavx+/frnwyoOSEUsVqwFcsD
	q7BmaNr2p0CFOewVgLHlbtAs+Wo3uZI9PVw3CugsDpbiNimXchraV186CxzXZuWPgcxS0qxb02z
	0dgUiLdxB+tseasAdgUABLFB1D8ZAAoLeGtRLAWHXnisyxOWBwZ5e/pQUBQWwq9EUPMywvBarCt
	LHmTnbXn65WyC1qeal+733hBVm7Bqkb4Ure22ufmrhWZrSqbeArwILSEMyTA2Orv8ysowJTDedp
	o7ePkR5O6+5JJchuq980KarImCcIVZ6Md0sXowMIzAO76YAjJ0rKXYsc0MnEF/bpJAFrz6bkQUQ
	DNTEv4OHiHHQbpLIW/Cgr2QGmY+T0BQdg0Md6jG3Y/TcDEOQwKgGouw3QlScy7/XEs7CUQoe2ht
	bOdDlLp
X-Received: by 2002:a05:7301:fd05:b0:351:2958:1740 with SMTP id 5a478bee46e88-3515debbfc0mr4973570eec.37.1791457810536;
        Thu, 08 Oct 2026 04:10:10 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c2esm14847521eec.10.2026.10.08.04.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:10:09 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH mptcp-next] selftests: mptcp: sockopt: test passive Fast Open early write push
Date: Thu,  8 Oct 2026 16:40:03 +0530
Message-Id: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add automated test coverage for passive Fast Open early write data
push in mptcp_sockopt.c and mptcp_sockopt.sh.

The server enables TCP_FASTOPEN on an MPTCP listening socket, accepts
an incoming connection with SYN payload data, and immediately writes
reply bytes before the 3-way handshake fully completes. The client
connects with TCP_FASTOPEN_CONNECT, sends request data, and validates
reception of the server's reply over both IPv4 and IPv6.

Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 59 ++++++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 34 +++++++++++
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936..04af7cebc 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -28,6 +28,7 @@
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
+static bool do_tfo;
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -247,6 +248,14 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		if (sock < 0)
 			continue;
 
+		if (do_tfo) {
+			int one = 1;
+
+			if (setsockopt(sock, IPPROTO_TCP, TCP_FASTOPEN_CONNECT,
+				       &one, sizeof(one)) < 0)
+				die_perror("setsockopt TCP_FASTOPEN_CONNECT");
+		}
+
 		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
 			break; /* success */
 
@@ -264,7 +273,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "h6")) != -1) {
+	while ((c = getopt(argc, argv, "h6f")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -272,6 +281,9 @@ static void parse_opts(int argc, char **argv)
 		case '6':
 			pf = AF_INET6;
 			break;
+		case 'f':
+			do_tfo = true;
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -719,13 +731,36 @@ static int server(int pipefd)
 		break;
 	}
 
+	if (do_tfo) {
+		int qlen = 5;
+
+		if (setsockopt(fd, IPPROTO_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) < 0)
+			die_perror("setsockopt TCP_FASTOPEN");
+	}
+
 	r = write(pipefd, "conn", 4);
 	assert(r == 4);
 
 	alarm(15);
 	r = xaccept(fd);
 
-	process_one_client(r, pipefd);
+	if (do_tfo) {
+		char buf[64] = {0};
+		ssize_t n;
+
+		n = read(r, buf, sizeof(buf) - 1);
+		if (n <= 0)
+			die_perror("read tfo syn data");
+
+		n = write(r, "PONG_REPLY", 10);
+		if (n != 10)
+			die_perror("write tfo reply");
+
+		n = read(r, buf, 1);
+		close(r);
+	} else {
+		process_one_client(r, pipefd);
+	}
 
 	close(fd);
 	return 0;
@@ -775,6 +810,26 @@ static int client(int pipefd)
 
 	alarm(15);
 
+	if (do_tfo) {
+		const char *addr = (pf == AF_INET) ? "127.0.0.1" : "::1";
+		struct timeval tv = {.tv_sec = 5, .tv_usec = 0};
+		char buf[64] = {0};
+		ssize_t n;
+
+		fd = sock_connect_mptcp(addr, "15432", IPPROTO_MPTCP);
+		n = write(fd, "PING_DATA", 9);
+		if (n != 9)
+			die_perror("write PING_DATA");
+
+		setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+		n = read(fd, buf, sizeof(buf) - 1);
+		if (n <= 0 || strcmp(buf, "PONG_REPLY") != 0)
+			xerror("Fastopen early write failed: received %zd bytes '%s'", n, buf);
+
+		close(fd);
+		return 0;
+	}
+
 	switch (pf) {
 	case AF_INET:
 		fd = sock_connect_mptcp("127.0.0.1", "15432", IPPROTO_MPTCP);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e850a8742..b3b523ce8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -351,6 +351,39 @@ do_tcpinq_tests()
 	return $?
 }
 
+do_fastopen_tests()
+{
+	local lret=0
+
+	ip netns exec "$ns_sbox" sysctl -q net.ipv4.tcp_fastopen=3
+
+	ip netns exec "$ns_sbox" ./mptcp_sockopt -f
+	lret=$?
+
+	print_title "Fast Open early write v4"
+	if [ $lret -ne 0 ]; then
+		mptcp_lib_pr_fail
+		mptcp_lib_result_fail "Fast Open early write v4"
+		ret=$lret
+		return
+	fi
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "Fast Open early write v4"
+
+	ip netns exec "$ns_sbox" ./mptcp_sockopt -6 -f
+	lret=$?
+
+	print_title "Fast Open early write v6"
+	if [ $lret -ne 0 ]; then
+		mptcp_lib_pr_fail
+		mptcp_lib_result_fail "Fast Open early write v6"
+		ret=$lret
+		return
+	fi
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "Fast Open early write v6"
+}
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
@@ -366,6 +399,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
+do_fastopen_tests
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.34.1


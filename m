Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A82228CA9
	for <mptcp@lists.linux.dev>; Sat, 29 Nov 2025 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764391107; cv=none; b=jitsD2hH1s7DnaHQ9BswCBLSrkYLGAGIHaR9h2DQNMAeb/5qbQL4B+Se23EPNHD9gZ3r+cI1gbrgE2sDFqrEWQR85DTvwrOgxqzxilK6NItmv39Dw4rDMkBJxiADNFzjyceNUS46LGKG4Ya7Xn9L7R3O9lG8mJLZ6gBq43APwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764391107; c=relaxed/simple;
	bh=MY6OepM4iCbQKboU2CzDmLhc+cf4XBwZQTl9an9blRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X28B3ZguxJ9tWCj30W2nkwm9pF2SHqAlR/Y/gPy82FwWUHzVX1obAdzt9myTEQOpHSJYEFd4TaQO0/umVQra7PRs3hT+AW+KNlLyyV1T9FyhlAUclglkSOrVOSLi8eg3WD5HKrzlYnKdT/5UKs1/SJpYhhtQB6mm2R7wcM0mQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evi9XO/7; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evi9XO/7"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-297dc3e299bso24159965ad.1
        for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 20:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764391105; x=1764995905; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoUjNl1uE2KTMWSYxjynIphVvFokAcjMOIAnwbmph0g=;
        b=Evi9XO/7ytyJAhAzT6YQhIypCvQID/CdbL08/sVl3ooVnBGEVKp0ehEIaHnna2gjtT
         u7Aj5Oiw7xNUjjioPrz+wruFWM7BnSrD/mP5QsbywNfJX++kbiZR4yISx77Us/Y5nCrp
         6l7zVgnHf6Ubjl1lh9k5950c88f/PX7nam45CDvHYZNM1+Mh/QKfP9/5JE4QgOP6eHWU
         RQ31SySAaGXSKVxa87DqxCv0heOXu+lVzT1IrJs0Cpd1dL8doH9hZLjy4qeCl5aPRZZb
         hQPdq2L333u8gAE8wWmiibP06jhQLDLbONZiqmX1jYSNAJpyRf66mdRpHcOkfMmfESA+
         Hdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764391105; x=1764995905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoUjNl1uE2KTMWSYxjynIphVvFokAcjMOIAnwbmph0g=;
        b=RZFm9WgV72s6GppaMSoUWh4Mr92FeZTpcGEsMZ5WQrC9JoO4LF5Ix43yxcmNtOpGmv
         znJ0yJC/XI4czN82b9SIPj1Q1kC1JssQoSV1oOJL1d6R5VkwYJbpEAMIB94pcGns0P4H
         MKqDP0mygvQTFrbFJLxChGD2HBY4j2RO3qDTXULiWkylYOpABjCYn+cREoDWKnwGKCV2
         sGmng9E+3DPd2l8jCPJ590nh3j0BGBaU3j8DPvyU9JQMQSUJquxz8iDSDzSpfWZs0Flb
         3X7hyfzFoeDudlkw1r5nIHiDVBMqIEXyckyZZ2Y3P3AajIcQcNtCeDnKuN0Idn7LK+A5
         TeTA==
X-Forwarded-Encrypted: i=1; AJvYcCWycJBsvYMBKUKcJG3uxetHWD30KwSX2ijv8CGfjXIfd+O1eLx1tjINXqNCTdZoIuqv04yXMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBg8cK+tLaebiqCCiPrHTmeJIjFftBvzPhTIWYWzbM+DIDd7c6
	J+jZEblYaSYIgFQ7UusjlyaQNkzblk0nljHUt3ykz1E8v5FvnFdPuK7j
X-Gm-Gg: ASbGncutzWyXDXdsVc0fwdG+n9JNMW7nrIUAchYE/Qid/E2YzKkN75ETpmv3CElI3lu
	hw2PGkm8P+tQ9xpiKxiBRKhUP01PXEvBnt53MpTnHkiLzJT0NnjQf8QgMKJNTjTypKOkeqa2eaI
	HvTs/YEjZNTMhfQwU2p+8geBCyi9B8/jJwhPrZ+WlWTxrdRc+oaCLW22B88u1ZHlZtNCxZnsvOt
	UZRcOzzbnJQrGuqVM9Pj+qnVDHwuekE/7iRnbw2oiqYQux6moeM+kQkS5w81NJQ0TfDkM7bvqeK
	5RQQEyBo//zZVUDkUOS3U3+a7/WkJ5QNKDfadv8fB0kbi0W1dSIpU/cx90lj3StrIr4D8aKLAb6
	nJn0IT5whSH9Q9wcl0ti7MDYBfRNeR538TmnMy7re9CPjcBRvXbnyLlJpZzt3csEK3gq5bst7+W
	94hSMhTUv3Dr8rbPmlPSF1R4U1YtKp2HMNf8d3hu2t
X-Google-Smtp-Source: AGHT+IE3d227D6O/a6E8EeYXs1AA4qchJAYZ2y3RerwefcyJ6amSAoYNHYb6emQiTrh6d6t1kWOLlA==
X-Received: by 2002:a17:903:1105:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-29bab1a156fmr189382745ad.46.1764391104946;
        Fri, 28 Nov 2025 20:38:24 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5c6c9sm60774995ad.97.2025.11.28.20.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 20:38:24 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH net-next v2] selftests: mptcp: Mark xerror __noreturn
Date: Sat, 29 Nov 2025 10:08:08 +0530
Message-ID: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler reports potential uses of uninitialized variables in
mptcp_connect.c when xerror() is called from failure paths.

mptcp_connect.c:1262:11: warning: variable 'raw_addr' is used
      uninitialized whenever 'if' condition is false
      [-Wsometimes-uninitialized]

xerror() terminates execution by calling exit(), but it is not visible
to the compiler & assumes control flow may continue past the call.

Annotate xerror() with __noreturn so the compiler can correctly reason
about control flow and avoid false-positive uninitialized variable
warnings.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
changelog:
v2: 
- annotate 'xerror()' with __noreturn
- remove defining 'raw_addr' to NULL

v1: https://lore.kernel.org/all/20251126163046.58615-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/net/mptcp/Makefile        | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 3 ++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 15d144a25d82..4c94c01b893a 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -35,3 +35,7 @@ TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 EXTRA_CLEAN := *.pcap

 include ../../lib.mk
+
+$(OUTPUT)/mptcp_connect: CFLAGS += -I$(top_srcdir)/tools/include
+$(OUTPUT)/mptcp_sockopt: CFLAGS += -I$(top_srcdir)/tools/include
+$(OUTPUT)/mptcp_inq: CFLAGS += -I$(top_srcdir)/tools/include
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 404a77bf366a..10f6f99cfd4e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -33,6 +33,7 @@
 #include <linux/tcp.h>
 #include <linux/time_types.h>
 #include <linux/sockios.h>
+#include <linux/compiler.h>

 extern int optind;

@@ -140,7 +141,7 @@ static void die_usage(void)
 	exit(1);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 8e8f6441ad8b..d4a729814662 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -28,6 +28,7 @@

 #include <linux/tcp.h>
 #include <linux/sockios.h>
+#include <linux/compiler.h>

 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -52,7 +53,7 @@ static void die_usage(int r)
 	exit(r);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 286164f7246e..15cea5e919b5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,6 +25,7 @@
 #include <netinet/in.h>

 #include <linux/tcp.h>
+#include <linux/compiler.h>

 static int pf = AF_INET;

@@ -139,7 +140,7 @@ static void die_usage(int r)
 	exit(r);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

--
2.52.0


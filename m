Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAB27F724
	for <mptcp@lists.linux.dev>; Thu,  1 Jan 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767288540; cv=none; b=GDCBGa4S/DNTZUgy43sn152I4GaSX/vaGzm7a0AmzF4DRTI5wu0KLg5oksFs0p02XJQvq2h6sqsofpT0XQ+VcSB1w+91xBj1ZeHwnMsVlqHgrNWL6lc4+SziDYyE3onRJ0ienCBTtYOQyayn9RW4fX1QM6mLN0vj+dojzbovvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767288540; c=relaxed/simple;
	bh=MV5n72uyCXTGufdfs+Tp7/c9h3fB3MkOv24cXNNb7zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YahKmQECHc2GOeeWyWHHHoAzuGGzAiPOVTN+iwSMNKtSMY76IqXih8K2H8+8OzIQTBbIh/cmrp8LbZCTXGSteZY2h8nd0ApSaFfoxVv0cRa5UFMtfzYOd4C3w6EOVq+q8FmMQuaD/wM40kbNFpa0oj6+gKtz5kzrDNhmH/zx4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaegXlKq; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaegXlKq"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso6353083a91.1
        for <mptcp@lists.linux.dev>; Thu, 01 Jan 2026 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767288538; x=1767893338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrW3GbVAxBV1YYnSWttRqVD3T0zt7/uD6xCGh6+826Q=;
        b=IaegXlKqXeviaWN9Pnlulg2MDjirlrKNHSrg+EKBQp7d22HcRfX/wqyMu6G8Vsscoz
         FtsqDhcGwrgIAKWtHA95X4t06zGQ4isNHigH1h4dT0zxxMcbp3gkFpS/7aOnykQ0NHJs
         TBd7aZeBYFOMrsRf/HsRVQprHLJGi1KRii4WsBblG2GX7FO07HwWrFhMwJ/z1vA5H2j1
         nB70dtSzXksAu/jcGBlIXW8ce/IwEHDq2ascYemL9y9+akwB5cF/D5nwfcK2rUS770kO
         h/YfKFGXAYZTuLi4WFzP2MB9+byjgr/XC4N6MG8FNHT/xRbc6fJPgE/t7wixap+h1Jpe
         tMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767288538; x=1767893338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrW3GbVAxBV1YYnSWttRqVD3T0zt7/uD6xCGh6+826Q=;
        b=P2JQPzUb9IgpU6AjNBprVyEokTuAebLlj0ZxG224SkF3dr17+Y+ZTPVNWAtJO/AinS
         MV/SQJeXIp48pW43WQpnRwBFQdzRvjmyZj0w0W874rfNSe9d8DM5bclL6UP2uCeJYN8N
         UW825Y3MFG1gqN1HvCBwr/p2tZuvAhHWRN06e1twf73wwRtLCggmUueJcgGotwZgNCgg
         //Mr3QI6PE9LqsrTy+FG230kDnPXjQjGO++Bhdrgc/l+f5JjLyoStj78tabaocz+gLI1
         uNbGSeVUeMY+O9pgBKIqNz9ZwXzFRA1L6WDuoZl9413DrGN0lxbmIxbxGApQu9yaWQvv
         E6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmGrgC0FR9gxWyfEyxMK3GT0jbtnaiYbWLXn23EU1NwdHxzDiP7TcBoWmn0pXEkyy6SVG/ig==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjtU5LyzKR0ZkcN2VIvRLa4a6tmV6jpOGVY5jIWufAzM0G0arW
	N2SJqWOakL6vwrxr5CUqgOpzib8gP/4BJahkIyeBqL5GsMTRP+a6aUR6
X-Gm-Gg: AY/fxX5Xw+UxP0DyNYafphG/1JWzmHhNl0RHsFCQ9zLiKY6PtoaZFMfKdHX6y+woiyG
	FVZ9vOVIQUotAoXo8SJy48bTdAv+AJgBPKp8eI7h+Vu3RvftOZEdKBif1GO9negz0/aSEKGZ9qJ
	UApIAs8Q6MGpmO80M4wN8qYKUSJY7HdjdVvUo+WB+BHoKXdqMawIRsTFDvnf8j3C6XW+O8CPzAL
	abw463pToLR3Z/C1xN0gvaWjv1hC8EEkyvYkXG0fjy8HTWjesdCfWuzV2005LVYV3eT0O83ZTvI
	g0Xg80+JUh0pAhEFIl2A2Ho3QaTxu/RDPfaFJVG6W+tebGO3NnKu8F8W1qGanVT3u6O7z+DUzgk
	pok8tAf6vKPMl5dFPyKz4NaiBgSR9eg9WfOkoBUvWdWtJQIYscwGwXsqP4eFL+v7Lm5NP5kcE/B
	gqBOQsbXcpYB/HGMWOi9z1GvUodpktav8n34A/D++r
X-Google-Smtp-Source: AGHT+IFq/e0ejvWVIghaAdB4wbXdz4r0A1x/pqGUvUQjwWFjrtqQuvmu8127TTkEaqjZBtPm+dNKzw==
X-Received: by 2002:a05:6a20:3d0b:b0:366:14b0:4b1b with SMTP id adf61e73a8af0-3769ff1bb74mr38532914637.38.1767288537751;
        Thu, 01 Jan 2026 09:28:57 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79e05712sm33360272a12.14.2026.01.01.09.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 09:28:56 -0800 (PST)
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
Subject: [PATCH net v3] selftests: mptcp: Mark xerror and die_perror __noreturn
Date: Thu,  1 Jan 2026 22:58:40 +0530
Message-ID: <20260101172840.90186-1-ankitkhushwaha.linux@gmail.com>
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
v3:
- also annotate 'die_perror()' with __noreturn
- add CFLAGS at top of makefile
- target this patch to net instead of net-next as suggested by Matthieu

v2: https://lore.kernel.org/all/20251129043808.16714-1-ankitkhushwaha.linux@gmail.com/
- annotate 'xerror()' with __noreturn
- remove defining 'raw_addr' to NULL

v1: https://lore.kernel.org/all/20251126163046.58615-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/net/mptcp/Makefile        | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_diag.c    | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 5 +++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++--
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 15d144a25d82..4dd6278cd3dd 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -3,6 +3,7 @@
 top_srcdir = ../../../../..

 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+CFLAGS += -I$(top_srcdir)/tools/include

 TEST_PROGS := \
 	diag.sh \
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

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index e084796e804d..8e0b1b8d84b6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -5,6 +5,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/inet_diag.h>
 #include <linux/netlink.h>
+#include <linux/compiler.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <linux/tcp.h>
@@ -87,7 +88,7 @@ enum {

 #define rta_getattr(type, value)		(*(type *)RTA_DATA(value))

-static void die_perror(const char *msg)
+static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
 	exit(1);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 8e8f6441ad8b..5716998da192 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -28,6 +28,7 @@

 #include <linux/tcp.h>
 #include <linux/sockios.h>
+#include <linux/compiler.h>

 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -40,7 +41,7 @@ static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
 static int proto_rx = IPPROTO_MPTCP;

-static void die_perror(const char *msg)
+static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
 	exit(1);
@@ -52,7 +53,7 @@ static void die_usage(int r)
 	exit(r);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 286164f7246e..b6e58d936ebe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,6 +25,7 @@
 #include <netinet/in.h>

 #include <linux/tcp.h>
+#include <linux/compiler.h>

 static int pf = AF_INET;

@@ -127,7 +128,7 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif

-static void die_perror(const char *msg)
+static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
 	exit(1);
@@ -139,7 +140,7 @@ static void die_usage(int r)
 	exit(r);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

--
2.52.0


Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55843FC6
	for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 10:34:20 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id e21so30009020ejz.12
        for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gK7Fuk/mxZ2LNujauB2rnS4xUfiDhSH1Rspzvmwpk7k=;
        b=CBcB4w0oHfCeN1jmxo6NnI3GqlFe9Ym649lUh3l99/E03EOvC0dZVEGq2U1EiubnFs
         PgHWy1Ksfpgz/YoaKY3W+rpTh7Zvd6YcTqNe1omOXWQWVeLx011NAAJ+qwozomqy7yf1
         v2Q1VxUnC4JSw4S2zBIw6AYmAja5YzXF50FVXofT/3FpJhvnxIT4YsrQymSlFO2O4qGh
         0sAxKLVBVhJQUbnyMtFWA1RLIwrmA/m34M+5xqf/tjynvjKpZRD2Xg3dyb2YlYSy/AAB
         qb/Jzw4tEdD8+FTFO2YogTR2GihpFt+QUglbjZXQ1ElKo8TzmBQuvgS/uHhSxt7U5pWE
         eD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gK7Fuk/mxZ2LNujauB2rnS4xUfiDhSH1Rspzvmwpk7k=;
        b=kny+807GXte9lOU5SYxHLeOQCLEetdbRC3qmceFWTbHJhoU83Jiogz51NUvHZBHqsi
         iCbhxk79+q9dV5j00HYRmGp6J97tc4w3bEjZ58uEHQCwDLAlYNcOCeRZYEuFZP53H8Hh
         C4qKUfwEWvdumXC0wPrIIjEXZJ4LnDwd8nH7gZ4b+V3+pUxcBvbnfhhlS46J8GrKqFY/
         2iGU7naYtRgGQ/nWhfGeCmNXsDecWAf7qtNzhczrik7QfZRthotjSc7iLufxAi8wxOlN
         02kiU/QADLV8zlJ7cAlP8yUY2aqj9Cj3HjVCuftzbFS+TmTLXWH1z+Pqwb2w46ejSEab
         thhQ==
X-Gm-Message-State: AOAM53132lGBiqdHciGCuusSmxgc/gEYKpdsAOlaqKhs30W+eVSPPrSz
	eKQPY5wrJS6sewbpGkhJvGN8yZECrCJ6xTSbUrY=
X-Google-Smtp-Source: ABdhPJxAxRu7u0CGmCrtf+X9F0G9yVgazhT80OAPHxtgxcIqjkKOZcAHmxNYYRUHDDYLhcgAogEM0Q==
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr23861741eji.445.1630319659056;
        Mon, 30 Aug 2021 03:34:19 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p21sm3282755ejm.88.2021.08.30.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:34:18 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: add mptcp getsockopt test cases"
Date: Mon, 30 Aug 2021 12:33:57 +0200
Message-Id: <20210830103357.3114290-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210830103357.3114290-1-matthieu.baerts@tessares.net>
References: <20210830103357.3114290-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3 modifications have been done here:

- Use '#ifndef MPTCP_INFO' instead of '#ifndef TCP_TCPINFO'. I guess it
  was a typo.

- Move 'struct mptcp_info' inside this '#ifndef' and above: same order
  as in mptcp.h.

- Use '__kernel_sockaddr_storage' as in the parent commit.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 66c4cee37937..417b11cafafe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -33,7 +33,24 @@ static int pf = AF_INET;
 #define SOL_MPTCP 284
 #endif
 
-#ifndef TCP_TCPINFO
+#ifndef MPTCP_INFO
+struct mptcp_info {
+	__u8	mptcpi_subflows;
+	__u8	mptcpi_add_addr_signal;
+	__u8	mptcpi_add_addr_accepted;
+	__u8	mptcpi_subflows_max;
+	__u8	mptcpi_add_addr_signal_max;
+	__u8	mptcpi_add_addr_accepted_max;
+	__u32	mptcpi_flags;
+	__u32	mptcpi_token;
+	__u64	mptcpi_write_seq;
+	__u64	mptcpi_snd_una;
+	__u64	mptcpi_rcv_nxt;
+	__u8	mptcpi_local_addr_used;
+	__u8	mptcpi_local_addr_max;
+	__u8	mptcpi_csum_enabled;
+};
+
 struct mptcp_subflow_data {
 	__u32		size_subflow_data;		/* size of this structure in userspace */
 	__u32		num_subflows;			/* must be 0, set by kernel */
@@ -47,13 +64,13 @@ struct mptcp_subflow_addrs {
 		struct sockaddr sa_local;
 		struct sockaddr_in sin_local;
 		struct sockaddr_in6 sin6_local;
-		struct sockaddr_storage ss_local;
+		struct __kernel_sockaddr_storage ss_local;
 	};
 	union {
 		struct sockaddr sa_remote;
 		struct sockaddr_in sin_remote;
 		struct sockaddr_in6 sin6_remote;
-		struct sockaddr_storage ss_remote;
+		struct __kernel_sockaddr_storage ss_remote;
 	};
 };
 
@@ -62,23 +79,6 @@ struct mptcp_subflow_addrs {
 #define MPTCP_SUBFLOW_ADDRS	3
 #endif
 
-struct mptcp_info {
-	__u8	mptcpi_subflows;
-	__u8	mptcpi_add_addr_signal;
-	__u8	mptcpi_add_addr_accepted;
-	__u8	mptcpi_subflows_max;
-	__u8	mptcpi_add_addr_signal_max;
-	__u8	mptcpi_add_addr_accepted_max;
-	__u32	mptcpi_flags;
-	__u32	mptcpi_token;
-	__u64	mptcpi_write_seq;
-	__u64	mptcpi_snd_una;
-	__u64	mptcpi_rcv_nxt;
-	__u8	mptcpi_local_addr_used;
-	__u8	mptcpi_local_addr_max;
-	__u8	mptcpi_csum_enabled;
-};
-
 struct so_state {
 	struct mptcp_info mi;
 	uint64_t mptcpi_rcv_delta;
-- 
2.32.0


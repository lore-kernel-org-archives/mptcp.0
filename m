Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50D2CA6
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:50 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id d27so2415112wrb.5
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUbElglYi2bACeCaWgbk6XZJdRkvi8+nDJaEzVTN65s=;
        b=cR8acegf/3BqGbW73ncdmtafdHZinJcic0UZ7/6s+GJjmW9Gzh1dgYK2hLM6aEDyZd
         vpRccR9IWDajVP0YCEDoraAGEqCExA8lsR3wi+gKOTp3tkxYoOOOu2OnAer3cLWYA9Rp
         CNB+BWVs0KEvO94TpTY2y8GYQ7AmZVs/QiwxqQOoaoJ/EX3LSgtESIjKjDIAtQgNwFrJ
         PEP+ll48AzXU7ZMpQE2hB6oiM6JOjX2BemcUCadRR4OafeYKObGbmiXayJmuwwDOQwl8
         buZ1J2JIo9Cu8zG5jNh7UUYNrD9WZOYoYoKVZhA0R94+Zev/H8/nbxfAw5aqgqcvj1ZT
         RQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUbElglYi2bACeCaWgbk6XZJdRkvi8+nDJaEzVTN65s=;
        b=Ix62UtVJXpWep+/NDquYb/aDoGa8HC1BrSbPLM9UvO6/XFPty+otiUbG5SQjFGMuU3
         jFWlRvxEfSahfu04fi5lFV8zWLRomqSaC6XBHKj5paQjt+8HnLIAbmBPJRv73lg+UOAw
         JsnZ2milzKHb0cInua0mGQomJ90lhfLE2+vau6mco/CSwZVN1gRTCENwsrAHh3KjXAFd
         cCmaTbnAzaYNzRD3xp8+6agdBGUws1ZrxrA8PEpQ23KG+nV6n8r2+r+Ybww4UaY4cxJ7
         zaKx4L7iaTH52ojkPpegJfyeo124sq9wjkDhE+pDgGBqIukm5VGWKppgcLOq82wc23aM
         w8Jw==
X-Gm-Message-State: AOAM533aO76UvHGEub0Y0NZxvON+5BNQR1MHGxXrUBqtkJ1/TGOgLFnQ
	UTpZEbM1kB7ficE0DXM3WvbyNaehl3+1r5QI
X-Google-Smtp-Source: ABdhPJzomyzex+RcKgmDEQGYni6QBET4WqUcUSKoBpekZLiikyoTCmHEBjGqWoVcxnoInvlyPjsq+Q==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr3791356wrv.647.1644441948643;
        Wed, 09 Feb 2022 13:25:48 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:48 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 5/9] selftests: mptcp: join: create tmp files only if needed
Date: Wed,  9 Feb 2022 22:25:16 +0100
Message-Id: <20220209212520.2989291-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tmp files will only be created when a test will be launched.

This avoid 'dd' output when '-h' is used for example.

While at it, also avoid creating netns that will be removed when
starting the first test.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ce3e7db30b9d..5691221ca302 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -18,6 +18,7 @@ checksum=0
 ip_mptcp=0
 check_invert=0
 do_all_tests=1
+INIT=0
 
 TEST_COUNT=0
 ONLY_TESTS=()
@@ -41,7 +42,7 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
 			       6 0 0 65535,
 			       6 0 0 0"
 
-init()
+init_partial()
 {
 	capout=$(mktemp)
 
@@ -104,6 +105,21 @@ cleanup_partial()
 	done
 }
 
+init() {
+	INIT=1
+
+	sin=$(mktemp)
+	sout=$(mktemp)
+	cin=$(mktemp)
+	cinsent=$(mktemp)
+	cout=$(mktemp)
+
+	trap cleanup EXIT
+
+	make_file "$cin" "client" 1
+	make_file "$sin" "server" 1
+}
+
 cleanup()
 {
 	rm -f "$cin" "$cout" "$sinfail"
@@ -136,8 +152,13 @@ reset()
 		return 1
 	fi
 
-	cleanup_partial
-	init
+	if [ "${INIT}" != "1" ]; then
+		init
+	else
+		cleanup_partial
+	fi
+
+	init_partial
 
 	return 0
 }
@@ -2342,16 +2363,6 @@ usage()
 	exit ${ret}
 }
 
-sin=$(mktemp)
-sout=$(mktemp)
-cin=$(mktemp)
-cinsent=$(mktemp)
-cout=$(mktemp)
-init
-make_file "$cin" "client" 1
-make_file "$sin" "server" 1
-trap cleanup EXIT
-
 for arg in "$@"; do
 	# check for "capture/checksum" args before launching tests
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
-- 
2.34.1


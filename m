Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F32CA1
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:49 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id n8so2264026wmk.3
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXfXysL+qyS8a5hJddIFVQ8pfxxd4mbtDpEUFh1yN9Q=;
        b=l2/W16xa8mLBfMpAJXxtmlm2qBHBWb01+dnvUcWlLIsiWh7EZHmqZ761jy6ppagXQX
         UzFrQYy1bAqVy/xVah78JQwxM/dO8qeuGiFfywxrfxPs2Hs3KXgF+wH6BrfK/CNIf4yt
         6O/Qw45UB4Z7D2DRvU+M7ADicUiiyqqwYYGFhOkX1Ka6wL1TrZQkQuR2AbwiWFck7eTu
         xlEp3fmnSXe5+9AxuNqm4QPLnukZWUaGHR5ZBHzvzDczjNMSZYWxJj3yv2se2fhWGj82
         0X6ftzpNBQx01iV7/qVMKVpbOzN2LF6FhNWbrbGl7MC3yyZ7e6nL/ESrUBKr1bCMLEk6
         U1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXfXysL+qyS8a5hJddIFVQ8pfxxd4mbtDpEUFh1yN9Q=;
        b=xszCvg7MermQ1wN1e6IrkacYwr8H7PDsxFu8mOUhrcXPr4CfRDDtlSafbW/Pa7s1Hb
         VBm8pt8uCvFLO+EvytysFZcfXohUqD3WjSHmMM/85DhV7xWy9zwhw6KhNyhYwQdIlZdV
         zjh4d+KFjNjO4SvfmWHVGpLEc/ikO+zfGMuq76jKgFfdo7PI8Lg0+X/8X5H9nZ4qP5C6
         /rJFxmEv/rrSq+KcSPJoX4MtPy0Kt2S3Ednl07x478yFMb6jb6sPmucOpQZn7q3SWTeQ
         2YiOwV2xoY7LpKl185HiGLKiWe0qXvRk2XJ8FfrnloadcSkmoypRWPPxuLF6HZiLREfm
         wIIQ==
X-Gm-Message-State: AOAM531S/ASTLcHF74xn7COcTMqJNy+OJAsI7quB5ZWEL1dvuQk1ymzz
	7O2PW76rERDvvXLCNoMLpUKa0iqdgz9UnP51
X-Google-Smtp-Source: ABdhPJxA7U2eIKWI+ZF/Qu9AOtz8iEgTk+MLY2SnpOWrCvSjBy2iguCATRo712ItFX9nl9elpy7CQA==
X-Received: by 2002:a05:600c:4050:: with SMTP id j16mr4382648wmm.187.1644441948099;
        Wed, 09 Feb 2022 13:25:48 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:47 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 4/9] selftests: mptcp: join: remove unused vars
Date: Wed,  9 Feb 2022 22:25:15 +0100
Message-Id: <20220209212520.2989291-5-matthieu.baerts@tessares.net>
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

Shellcheck found that these variables were set but never used.

Note that rndh is no longer prefixed with '0-' but it doesn't change
anything.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2dc81646e326..ce3e7db30b9d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -45,7 +45,7 @@ init()
 {
 	capout=$(mktemp)
 
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
+	rndh=$(mktemp -u XXXXXX)
 
 	ns1="ns1-$rndh"
 	ns2="ns2-$rndh"
@@ -701,8 +701,6 @@ run_tests()
 	addr_nr_ns2="${6:-0}"
 	speed="${7:-fast}"
 	sflags="${8:-""}"
-	lret=0
-	oldin=""
 
 	# create the input file for the failure test when
 	# the first failure test run
@@ -730,7 +728,6 @@ run_tests()
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
 		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
-	lret=$?
 }
 
 dump_stats()
-- 
2.34.1


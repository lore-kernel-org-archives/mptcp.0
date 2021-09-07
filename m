Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E13FC1
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 10:42:12 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id k24so9486111pgh.8
        for <mptcp@lists.linux.dev>; Tue, 07 Sep 2021 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1K7ugEhop6LCWfr4ijQCmh95fD7Pz5Fai/YV5A3EDdc=;
        b=VkpOGbjDZLHlsNiIN61pNlaphJYMnAb5PpWHzJzWlfQXID2h1ricQgXAQaVP4f76ZV
         A/88kM96zEaa9DqL4J1oXpeYL5/yBxXBlac7ovKiy88XOgVx3NNkgYasilUHwCqOPKpY
         N3alTTO3DY6b+jIhir9zk1TjaT/TkECSZV5UzLQyF7V7XNa/d/3fA8ho2hTyUBmdnAzm
         LN1Qdpd39YzkpdjK2Fsq5xpvRO5jgonn33EiHekSVejl0OEeFEzZd8SihTVFHN0LqE6S
         wl+Wpz/EcpUnlu34aFAQgEi7rbuMzDRjmsJhqJLi1ZtUCpjMeknvu5e8yZvGLYvtcGsg
         d4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1K7ugEhop6LCWfr4ijQCmh95fD7Pz5Fai/YV5A3EDdc=;
        b=H3z0Fgz/WqXQpGVoMAbd8Z34VVZUOzemk/fLIM6nyR+CMZ+deHttobHrZqz4Pa811g
         simLIgTTUnY+ukcow3Yty3U9FOPytojN/J/mPB+/vKuLk/BXNEQomi/cmir5n1XHapLb
         oX/wHByG0z+aAlOzQphdhEIi4ODiDnIuaZkJ9UMwlRjW9NP1v2iarjtsagSlbdHc4YkA
         StsGiYdAidgrqNf+u5w+R9y4D74592zGkS6y9JKU1VsXFnZ1/iLu7R9zIkYYSZAnUHNB
         eEcJhns4sjGlzpq6Gqu8h6dYlFt6cCqXfpBoE92buVvrlI6My0S0xj/YEVVYnpLrDgeQ
         n0Lw==
X-Gm-Message-State: AOAM533uM+sKZEtdG85b4/BlysMfa3WEW1CpbNB0qUHYj0oNyroND7CQ
	R6F3xO0vLsbyCXknmJRiYHEZXy+Dp7c=
X-Google-Smtp-Source: ABdhPJxhr80cY3lMcP/ge53m4BivKZeJKD27FiZSXhTHbIGrJmHLYlsTU7Nr6sLApEVNwP//49+taQ==
X-Received: by 2002:a05:6a00:d72:b0:3f7:7f03:6cfb with SMTP id n50-20020a056a000d7200b003f77f036cfbmr20476783pfv.1.1631011332158;
        Tue, 07 Sep 2021 03:42:12 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x189sm10571885pfc.52.2021.09.07.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:42:11 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH RFC mptcp-next 4/4] selftests: mptcp: add round-robin testcase
Date: Tue,  7 Sep 2021 18:41:59 +0800
Message-Id: <7e749e6d27fee702dfc1c6478cb426c36e84a3ac.1631011068.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631011068.git.geliangtang@xiaomi.com>
References: <cover.1631011068.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Add the round-robin scheduler testcase.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 255793c5ac4f..c69b1dce95f7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -15,6 +15,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
 capture=0
 checksum=0
+roundrobin=0
 do_all_tests=1
 
 TEST_COUNT=0
@@ -55,6 +56,9 @@ init()
 		if [ $checksum -eq 1 ]; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
+		if [ $roundrobin -eq 1 ]; then
+			ip netns exec $netns sysctl -q net.mptcp.scheduler="roundrobin"
+		fi
 	done
 
 	#  ns1              ns2
@@ -1854,9 +1858,12 @@ for arg in "$@"; do
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
 		checksum=1
 	fi
+	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"R"[0-9a-zA-Z]*$ ]]; then
+		roundrobin=1
+	fi
 
-	# exception for the capture/checksum options, the rest means: a part of the tests
-	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ]; then
+	# exception for the capture/checksum/roundrobin options, the rest means: a part of the tests
+	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ] && [ "${arg}" != "-R" ]; then
 		do_all_tests=0
 	fi
 done
-- 
2.31.1


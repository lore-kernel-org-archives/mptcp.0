Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD82C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:51 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id m14so6147658wrg.12
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acs+sFsBD+/Wj2OU+Z3H1bQcRouZVneObiFmNnGkWfI=;
        b=zuUq52HfhYCiBN0CZ2RMLl44ahnECvQOmOI4Ayb0kP11lXOiHuhu8VVfHGQg3SGE/T
         2tR1sWEgX8e8H2FPr55ECeexHejpWSQ+HNKJwxBO1DRChj+6ZPwfyrGvZwgpfdS+OGr1
         v6w7KV+aCgfKiQVASDJlbuo7v8vFlXCdb35DKC7aVxFxWhsMEKsntXwEE1zv3r4X5M3W
         zWFSKTUjaIseYSupON3c9p+0Yq34Ndu61M+aYJu4vWPLKssxKHxto4A7cnvPxFwmsx3q
         CRM3XcSBlCVB8eJaGt9q1gRx2a/hHz/4R9FOwNciOHfbmrBorYjh7dzbH5aw8lP38KWP
         B5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acs+sFsBD+/Wj2OU+Z3H1bQcRouZVneObiFmNnGkWfI=;
        b=aeEU912rys5nDbWxBx61pJxL0fhpvPIp/SOIonWH1G95Gsyf9paCH13Jl9T3l2sBSe
         xXEv7mmpiv5Qa1rAGBuOoDhdgBdHfrbPQlrr+meE9kwtVdzmrNOTwkkJN5Ed8flqH9xB
         kmlCUPr8+An2EKJQdYYDx6DJYUmjK7xAF7pUCXHm2Zk3bqlPH0LYP3IbnjksNXU+oJRo
         Z0FbFCHedrsOyVI7/lh55Ujr/E14PiSRKiOcX4Yh5UwbFYc2Z14L3xPcsoTgyuc5tafj
         fbKngM1uENewCE8U8FuSk3ODNEqY72GeiRzTDXy/QOiy9eA7nLgic3QS/+B2ya0g5YHq
         Os8g==
X-Gm-Message-State: AOAM5324po7hgEO78P5d0Ea0prhK6rudIz2I4RcvPzZdc1QxtqVLKCgZ
	02W6M/DjwfUZs7oRiHLIR4snDUawPJtARrFT
X-Google-Smtp-Source: ABdhPJyLv9BHpLDbLZfxyM78BibuXoOKTisbnBHtC9J+2+7BvqxMlAi/6fF3Xe/QVNP7BmoRpIKAYw==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr3580019wrr.643.1644441949420;
        Wed, 09 Feb 2022 13:25:49 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:49 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 6/9] selftests: mptcp: join: check for tools only if needed
Date: Wed,  9 Feb 2022 22:25:17 +0100
Message-Id: <20220209212520.2989291-7-matthieu.baerts@tessares.net>
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

To allow showing the 'help' menu even if these tools are not available.

While at it, also avoid launching the command then checking $?. Instead,
the check is directly done in the 'if'.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5691221ca302..8c1ee51e9cfd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -105,9 +105,29 @@ cleanup_partial()
 	done
 }
 
+check_tools()
+{
+	if ! ip -Version &> /dev/null; then
+		echo "SKIP: Could not run test without ip tool"
+		exit $KSFT_SKIP
+	fi
+
+	if ! iptables -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without iptables tool"
+		exit $KSFT_SKIP
+	fi
+
+	if ! ip6tables -V &> /dev/null; then
+		echo "SKIP: Could not run all tests without ip6tables tool"
+		exit $KSFT_SKIP
+	fi
+}
+
 init() {
 	INIT=1
 
+	check_tools
+
 	sin=$(mktemp)
 	sout=$(mktemp)
 	cin=$(mktemp)
@@ -214,24 +234,6 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run all tests without iptables tool"
-	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run all tests without ip6tables tool"
-	exit $ksft_skip
-fi
-
 print_file_err()
 {
 	ls -l "$1" 1>&2
-- 
2.34.1


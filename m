Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4733FC0
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:58:21 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id i13so3776911pjv.5
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYx3YyFoHwDg4nx5uFvbO2npW+beq7yD9VEjzpnMdSw=;
        b=bOZin4pPJGYYFb7LDt6NpIcHc69PKQ2hPic6VzbjFF4UA1qsa9XRkqDVKefzsDIUWz
         1/SxWAcl8+nGAn9KkrGLbYQHtOIdWrmTv4Hcgqmi+s0F17iuTK+d85onPUklTDQKXhGc
         pzizeOsbBaFvxncZolaYlSKS3bHI5EFNRcnluN7onmyBn7YoHvSiIeNUGHbpvVWyjJdm
         uN/MCRUDJQvgT9FRjraUytyaomNfxQbo4Bh2q29snHUqpPEu7BKzO8WaoQZt9xz2LIjG
         hCnJ7xpzPv0ssXM/feS62CvZ6f4XR7DfwU9OkCPMTI/qlG1UspL9HTaSVPd9S8mhzsas
         uWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYx3YyFoHwDg4nx5uFvbO2npW+beq7yD9VEjzpnMdSw=;
        b=sG+JceQRrazIEq7kTO2Q2N24PrlYYNPeXQKAkQgBl/1UrPM4Y5YZZBWCJ7WjikdbYZ
         aHk2QfgznAsRttREWluJHUASeczq39b3ghNIeyRrnwMabpvjRsjBdcFRAuUuVXTkj2hu
         D0RszTk3Nucl/HSc2wm/JgXbcRzHf4RPAMCx4+p5CQolkXNVOjFXkO+YSpkwFQJ6aG0M
         Ng1tewt+t8suUaf0+ixFcPzmWa8fRogt5jHd2feeurENMnT4WLixqF0DqdlC97aJ0+su
         //ILVf/GETpCWFv4IpK/zOugD+nO6ViAjX3YjIFC96m4O8r7zDKTI4zGTeg9xs/ZYWOD
         QmQw==
X-Gm-Message-State: AOAM530N4iaaPDiGcDSAAjJ8+LIMMZktzjDOjyXSheUnv3s56ihpV90R
	CYNiU2am7wUtXrIu7xmlpRP92v9qKAQ=
X-Google-Smtp-Source: ABdhPJwyb02bwIzysMxk3IwtdSIdFKIXND2+2NpSjHDqmaQBW0WDe+SIJLkxrGj+o6a3XmNof7VX0A==
X-Received: by 2002:a17:90a:8c8b:: with SMTP id b11mr12703699pjo.14.1630915100605;
        Mon, 06 Sep 2021 00:58:20 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c24sm6895702pfd.145.2021.09.06.00.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:58:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next 5/6] selftests: mptcp: add infinite map mibs check
Date: Mon,  6 Sep 2021 15:58:06 +0800
Message-Id: <ced757a779ce16dc942d3c508774a8d01a39baa4.1630914699.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630914699.git.geliangtang@xiaomi.com>
References: <cover.1630914699.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added a function chk_infi_nr to check the mibs for the
infinite mapping.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 255793c5ac4f..fe0c8f3164a7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -615,6 +615,43 @@ chk_fail_nr()
 	fi
 }
 
+chk_infi_nr()
+{
+	local mp_infi_nr_tx=$1
+	local mp_infi_nr_rx=$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "itx"
+	count=`ip netns exec $ns1 nstat -as | grep InfiniteMapTx | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$mp_infi_nr_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - irx   "
+	count=`ip netns exec $ns2 nstat -as | grep InfiniteMapRx | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$mp_infi_nr_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
+		ret=1
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "${dump_stats}" = 1 ]; then
+		echo Server ns stats
+		ip netns exec $ns1 nstat -as | grep MPTcp
+		echo Client ns stats
+		ip netns exec $ns2 nstat -as | grep MPTcp
+	fi
+}
+
 chk_join_nr()
 {
 	local msg="$1"
@@ -665,6 +702,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_infi_nr 0 0
 	fi
 }
 
-- 
2.31.1


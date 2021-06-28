Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF970
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 04:29:23 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d1so7552659plg.6
        for <mptcp@lists.linux.dev>; Sun, 27 Jun 2021 21:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRjTf1bCREktT1V4BhWezpPbfiJs0CXebCCc2qH2Na0=;
        b=SucM2rcgwb0kCPfNuVMwgImL3mHd6v2h7RhXyOTJAMYulKbpU6KpIW+dysxzqCVQCb
         2HITfYQpnRP88GWfVAMeezjNtf8kSWH1hasZt/L0l/wXKMqFP6wvCppjTUglWOob9sYp
         X0OaYsyE2hJvUUtTV/A0tBxWSKYWoj0iBPZETBWdunOjmAmn7OABWcVu6dSER/rWWKGa
         Wum08Xid2CbxcAfVcBsExq8TKCTNrQLpGF32+SR4iLJ2sDKjVRyvaoek47cO8ZQReqPh
         PfTjFTm/92Kj2s31fM1PWYerz+ubTSp9lYS41rhbtXlJzVGOawTSCLRh9ufQL5hOvPO1
         /7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRjTf1bCREktT1V4BhWezpPbfiJs0CXebCCc2qH2Na0=;
        b=YbGU0IasS9bKWz0aPVqov7DyewLHKjzvBcLfIYNmeYwq154xpSfFNh2NlF8/ABtuJH
         hTp31Hl7qIMdD9YvkIB14D36d1ztoJE9hojcZoJnBpifYGCkL0oKdxgKQ7OSycXZC12U
         U/e/wPXcUwK9XjJwXFskgFPnI/MKzAaaQuqaTQbFtDEiv7mxTXRg0RWxg/u3iCRU7HmH
         YSF/O9XondR8mk7MY2BdhcGDxOlZR5acsZ+sr0gpn8Ux5Cd7ysM57DUgOivHVRFe0Fxp
         fcoanZpQp20Cancs9E5GUg2rfXxcmynvrVD55VIHPxsjs0KQut/TBaG2y8zEPxuydKhM
         bwTw==
X-Gm-Message-State: AOAM53230url5xMRXBgKimsMk9yHhNI0TjjRz8gBnJpZL9/i7iaxLrfU
	62d+oM+pdZeSAZwK1MQJzfr06J7BWNWHYA==
X-Google-Smtp-Source: ABdhPJyCkREt0cs83dYAjU2SV56jXnpBHD2hsNtY5Ya0HPxM1WU56igwtyQHIp57EZfizJDGEpJR1A==
X-Received: by 2002:a17:902:74cc:b029:128:cd7a:c070 with SMTP id f12-20020a17090274ccb0290128cd7ac070mr6074295plt.57.1624854563004;
        Sun, 27 Jun 2021 21:29:23 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g8sm12837391pgo.10.2021.06.27.21.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:29:22 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 5/8] selftests: mptcp: add MP_FAIL mibs check
Date: Mon, 28 Jun 2021 12:29:01 +0800
Message-Id: <926e95605f1d2a7cdc02b99a1701a1dddf1e6424.1624854005.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <fd3ac7612efa93564019e8542bf67ed38ef06627.1624854005.git.geliangtang@gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com> <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com> <fd3ac7612efa93564019e8542bf67ed38ef06627.1624854005.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a function chk_fail_nr to check the mibs for MP_FAIL.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9a191c1a5de8..535a2757ec30 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -541,6 +541,43 @@ chk_csum_nr()
 	fi
 }
 
+chk_fail_nr()
+{
+	local mp_fail_nr_tx=$1
+	local mp_fail_nr_rx=$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "ftx"
+	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$mp_fail_nr_tx" ]; then
+		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - frx   "
+	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != "$mp_fail_nr_rx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
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
@@ -590,6 +627,7 @@ chk_join_nr()
 	fi
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
+		chk_fail_nr 0 0
 	fi
 }
 
-- 
2.31.1


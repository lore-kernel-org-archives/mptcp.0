Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3B3FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:27 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id t4so2158740plo.0
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkKzUiWsVaredgIGXg1iu5+B3Z7qsRltK25YrnE3fbY=;
        b=Ntqn1Tj3AJUOb8v3twk9wf7xd59UYUpxl4hgRuKpsk2E0gAqg5MxTiIbli3Kjxvv7d
         85dPsN0G44hJ9OOvByX+ZL17iQWfqxydRkW8Y38mQ2y5LRegPmwPUA6J14Vab25VLAhn
         /bRBZyRxCsK3JXdtIC0tbM7qkfUgilZoI4JUK8OH1hIrj2rvnVkM+gu48MC2Xi0UH0oA
         881UZP3w+hM5rsURI8Yucyth1Qbrehq0LclvU5hxh4QYZSkgsnoGa+X7DBpQm0Bs9o2T
         wPAQ/x4YMJ9vgWj4L/bYrexCOZ6andzdYDDcFKgFIFx9PZGndCGz+4sKx3t1BCUKWbe+
         TqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkKzUiWsVaredgIGXg1iu5+B3Z7qsRltK25YrnE3fbY=;
        b=j7bmDAyKsus5Sx/gXKTddXEPxoHNREO+si8jIOkUL3S+wC88ZPxTR3+Ebennj3gIQf
         bH7JblPAQ6UZ2Xp+pl4donYiTMC/7pTBiPbfrPhq6xay1HscBOK22klbZd7EvNt/DEx3
         8qjAELUoU12bdzA6wy1Wl8AYV/ObIQSQ1RX5Ua2owdIqhXHB7bBfpSI7Bf5NAeb9aR6E
         hN3HNSBvlvRItGJIN812jtF9cQFopI0HyTk4nw71g67qHpkksnRawhHrKespgWJjL3UO
         aYrCPESoE4ofqgV29AsFqSilb9uCCbPPHoQu7PAAtINw7Vue2DYSGdOuZE6t9JpilNeA
         yE5A==
X-Gm-Message-State: AOAM531tfS/1ENQfh0mzursPWmqYVZe5OIGAbD46jIk/KcXHkVa8F2Rw
	9CiWgmtB7oGKPFXXN6UXZdXijZkuPZU=
X-Google-Smtp-Source: ABdhPJwF+aYO1mTMDudSif6O8Yq6sDeaLSBxuiYjR9wUyncX20sg1Nzvo99je2Qfq6PXGt/cceAXMQ==
X-Received: by 2002:a17:90a:7c42:: with SMTP id e2mr981176pjl.132.1631611167081;
        Tue, 14 Sep 2021 02:19:27 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:26 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 7/8] selftests: mptcp: add infinite map mibs check
Date: Tue, 14 Sep 2021 17:19:06 +0800
Message-Id: <e0a186c006a5b4f88ff5503937215696046415fe.1631610729.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a function chk_infi_nr to check the mibs for the
infinite mapping.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
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


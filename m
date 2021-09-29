Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DF3FCB
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:25 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id k17so1204624pff.8
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkKzUiWsVaredgIGXg1iu5+B3Z7qsRltK25YrnE3fbY=;
        b=ekgarpMy0poW6zpROjSVieyMNTCfAsHscfi3cNY9wIswAhFCqq5XjJpvSxjRnPgZps
         J0Uzvv+vng1YW09/VoqjTkJSx4NhJTnUn4ykcmK44nzoeYAH0hKOITB3I6ATodKR9i4z
         WIfMaE0wW+wXfnKJAc1ZNhaa5E2X+RPRgLEJXW6ejwHLvTfl7xOkWMD/iMUYXguDTfIl
         wfU6PO2zQcHscc0IC2YDWPk740Gvm/jXFD1nVqIORcV9jWBg2zOBOW5T0UESadSVDPO/
         avMhdwZst7H/Y5DvYAaf1VOp0ZHPijqu2YKUD/GFlLZrgj/9ejoiLkzBzmguJ+fwCeuH
         5sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkKzUiWsVaredgIGXg1iu5+B3Z7qsRltK25YrnE3fbY=;
        b=aRE+gXRZ2gUMAsH/bYZk8If0EalNvRa6zJncgzxxENtOgC/BEvWBanWME7/yIkRAWA
         wtJBvGzSnaIvhwQoBXEFTmqMdp8SLNouW87T0RDrK8FeBLC8HVlZHGKWciFdkH3NswXs
         ZRCmcVGOlZUYNPzVIjjDqjiuEqAhxxO+XeoixujHzorKITyznYnk0y3MddN8rc83wa7a
         tWF0I+iAPGuzjcnuAdzkO9nzIzzuKd5DO4LreW2ZDfNvFwYYxrOHSTFUwYRrHRiAI7Rn
         6XKYG83AfjhTodPfKL7qOQ/Cv3wFUggvj5wcuAIFpk8IVtwb6v6N3BbLhDg5nhvijhX9
         VIyA==
X-Gm-Message-State: AOAM531ijiuUqqVHzi9nV4RzQuQBbQQuoKZJGbXOzl0ZMlaojOU4PMNd
	48HxHxG2U8YKfvWPLnLhv0uS82GzbjJyVw==
X-Google-Smtp-Source: ABdhPJxqhYZmqrDwZG41HN7w3i0WfIEziaDpUxeh+ubBTe7FNaKLI9tjLL/wKHmSlQPqSkgs1TR7yg==
X-Received: by 2002:a62:641:0:b0:44b:74bb:294c with SMTP id 62-20020a620641000000b0044b74bb294cmr9627587pfg.12.1632900924646;
        Wed, 29 Sep 2021 00:35:24 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:24 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v6 8/9] selftests: mptcp: add infinite map mibs check
Date: Wed, 29 Sep 2021 15:35:06 +0800
Message-Id: <0631510c298457e2436d854762a0004e8fa92030.1632900306.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632900306.git.geliangtang@gmail.com>
References: <cover.1632900306.git.geliangtang@gmail.com>
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


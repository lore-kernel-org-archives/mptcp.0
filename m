Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D23FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:56 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso11315945pjb.0
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkKzUiWsVaredgIGXg1iu5+B3Z7qsRltK25YrnE3fbY=;
        b=mOTtkrQZSMetnO45/08TMf4tiBFeLCIR07z4gsKQlAXB5Z1cJ59Nj5ayJ8mVQuGli+
         3ZXg5YFJdzHUm48W6IgeoOoQlNPqbkmKteP23gwD8S4uzQRhIEStLrXkKB4QaYBF05fl
         ioNw/FFzatsbS+knORUE02t1u0DjgiRmn0ZiwJPZfY2i9+16HoRpV5T1fcdA0cWqfQyH
         e3o9ceNSZK9aMax8sUhG3OBcEAuBKUjgoFTacyA2WLCmklIxlINBD6PEnbUeIFO45lQ7
         4eX4lEucrty1AvfdBvSc2QO5re7LBuqXa/2fcDI6JMvLO4vDu94kYBgqBDlDTVIeX9Sy
         hM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkKzUiWsVaredgIGXg1iu5+B3Z7qsRltK25YrnE3fbY=;
        b=3iqBNx6imVjdlsCMohHdFUCV/cRpIXneWbrzphdRZad+XcpZWEw8fhR9o7d5iWY/qv
         NA1521J3bOUGaPS8E1xwh4Sng7echVjfcrEgh3GFsHgxdAd+smGHmvvIVxAp7RtA1kxB
         4Yl7u/a+qn/F4NB/rRddib4wZPxkMYGzW+1aSfdmimJaUTqpnnsz3e1/YMdnAJaelCUs
         2Y4nKhXLDGXuD8i/NwQ5MaEBqTnJ8wErH3+Mp1yoqDfPqRv1EiO4qy64pPlB9UFn0pyB
         KtDVJ0fyjGD7fM1RBk4KFYedpt9y2vHPRUl/iryxiFaP6EaQd99nBuf/FG1g46j9nks7
         CV8g==
X-Gm-Message-State: AOAM533sxHeIpGpPCsnWKo1AllVM/wBmt4MyRfNKMLQmUcf9nAYUQeRG
	8wrxvrICG1Fr6QKXX91LK78FBpgvDsc=
X-Google-Smtp-Source: ABdhPJwfPIQKJbg/gkFy5Wzzq36gVkSqBtfidt3uGqyptkxXh9M3TrugOBptQOwvp8fMWs9NrrAPNw==
X-Received: by 2002:a17:902:6ac2:b0:13e:2b51:ca27 with SMTP id i2-20020a1709026ac200b0013e2b51ca27mr610551plt.65.1632666596034;
        Sun, 26 Sep 2021 07:29:56 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:55 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v5 7/8] selftests: mptcp: add infinite map mibs check
Date: Sun, 26 Sep 2021 22:29:37 +0800
Message-Id: <3191f501117aec229ced38e1e875ec6edaa1996a.1632666254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632666254.git.geliangtang@gmail.com>
References: <cover.1632666254.git.geliangtang@gmail.com>
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


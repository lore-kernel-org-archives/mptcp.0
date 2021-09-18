Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A172
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:42 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id n18so7673257plp.7
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VkKzUiWsVaredgIGXg1iu5+B3Z7qsRltK25YrnE3fbY=;
        b=TvVdE6/XeNVnMidSpHybUuwkULfeQYWD2uqPuAbi6zmlq+BUdutlWBKbrT6KtbzNdi
         TGpuqOwhq2XspacSj7k0dQ257un+2ayBtSmoh1LO+/6f9pSjiGqUQRqrwY6OAK5htq06
         e02IIO5wbR0fGf3M6ApNxXoAC6+WBh994jvl8L+kiikB7q10PLezz5mZP8UUVqLI09bY
         KRbRgAkVnohMCKyfRnc4wq792KRuHb4+Vbv9s0ScRtC/LJ5ZCmG/IUIL0kpIyP48p/5A
         uSkWX7wgUn8IZABaHn78qgZncApdvbnnQMvUZlNu+Iy02pLFZG/GDCcBir2tNIwYZ0AK
         Fo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkKzUiWsVaredgIGXg1iu5+B3Z7qsRltK25YrnE3fbY=;
        b=RorhnfYfrFib7dzszqoTyNaH8NqR5qJ84tUVNHXZWOSnjUQo5LlCSLxpEiCEXTMxTv
         IAkjh2OV59/XfrtcpP0nEMwU3dkmmApXkEQpB3RxGogW5/lhIpyK2tfzNxOv20J8D6wE
         TXf9D5Pd+rWHgXg+WeuhQk3zG6DbOwXqmktTfKqGdFfkeoPOgiQbNUQ48TpNbjSMypF9
         TtuofIODPHPFDhJLizLsUtc4LiUXiTim/BEkqoYdBGAU8IyvrQmNHic7bOgpEaQBrIs3
         3ZvdC0e1O+I46ARPN0Vc26QFWvPh5uxPa1JW0vAYS05odWl9AWc26Un4gIx7BO62OW/n
         yRog==
X-Gm-Message-State: AOAM533Qi0MH4Q4jBsUChbkERx6CY1mRC6103TvZBMPRGyuwuqmxvToL
	bfrpFGuQPeGXe6jOsOorFezj6P2GrGk=
X-Google-Smtp-Source: ABdhPJyb0D3PUIIJ0shmwuYrmlpjp6FyeT5W59YzI5bwzOYIbnF+xCQKqZjIW3oxYAFZibp+vLY89g==
X-Received: by 2002:a17:90a:53:: with SMTP id 19mr25163298pjb.159.1631949762044;
        Sat, 18 Sep 2021 00:22:42 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:41 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 7/8] selftests: mptcp: add infinite map mibs check
Date: Sat, 18 Sep 2021 15:22:22 +0800
Message-Id: <a8a18d1f69a7fdbf305c5183503f6486924da274.1631949480.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631949480.git.geliangtang@gmail.com>
References: <cover.1631949480.git.geliangtang@gmail.com>
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


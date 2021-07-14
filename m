Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5B173
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 10:42:08 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id u14so1927907pga.11
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1gMyZjPdYJnntjHOBwT9ccIYVgc6HeN11nw9AWA1Mo=;
        b=M5rs7tUe2yH5HSLO61lTnbkEmRgi3IV26dgvimTFG9PLiJgNNN+QRyMEtjsBwWpM/z
         Y8KyWUfyeO7hbUas8k6kXLXbleOdTTkEr61wL5RodsGf+AJ/NF3nIL5ZaBvT4je7yOrd
         3OADcDi8gb8T/WUJXwFa4O+ghrS9WvDKo6igJrgVGvxmRxhjJ0ARtkgJemaFO265ATlu
         ZXS3ZBfw7lhTo5dqgBkhfncB5IiuCQwA8FBXRR0yvo8PyYcxkte9nLbvsD++EUqEI/pG
         WPvj8JUS1zAhCV6TGLQktQXSLIRorLNbD08NTtV44TviN9A0b3+9cd11B/f5XaVleREE
         uOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1gMyZjPdYJnntjHOBwT9ccIYVgc6HeN11nw9AWA1Mo=;
        b=q4rBnzfOWb3Ta52JJwqIX3SLJGis+lwYr+zVLVJ+kQU0OG2h9PqUpNkNxmQW9Sg/F0
         Qa1liJo277ljZHUBxhL+Jw056K98UGV47ueEoHW+xdXVza8puktV6xycKvpl7OCR6hCl
         ss8/Y5XqBbrJvIzjOg5dqXECTHeZJuBsjbBx8pcr09QwRM5PR5XLv302llzAE4zSp5zT
         K1vR1iq/GJHLehFOVWeSpx9nAqcPNv86lfWJbZKyVEKWQ7j+VBiI+FWlEANozCEPIe69
         u4dtQjGXcP2fHlmggkPSgW4aoWMwi2DT1jZgiyr/f7lFpDSIm2bVe5CAq9mo6dpAHGKk
         cqDA==
X-Gm-Message-State: AOAM5304h3OOjtf4frzMBOG7gend+7onL+r/DeFj2BgZrc3yR6aRhjI2
	knltHsfdDt51eCmOJBogofmHTcshvj5kOQ==
X-Google-Smtp-Source: ABdhPJysvxhGyvIAdNlLPHmtLzKqDYcd8q2kFxNRJ1ABc7i4xiw6JWn6hMV62PdeYgfswmpwqKbEsQ==
X-Received: by 2002:a65:62da:: with SMTP id m26mr8898226pgv.370.1626259328115;
        Wed, 14 Jul 2021 03:42:08 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x18sm2122904pfh.48.2021.07.14.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:42:07 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 5/5] selftests: mptcp: add MP_FAIL mibs check
Date: Wed, 14 Jul 2021 18:41:57 +0800
Message-Id: <a10df9865250ee098305a9ea2b481455b59bd200.1626258797.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <5df5b6ba135e5951c40056689f885e5101dd1abd.1626258797.git.geliangtang@gmail.com>
References: <cover.1626258797.git.geliangtang@gmail.com> <d719e2be68d4f75b1cb392f67516261a59e94c5b.1626258797.git.geliangtang@gmail.com> <c9b00f7ce8d17ea4fb6e60c09433f36cc144a2f7.1626258797.git.geliangtang@gmail.com> <779edc1afc2f4622d9cffbdf3f8ccccfcdfd33cb.1626258797.git.geliangtang@gmail.com> <5df5b6ba135e5951c40056689f885e5101dd1abd.1626258797.git.geliangtang@gmail.com>
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
index f02f4de2f3a0..426d99c17512 100755
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
+	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
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


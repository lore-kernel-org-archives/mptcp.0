Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB42FB8
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 12:02:58 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id l11so3321926pji.5
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRjTf1bCREktT1V4BhWezpPbfiJs0CXebCCc2qH2Na0=;
        b=U3vMCV1NOK8E4wVHZcroV6hJ4IxMUIYEUMXEa0mg8dIfJWTcacMlThlWLfKAGPgQai
         bqy0bKgDLbFWobLX+kzOFOTiwKtw4cvJRQQHJRbPBWAOk7i/MtKhv45hrTNWTVQ8ozkS
         ps0Csx76ObiBznSfp3zlYnxuvj+0FV2wYqSd8lS0nxZFgGRQKZnoBMcGPGu1pdVShMRk
         Vnu/WQZvXCnoPA+X/VHXkmrOlsaezXEnHIgpndeFFWeWoK8Ck1LMVuBAlW3nMVly7nM5
         OLyyfBp3a0BmrGpuMsVJRqhgviBidyQHYBYuOzgNbpQVFOIenSpkn5Vl76BsfV7xU6Ad
         K80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRjTf1bCREktT1V4BhWezpPbfiJs0CXebCCc2qH2Na0=;
        b=GBEm61rANLpIBmHmzQHpNxLAVRundDMf9/lJeVVRNlWOo2jTeVHE+cIIbdGZkGodHH
         WrckE3IphKPdaM0Uj6bF16FeUc0EOdRKwTpDW1UNatI7aP6YgRDSOcJ9qzvqOLFa9GHF
         DIpTQkvgxINApxAc0q6Mlo1C9TJns2C9TopLqyZqwcEHjUQHAmwxkipptwFuPxlVJjwd
         1XdPeFRbxpY6U/FEMySfV3ILRGYBU5UOBV0hqmW8yKBxPMvhQsLWFSsnyz3mtbZQCvx8
         2lGK8ZOneLtCqq/tiMofrmC4+ayIeA3/SCdfgQLStxKBJov5JX2prBCHxl+E9BejbTBC
         0HXw==
X-Gm-Message-State: AOAM533f2a7KRlpARFEkhETYdlKJO1Akp9igXAV1X+5kq5RTi3kzEcxy
	BpAhS5URkg+2Y+Ks5AbQMNL0irsfh+xL0w==
X-Google-Smtp-Source: ABdhPJyUpl0doKtG1HYPOAY4vvsDdZ24K+AD1+EAC017aXmZaKjiBiUkg7ju4OXB5mzMO4YYPJ/8rg==
X-Received: by 2002:a17:90a:384d:: with SMTP id l13mr5570120pjf.201.1624536178279;
        Thu, 24 Jun 2021 05:02:58 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h24sm2863824pfn.180.2021.06.24.05.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:02:58 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 5/5] selftests: mptcp: add MP_FAIL mibs check
Date: Thu, 24 Jun 2021 20:02:46 +0800
Message-Id: <33ed59558340d04c6fe83fd4ceb3cc620f75daac.1624535762.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a19dbf57d8d1a44e1bf3314f95b1e6023ede46f9.1624535762.git.geliangtang@gmail.com>
References: <cover.1624535761.git.geliangtang@gmail.com> <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com> <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com> <92e3fde76e7efe8c6a5efaae133b21ad637c47e8.1624535762.git.geliangtang@gmail.com> <a19dbf57d8d1a44e1bf3314f95b1e6023ede46f9.1624535762.git.geliangtang@gmail.com>
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


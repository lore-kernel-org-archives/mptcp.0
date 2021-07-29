Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF072
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 07:21:12 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id a20so5974757plm.0
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jw+2gozvuH/YXEW0fIc9lgkZeSSAXLELaUD2N30a1oc=;
        b=EU8RzYmmp//yawBwdyf2cZJiVCgEtBHo93fU5hbovx71bYMNHX8h4/s1nm/8V4seUU
         lpRfPaBN5TjJz7nr/8pim1tQAAU916y7xNt7ZUs50yw9aTRcRN5bQdezwT3CGOD2zSfs
         lwFJ5mabdDylsq2TeaTKDfNdYu+avnt3+3HkGf3LMpG7Rxq9uah7OH+3l5Q3S7cSPlvr
         +TeUBVNGdCiT0Wm/qtClWC+Lg5nz8XreAcvEDrWFQUNHCdegVdxQRMQOtAjfpDH2BeEB
         WafUEXOVf/R8EsjZtU3z6IylxwlwRN4Lv9AJUJgxmHys3FLkiPqPugJYLMSChWJZ+UbE
         9l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jw+2gozvuH/YXEW0fIc9lgkZeSSAXLELaUD2N30a1oc=;
        b=G3XPlxGpOAbKj00g4Cz+wxL8QIq4vDnCT685WY6aB3voq9Y1CoX1U1BvXvxPVVYO9e
         G72o6VAaxc1bmeezdWHjqqM+FB7ykSHJwjbV5CSitF7StIKeF8PxRsR9VCuKPiRcR7et
         IdQtjiYR7Y5N/Hquu7f0qqsGN7KJjN+N7UxwVQlVWWkmxsuiLzM3zMNemhrQhK7pxiMx
         DX4bxunPVyNoEpUH7Y+eJQi+rMFPfb6Zq3WxMLPW67lRF8uprZ9oBH+GbkeyiDyuLxrb
         aqRCF0ntLFCk/sIX1gLV/nzAlzPHPGPoF3hK/4NRXK8R32daTGOH7DlU+8Yf8xEe2MP6
         KgHg==
X-Gm-Message-State: AOAM531W5urXXVxU9wJkyw8xW5t6SxZiWcnzI6p9CrHm6x5WJ2bob1XC
	wN0wGLXVtPpPcIlT9N/tV2bu7Zd59mc=
X-Google-Smtp-Source: ABdhPJwlxqywh4n7xk+SJqWn8IEM113CAFTofNOosf5nMkGT01m9ZpjxS47VlpoK0tsyjsBDv9osjA==
X-Received: by 2002:a17:90b:3704:: with SMTP id mg4mr13092809pjb.201.1627543271970;
        Thu, 29 Jul 2021 00:21:11 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p17sm2211550pfh.33.2021.07.29.00.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:21:11 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 6/6] selftests: mptcp: delete uncontinuous removing ids
Date: Thu, 29 Jul 2021 15:20:55 +0800
Message-Id: <d13e78a4250121ded5b1a24586972b7dea410953.1627543032.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <6acd8786b4c151c4c9f01a0370bd6a12aaae6107.1627543032.git.geliangtang@xiaomi.com>
References: <cover.1627543032.git.geliangtang@xiaomi.com> <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com> <af7def3b48c96f1f0c68360326d2e9cfe2500826.1627543032.git.geliangtang@xiaomi.com> <349c97cf4d1091f28aa62e8200ebfe4fa0f5f2d5.1627543032.git.geliangtang@xiaomi.com> <ae4edd8c446c94e57b981c16498f4f407d6b3e78.1627543032.git.geliangtang@xiaomi.com> <6acd8786b4c151c4c9f01a0370bd6a12aaae6107.1627543032.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

The removing addresses testcases can only deal with the continuous ids.
This patch added the uncontinuous removing ids support.

Fixes: f87744ad42446 ("selftests: mptcp: set addr id for removing testcases")
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cb5f9a43baa1..dab7fbd6813a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -344,17 +344,18 @@ do_transfer()
 		let rm_nr_ns1=-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=1
+			pos=1
 			dump=(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				id=${dump[1]}
 				sleep 1
 
 				while [ $counter -le $rm_nr_ns1 ]
 				do
+					id=${dump[$pos]}
 					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
 					sleep 1
 					let counter+=1
-					let id+=1
+					let pos+=5
 				done
 			fi
 		elif [ $rm_nr_ns1 -eq 8 ]; then
@@ -392,17 +393,18 @@ do_transfer()
 		let rm_nr_ns2=-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=1
+			pos=1
 			dump=(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				id=${dump[1]}
 				sleep 1
 
 				while [ $counter -le $rm_nr_ns2 ]
 				do
+					id=${dump[$pos]}
 					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
 					sleep 1
 					let counter+=1
-					let id+=1
+					let pos+=5
 				done
 			fi
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-- 
2.31.1


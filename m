Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A826E168
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 11:08:40 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso12858972pjb.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gw9TtGaavMhYghAEHTUfhMxXXW6bMzhQTqXjCvAMm8k=;
        b=Z4HVvsbED2ypBrh68vg3XmxDGe3NQDZbTQMpIjOVMn/MIbr6Jkrz4O/996O+Bpv5+Y
         TUWLLBeQN0o/FpjNeIDjk2ruZF8zwJiDnHsCkADXNW2zaDElYPb8OtzhgZXCzbCjj38T
         Ke1JaJ1L6oX25v3cGd2YIZBKpovoYJU4pAiKXVBHpFAW6ProHgFWXSAx8XtRsdvcDICa
         v6h1IxJmuCzNQ5edibjOdi28WwmnqNCWH6aOvR/GnuXKGbHzQ2ukPaZmgiqum8MbVaHY
         TObueGIEQ0t0Wh1eAccuP2ePP7+O7pftzt71quVozPEHg4Ons5cSDx31Ssqj3w7lgYDV
         cBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gw9TtGaavMhYghAEHTUfhMxXXW6bMzhQTqXjCvAMm8k=;
        b=dCh426VueLda/9gRa9nZZCgCoxjE5i/nv9oBhov4cv8otoa4/5SD2wXyXh5Arqmq45
         bMt2OzbxV2dmnZlX6z2N/H9tll6cKCXNUvBj3SpGj6u4NMNqMqjOm0QSx75WKPchwuaT
         FRYLhqlt7hLWNCcCS/zxhJLRZmMdFFh+/dvA+SIxQjWs6TG8wTNa2k1B4pC8eDwLfEdv
         I+e0Ly8qmnZqSY4tpG3IKzYBTwphU4VmPVt4DyF2ST58nPE2ZZja1YciQ4I63R/Bb7eN
         4Y0E9KdALFYZ6YVDiY9pvfBd532maB6nHs6ACaFjdre3LA6563V/bqa0h0ExqEmfsg/+
         k0OQ==
X-Gm-Message-State: AOAM533lrJnLlxilk7i0dCejxmBBMSss/jIDohIxCFRr4AVdbWiP1/EO
	86WGpy9OiFyvWo4dO+Ca8PrPInSRKseWSw==
X-Google-Smtp-Source: ABdhPJxfoncqtNAE4iC4whzsFy+sMAglAWXtzjY2b0SkIlvkWbctKxlVEbDDAZ6LjAQkNdkwsmLdNw==
X-Received: by 2002:aa7:95a1:0:b029:359:ca4e:d25d with SMTP id a1-20020aa795a10000b0290359ca4ed25dmr17653593pfk.51.1627297720238;
        Mon, 26 Jul 2021 04:08:40 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id e30sm50282700pga.63.2021.07.26.04.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:08:40 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v4 mptcp-next 5/5] selftests: mptcp: delete uncontinuous removing ids
Date: Mon, 26 Jul 2021 19:08:26 +0800
Message-Id: <abcc353fb104d1c330e2283c42001d96ce2996b2.1627297096.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <17cd11f1f902cd545ade9930d03ab0d82e0272df.1627297096.git.geliangtang@xiaomi.com>
References: <cover.1627297096.git.geliangtang@xiaomi.com> <457db25d2c745babb98b8f29c6d2ace3d6348ff5.1627297096.git.geliangtang@xiaomi.com> <afc79f9b4d6b8afb6492a52e9c1ccdc780fcca90.1627297096.git.geliangtang@xiaomi.com> <0c40709e5ccf24e810c5a5b073a47baa0946f41a.1627297096.git.geliangtang@xiaomi.com> <17cd11f1f902cd545ade9930d03ab0d82e0272df.1627297096.git.geliangtang@xiaomi.com>
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
index 9ceb6052b513..5c2fb282bf14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -350,17 +350,18 @@ do_transfer()
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
@@ -398,17 +399,18 @@ do_transfer()
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


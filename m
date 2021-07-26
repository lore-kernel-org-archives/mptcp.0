Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B472
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:12:43 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id b6so11154548pji.4
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 21:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/QVe2FLFsIMPpMsa/qN8cF97ciuVH/s0PCXfjM5JJg=;
        b=DPr8N6sh+6mYdYbrMpmc8hwFY/JETLR0QRTB23cbtt2Qr9QBWlHbkK0mjbT1nYudSG
         5WYZH00InExMRpav2OBw0JOraOLPJOAK5rd4ZgnQjC27amLiRTeF0Xl4J/9sxiVsmf5z
         zReHjKsvmbKsGrYDfqrOVnNhkuIi1PHflOY1TbblEeUbcbHKuqfiinItbpceu7+UeZys
         0By30wZWiMr+WkyIDYvdEyZRf9IU5Ao4Gq6nV3zLJm8KdzdhzmEfcp1quvY2UTC5rntJ
         EpjlDYQuU00jC87ojHFJMYnC3k2PGvMYdWbL26xWVAsbh0a6Yd3Xa4FqGfOsdMMptg0w
         TfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/QVe2FLFsIMPpMsa/qN8cF97ciuVH/s0PCXfjM5JJg=;
        b=B9hmilZRkdclkdJ1/M4XcA2av2mSmiygzyYyfNu5cvRrskqymeJMef4VAg4VU4OtMj
         QLTKbzps/vuBqQNqRWiJPMDIn4XXbqI3wSfGmynLeIx9W3emV2fbkQGTxePdEBP2RPA5
         /q6XlF2otq3LlHx9xlF/GLrzlRDMMs+e0KFZgtPnevq+YOORo7wad28FQbm5cSU6Zi6i
         X/ctm2js6bFnKaBAyshjVpIEqk5fdu3xIUiZ1GUX5e3l1Mu4rhbUoDmvfkQ0wqcDpgNu
         gWzLSb9yGnUVm2HaNePcCFqzgR+Npd6sU/91oAQpOnamuzpXNccMd47LbGLVUv+7oZ2m
         Xoow==
X-Gm-Message-State: AOAM531/8gwUPtLgGcBziVmIhGlYjaDsD0TukOceAKePvnu/0GzfG/Wj
	sHrEdo/M0yQqciLtBjBCe1rwWdY/MYcI+Q==
X-Google-Smtp-Source: ABdhPJz8BL6Vh8BYIXVMJrI/BZAwckHkpSvTT//4IF8CfC5G16jFhNjf9HTImfLZPiNCwOHjY3t21g==
X-Received: by 2002:a63:4b20:: with SMTP id y32mr16289388pga.382.1627272763193;
        Sun, 25 Jul 2021 21:12:43 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f3sm2608543pfe.123.2021.07.25.21.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:12:43 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v3 mptcp-next 5/5] selftests: mptcp: delete uncontinuous removing ids
Date: Mon, 26 Jul 2021 12:12:28 +0800
Message-Id: <8b5eafa26088982c732c04f417f0c31fb84c5a8f.1627272435.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a0bc6c98c1d78ad6b2ef7bbca3b0a0ee1e7b6fd7.1627272435.git.geliangtang@xiaomi.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com> <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com> <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com> <3e4690d0d33f8285465e54870410266e22208acc.1627272435.git.geliangtang@xiaomi.com> <a0bc6c98c1d78ad6b2ef7bbca3b0a0ee1e7b6fd7.1627272435.git.geliangtang@xiaomi.com>
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
index 887b94eab64e..4d2d5a6843c0 100755
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


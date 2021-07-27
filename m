Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5272
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 13:24:48 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so4201619pja.5
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5m2t9tl43KMdgOI4zJQaYmtUqZeGCANdqPtLWVhppcw=;
        b=ouRWHayKAN7lbKqZCHUgeNunHzLMAA8jOCGTEUKQhmiE4zQwz3bRLDmipRFUlAYUbr
         9SLwyjMJDQfz0X2JymUQP7gmWRk0C2iVmYOfmre4GY0/6Vhczx6iUouKX+awFdYduarU
         fg6AgoXi4HDvUCZo08buwMYHUFKrAAh4ffnwcWIx46n0c4hxVbW6ZNkV+KkccFi7uzhg
         4dVzkCUIqxOzxPb0WJlYBIr8F5h1FKmEA0MMFcDjJgPYrox2EDmBaK+3PnyuJjzLV5Iu
         sonRBZOJVBPsEqo5gUYNRSASDDH/pySP5t8XJH7NTWszs+5Nw4Bx6QEqoEAESMFP2ETR
         EUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5m2t9tl43KMdgOI4zJQaYmtUqZeGCANdqPtLWVhppcw=;
        b=ThuNQ/SwdPbaNyWDE08xYv8rnyPrdoDwP1tF/x0FoFzXs6lhlbIUgpwOakh13noX3c
         1vGMrkkX/yJXi1p9xilAWZXJq4WJFSr+Tj3z2D+IxroWxaT/IJRu1sMMOnQdVw0Ba/nl
         ImCcU2lgoIS7qFVPAFZmEO5Yd2lsMM5BtPYmmrJYDgwIufS/+T5hGL7NgOygOs1Vv2Ow
         /LbmLtXFkBCuySi6hGmZoNAX53ddW++45BsFSazarcndxq3Va5tQRWfEuyrSnhC5nIgH
         x44wmnKSoBm2UjYYe4DS7quRiqQcoFgP7DEWpZKOHO4BF5XdVD/SJfEwwSbmG0zCBPEn
         VdpQ==
X-Gm-Message-State: AOAM531RtKzUN8r0ezt5GqjYdMS4gF3CSuAlpGneIeorO+ibaeet/cwX
	dmP2kNWBf1q8E0IBKdNBEZrdrVUJSvw=
X-Google-Smtp-Source: ABdhPJzqvDd9DQn/OUGSHXbO2olyZzlYp6SYv50DeuoRM6fNfGS9pY/PTjzYQsbIuQ+NPu8izU85Zw==
X-Received: by 2002:aa7:8e18:0:b029:2ec:a754:570e with SMTP id c24-20020aa78e180000b02902eca754570emr22937740pfr.38.1627392287767;
        Tue, 27 Jul 2021 06:24:47 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j13sm3511066pjl.1.2021.07.27.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:24:47 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 5/5] selftests: mptcp: delete uncontinuous removing ids
Date: Tue, 27 Jul 2021 21:24:33 +0800
Message-Id: <fa173c636952104f1c84070570e42bd9328bc29b.1627391588.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cb461bd9ebbbfda680c2d1fea3bc7467596e3d5d.1627391588.git.geliangtang@xiaomi.com>
References: <cover.1627391588.git.geliangtang@xiaomi.com> <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com> <87310b54d3987e94138953e171bad7b081b63df5.1627391588.git.geliangtang@xiaomi.com> <10a327d0ce8f917d17166ae7de561a8b2af23ff3.1627391588.git.geliangtang@xiaomi.com> <cb461bd9ebbbfda680c2d1fea3bc7467596e3d5d.1627391588.git.geliangtang@xiaomi.com>
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
index 2a27d6240f5b..a5141f933f3c 100755
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


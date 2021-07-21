Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E82FB2
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:57 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso1036067pjn.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0X6g7GFJP3mYnnTffr58IGM+6/OUqUzj4xe34dWX7d8=;
        b=NK53KvvFTz4l0QkEasKeeV6Z+FBbp1Erj1YlpFzdVKub4rs5hGSBTC6rCdrK36Vfz7
         95/gmT7DAmgNs3W1oOEIXGu4NSkLfOfb9bPfvPmZ15vdUsPJD39p4m9gnWdjanKjdWrg
         RBqWB9TVzLreoAMDbJJ0MfBQ/gyB8D+i6hGs3L7e35PrDE6RNK3wKpvM8h8uuAKsrNZo
         q0QZnuBabAxdYgXuWSmZtszgNOTu9AtYcscfDiLp2vt1jDRgQYYPtlqSxq7bAGaYkJtb
         Q69H/lQOqjbwivGQZ7/9RxYTHSGArY0R2K93z+Xd9cVjDT7o6jlQFLMrJQxQkstDaYIi
         GO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0X6g7GFJP3mYnnTffr58IGM+6/OUqUzj4xe34dWX7d8=;
        b=Z/FBwYgMPTqcFj4im7gm++9l6EslJI7kBTCP3XACJDIzsh5g5NaUeD4hz7jUhtjQkL
         oQGs6Lsl4bwJ779tmnRpwPnGC7FEbWXZ+/ebXAa7aaNdVyEVMicsIaVnGZ2PIpwoZHu1
         Llq2MXsKtYIXtnZqX6Gy0FH++V0lA85CcSlxf3/1tLG4wqUIL3tjB+MtGiz0s3xkiKPi
         OQ6owG/KEss0KyA0Sg8yRyRVGUaFeKP95gcLNUOHPkbQ/vsRq5lRFFIogwZHVrVL71tj
         M4PSdDA+NBcZqzEUlFtKqKvRcWYNtlttLmd1Atye74ALq1dMPQfNNmPG8+gnbL+Zk7Gv
         kNqA==
X-Gm-Message-State: AOAM533aytGbAapbQpQ5zLN5OPuvunL3vCuGfUa8VYOBtRkEZrpEeX7c
	i4u/lTuki+Zz925+M/mmnOY6kDK+C8CBJg==
X-Google-Smtp-Source: ABdhPJxFW6oZe6PY+jCjjNBelQUSr5lPEYE7tCPNlCirPljwViBZoZ6gcGUS/HlUkcvD1k687y+FYQ==
X-Received: by 2002:a17:902:6941:b029:12b:7aca:ac10 with SMTP id k1-20020a1709026941b029012b7acaac10mr17304997plt.72.1626877916577;
        Wed, 21 Jul 2021 07:31:56 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:56 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 10/10] selftests: mptcp: del uncontinuous removing ids
Date: Wed, 21 Jul 2021 22:31:34 +0800
Message-Id: <95baa58d48cb7cd7673d795cf7a4821bda6c3494.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <b2634ea97c51cdad4f50dd10ef9b8b6dfb267f81.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com> <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com> <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com> <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com> <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com> <149236d46fe59a177a2f36a5c6e45941a1e0c2fd.1626877655.git.geliangtang@gmail.com> <d40b7b32bc427e5d43fce298b60e1040398977ac.1626877655.git.geliangtang@gmail.com> <66797ed318830e28cdbabf59011c0da39b9f6cce.1626877655.git.geliangtang@gmail.com> <b2634ea97c51cdad4f50dd10ef9b8b6dfb267f81.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the uncontinuous removing ids support in the removing
address testcases.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 823300986459..a1efba165e80 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -366,17 +366,18 @@ do_transfer()
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
@@ -418,17 +419,18 @@ do_transfer()
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


Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85ED15492
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:39 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso8795315e9.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542598; x=1688134598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhLEa/kO5/W0DHYC4E2CGVdrNW1mmEn4jpfHWofA1sk=;
        b=Rh55WjVzQBaZBmuGVl5RAmYZScqeHyvNVlSr7qvtO99Xp8I9bx2Uawhv5M6snIJBvJ
         WECmLNb2EfkjHrvVSEaRv7YmOxrxDANCSRQdI7QojhiuxUp/4h58g2jlu6fxjs2reqrB
         6YDpeVapWLjCno2h6di45Gy4ElqeWgJiNrjXnJdCL6SzpPuim/b8tsb1Voqv3P/Wt9p3
         F2K64HowA898CHGpX7scm13YNZGxYXt6nbc83/R+RO/NnEYT1OmFrxJKjTZIOPWuPyNe
         czkA8DWYdcBazBisuwF8HD+CZ51Mt2kBU4DBTSfi1JN7xMGtRHjtuf1rCKgvBtsqT/pP
         ZXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542598; x=1688134598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhLEa/kO5/W0DHYC4E2CGVdrNW1mmEn4jpfHWofA1sk=;
        b=BSoxlNGCBm+SnWqAbHTfIoh8eofLwzDwEcOsHP49DylHaTgUOUw/0IaxEYO3yqWwVT
         /zr8RwFvXDZDSAiL9WAJYbrRCfs4lH+ZQDzPX4VZt/GCLRqrRg/RM17XqL7IzTgvjAdJ
         EK6WDIqQOR115QWGHR5U+yoKURbHxIOLtC57jPOfqwLB/jfgn/KyAwQcnYFwjt2wyMj/
         /u1Ss/ufb+hA2LGT+D6rzkRYRpM18h5yNNhQp3F5hPZnluGZEa0pvtzqEcsOWkJ2IIf9
         n99dN4jhz9btdVSfu5OYA4zm5l4IiqC/S2ISyKsPZjejY9Ry+Y2NwQFeydHhcHNx2E8w
         JoJw==
X-Gm-Message-State: AC+VfDwxGjp0zkOLKHVXSBDOTFZQuy51aCrrlIMnMrQSrGqmeQALHqcz
	M/aCH7XHiZx28Dg0KOE060HSnA==
X-Google-Smtp-Source: ACHHUZ7OzQHyT6UN5BzqrGfPsXltIeefxVELt9FJRhA9XJVwNdK7pIzPnOOARHeTdhc2tMeIa/MEBA==
X-Received: by 2002:a05:600c:3b27:b0:3f7:a7c:b039 with SMTP id m39-20020a05600c3b2700b003f70a7cb039mr5154820wms.2.1685542597802;
        Wed, 31 May 2023 07:16:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:37 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:21 +0200
Subject: [PATCH mptcp-net v3 01/32] selftests: mptcp: lib: skip if missing
 symbol
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-1-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=zwQFmS8uNzLeY09FTlLcmYGOdopDU9Z7GT/O9iEBClk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCRKJJr7XcGiqlzaSdvrjzkqo3qfDWGEirH
 1KdQvkVup6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c7fXD/9S6H+CGjMTZNIJIPdOYGGk4IOa1uW4aJ+6qcfVKKU5pQvDS5xaw5CKgxu383l3DUmVDWm
 MBiGUSDr82R9U/OWjq61QxKpVbGHOSobN7OsmdXz4egF+rxZsNtOjxx8aMYkR/QdwkJ1h70WzRZ
 LMKDJ8eigEHEqdPcKSCGfLruHIoT/Dj2CkAYk60JSRy8MpMZOmBQ0zKAKfQ9cbq+ycjT3zypLdh
 UHD/auaxWG1qaHItE1pIeGF7xmGZJPvFTTb6X2QnAqv0A0cyQQGq5PUb/N94G+3AStV3Y9+83Nl
 0aWXF2hT2wqttebppMIQd8aa/xoDJ4X7vBbaUcU0YDDYVYuWlcYpzK4YWBVDI6Hxk8dnkoK6W+M
 TUXCUKSCfWDoJLsNWow38+VDDhM/beeu3Wt4m/1ep1a5/045+6iJf1TPMbO7/y/zHVKd8JCKXSG
 xaDiNcPB4aKjuVtknQXaj+vziHjpr+vlkee2VDYujN6q8qKpk0qOspo6Aq4/rNJEalhEOSoChfZ
 TZQuLjopPhekCK24rfqA63CiSwExcBS6j44Ce1idxKLETn/2ajkx3uYkJv3/emG7/hfFQykkD0+
 a5IsBPRd8ijpXupuzGfoz0cfpYTw6LLbO8QmkAD3Br+6AFB6mxRLH/mAeCQFlHOwEw78C0gxk/d
 fvjvTOr3wPWMifA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

New functions are now available to easily detect if a certain feature is
missing by looking at kallsyms.

These new helpers are going to be used in the following commits. In
order to ease the backport of such future patches, it would be good if
this patch is backported up to the introduction of MPTCP selftests,
hence the Fixes tag below: this type of check was supposed to be done
from the beginning.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/config       |  1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 38 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 38021a0dd527..6032f9b23c4c 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
 CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3286536b79d5..29b65f4b73b2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -38,3 +38,41 @@ mptcp_lib_check_mptcp() {
 		exit ${KSFT_SKIP}
 	fi
 }
+
+mptcp_lib_check_kallsyms() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		echo "SKIP: CONFIG_KALLSYMS is missing"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+# Internal: use mptcp_lib_kallsyms_has() instead
+__mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	mptcp_lib_check_kallsyms
+
+	grep -q " ${sym}" /proc/kallsyms
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	if __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol not found"
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_doesnt_have() {
+	local sym="${1}"
+
+	if ! __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
+}

-- 
2.39.2


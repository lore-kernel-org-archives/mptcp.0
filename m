Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6052F15495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:46 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4eed764a10cso6461318e87.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542606; x=1688134606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDDqMjQYOp2wFxeAFFqcvQbYk09WfYCq/KJQagEy/6E=;
        b=KKZ2b1fxmlEcK5+a3hD6jwv8xoqIrmyhqvnKJ9+E0XtR9C/nIvXumOU7lq+Ut80Axo
         c7ZeWJicsFoj/MeK5lXvLXc/S2wMj6+CVGCS9HBNTVI/T3ATIYRDZj1lZS3O3drmIyC3
         tYjxmnMvr4s9Ply21fKsKrxrxIwpe+5Ao1XjHBxAed+pFOIx/AC9z2u8B9/o992Ev8s1
         ofyD4frGKfbDBugwhfN4RaamrHs+oI2r4mNq4h8GK9ekfAdNyPLpH0g024sBR7rjrdPO
         NcvTz53nhvd4oMxc8QceJYA7ejY7kIPh8rUmTugyus+SCWETucZrf0FY8SpRk2qQDMIc
         AVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542606; x=1688134606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDDqMjQYOp2wFxeAFFqcvQbYk09WfYCq/KJQagEy/6E=;
        b=Jh+9NfUgcUqku4EnzLl42WNS0iaLm7QTzTvbVRkHE8cCuAgDiUalST4z1b9pKHHUI+
         CQBuIID1KW4t8IZsSH7in63q0TtbukjOSs2R+nFVwBuJmRrkXmYNnN7SfHaAS+6e/QHM
         ZksD2RtLYWCI1VTuTXVw/l5xQCdf4yhq/kd3NfxMO4sZFzk2jYYUjzmuOestZ4U7kq8w
         Gw1PYL0LC6YKQxZaJBhtenxgdux5/VYNtDsQwaGNNbe0M1yTe/hy7rqh9P1bum4tQ1Ho
         GIH3RGZ8idLxGpzBwntdgMEBA8I/iFrMjiI+7lFdHGonKb25btsbp2XWKMW1QXdrkD7s
         pLPA==
X-Gm-Message-State: AC+VfDxGT9Ho11Gp56FvOcKE85/UrBFg9rJrJmyxVbwjrAUwH5LU4eiU
	9paFNafowBgk/XcifWzk3oWCftD/jp0pEhKZ4dNRdoHt
X-Google-Smtp-Source: ACHHUZ4YYR6Lacn1DLn2HyawIsYYVGvlnALnkHcrxEg5Fk9UhL8d35n6Cc4IKLzYPrPRojCFgV4BNg==
X-Received: by 2002:a05:6512:21b:b0:4ed:c639:54cd with SMTP id a27-20020a056512021b00b004edc63954cdmr2875122lfo.35.1685542605852;
        Wed, 31 May 2023 07:16:45 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:45 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:32 +0200
Subject: [PATCH mptcp-net v3 12/32] selftests: mptcp: sockopt: skip TCP_INQ
 checks if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-12-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=jNMlBxSyx3VTiSARezuDvvNOfQso1SFAQGcty20ihVc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCesAI+mOfWA5pHMerQC0Q/3wqcCR13nVEI
 d7TtktDHSeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c9RVEADahdLrejTYOixhmcexVER05qnzj6lKROoc7NdHTwWGL1QR+orxOSj+YqWHOd6S55e0zik
 EhOmlwLZwZveiEuQ3Dguk22DYo75dZ/vPVqm4xKNf5TrmU0Zm8reUYNQ6rYvbwFT47Swn7a/3RO
 j/+XTkharlycanzBPvbg2Gg09A/PDIdLjxWhUHeH1mEDSWt9Z+VHn+B7lLI6y00MTgyDYc7enPM
 fscIt3Z/75RQfqWAjrdm+g337Kulaeg9S7QhS2bCi9Gp2Tt2tEyRK9OJnGLqG3cl6FrxsUxmvQc
 Ozc4Ie8MvhtTmmhXg5RkdzJyAJ+JiuVtrVgjQjaXAp+OHzizrdJvaHvbLx7RuU8hSVNXxdnlSOD
 lWcG1MG/tx85eeXDC46zrc2xtmyTlzqMhZnssvBi9F3+AdGhjF0d8IRHh7eg7yhY9QbFjGUPmu/
 5cYlzLAWEejqkPHPz+/HnJvGQ2bNARL/kuuo+fBIjNUDMbGxh7nt11va5U8IHr8L8KKiori4oXt
 JDp7+y8cuYLNE3TKsFgC5lJQ3fJq5bFUtgBWuVysqdoy85jz3JchgGHYssn7xrj7komaSQ+bLN2
 bEHiApip+ayCXV4QUmg/RCQ2J7YfAkQXQUOwGUqUAMPhoooCsaXcHznOFn36rV4cM/hgfZ5XujO
 Egmb2IbIqayv9yw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is TCP_INQ cmsg support introduced in commit 2c9e77659a0c
("mptcp: add TCP_INQ cmsg support").

It is possible to look for "mptcp_ioctl" in kallsyms because it was
needed to introduce the mentioned feature. We can skip these tests and
not set TCPINQ option if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5cbd886ce2a9 ("selftests: mptcp: add TCP_INQ support")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1d4ae8792227..f295a371ff14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -187,9 +187,14 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	cmsg="TIMESTAMPNS"
+	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		cmsg+=",TCPINQ"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
 				${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
@@ -197,7 +202,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
 				$connect_addr < "$cin" > "$cout" &
 
 	local cpid=$!
@@ -313,6 +318,11 @@ do_tcpinq_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		echo "INFO: TCP_INQ not supported: SKIP"
+		return
+	fi
+
 	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args

-- 
2.39.2


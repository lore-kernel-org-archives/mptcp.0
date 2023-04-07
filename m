Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85457749C
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:07:02 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id m2so42792678wrh.6
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ixDrMDwhoIft4NjW3uD/H+PZHgkF6xXWxJXb4s+4VA=;
        b=pClnqyuZkVVl47KNjlS1MUck9Ko0nqFhQ+LqaOrkPY6GwlyyhEzOCX/RvgiRD+bcqa
         MPvzqiJvH9pd2rsQ9Mnw/SxQNvQTDahbpuvYFbKgyfkuD6HzlsZ+leNjIjE2hHUEfS8w
         ynZljV44sCcEHhHf+PF53f0B9Tu6qopcIvl+tDURxmBcmQGDrTR5wLYdwTZzIRLIYd67
         P9OgfeFqZHGrcxqwqpV2BBMTBQv42r3A8ipn6vGuPdxfcKrcdTNimqfj+eOmouatqdFQ
         6zgd5tiX+1VpUH4rNK9StIwa4EoF58pEFEfKve5oDg5O/b3CaknExPgBhCoKnCKz4J0c
         JnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ixDrMDwhoIft4NjW3uD/H+PZHgkF6xXWxJXb4s+4VA=;
        b=jZKRudC/iKB8OuRu5S3ZwohHrhiKnT5EkvtNvPaQrKrM3Qi7Ybw3NdHaF+tYt1CDxu
         pnlOQKemzauy3psYTRK621WMeKVERAGoNaUG4/nCgVzgB8GCeeyNAsYSLQinLloZY8Xt
         Yb9wQdgJ2WAuLT64aGHNWYQRh7hnNg5eNocez9RdJ+vFH6dSzlbyp1oHKOn0MPgmHbr4
         4CWbi0Wz8DntyS0kNoKzcic7O1OKX93vWseecKpONAeCycCvbf61gsgB80qwaQ5cOc7j
         JDSnMuro6lHoMTkX3+o730s5a2ytTskDyhQUNDmV48qxxgPy0uurooM3y3jxBjJT+xMa
         LTcg==
X-Gm-Message-State: AAQBX9dWo89gtBqZ+tB7FV+bk0raw5TD32BuSn2ON/w/aMbnvyJzWc1p
	VpKP1Bnlychw7tYjdQEapkExa4WSToL9i9dbV7eACA==
X-Google-Smtp-Source: AKy350bXkq3wiknPqxMdV1cgVI+GF+nINNwIQYecj82iLSQQeIAiXqeIwZsI0YRbmmA1jAiI/uUeKA==
X-Received: by 2002:a5d:5907:0:b0:2d2:ac99:a72 with SMTP id v7-20020a5d5907000000b002d2ac990a72mr1786489wrd.46.1680887222035;
        Fri, 07 Apr 2023 10:07:02 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:07:01 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:47 +0200
Subject: [PATCH mptcp-net 13/13] selftests: mptcp: join: skip PM listener
 events tests if unavailable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-13-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=vUZBWnkYOXG80tzk9dxX0Faz8JbMnWd7bShiTws58ZE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2rRXMdmJ48OVI9SWOTLYvOkBwlnl18bdg0l
 TaHs4lhHiSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqwAKCRD2t4JPQmmg
 cwZwD/9vxIk4w5l6asaHOt3Kjh1QgJv3JaG+PojpIjgs3mvBonmqGNR9OOyAQIuiGLckfvzifmB
 bSxSbvkV8bbbrUojs5xmTpP7f/2LvDzhSR3iTUDGhPbDCgMOYelNzCz3BlKrMXFDP73bmPDtBct
 AN/+XxFZhV5iFonRQoqCT04iHRi0JuHqLgrartmPheRJFd8a0L5Zq4VPoWkCkH36BIXAe0L+y0M
 pk0n4mK57GkWiNXoopGSm4ZHWN0dBP2jzmrfCiRMEEGv/7y8qSzvOjr2vVpdf2RUjBoDg133i1L
 QgtzKbHScHTp1KqHQqdKTj6dC88c0MSq+XHaWBNDCCZyaQJHf6lF9sckVS+a/oZsChRz8LV0B1t
 qRqATqs5dsYOmmN7zopsO1emFRpEzSWSrl3a4HJfVxBvpeh28nYdozL3dIoiPCMh7u7PpZkF4/W
 fL5cHnshQrGOPjpXvUJD9YRXTPdLCeZ9CQbRMp44DDn3hgujNbbXEvLBcrqcsuDNRQ4n79xiIsY
 EFnZPv3Sthl3/GJZ1dlw0f8gw6iIRGFpqg1crPFQY+X1TwvWUaTHpRFk4mQYMxNyBWi8OzRmm2I
 TMlTqimvckcv10D2MPCz9jclxiqX8L1ALeK2v7LDh7f9cJle5GqtU+uxi2eKCampzL/037xdAR2
 P0ybdkJljGAvnBw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the new listener events for the PM. We can skip these tests if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 178d023208eb ("selftests: mptcp: listener test for in-kernel PM")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4bc181485fef..91a1e8802fbd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2689,8 +2689,12 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+			printf "\t\t\t\t\t SKIP: PM LISTENER events not supported"
+		else
+			verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
+			verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		fi
 		kill_events_pids
 	fi
 

-- 
2.39.2


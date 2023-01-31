Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF922102
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 11:23:54 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id a3so7181930wrt.6
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 03:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjJCn/NsFwivBP2qiE+0v8GiWRstnXE+SxqxP0dBT8k=;
        b=JNyUYWNlDpuio2j0EqIk1wdOgkZVp1Npjk3tPOwD8b8Pi7AJ/M7E8WGJetRriXNigS
         UIcYvHCC9m5l3SRIuiZVn6KYMqLVSqDZKXQCHtv1xqE1U2IDEFbRqc8rGNxbCM9mvF2T
         DCjn4o9BPiCCTvNjUcxqJInefrNBNkn7A6uYS8JDBr50R6yHiKIoQWomo60RkB/LO3k7
         pAkKhN6gw4eaNiywNhOZSV4lA/R5pcMmTZXzN22bwwXdNl8Lm3eMogNOEwV/HcY2Z5tU
         s3j2T/wN3uSYv7GG5iLucRvUXXUDxVctNigSDirgv5luEp+dNABpaz8nvgjYIhFZO5d7
         kdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjJCn/NsFwivBP2qiE+0v8GiWRstnXE+SxqxP0dBT8k=;
        b=U8WQZN/+tJW/6Rkjle0vVwmZOfBecAsFIw6HJYYEoTYvcVFpwCGqeMYIFiJtjAXcWb
         Lt4Pw4vXnKF/Tgry/yzEPLoyUYrzpJC0t9CPeA55Mw83vJQGdHTijLUstyEkD+fsRiLY
         tkXigAp+R/Id3NDOZ9/qbSNZW31Ejf6zayfiBq+Atn434PrVJJtf4sWu799CNuvJm+X1
         xhHRBvT2PvhIY79H7llVYVAT/LfPePbHylZVJqma58PYBqfizK0d76X+QrkF725y36Nu
         XP2jtOP5hpQwGKXUBNwV2+1AJ2c1KrN4FPlBkp0CfK5r7WyCvLhEGNbWQmUfMUONLtKm
         /IJw==
X-Gm-Message-State: AFqh2kp0JePRrwVs9P+yaVZLL2tsx2g/hqatPhkkklMcIhOHgBD+YlmG
	IJGMhgfen+MFSPlhqSebJ/lgX0Gf8ZsqUQD/oiw=
X-Google-Smtp-Source: AMrXdXuPr5myfvTcoQb83HPUWP3zsZCJ54HTYV2LLag6JoGoysa75Cl5pKog1AVs75Fu4IwQb+KqCA==
X-Received: by 2002:a5d:6d4b:0:b0:2bd:e1fd:2536 with SMTP id k11-20020a5d6d4b000000b002bde1fd2536mr42076993wri.9.1675164233084;
        Tue, 31 Jan 2023 03:23:53 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d4a81000000b002882600e8a0sm3140503wrq.12.2023.01.31.03.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:23:52 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 31 Jan 2023 12:23:30 +0100
Subject: [PATCH mptcp-net v2 2/2] selftests: mptcp: stop tests earlier
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230131-mptcp-issue-323-join-delete-re-add-v2-2-8de2421163c9@tessares.net>
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
In-Reply-To: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=5L+NrhU0mdbv1XiBdpNFIeaavR/J1PHw1VTQ991LDws=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj2PpGmLvxldkqNN3UCFkI9n9Tv9njJLq3Bz2wN
 hcyzEi+27aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY9j6RgAKCRD2t4JPQmmg
 c+DCEACNXR9y9k+viK64JcTl+UCUwz7OhIP/rqaYU7Btpm0UyH/U4JQFaxx3TDNQFYwqJytw8lj
 ZtZgQBJkrxYgKheN4rmJACZgNf/2fPCMT27BoZ3VbWyLcGthTwe4wJcvJ9iZXf62/VEmb3a1tiS
 y4xZ/WZqAeiP98+3PDJZedZxYMhjCrhZizcE6op4+oCbO0LpatCLUr0Y5ZQyfD+x/9UTUvcexWv
 LQjIsy/HkFCYRdxkF2YIZswAVcdvCQUr2gu/qFV9ZHfPlA8b0bSAC15E1hxRqrNuFRNkCR8HXic
 MTLXZSGx12AQwmFPIIEDdNWE8JKgU7subIMbPSau+EwPEyccv5Mgrr1pD0qIfh69HyfN5jdJnKG
 OXWgFX41fWP7aSD5+9ClrnSS2mhe/2TSebFxwdn9L5JghSJelbYcP7hnWMETltLU23Gg0GnH71D
 ujeI6tFiR5ZITVLx+E8zIr/rZc2VE0gCFPViiGIiWNWkY/z2nN9gluumuOSRlQwiG51f+2ZFNDq
 bUMhDqi4WKtEi42oGhnUbVy78zdA2LuCJ3LreIl95Akxt8t5d0a3j31H/pMnvt/cs3cOBvOYFUI
 /QU2PAtsqHxtqLF4U3wmGD1GTVQqi+ID20jPeU1QsklNynPkJJzgUqd9MQAjM6Z2vnvhs7+D5l0
 W4ql0IlMgCkQWmg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These 'endpoint' tests from 'mptcp_join.sh' selftest start a transfer in
the background and check the status during this transfer.

Once the expected events have been recorded, there is no reason to wait
for the data transfer to finish. It can be stopped earlier to reduce the
execution time by more than half.

For these tests, the exchanged data were not verified. Errors, if any,
were ignored but that's fine, plenty of other tests are looking at that.
It is then OK to mute stderr now that we are sure errors will be printed
(and still ignored) because the transfer is stopped before the end.

Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 52484a7c286a..42e3bd1a05f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -498,6 +498,12 @@ kill_events_pids()
 	kill_wait $evts_ns2_pid
 }
 
+kill_tests_wait()
+{
+	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
+	wait
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -3089,7 +3095,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3102,14 +3108,14 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
-		wait
+		kill_tests_wait
 	fi
 
 	if reset "delete and re-add"; then
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
@@ -3119,7 +3125,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
-		wait
+		kill_tests_wait
 	fi
 }
 

-- 
2.38.1


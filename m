Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C71B64
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:48 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id bg10so4536594ejb.4
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qffqFYZaczUvEfRFJIoTzyQeopr7ViT5TCmTw+r70kw=;
        b=FEjH4E1ooyIjSWF2AeLyMwKIKl0gQ4z+T2zQBMswnb/QN3+c36a45AbXgZT+YMuJqL
         s8fqiNkSlLNpt6VOGpuZ5+OCUFEfJkNLedSw+yCeEf3NhmEoliaSRV1b/ZHaSwZ4UmWo
         1HdJL/V6aEisGFLuOTDo22Wd8aluJb61DXQLjflEc+dbcjEgnTza/4r2jqk6YIaVicVG
         5se1KVMbb7VQZDUNxZ4CbH2CvNGFt7f7ZLOzmww7NuSj/gNuoYVfgpVpO6nvmazoCSl9
         cgJTwAWdqZTxbnzbDndMyVcWwdhvUNAoMhvDhCsChaR6ZUTu3RRkOYdkzQWMElntY1/w
         xk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qffqFYZaczUvEfRFJIoTzyQeopr7ViT5TCmTw+r70kw=;
        b=L7udwmgfdPSys0W2tTO5683yrsQICDBHerftue7HY8UcVLB9DK6PmPYQEMclpXye6A
         QFs/K/OR+amlJLfQS9lATserYscwPSatuPVphcLY4TwM9ZsQTdZEDcsaN1w5mlMbGJab
         HHFzQFB+dSbmy6FrO9OdobthWcO4074FkDfLPkQ+XqAa1Q7sWai5DXZ8ulafLJZCaqMG
         KK3wVUOm70C6zuTVeIGq1d+eCDajNEtHxGBuPOzJJQk77hJUQ2S17iJ2Nc6q5LAK4Xft
         DF7n3/tlnsVl1Zx7btT0hA1zWVb8iqAFuVYFdOtF5PKXPzae6t2PfrjM51tr1e+9XtoJ
         Gjlw==
X-Gm-Message-State: AOAM5322xKcSr94gAaDvl1spaNI7nhttfutQAqzgoW4is/gWfU8P9GfE
	WFash/J/+/IoxWaGDSBMSTwdTm033+lRNi4pQeg=
X-Google-Smtp-Source: ABdhPJxLyA+TbJ48zlpbmA6OzR60TeODUQmIS0/MCOr+EvOrXznYUUHQZgWjs8ZO1Zh0gqDn4lWRXQ==
X-Received: by 2002:a17:906:9547:b0:6d5:b3de:11e2 with SMTP id g7-20020a170906954700b006d5b3de11e2mr2476641ejy.630.1645711006956;
        Thu, 24 Feb 2022 05:56:46 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:46 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 03/12] Squash to "selftests: mptcp: add implicit endpoint test case"
Date: Thu, 24 Feb 2022 14:56:10 +0100
Message-Id: <20220224135619.2523272-4-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move 'wait_mpj' with the other 'wait' helpers.

Like that, we have all the helpers first and then all groups of tests.
It is easier to find patterns in the tests parts, e.g. finding if there
are direct calls to 'ip netns exec', etc.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add implicit endpoint test case"
    
    to be squashed in "selftests: mptcp: join: allow running -cCi"

 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 02ae2692f7fc..231bd8322415 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -365,6 +365,21 @@ wait_rm_addr()
 	done
 }
 
+wait_mpj()
+{
+	local ns="${1}"
+	local cnt old_cnt
+
+	old_cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+
+	local i
+	for i in $(seq 10); do
+		cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+		[ "$cnt" = "${old_cnt}" ] || break
+		sleep 0.1
+	done
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -2532,21 +2547,6 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
 
-wait_mpj()
-{
-	local ns="${1}"
-	local cnt old_cnt
-
-	old_cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
-
-	local i
-	for i in $(seq 10); do
-		cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
-		[ "$cnt" = "${old_cnt}" ] || break
-		sleep 0.1
-	done
-}
-
 implicit_tests()
 {
 	# userspace pm type prevents add_addr
-- 
2.34.1


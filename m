Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DF2F9B
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 20:34:30 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id j12so17296633edy.3
        for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=muAu22bGqt5pqmSFcUEM0puiSFc6ZVph7xgKTYXAOU8=;
        b=ybr3CaecT1vCiMrGuRV2uaYpBXcmzAOf/e3r2HIjzD7Y5170lEFxU2z0FQhdDDG9pp
         X4UD8TkXCDgIjDEg8kmFBRJ7caVjiB+3WC1P6Vcxlw6gYAXwS+NIHk4GPB0aArACMLkY
         q7Cbp/xN+2rImaJ4hiUR0RUiBhmghmQVNuyn6sQJbYo3IOC2UIIa9KgpGS8U6kgSofMk
         ZCmFK1826NSzvwQzj9QaYN4mIoOBE3ZLToQS+UVxfxL/2zhSbF5Hf7T3OuKLIWAXzcoG
         sYQjW3wp1OSwgonvPc4GjpKA4s0GdKbUs+AkW3JkoezGajZDCbjNLRdgw8toln5X8LhT
         2Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=muAu22bGqt5pqmSFcUEM0puiSFc6ZVph7xgKTYXAOU8=;
        b=sl57KivVZUK20JTQkOyjhLLa61XKhvDuKzxAQdl9PMbDwdxiPWu1uzTk6j1i1PGxzO
         YEPbbFDA9Ex+5C1HGlGxK0RayWAlupNBbmsbj1KXkf0DyeXgGoS9mvR9dsMhWKeQban6
         XInGk8qBCiN2BnqNkoLXwvbWVLk2b7nnrm50lXEJaYs6Vxte2xUiLB5aC6ol7Yxq46Cr
         o2D2Ss4FginZX/Rj4T7b/ollJN4rLe5A35R405R1/qG7hwLAKOmikzFyRVUgi4zoIBsp
         O17SLE68nqyJH4uxQP+UyypANQ+Jo+xP6ad/Upd2wF5zkyatHIPZ/9vS46s3+uoYQNhG
         Fe5A==
X-Gm-Message-State: AOAM533G/XGSJOM4YbeyCLlidv49zjDhFSCruhWARs/aQUplSV7/3EjH
	oma+zsuSyNxoK71fDrpZS5s/gF+sAc5JaLs0Gp8=
X-Google-Smtp-Source: ABdhPJznCE3x8oY8Fk1EeahBany8S6/UKUv0Vt6K/o5eGB6kBnHpnDr9NWxAGnyAsFidn9gmoPdgVA==
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr17171117edv.337.1618864469264;
        Mon, 19 Apr 2021 13:34:29 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id e16sm13941867edu.94.2021.04.19.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 13:34:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/3] selftests: mptcp: same NS for Peek tests in IPv6
Date: Mon, 19 Apr 2021 22:33:54 +0200
Message-Id: <20210419203355.3937162-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
References: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also when refactoring the code around (see the next patch), I noticed we
were using different NS for the 'peek mode' tests in IPv6: $sender was
set in a 'for' loop before. Certainly coming from a copy-paste and not
what we want to have.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 28530f1bd285..dbb4aea8b636 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -742,12 +742,12 @@ testpeek=true
 options_log=true
 peekmode="saveWithPeek"
 run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
-run_tests_lo "$ns1" $sender dead:beef:1::1 1
+run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1
 
 options_log=true
 peekmode="saveAfterPeek"
 run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
-run_tests_lo "$ns1" $sender dead:beef:1::1 1
+run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1
 
 time_end=$(date +%s)
 time_run=$((time_end-time_start))
-- 
2.30.2


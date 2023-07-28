Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CA14005
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 15:28:59 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso24566405e9.2
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690558138; x=1691162938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVKjGVlu4pgfx6kzOiTRfi3OJprY967oBAjVfeN6gOk=;
        b=GwEjOTuES02ROFRadjhcWP2oKtDLPfL5/qurf+DHyPms3L2kxoxtsz3DFTAPHxsmFk
         7x1IQcN5iIQAatfIEI41KoykQGQXKVzhzuwUh0TpLT4nsc+ceoqWHryouJYnigdqGE7z
         oATc1hqmjsKZtXQNHgKBJMF8hkmgJ2ZFto/YIL8NXhTAZpgYEvQ8aEjT5DxCYky3WE8V
         EXsBEceKPKhoxtwXV65Wpz9TKt0hgwPeM5xK7Ut6kjZS9AmmJct2UaFh1i2d9UQy0Td4
         UQNwKbY7FSjtHxzLLikpX2ytpCyBgOry81lm8KYTIvyRcSakQm+fzX0lOra7coAbkHYu
         Q4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558138; x=1691162938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVKjGVlu4pgfx6kzOiTRfi3OJprY967oBAjVfeN6gOk=;
        b=IJgBpAN2RAULG0vVFvxEB9zzmVs7OAV7LE/pQM5Cn4BpOXS5mSuPBg1uQZ/cbaYECH
         V+niiymO8yxGK2H6wvvLQrP/FypULR7Riwd/NCKAi+pNJn+HxPy++iK5rp3irAvHVqnF
         Z6n1pfz8F7lTgndH5IH2wawdV5/tuiGSVm0hN92KHelQVHSpABq94XRKgeQ47NJtxB1E
         f+76V27iQxTw92mfJS9Qr0JjNz7iLXvr/cz6PkMfhJ0kCNBhnP924mr277A6I/UhiAso
         lu3bYv9yLTzuKM0fQ/3JaNdUOSOsJmzIl4HZLYfPZ5lX4b+HCEHj/4IpMSEWY7VmPnxv
         QuQA==
X-Gm-Message-State: ABy/qLaV05xr4PU6fBDm3s+i+qHhiBZYu5dtttwXUQ7k1FyCuxx1c1m8
	lWTTNaXLX6f+3gnR1CayD7ZdcoUZ5rXJ+5Dnuxg5fg==
X-Google-Smtp-Source: APBJJlE6CP9rMnHmhH4xlv19+FW0gZAmyic+kpbAPU9kCFol61aAOWlCEc78NVY8NvRBDT4z4CUueA==
X-Received: by 2002:adf:e586:0:b0:317:5c18:f31d with SMTP id l6-20020adfe586000000b003175c18f31dmr2138088wrm.35.1690558137794;
        Fri, 28 Jul 2023 08:28:57 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d4e8f000000b003143c532431sm5083717wru.27.2023.07.28.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:28:57 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: pm_nl_ctl: always look for errors"
Date: Fri, 28 Jul 2023 17:28:45 +0200
Message-Id: <20230728152845.1020528-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=Gy3uxWxbhLg2phvFj21JGrPbylUIP9jcJItjIRKe7oY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkw96t2Un/7iz1DaT/gR91n+jXS6o9B9iNapJ5r
 6Z+cClFkdeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMPerQAKCRD2t4JPQmmg
 c1gdEACXIS1ShFl0aYbnUSqtR++tsNlfKFfhIVZUe8YLkkbr1oLocB4L/KpI8irMh1Kf6Wm+7Be
 oCO9paVbtVQVXIjUNkVl4HKlDUg8SFOgnqtJ6VBf8Ek+LH1KIXK1rbklffTyP2+gXclmQ1STHBf
 +8Oyf8VPram6sV3FpNWu6fSg4WBJFGTi0jD/sMZajzPS0sii/DhyOcCB3K6cRvxTDcteDQ3jEgs
 HP1sEPSQia9vUo1jeWuK3bZfIACcf4DgoEuOevUIZqhcyVPSoOUjY8JnzG4yq9p3hXp8dsPU8pk
 gcIMSZs/pbk5zXocXoTGPwrS3zsYdycpgW2Yvrfh9U9jpbhWfQQvOPZjMUJcRnBP4n93YuYyPn7
 NGzHGf3YNhYiL9w088ToQYQZ3+2C9nwVwQf9M78reIGqHxis3h40SnnFPDHKCk0YPz5Coy7FdOW
 VQNRie/7RYrdCPPsVlxa3Nafm9eiKpNKvp6Nob1jPimCa0ZzYg4j1qRuFN68KIwdGITzy/+mrgc
 C+1xzlIgsmbTmHEWv1MZq7NPyxC1m2J/wd3tfwJ36QzwZoJXWQZZmY6MnACtk3Ww7HCH33liOYS
 yE4x4fCL7TGi+8kY/bRFJ5tSDcUxuQKihiPFYzbKxLChnl8gyofcQJx5HlaREIB4b3JMnSi63e1 8yftaYCD8ya0/ig==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

mptcp_join.sh selftest tries to add a bad endpoint on purpose ("ID
change is prevented") so it is normal to see this error:

   114 implicit EP
         creation                            [ ok ]
         mptcp_info subflows=1:1             [ ok ]
         mptcp_info add_addr=1:1             [ ok ]
   netlink error -22 (Invalid argument)
   ./pm_nl_ctl: bailing out due to netlink error[s]
         ID change is prevented              [ ok ]
         modif is allowed                    [ ok ]

We can mute the output because we expect an error.

We also need to edit the commit message to mention mptcp_join.sh
selftest also need to be modified, not just pm_netlink.sh.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: pm_nl_ctl: always look for errors"

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d23004ddd0b5..ee1f89a872b3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3454,7 +3454,7 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 33 2>/dev/null
 		pm_nl_check_endpoint "ID change is prevented" \
 			$ns2 10.0.2.2 id 1 flags implicit
 

base-commit: 7ba82a61fdc510b19dde7a394d08cd214e5e280a
-- 
2.40.1


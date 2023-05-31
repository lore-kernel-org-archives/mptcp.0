Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30E16401
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:53 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so44039415e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542613; x=1688134613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFwYsdoD5+/SQpHVu2Ji6zWlQ91oPWysx8gRnT+beOo=;
        b=yLyR+Nmd2WPF4e+tVoIG+8TVkm6+p8Cxpqy3a5dvgk9I2D+CvD27SKoZfIKBAtEKqn
         TAx02ITbPKwf4otCisLu6AQkEXh+ADahy1DEQLfO7LDtO9gQrgBykvDW6UV9d447kN32
         MwgCIJojW/JPszLIKlpAouQzvGa4XuSbubpC9sj+eEB4KlLy7AbyNBXfx5DsuSyY7Q7m
         HiWpsNb+rtKeJHjj1KLL+ALvT92h3el6E7epxZDKY4wYmKotQu+1bOYBQCkGpILBdWVq
         ZL17QdeDjBU+JAZ2iOP9FfKBMDAW2NIKd8VObSdE13oluDqoEc0vJhr3ToIiHbpouPbk
         Z3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542613; x=1688134613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFwYsdoD5+/SQpHVu2Ji6zWlQ91oPWysx8gRnT+beOo=;
        b=Hdc1uJ6CQ+FSMQJcfW+AqIry4UHfkgFUx7T7NlZ+eq8ZSRPN9Xr0MjYpN2o8vc58O7
         kcXh6U5S26xIZ1hxQuazTMv88/G773iIFgVUkppHtoNMqBfmfjjlOehrSpqu00RNFboI
         BaTJjp457jrO4TeIqaGU5pjItGX62jRtm1clFWUeDsB7LopiniRUY2lP/2qNQ4BUFcGg
         6/H2vOiwWD0wazdJJHlfstUgSZj/QLiSIDGKCXvUEjWKFtlnWAXWzaagQ35ef1Ss58UO
         A7eTNDjxheranQFIb94BU9Q5Xzri+DPnWM3tCr0/GZtRngfcLA0OAr9WiT8XL6lFPd5R
         zCfg==
X-Gm-Message-State: AC+VfDxvI5FhqbV92XReNJQGw1ph12BO5D4ETuRZtFNOY7obB2Gq7z1N
	/4ZiDhGOYAKmHkoblkmXG2/7zw==
X-Google-Smtp-Source: ACHHUZ4i5pqR7fl6J9qG7dfk8DuEwrDK/ntkTK/TQp7dNl0TfvtqL/eO6hu/97To6EZYLg4O4OT/mg==
X-Received: by 2002:a7b:c7d7:0:b0:3f1:74bd:bc22 with SMTP id z23-20020a7bc7d7000000b003f174bdbc22mr3728365wmk.6.1685542613139;
        Wed, 31 May 2023 07:16:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:52 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:42 +0200
Subject: [PATCH mptcp-net v3 22/32] selftests: mptcp: join: support RM_ADDR
 for used endpoints or not
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-22-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=TA6WaRxn9RvOnzpUboyxJQQt7PSwNLMC958ZXKBfqN4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDNn1I12oNITAoj9AjYFKGvDWZh6cJw+lDK
 yGk5W4EOB6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c6PvD/9JcVWzBg378JYDWw4znRqa6CKfxpH+NjbYI8Djzk+1fhciUiJUJViaDTxn8wnaccczCnM
 /LYG7rcBg4NGHR8nXIrZZNOvg7PLnyXz5GMMbEftVN+uCOAwlxkSY9ZERpCOokB4EJ9xo52EYoZ
 5A/Hiha5xceoZvi4ORfapwSvc9BMdGSCbqCviFoQDIUM1/ByxxYo0SLbIWZ4DrBbyPVYErDW8+P
 1dYmEh0WX5Q8g1kzYfSo4C8MN7cFJh0AtQRCAh/K7U6L1n1YXqwfSfYGf+vt4a7J5fWJ/S0YTsq
 R4wMWjMsDWgw3qLp/DV2UuZnYTgivld04os5kHd7f9AhTX2Rh0Un6d/LMp/wdin7uhbvNuKURuN
 LRDRh9BZ5VLiOJk3vBDwLnXLwF5rfC1lIbWYhOpKj/sr5z07GTbkHv8nNtgAPDaA6MOj+imfWp0
 DFvaDoni1PYF1IFp9CvQlMtZy9vNO9Ihs1dT6ApsYcmZyoxB4lJCAkSqlNuG9eRzG21bvRR2j+V
 Mv7MoRv7ki9GPHAL/tgcmV9gV1Rcu6uuH3FHI2P+Zc+VAf2yFlfISrpI0Z4P/QwOk1JAFXIKqp7
 iuuG/sN9vEcFZ/PyBZKpoOAWtpZxSzIbbVqcm8dqnhI4fSE5ULPSYGwgXfZfACKoBxSe8ErTUgU
 pqGEKIgou7TMHkA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

At some points, a new feature caused internal behaviour changes we are
verifying in the selftests, see the Fixes tag below. It was not a UAPI
change but because in these selftests, we check some internal
behaviours, it is normal we have to adapt them from time to time after
having added some features.

It looks like there is no external sign we can use to predict the
expected behaviour. Instead of accepting different behaviours and thus
not really checking for the expected behaviour, we are looking here for
a specific kernel version. That's not ideal but it looks better than
removing the test because it cannot support older kernel versions.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a2455d0e2abe..d07d448059b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2402,8 +2402,13 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr 3 3 3
-		chk_rm_tx_nr 0
-		chk_rm_nr 0 3 simult
+
+		if mptcp_lib_kversion_ge 5.18; then
+			chk_rm_tx_nr 0
+			chk_rm_nr 0 3 simult
+		else
+			chk_rm_nr 3 3
+		fi
 	fi
 
 	# addresses flush

-- 
2.39.2


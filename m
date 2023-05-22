Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F71548B
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:33 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-30644c18072so4026483f8f.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773511; x=1687365511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vLZ2HxSpO+km6KEZBqkj0x08T546Xk2PbuQGjhei0I=;
        b=k9y3ChjcCHycmaWRZ+dL39+veSLMD4ptPlV+RfoPpARo/SEyghDE/vrstJRntCJnwq
         2lgLHaNbH5NFKSDp0S66TPif/bmeM9rkmGsRn87Fyou+00HpgOi7tcl1wutyvZu5fUsr
         fpkZrVSsBUPHrkpT2nlTeKSuViHS4CGGYKZUKQtft7xNxxBlmRlSRPR4uvbnJZt4NyQA
         NqYWOzm1n7zBCJOKP9sFHD9EzSjPBFWpzcL7lWwhutI95SYv0UWcIv18MdK9xNAzGY/5
         K9GzSb1xdizEUmRvngjUg1wK9NPF90Uje24gJkSWLleJO7z/A29+TnWa+HlayW8zndTN
         w9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773511; x=1687365511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vLZ2HxSpO+km6KEZBqkj0x08T546Xk2PbuQGjhei0I=;
        b=U33rs0GcZYGDc6VUKGWnVuZYIxy/1VjJ/5YnKlmB3J+G73Ii6vyuXS9SP1OS6nV57J
         kz6Nxl2EuEK1dbYwr1q4Q/zNDzGT0sx3r1MOIGsFRM71lW6sehNPhaAstUwAy6XX9QZD
         mkdYE+opIDGNCnQuQfVCDOTPiXI9OuheVduppZjqOgya6qwseU2WywfG/ghANH6FRNBM
         P0U5joYoljRwGEFHsIcZ6KLKsnvUbLG2uJsZKEutOrxiPE3zjH2ZFM1AqN8RiunYm1OR
         hekBTvlUJFNR4Y1AeBva7OvewIHT90e9fMOibMEXMt75kpC3942wX/031IRQcBsM0wPw
         emLg==
X-Gm-Message-State: AC+VfDzBfgKLbZ895l7N7sACqGjoFsUUU6xISCtlZm8FTWO6aJjd/kCL
	DTJZD8pbN/HrwGuH4M4fM/Ci84kR2b7/Y6pErOmPBw==
X-Google-Smtp-Source: ACHHUZ5ETSqjGsk/sPetqMyg4Ot5qcci2R2yb4plyleDZIyN/S3P7BXiPcOH3LrfQlNCD74QK6YFlQ==
X-Received: by 2002:adf:eccb:0:b0:2fb:7099:6070 with SMTP id s11-20020adfeccb000000b002fb70996070mr8037999wro.47.1684773511163;
        Mon, 22 May 2023 09:38:31 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:30 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:38:01 +0200
Subject: [PATCH mptcp-net v2 29/37] selftests: mptcp: join: support RM_ADDR
 for used endpoints or not
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-29-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=nak8I78p+O28kdvZEZ0ilTqUjGOt6d60GZh8Zc6grig=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxptMhrCi0szp3h9zo8XH9WPv2LEZYtcW5p
 2AE8eST3e2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 c3kSD/9wSDjpP+Cgf/CQC+/Y2CcTeqFqIlbCFAlKiYW6QFp2MC/mFZpXl4cF2FNkG7jxRgib6RK
 1yYpFeoW1bgJB25UeWx1/daLp4IWtLsRXhqCUGnwnoKG204q+HEebVE6fWmXnN9GwTPRFKR38Xs
 HZf/pHCLqfYKyNpBctedpPgo/UoINE/RUd6yQRCbSxAdGxsp7anrufQvNRE8qUnz/BK3FIVPXjX
 zJlpdaL/nmqtgSuQ6F0NX+bNyqnsuI5Q1iuY7pZycGJSwlGVeYeyQv0JYgDVnzZ2MOgqNNQEQKg
 EEaM2Qd/5bZ9+tF64tbN4g7OdKxfTdP8KHdjKSvjBI6M+zbt7x5AIL0nQcOu8QKnbjKNLsi3ZEJ
 YMkNLZCeZR7NKcXaOo+uQaxklH1nIGsxxdy1fxuC4o+Mas/k9pizhqvpytLETxw95kg/tBGc42P
 Yrm8c5th2ER5Zyx71wC2w0TYgop7QmQugnS2RUjBJMtrtlKBnFL5o8va46wdB6hIXOEc+1/mmuu
 zXvzda6U13NKsh2EWcfUCu/+5Xf8AoinYN2UlafFh65i5byOF+IzKYkhY2+yfAodlv6bDHdifjz
 2FHE9ewRww/6IhkLazREouWRCnIxaeUm5DE2f78H0G7U7xjO8KVbeYKfb2aLtYay24MOLhu+yv5
 LbRqeu2UXlCATXA==
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
index ccf52aba8a1c..fd0e3c6fa147 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2451,8 +2451,13 @@ remove_tests()
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


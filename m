Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871307B
	for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 10:23:12 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id y1so1361228wru.2
        for <mptcp@lists.linux.dev>; Thu, 16 Feb 2023 02:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHwlxhHdNZSm3I25Iss1c5xdpPzyk8lY3ruYFLVW+tA=;
        b=PYTHZggOQ5bczLT2boejjx4s5W0kpuR7Ui/+GO0dL0FwAvG5kIKemddvnfY+5zxLqy
         pdS86p6qNldHUBucxzr/zT5gNABKXfxsOp5nMfll1gSywR+bXZOzmzpOPxJjBr/Eu7mX
         bREDqQMb33Z6a9IyQiA56J9onqjNsl5raHigi3dQE930yEZKBBqAHJN7/wA+Xc8yqhD5
         7OJVSdP8mg4l3LKcos41rVgVmyNdBGP/Log8rmLujdtBRRuPkWOcRa8IO3W0G02iInRJ
         IRcQnM7H+iBe6v7iP3ovslsGhsdPQsQyYFkW4f4cT0EU5AiNIuKC2FqqTXuBIWUl+p2n
         xspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHwlxhHdNZSm3I25Iss1c5xdpPzyk8lY3ruYFLVW+tA=;
        b=BNR54eJe+A0lQPbuA7AHr6iJCIvZSIK9/rqDku9XFWxEhC8ELwob2CLRLZd7G99Dpz
         P4C/L4Np8Hrgs6RmkbTHFFFKdjTXHMkf6cK8htNnXGuHqnrjJGPNYQWzeR5dRL4AwA6O
         BvkhsykMfPvIk6Uy4TnEQb2ZkaMwbKj6RrRCa114X4SNe6OVNMIQZa8M73O89zcuR1ka
         G6ExSbA1SzLLLf2/e8ca+CbcrKRE5zqjidNFc11NAGuMML2F/6hXLNIgws3XP3vrreU2
         b+mM0543wDfQF5VRivRXyiNIjg6AQ4beZtj9GYZGAT695RSR4hF0a/7MVNdrl0Scqhrn
         tggg==
X-Gm-Message-State: AO0yUKWPWJ+vaXPetE3bs31WhBN+qvMmsVRyi2li1SAVu1sKZY27sgqx
	/q+H0onGuoWhrbta9bou68bdmEDwQvKuom75Ur7Fcg==
X-Google-Smtp-Source: AK7set8IWJ0pmqrzN0kBeCxX9tirRtOdFi1Ut/1s4FkVDFWuPaUjhhUN1JlSopk+rFxPTOOgWjhgHw==
X-Received: by 2002:a5d:404c:0:b0:2c5:5881:be0f with SMTP id w12-20020a5d404c000000b002c55881be0fmr4348319wrp.25.1676542990066;
        Thu, 16 Feb 2023 02:23:10 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d638d000000b002c54df43b42sm1158065wru.23.2023.02.16.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:23:09 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 16 Feb 2023 11:22:32 +0100
Subject: [PATCH mptcp-next] selftests: mptcp: userspace pm: fix printed
 values
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net>
X-B4-Tracking: v=1; b=H4sIAOcD7mMC/yWOQQ6CMBBFr0Jm7UQoAsarGBelDNJEyqQzmBrC3
 S26fPnJe38DoehJ4FZsEOntxS8hQ3UqwE02PAn9kBlMaerSVC3OrI5R6DUqiQquWSBsHSHPqB9
 ekBKTUxqQrl13sU3T1p2BLOytEPbRBjcdSj2vLBrJzsfIkUaffk/u8I8ESgqPff8CmhCvxaUAA
 AA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=3zOPiad0Xe70KpvQQKlZy0CdVF4QQXLNlsRVsPWNtgE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj7gQNC7cX1qk9JaKsyzU1w5z4PJl9Inrvqz980
 diw8iUpwjqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY+4EDQAKCRD2t4JPQmmg
 cye7EADa3ya6gZv8OljDpj2QQ7VyoR72TPAJ+dDVZ3zURPzh4LkMT4Qn2uBTkx3FOJyuTOFSzK6
 AEs3QJ5h20jj/Ab7J82+4J+JTJtCvfBTAjEynu00yLAdQ3HGycoQ++wghRoIhoiW3BAMwm+L/ag
 +QmpTdjklHNhWWJs31KavQhpBssUz+/B+iwYvKMQNSBPahENBhJgkcPNqTBavSm72VFQ1yo3gyL
 nJ6TPTiRwVSWPiqnZaA+214CvSfdwhN5nvp8YGr1834I3eVjtmy1X87yZ8E2yZVo1JsK7+GRF/G
 rpsULD/W93sr5lk+jon4cvbApSQT1jIaiMGgMMq86wsW2Yc0ZLEEvGEaW8dGH3U0kg6JxKtrfFh
 ntElIRvcTtHnqvMlHLgoZrmzZUh08C2oIZ0u5cPiyXwNX3r1dk/AAYH+yP2MeAAYFy+N8DsZ85x
 MKkPfe2xyMYuMpf7Rb9E6Tw9iZ9nhvsBgnzBKocN7CyQczIk0690kvFVvD5nqnI/EtdCdQJqDMi
 7GDfMxbzvVHwY5yJJ3qkMvcsa9yKZ7LOqb1jx4Gh6TD3A1ZvotPkN9ny1IhIb8OZz8WyvoEyYlf
 KntOKlLEjMKWikBUFzsrvUAjx9DkWu5b6CPIIKchA84nqhsXuYM0OTARVnqZ1S9/YbyulI12KWf
 6uNCIrZ2lbqu8dg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of errors, the printed message had the expected and the seen
value inverted.

This patch simply correct the order: first the expected value, then the
one that has been seen.

Fixes: 10d4273411be ("selftests: mptcp: userspace: print error details if any")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 66c5be25c13d..48e52f995a98 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -240,7 +240,7 @@ check_expected_one()
 	fi
 
 	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!var}" "${!exp}"
+		"${var}" "${!exp}" "${!var}"
 	return 1
 }
 

---
base-commit: 744bdaf391bf58029612bec80f292805e349ae27
change-id: 20230216-mptcp-selftests-userspace-pm-typo-expected-e8774a556372

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>


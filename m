Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5112B8D
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 16:39:04 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso657505f8f.0
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686242342; x=1688834342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5QfjatVBc+UOU/sh03jIPNVrbTRG+sfLrSsyGdKccw=;
        b=FgcnTgDeIyKjr2ddER7XjIWrbKxbSmU4qNUhVBJsu0BeUs7lZOQVp38v/HH5qgE3zg
         Ottn+GpfAYauezlOB1eLjayZQ8yQv/OT7JB+LFFrN1MUPDrrqjaH0naxCVLrm5ZyaDBY
         q2CEBhQTeoe7p0QjuMXEkBLyvklz3y+pNZYcrhRMg3uF7ZnU+nZE1dZXOdxecdFS+VDO
         SYP7bz5G1W6Nql32d+MFW9nL/nLstTVTBWj6U4uPQYWvRXpTYIDJCR29HWX23cMJ5J8d
         t3w1E7INp2oQv1mHWNiW0M6WGpnfpXUnOloyjQIj+0Bok69H5tcPsIbszjdADtSgYsNb
         vmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242342; x=1688834342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5QfjatVBc+UOU/sh03jIPNVrbTRG+sfLrSsyGdKccw=;
        b=O9FYtq3V0PKTiwRq2P3PRf+xuQToutgVX084p+HWIu1fMLJrCMsspOzDyHU5UHu0Hu
         8wUeNCyDzinudNkqOCW0Pk4/Vgph6C1yU6lj9lcueFqmhuJm8cacPVNH8IzRGhSGvRLi
         pBZcF9Wt05jVzIlI/UuL4+9ewgMKb8DkTFEFCa5cQh2jSj2+3kjDO2ekwYAQGxaL8Eg8
         0Ghgd95bD/lTTNasySfuMJvhaXyyx6laYqkdBYeCETSXAQ3ojFNdrMnZUoW2EYRru2Ir
         bx/gDd748fVXMCgHRsLpV7JX0E00LZSOVx1Mbi1iDqBGh8l9pK4nZ7QRvrh3TJ1MKUiR
         qrIg==
X-Gm-Message-State: AC+VfDzreeD7BEc30M3QQJF1LzjjMkg8smmseApkvvh2C4L/zmWPN/Hp
	fEf7B/+UR2nXSf3GeITKQfAr6w==
X-Google-Smtp-Source: ACHHUZ7wx7hlSwuMrdCrq4YW/Kh5FCR6bvTO4XgnIy6RUYYvnVtbyh/v8tV9f4Kj6BZkkDQXR8yDhA==
X-Received: by 2002:a5d:65c2:0:b0:30a:6958:456 with SMTP id e2-20020a5d65c2000000b0030a69580456mr6237867wrw.4.1686242342528;
        Thu, 08 Jun 2023 09:39:02 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020adfef0d000000b0030aeb3731d0sm2038215wro.98.2023.06.08.09.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:39:02 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 08 Jun 2023 18:38:50 +0200
Subject: [PATCH net 08/14] selftests: mptcp: pm nl: skip fullmesh flag
 checks if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-8-20997a6fd841@tessares.net>
References: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
In-Reply-To: <20230608-upstream-net-20230608-mptcp-selftests-support-old-kernels-part-2-v1-0-20997a6fd841@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Davide Caratti <dcaratti@redhat.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Menglong Dong <imagedong@tencent.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=fBWV1AaPrYseN5Cy0tbLjkgFuddp1+Kl8LYSe6sCVzY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkggQa9cZgI5NnXWQxzcCcxMao08wnQcD5e931m
 dXG6wzLDN+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIIEGgAKCRD2t4JPQmmg
 c8luD/9WjQztHwOltdgDBF5y7YlQZ5onmoZos6LzgMQN6IjPZKmWoBDr4BA81g/din5tFnWv0K+
 kPGP+EU2JpD1wQfvFhc64aPZNXMqfPPgRpCyeyFO8apNwwg9yj2+B4M6IjENwwlYxq7A65a0JUP
 D3OdNQUdyRRMhJfaUz5tfHtcSrbJW7iMcmsYKUObPv0znqk2jJGWjKFz5NMxoUB51ys27v8oqdu
 0gncKx6fRfG16UB1T0btDLX1g3fvpvAbqCZv2Dhk1S1seovR0DuKo1UgrUNdg7HzBD2b+ceHYR4
 lz41jHOPx5ZdpxsSd3ObmeJRpzt9mXkynIatoIdST6Z1kqKzC+PHionYS2IfmOXkv3SAbvzn8eP
 5TsjD93PHrTKj0oG/FmeUkqATztSkU7d4XhlhXnTnMBjKo+KD6K3C3ebsKbT3/zA10FjGGykx/Y
 gwEqG4M0HVV8fCz/d0KjCerI3lS0H0WLUoyj4l9rK0PXK9Gn1fsa91YYG+50a5YZvhKoleCdyVa
 w8pa6nv71W7Zv0Lrt26343a6fbgVnNum3lEhgkucxeKtw1D/sUMuzrSqaU5B8oUFUDMVQLCB26t
 GyVdmSuNhwHhuxBK5WEfSq6Ve+h2FcFQKHQ8v0O1AJDne496xy7WjbmPW4MOWnUTU9c44NMqE0E
 zWB0ic0yaghREPA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the fullmesh flag that can be given to the MPTCP
in-kernel path-manager and introduced in commit 2843ff6f36db ("mptcp:
remote addresses fullmesh").

If the flag is not visible in the dump after having set it, we don't
check the content. Note that if we expect to have this feature and
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, we always
check the content to avoid regressions.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6da1dfdd037e ("selftests: mptcp: add set_flags tests in pm_netlink.sh")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 664cafc60705..d02e0d63a8f9 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -178,14 +178,19 @@ subflow,backup 10.0.1.1" "set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nobackup)"
+
+# fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
+   mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,fullmesh 10.0.1.1" "          (fullmesh)"
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nofullmesh)"
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+fi
 
 exit $ret

-- 
2.40.1


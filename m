Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB178154AC
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:44 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so44080945e9.3
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542603; x=1688134603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQ0/sONYGaemYjF6HodoV0Hl7EvG7+/XEdGtw0LdLXk=;
        b=MZp9uKMx62/Wbe2ZdHfyrdfe1RHkBmB3qJX4ssQqeH6O80vbgnCkrpJy0ZHTfVzupu
         4e17Ff6zGf3PRLIzUiYAMu64UjpgRRiG+hQtNwTh6JpidHMznpzrLPsJIeilyhJurBS6
         1BRIe71hFTtihZKLTlRnnFWKXAptWGLW2V30Q7jF/T6MwJ9jkiOgu5f84EPGqzNOgMYF
         7jFEu9ZFdyf5l0+iNxUn8f9K+od/Sq65diIkdOt6Ta0yMFxKVfVPA71XJzAXZCI4GXN2
         Czmb9wxKZ5mOmcfdtRtGpG6h5QMnMaEvfpSBPV0SsvHK4L7+rGSO9eIaiHCziu/sPUIz
         Cuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542603; x=1688134603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ0/sONYGaemYjF6HodoV0Hl7EvG7+/XEdGtw0LdLXk=;
        b=YjwuaVyLHzxLGoW+ihqQw4pD/L66V4KARF3/rt7nKJvhF+/Bfe7+jQNANvupPOzYsI
         BDqwi7lgaSkPdLX5lBrnLoyVVmXyAUo9URX4UivoZX39NWoX13xgW0iqGzgvlypzxP0d
         Cbvpl0dEWr0Dz5BbMYm6UJYU0BrHjzaaM1eQdiMHD3DZO5VgpQzG2QN45cJO5H6hvSja
         E7D+fymuspn2Pp0J+QJpLnJkBM7Q0jgkZ3KRIY/UFOM063uNxALiPKMlmMrlWa3j0lgd
         hc6w18BWnwSDNrISI/vjoj9BBzTWmJkH6Gt6i/gz+Z03SPTEEkWotuH/qEZYkLZ7kUZZ
         WaOQ==
X-Gm-Message-State: AC+VfDw6nsxmW8YqqkSRYRFES6fsgBdltnLE+pun9xMrF9Z3XLCiSumn
	bt4Nu6QGlSGGUkoSsyHHqKagxvoTD3Gpxs4kpt6eOn3a
X-Google-Smtp-Source: ACHHUZ7E27tdq0zOVjmWpTsGGqyYnO8HQ2KJoNINLdbqyg/MSPwBV6YCPACjavw0ZjSTURgPulPUsg==
X-Received: by 2002:a7b:c408:0:b0:3f6:536:a4b2 with SMTP id k8-20020a7bc408000000b003f60536a4b2mr3883190wmi.27.1685542602899;
        Wed, 31 May 2023 07:16:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:42 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:28 +0200
Subject: [PATCH mptcp-net v3 08/32] selftests: mptcp: pm nl: remove
 hardcoded default limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-8-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=aVuU2oyLjzTS88MYhN2EnnAYnefqP09EdnhSEtFCMng=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bClhpN8VOJMsPwa/eNZYEimnw3Ghjjq1dWI
 Z2d3vqPiOSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c+NMD/oDwmeFOvI2c4VoDUKx8B6ITSKBp7VLwWGwB06S0YwCsg0lezpf1yhca7u5Bfxfa00JlhC
 gmMiQeyw0rhm9yi+ANVvHWaJS68/HnaYQiEfeFcldSWFfYHa28G5Zxq/i4wp/J3wIEdXUZ+akYY
 0IQn7x8dhKFC+KrLENJj7NZMCAWGpRLuqHPvxcq0sFlJE/TaY/kB2HuKDaAjKePy59aZJOTGNYB
 HKTCQmqeNQgbyg7Kbpn7A1Ji6k7//YhBY2tZcH+MQXTaj5hpkcOj2iz96xjYOSDqNSXw1MybDjw
 Um4XU5iJ0RsWlFzv1NATKkLgV2Cr7KXeg89g/riz55UtoY+6lS/XOTCwkKNo8sB2JRrNL/1W4S/
 DX0QX+Qxf1utQW/6AeP8BZUs384GM6DZm5wK/j4S7IWhxw3ShRPX7ceif890+XVsdLywvEQXwCm
 2RlpmUjSjEj0Wpi1rHMA63rZ96aS3PUwsgqaFU1Vu2iumpTqz18jIXB4TuufdwBsJWR8/q2BAT7
 sLSaMAmDGe64oCkHdw6iE07pkFo3HXfl1pQg01ojEWrAlmw2vhVuazggHDrUCTFJItMFNfcD1IB
 a8hYhJCc9HknsmRjv1R+zgnxJB0HavvOUZap1QDBXfhsjvwkW7mktWE5h6CHpxwEUIUVy3ksrc8
 JBvBh+I+qxSA3qg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the checks of the default limits returned by the MPTCP
in-kernel path-manager. The default values have been modified by commit
72bcbc46a5c3 ("mptcp: increase default max additional subflows to 2").
Instead of comparing with hardcoded values, we can get the default one
and compare with them.

Note that if we expect to have the latest version, we continue to check
the hardcoded values to avoid unexpected behaviour changes.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: eedbc685321b ("selftests: add PM netlink functional tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 32f7533e0919..664cafc60705 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -73,8 +73,12 @@ check()
 }
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+
+default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+if mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
 subflows 2" "defaults limits"
+fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -121,12 +125,10 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "rcv addrs above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "subflows above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8

-- 
2.39.2


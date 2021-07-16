Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123A70
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:05:08 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id t9so8624789pgn.4
        for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8Hg4uWGVtuXMjbA+eMnAVBVSSMehcKpA1bopxzNvi8=;
        b=U67txIQp2aUuZ13zhtWp90U+c38e9ejsZmV8JCUGy3LXcnFuIAsHQQTn6/9zrNXnx+
         aTcoQC7NDrrUqAWYG9BAxtGeAdbsSyeZNCZQ8qQjzRRNbpe/XjoAam83fZTO+CEKnfAW
         AwYqONtohef9uogKHFf7foYcSU7fG7J0iA9MYjzstjuWaAQVy+3PqB07JXiNWucZroG6
         YMUlr1iT46sgmy+BHWneAqhuNXWKbFpo8hXCWreJcFqQ3mJR7y+s6OdyNbiKMMWBRRGs
         8YbneMTclO19rXxAuSYFctlIJDKY6aq6kjURLntnIIlNUB+/sz73KSFK32mz/35fol4U
         QPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8Hg4uWGVtuXMjbA+eMnAVBVSSMehcKpA1bopxzNvi8=;
        b=XPI+anp7YbE32eRqvzypF+/9VJjJngdtrWGmEFniYE9fmso1gA1XKUP0/aR5jEomoi
         e81nngEv1gvxy0FU7cTmenjmqzECBBcbbfXL+JVu+RwapQPpfz6Io00wO4Olo/Px25tB
         FdyKCZ2Ts5iBOBpv3xR3OKGrr7jxBuHmJhBKn4IxTVcpNpaJoyxe4D7O+EWsUdabxpFp
         EZ8PwGZJ2eWtSvX8ykOFE0WLXVL7UTvexPiUlPmZ7JW3Q0QU1aoU/QJjithJm6HIM9PN
         cY8i2aADIT0VxMUlCWU0Zgvv7x4kWBwBRgrQE0dO7lHgG1PFtSolDQQIFNytprO/AkkP
         ZIdQ==
X-Gm-Message-State: AOAM530AwwDyF27LUhcHSuTvWt4brl0j785cImvpBnGx7g7i3OGUwJb6
	BM09/KMekseHQF6+YclIlI6dE8D5dCXlAg==
X-Google-Smtp-Source: ABdhPJwqd1uqwg5n84N4KYRfHRZSeSgUXFgif5jBakd59wwljc5GR8tEBjP9eMfRVr24+m7KcdVgYQ==
X-Received: by 2002:a05:6a00:178f:b029:32b:2092:c3f5 with SMTP id s15-20020a056a00178fb029032b2092c3f5mr7870297pfg.57.1626404708215;
        Thu, 15 Jul 2021 20:05:08 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s15sm8344119pfu.97.2021.07.15.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:05:08 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v9 mptcp-next 6/6] selftests: mptcp: add_addr and echo race test
Date: Fri, 16 Jul 2021 11:04:38 +0800
Message-Id: <6fef6589e875a0c2c05d746e88842a3d6e8e868e.1626404090.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <e692d25333e3da8f0f2574277a508b274c5d8837.1626404090.git.geliangtang@gmail.com>
References: <cover.1626404090.git.geliangtang@gmail.com> <a742beea506017b809bbb5f52c2b9aaabd18bc4d.1626404090.git.geliangtang@gmail.com> <26aadb84ac57a74e69d5a81dbdc84c4770117b20.1626404090.git.geliangtang@gmail.com> <6a400c9de23c2254e57d472ce7e49d16aec2e294.1626404090.git.geliangtang@gmail.com> <94457ebf428f392419c14baad4babbf7f93a26a2.1626404090.git.geliangtang@gmail.com> <e692d25333e3da8f0f2574277a508b274c5d8837.1626404090.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

This patch added an extra test for the singal_address_tests() to do the
ADD_ADDR and ADD_ADDR_ECHO race test.

Co-developed-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f02f4de2f3a0..8ec9f3408de1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -918,6 +918,21 @@ signal_address_tests()
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
 	chk_add_nr 3 3
+
+	# signal addresses race test
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_add_nr 4 4
 }
 
 link_failure_tests()
-- 
2.31.1


Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88790A5B
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 17:18:41 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id i67-20020a1c3b46000000b003946c466c17so777338wma.4
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bcAkx0YF5XrVhaL1qynVdnseeYSj6j9kBWrxnH/0Zk=;
        b=aq9FplxUKkEmN+3Zgct+J8ugsbQdxTkImzFwKyYIqNJxKHOdCwYZkscnWTqTQZoIl6
         bj4XeIAat6TkmvZOEKyAwuWUV20GFXqwIqTjd0OSYZAy1RbyonryRVzZPQ8mkFgR5dYj
         nE+nl7wQWmv8oMI9h8QsgvpMt9uMFxrKxwKVXk9VigrilP3Z40OikpkHaBwdKjXQ0Vd5
         xuQ8SmdAer0KmVe0OE7/Scp7UywHzQXaWmG0l/FNEfda+YUPiFOEufhALZdHZCtVuhtz
         EPSQH+ytCI3z6LKBUxt4bZ5CzP8udmrEGDqWhJ+0OfjMCj7Ng6egnwR+RDIHBx7u+lBd
         +tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bcAkx0YF5XrVhaL1qynVdnseeYSj6j9kBWrxnH/0Zk=;
        b=PYlBKSQtleCFO0Dusrv0NcwWiKjs8lm51/E/J83JD3xu5CZkK+RtuofUej54H8hbtL
         2ARRDKAWMsuo7WBxJiSycj38xu6orgQXSZPTc+yaEigfc7Y+xzMXS+eom1cY9BbaLxFq
         vmSfsW9dCg4WpIwxqhByhlEr9veuDOefVdRH9fWW6GxD2fpfOZ4JMfr/EDdNMM5Um+kw
         SU13RVu8sKx1ujMgSLH8jKebaMKu0O6SF4XLfbSCQnwZoLaNzY40wVAKjKA2q13INLZR
         3fq6gya1WSE5IUriDVmLnSf9iXCUr8dGK7JGBtl+Hynz/12w0DtZ9/H/4+8hO29pOMJ0
         vDxQ==
X-Gm-Message-State: AOAM532gt/X1Z4bq644QEZXgpO4cWog/+3F0g5dy6Dm9oDr1VIW4LpQ1
	pGgR3Uutwahcr/eEZ2XZ/+ilBC2IE4TASHOy
X-Google-Smtp-Source: ABdhPJy8nzCENW5HNylXTDE4CU4hMWes5PoAFjf56fQM9t/eJEVOF6trXWsIa31rA3ZaqwlqBiRB3w==
X-Received: by 2002:a05:600c:1e13:b0:394:5cdd:e8e6 with SMTP id ay19-20020a05600c1e1300b003945cdde8e6mr10792230wmb.108.1651857519325;
        Fri, 06 May 2022 10:18:39 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id k3-20020adfb343000000b0020c5253d8c2sm4239213wrd.14.2022.05.06.10.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 10:18:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add subflow limits test-cases"
Date: Fri,  6 May 2022 19:18:19 +0200
Message-Id: <20220506171819.1104074-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The test -- "delete and re-add" introduced by the above commit -- is
failing on the different CIs with a debug kernel config. It is also
failing without the debug config but it is less frequent, only on the
public CI.

Increasing the packet size from 1KB to 4KB makes the kernel sending
multiple packets and it seems to fix the issues reported by the
different CIs.

Note: Paolo shared the diff on IRC without a commit message. I prefer to
apply it like that (without his SoB) so we can stop ignoring CI's
output.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/274
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add subflow limits test-cases"

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5763595c885b..48ef112f42c2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2610,7 +2610,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 slow &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
-- 
2.34.1


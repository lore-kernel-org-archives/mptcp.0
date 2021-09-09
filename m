Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C63FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:36 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id x7so1536288pfa.8
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERXMsZt9dBtqPWxiTjR++W1FhzEsgxW0jKlViJJF44M=;
        b=e7e+WgOGLrgkLqh8lhmUHgmsJ6I/6yJDCuCjoXeP+BgNgI/9XWBFkHB4gUebpS5o1e
         gdqIVOMB9wiWL1kCfkcjh75spppGlROemBbmJNgGLCPazEAe8MOQFQ+KK+8n8JnTK0Uq
         l4gBtfvRJtYPcpUVVvdiunI0uhCC3a2nvHc2F/3YxWSXNHJhu7XU4H9lQtlWGcozwQ9+
         GAcni9q1MCWtmGdmQOoO51wueXiTrdkMBIOpQ7jxdfePrA9iZbuus5xylSdXsnWtM7Oi
         wXCv8yBFjKfq/gZ+M4+u62rTgoCOKlZCToUFWIkEhJK6qJ/0BCXAitB74VUOsrxiU503
         HCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERXMsZt9dBtqPWxiTjR++W1FhzEsgxW0jKlViJJF44M=;
        b=QxDOLp+gJNLMwen7m0AbTdY7nMFfrzlaN1c8nqrtdwxXLksaFRb/uK7n/OS+VOGOve
         iiJTHXHYUlNJklGuHpWV9Zlmctva9MblxsI2uk2Kli914yaOulZnKMWj8j351OCHBdfB
         1yk5QPToPEBZTm1a3KHp/0mniZQRI1IaShYRDX9SXXPSTVQvrYpkgGcFeIJuuZK4TtRo
         ONVBd8JP32l5pz31tqSojx7tGva2bbegE+F7fwhikzoGb9DRtyjwQlYCA5kaNqkkoQWI
         rsJK2sgzbhBzIPJGfVxQz/cJhxmhb9aq+f/78BU3SDjucnZB4G7zw0ApTjuyMwy6F6RY
         u/aw==
X-Gm-Message-State: AOAM531lPNGw1n4v7FvAWpUY6R8XQmV/F4dNwowz/sqF/vMKWL5MjTzR
	rBQ/dGPemknosaDbEKCYJcmdsZRCRyo=
X-Google-Smtp-Source: ABdhPJxQQSOY+Lub9+8glHP3+wokfs6/8vvCeO/5CJrEZMgIULiL1+GaSvOdFq8bfnON2wdfeMpojw==
X-Received: by 2002:a63:204a:: with SMTP id r10mr2293069pgm.365.1631188295874;
        Thu, 09 Sep 2021 04:51:35 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:35 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 9/9] DO-NOT-MERGE: mptcp: mp_fail test
Date: Thu,  9 Sep 2021 19:51:11 +0800
Message-Id: <5afb788b507a63f31f390c512fb5eedb464dd01e.1631188109.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

./mptcp_join.sh -Cf

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.c                           |  9 +++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7036c78ccef2..10d15e93d70b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1296,6 +1296,8 @@ static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_e
 	__mptcp_do_infinite(msk);
 }
 
+static int j;
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1430,6 +1432,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mptcp_update_data_checksum(skb, copy);
 	if (READ_ONCE(msk->snd_infinite_mapping_enable))
 		mptcp_update_infinite_mapping(msk, mpext);
+
+	pr_debug("%s j=%d", __func__, j++);
+	if (j == 20)
+		skb->data_len = 1;
+	if (j > 40)
+		j = 0;
+
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fe0c8f3164a7..38663f6373b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -977,6 +977,24 @@ chk_link_usage()
 
 subflows_tests()
 {
+	# 1 subflow
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "1 subflow" 0 0 0
+
+	exit
+
+	# multiple subflows
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "multiple subflows" 2 2 2
+
 	reset
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN" "0" "0" "0"
-- 
2.31.1


Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D19154A5
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:55 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f603d4bc5bso59922465e9.3
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542614; x=1688134614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q34ylY7RyZGWOPFI8ZS/rIN5/CmnfZRachx6yao2tGY=;
        b=Bh0HPteoisBq4kANGFl6Lm8Z3vPpEuTDS/zUKyCWOjcFnfwWPKgZvkEq7D32DN+oeu
         3KavlLU9RP58Jj2QgGNG/MHV7Qjg4FkCjS+drx7UZTGaDVj+I6ePBhengFq8qvVovuGd
         EKcN7lPy6LB8qmetk8Ots+0ZDzxLejQj1P4ngxJIsFmm0israqJsGdulesk68KzqCSXV
         V1p17UX0aHzaMXLAVlQDUtvLsbzdKg/fGDhPE+VHvSeZK8VLh0SYeMFSdfktBArUpmj6
         1bjY1pWYhR25uB+Rn03GC8zO1ppl7Fo9BnSSKjnfh1t2hnlYdsMYExgWpQdGMvL1DCvH
         h+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542614; x=1688134614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q34ylY7RyZGWOPFI8ZS/rIN5/CmnfZRachx6yao2tGY=;
        b=AB96UjdkdhKmmG53q1eaZhee4uDEnOdvx76HJFCFN2qp/qvRIQbDl8xCMA9t1+SGWn
         ZUifKGARtdrA3aYq666TC1cBgMoNzva+mFBuaSxEJFAOhmrmkHL3PmrJph5aodDeaMcj
         ajb1PdmdJFRoeTB3imgwXC9+Wa/E+zzplmTXk2udCRNC51mQQUgU3qxt7yj4NUx4G1Tk
         +DHbCQyzQSxWMmM8m9dThk/jAbtVu+TkcWdHgqMq/I63CGQ7rmsr0SETp4Dsr9ds/q7t
         InFtrCFOf0CemoynB4t7+bXtXeZT6oF5S/4isx1wewzDT7bfIE8nNTcAJmfG3IPsWU+P
         cVCw==
X-Gm-Message-State: AC+VfDxfIB/YN9CeBR8luvadKpCG/7B8LzMKs2cZzHFpsP/E2649IByF
	hggqtPbj5IU7q3IWZZ03hSNhIVEjZcNybbW/Jz5ex7d8
X-Google-Smtp-Source: ACHHUZ6CUnIuTQ1cLiwH5H9s+NSk9LMSiqZgxKH+XAaph8KuqmBA1crJLEMJg3CIOLBY6D8NL/SkGA==
X-Received: by 2002:a7b:c5c7:0:b0:3f4:2bb3:a5bb with SMTP id n7-20020a7bc5c7000000b003f42bb3a5bbmr4671381wmk.9.1685542613872;
        Wed, 31 May 2023 07:16:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:53 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:43 +0200
Subject: [PATCH mptcp-net v3 23/32] selftests: mptcp: join: skip implicit
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-23-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=qnQZ8QuapALu2QazVTTWFcJXlz1v7ovVGGnwntO2FWQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDQMXxEizv2gsh1UeVZFTdohokAcvskVovz
 MYSG6kf+I+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 czT9EADZxqjAv63UFKma7dyux914zeLeqUkhA0Zke/eE1cPtRwXkSe+TBuwT1Z9xWseuEy/jmuT
 11un8gV3VNd4MMmtO0eHRw/YCYjlgMkH7wr7faWl6onh+lmlN3/rp9M451U1lp6iG5n4CtUgb/8
 ZTV0Wc+M+f3GmdWWyw91luoh+jjxTBkA3pcJHJRqdPlUeExw+sSKRdjGuTrZ+lTXpt8XO3IxuZO
 yY+o7nVW82uqst1HzSEXO9qDQ2fCuUZEefI8wzUUY6k0f4tjyWMQIeWv310fwldciDmrzUI1VFo
 1ZuZzk+pW9zuSXGiC1w7kZ9EOPqk8s+u/9hyag+//uql0keMJhnZFNOsStZXPhASH95ooJGk14a
 +46RySXNzTCc1lCxET3J5y8YlGDg4Y57X408E6tmjW2TQp2tCHiDVhhQdIvNjEogiXuPMfMQ9gs
 NonBOov6Gs14+r3QP1KTuMf+jfatDkqdwIUSkazYIpMcrb5H7iTvGpw+qhXGmSE44JzUmgySPlS
 IkC8ZEKd8M/avtFV5B5yMyhB94dpCH2SSDrES+TzkI1r+NKcjP+kYp8PvzPjpwVobNXVRlzo2c3
 J4/U66LxJ0CLQkRlCFRxb/x7S+o+8PrhgWHhVwPCvXBG0NqLkRbsRkTmfp7BOuObR2mN3w0NR0b
 8+I5TYYbHHxzgyQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the implicit endpoints introduced by
commit d045b9eb95a9 ("mptcp: introduce implicit endpoints").

It is possible to look for "mptcp_subflow_send_ack" in kallsyms because
it was needed to introduce the mentioned feature. So we can know in
advance if the feature is supported instead of trying and accepting any
results.

Note that here and in the following commits, we re-do the same check for
each sub-test of the same function for a few reasons. The main one is
not to break the ID assign to each test in order to be able to easily
compare results between different kernel versions. Also, we can still
run a specific test even if it is skipped. Another reason is that it
makes it clear during the review that a specific subtest will be skipped
or not under certain conditions. At the end, it looks OK to call the
exact same helper multiple times: it is not a critical path and it is
the same code that is executed, not really more cases to maintain.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
  - Note about not skipping the whole function
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d07d448059b8..d02f715feb62 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3281,8 +3281,10 @@ userspace_tests()
 
 endpoint_tests()
 {
+	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
-	if reset "implicit EP"; then
+	if reset "implicit EP" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3302,7 +3304,8 @@ endpoint_tests()
 		kill_tests_wait
 	fi
 
-	if reset "delete and re-add"; then
+	if reset "delete and re-add" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow

-- 
2.39.2


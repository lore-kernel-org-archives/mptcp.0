Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9680F
	for <mptcp@lists.linux.dev>; Sun, 19 Feb 2023 07:01:45 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id e4so574550plj.13
        for <mptcp@lists.linux.dev>; Sat, 18 Feb 2023 23:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfJkHMMisOq3RuXOIR8+nfpzl2qNn0HErgnT1e8I+sM=;
        b=o70ejizjG0urg79BCKhprsll7qcNYATLv+u4WS7msZ1WJWKfH6tuTEYOR5TGWMAQ6L
         CSA7+0cftdEFIy34hbfXNY9KPDv5GFAvZgR8WZiMsTDFcMcxxd3VQ+0fjyuQV810XuGQ
         UACXq22XzSddtQQz46zkWh64o7cW4Zl9vz9eeVhq2jJBLGcqjxc+kZnlXbbzK+ivJ0ry
         wqGlWJSkyd8PzebaWpGBHPrsIESTqbZsP+3SFQ0dSz4Zj4SXbI03EE74usgRtHP4Ly3L
         qO71m0wFAWNQ+KRdDI0TgEqHenhbQGJPsmz3kR8shUwtznJfRuVpVipvsdiJY5VzdUKK
         wzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfJkHMMisOq3RuXOIR8+nfpzl2qNn0HErgnT1e8I+sM=;
        b=I69kS2KoW1pbSQRo5CCjERatTtm6t5/LhgeS44usxOD3Pu/LMsQFYcU4l6QDrctXUI
         MqtYGCSkv5y7z5U9HVx6nIUJHaDbwuH5sQbmOeeFcfHK91wVDxIIbWzwZg6XC/BXVXX9
         jh9n0PR5lSRdNJp4Z+LDhKHe3VeGlxFoF+mRiQJs5W16IjPNlkBlcHxikL4LCxAtnhcE
         z5iZobXqsRQgvprLs/9hD5QgyiJ3x3YOfsKp7/TCq1absIR9ChZEuS/AZvLzY63FWsAA
         zqFtyalKxrAkn+nRVOAttZsHkeyb1QVWruZ+0SWuSWdkHX7dfXyRz/rryT7WVeAZYXcZ
         P9VQ==
X-Gm-Message-State: AO0yUKUBK/8+DksXezrBpkwrwFVLgYLhWYbw/vmdFoc6wxdFnu5t6xHg
	pg0PxGSIymG2etO2eWLMPWM=
X-Google-Smtp-Source: AK7set+412x7KtecLuZPxcpcAxyHwNVewZ20/HkYRFKZWkTORg2Wq1u3dxzhw/PnyjKovnpAWjiobA==
X-Received: by 2002:a17:902:a513:b0:19a:7d50:aeff with SMTP id s19-20020a170902a51300b0019a7d50aeffmr18895plq.41.1676790104686;
        Sat, 18 Feb 2023 23:01:44 -0800 (PST)
Received: from Laptop-X1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b0019a928a8982sm741056plc.118.2023.02.18.23.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 23:01:43 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	mptcp@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 bpf-next] selftests/bpf: run mptcp in a dedicated netns
Date: Sun, 19 Feb 2023 15:01:24 +0800
Message-Id: <20230219070124.3900561-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current mptcp test is run in init netns. If the user or default
system config disabled mptcp, the test will fail. Let's run the mptcp
test in a dedicated netns to avoid none kernel default mptcp setting.

Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: remove unneed close_cgroup_fd goto label.
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 59f08d6d1d53..dbe2bcfd3b38 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,16 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 
+#define SYS(fmt, ...)						\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		if (!ASSERT_OK(system(cmd), cmd))		\
+			goto fail;				\
+	})
+
+#define NS_TEST "mptcp_ns"
+
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
 #endif
@@ -138,12 +148,20 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 
 static void test_base(void)
 {
+	struct nstoken *nstoken = NULL;
 	int server_fd, cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp");
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
+	SYS("ip netns add %s", NS_TEST);
+	SYS("ip -net %s link set dev lo up", NS_TEST);
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
 	/* without MPTCP */
 	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_server"))
@@ -157,13 +175,18 @@ static void test_base(void)
 	/* with MPTCP */
 	server_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
-		goto close_cgroup_fd;
+		goto fail;
 
 	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "run_test mptcp");
 
 	close(server_fd);
 
-close_cgroup_fd:
+fail:
+	if (nstoken)
+		close_netns(nstoken);
+
+	system("ip netns del " NS_TEST " >& /dev/null");
+
 	close(cgroup_fd);
 }
 
-- 
2.38.1


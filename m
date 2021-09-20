Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79372
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 15:42:56 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E45173F320
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1632152563;
	bh=OcpxhdBlzejp2v0C2MQE07mgZm7uaKlgWhogNvtB6Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=jYU4h74b7zZgjrw963sCoErSuOmZSuTt+c4340SlhueniovejZ9dM3qYxl2QNeFtm
	 GREH3Coih0Fg2Y0bOy0D/6MmQO4hqM9/edDiShqM60eYXraAk1OeV2l9ZbCB/5/8xB
	 4EPjU8EPnX8BBCrIeEuXRX2fKiIT14B7BzZ0nlySjLc41Wg51swarqb8uGQm4MOApA
	 9AiujQSrJFpUgOEekQcHCrE7jT6M5aDt0/RxCIcE0W5o6sQBcCGvGAPUqWJ+JO9N4D
	 Pk25/vSV80laY3XItzNapYNRpucFh5xcxKu4kxCx76ufJikaUY0MshKBT32L4hIY8I
	 cxQVScqLXxMvw==
Received: by mail-pg1-f198.google.com with SMTP id q22-20020a63e956000000b002524787adb1so15160830pgj.3
        for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 08:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcpxhdBlzejp2v0C2MQE07mgZm7uaKlgWhogNvtB6Bg=;
        b=DPZM+7Pe4BAswhHCSO73vM/YDx12ZTNPYhuIC5/n7OJrBGe7ZPfKGkuZUottz5Ynqt
         wyfFrz395FiBagb8RU0+oqqWUGlLzjO45Hul6majJeZvQzTzc1kfcMhkyMHT3VqqmfwN
         9VIkqLb7J7SfpIwXdvXdeXk2PRfn8jstm/auVM+odQilFOS0su/8JQgxtx6qc0eMJf9k
         g0jw7amcE2lV2jVj8JKG/XFF3uKACKYdioon3IiCCOXX1T0orK8O4AHHUxZ4SlIfhS5h
         U79WfqKq5MH7FOP14CwTyLMKfNUGBb6oJaazkpIsSegfJ6+Pajz/sE342a73PhxtSdhe
         +rrg==
X-Gm-Message-State: AOAM531+3pScEiCuALluFFIYHdGxU/Cgd6K/RnrBoY7J647nnk6t1dhB
	11Ubq17GIV4797ZxqS6JZDABTMrjn/VJoQAEWop7MoXbeuXJoRqtWHi6Yd8pcpxdRrilZQnoXZs
	/XHMqaPLkKm1Bb5IP170BTbcip6VO8xLU
X-Received: by 2002:a17:90a:7a8b:: with SMTP id q11mr29895646pjf.35.1632152562060;
        Mon, 20 Sep 2021 08:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN+ikGFNNGkvQl7+s28E1V/m0S/lNnypEIpSFEkQjJp9P34/1b21IXIFSgIWBwJnHVvmXx7g==
X-Received: by 2002:a17:90a:7a8b:: with SMTP id q11mr29895618pjf.35.1632152561766;
        Mon, 20 Sep 2021 08:42:41 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id h18sm6260556pfr.89.2021.09.20.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:42:41 -0700 (PDT)
From: Tim Gardner <tim.gardner@canonical.com>
To: mptcp@lists.linux.dev
Cc: tim.gardner@canonical.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mptcp: Avoid NULL dereference in mptcp_getsockopt_subflow_addrs()
Date: Mon, 20 Sep 2021 09:42:32 -0600
Message-Id: <20210920154232.15494-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity complains of a possible NULL dereference in
mptcp_getsockopt_subflow_addrs():

861        } else if (sk->sk_family == AF_INET6) {
    	3. returned_null: inet6_sk returns NULL. [show details]
    	4. var_assigned: Assigning: np = NULL return value from inet6_sk.
 862                const struct ipv6_pinfo *np = inet6_sk(sk);

Fix this by checking for NULL.

Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>

[ I'm not at all sure this is the right thing to do since the final result is to
return garbage to user space in mptcp_getsockopt_subflow_addrs(). Is this one
of those cases where inet6_sk() can't fail ?]
---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8137cc3a4296..c89f2bedce79 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -861,6 +861,9 @@ static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addr
 	} else if (sk->sk_family == AF_INET6) {
 		const struct ipv6_pinfo *np = inet6_sk(sk);
 
+		if (!np)
+			return;
+
 		a->sin6_local.sin6_family = AF_INET6;
 		a->sin6_local.sin6_port = inet->inet_sport;
 
-- 
2.33.0


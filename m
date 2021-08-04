Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785C70
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 07:37:27 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id hs10so2445641ejc.0
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALXNeRuiZXRoNrnxupopBntGuoqgPwGx8GxWRhIFFKc=;
        b=TpMwCKpDCKklUUmfltrm7yJOnwPeoy7y0N5rUA8jvf2BnxQCHxSx18ams9kbngGKZ8
         /NGx6Pt/q1vsio2Z/OZpT7syG6meCF4YoOZsaF351puGbaWFfBZ31Wr0VWD9a9JlTbRR
         zuZoY5XQE5G07ufEfq+FCaZHw+z4D5BfAaZjOnh3RCVcoeVhByD/i+kb9umIR2JgHLga
         yIHfX97r32Rj92xsTvTA1fqyJAcw3S2wFh5nG7qImHt+JYUtMQVUX/1ITQgzDN74tUSQ
         TFlo1YnyWiuLNF69MNeC4gDzuW2mKDmIq9/3B4dJHRlcTRJhZ1/xORlam4xAqPqjYQhh
         go5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALXNeRuiZXRoNrnxupopBntGuoqgPwGx8GxWRhIFFKc=;
        b=KOqrurP7hjFxaTFXWItmmcWc7LrPlnqSt2tg8m6ddInXbRQo3rYnHgJZ8l/4dnDngn
         iOhOGvoydmWR5qS1eTBHMgH/FNH3VNgPGTfoIO4sSEaD8JP3gWdUdRUR16Y5mIOZ8NUV
         cVqdRYwbq9ZCoE7+K9rau16W1MdFHdWy1XEDSBzaPLQcz4N00o0DQoS9G5bjqAXvKzI1
         SSMXJDpQStNpwLXOvqUztaeQ6nBcujGJxSAHqghXmkRj2HuVvuyQPWkklIsKwoD0KaL9
         EdXFEtZ2c0lAfsSkUfG7dknyedTtMS2MYhhq9szR6I/OcB6zmqjuk3Fd0rMrRBhEQyps
         i9og==
X-Gm-Message-State: AOAM530rxkDfbDtxfefgScQ2BbhfLQn+9kwQ8uWOEQbr/SgFlzH9LmG4
	qgqp1OgkZE+N9R/AYuO8I58J/zUGL4O7nYhe61g=
X-Google-Smtp-Source: ABdhPJzd/LzWT7zvLelqsL2wMXOof2mN5a0pWYaTpMZr5zppArjKr+g0YbqDGpJN68RDMOs+10oeEA==
X-Received: by 2002:a17:906:fb11:: with SMTP id lz17mr24610281ejb.336.1628062645519;
        Wed, 04 Aug 2021 00:37:25 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id i6sm405098ejd.57.2021.08.04.00.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 00:37:25 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Jenkins Tessares <kernel-dev@tessares.net>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: remote addresses fullmesh"
Date: Wed,  4 Aug 2021 09:37:10 +0200
Message-Id: <20210804073710.681267-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes 'unused-but-set-variable' warning.

Jenkins Tessares reported [1] this error:

  net/mptcp/pm_netlink.c: In function 'fill_remote_addresses_vec':
  net/mptcp/pm_netlink.c:435:23: error: variable 'pernet' set but not  used [-Werror=unused-but-set-variable]
    435 |  struct pm_nl_pernet *pernet;
        |                       ^~~~~~
  cc1: all warnings being treated as errors

Indeed, this variable is defined and set but not used. We can remove it.

[1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1096568275

Reported-by: Jenkins Tessares <kernel-dev@tessares.net>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "mptcp: remote addresses fullmesh"

 net/mptcp/pm_netlink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cbef50fff6e8..29ff454411b1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -432,11 +432,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info remote = { 0 };
-	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
 
-	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
 	/* Non-fullmesh endpoint, fill in the single entry
-- 
2.31.1


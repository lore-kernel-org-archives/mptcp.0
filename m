Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917BD134B0
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:40:51 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-30789a4c537so4171572f8f.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773649; x=1687365649;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3X5p+riPcRgv57UJrrT0haiPEY9cn0DwuNVFYYrl4w=;
        b=zCLDbDcrIF5yLkb0HFH1gsPd2qSq37lLYHFuncfflzzQ1CHj5P1cGN8qWrGFMQCWzj
         eTVCpZg7+vFPid9K7ayN2TwvnbZb1wT6m/McjYT9/YXpKTFoe4ULBYGI+eQtx2z371Bz
         Nto4wWcSCd9+yy06AR46TtDDAglpnKInW6pCTQ8DyBTuCE93ThhuJWhKKQK8dcXA8Y9h
         PiyaMCmM5WROMMntFwbQwcBP2j90TKEu86Djbw/IdoMC2TXPkkz+ozuoZoEJ1LdUZx+E
         9/iFhJkFQBhjqZkOmbBFTDAhtobZlvGJ6DNj8XDG3XcmJzhfS5SACMEjGAKEtO35p8p8
         gg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773649; x=1687365649;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3X5p+riPcRgv57UJrrT0haiPEY9cn0DwuNVFYYrl4w=;
        b=bn65XuBQxu9Ir2bQqzmVFPxs77T5Y20u7b06ROgxLsevAPPitwgnX89PfEEs6B5ke5
         89ouKuRiiCW58Fc9lOZE6bYjZTWyky9YeftRAd5HH6hg99vUslIjpgeCEvJYxwsBnmZQ
         NXNKiUGf94bWybLZXO4W9p+JYCl001UZAshAvIxt7bAyQvt5dIcFz38VCfDb5DthYQ9z
         5VW9x5u+R2ybNdulXKYiU5jW+WCF4WeTuuAKOE+LluKhFuVqvCAlhz6pMZYtPIwi8R5A
         BxrwD09Ot9GflpzuZ2J2YobqawedS8HruWlY9IASJ6+ITmxSOM+zigzicv/PUuJEXQGY
         4Sig==
X-Gm-Message-State: AC+VfDxY6AlxqDZ6ym9znG9AKms1PtYX8agaTuQ6TPR2pysG3aWFf7il
	3PY2riAh09MfXBHci6fFOLYhCV2ytlkWV1Vz885O6Q==
X-Google-Smtp-Source: ACHHUZ5OBf+TDkVY0P4hbNQypykif6ueUtwpO7x6YV5tueqdk/TXjfA21pXDZgBQvWxv0HefvsONbA==
X-Received: by 2002:a5d:5152:0:b0:309:59c6:2909 with SMTP id u18-20020a5d5152000000b0030959c62909mr6726461wrt.18.1684773649378;
        Mon, 22 May 2023 09:40:49 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6411000000b003062b6a522bsm8156281wru.96.2023.05.22.09.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:40:49 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:40:40 +0200
Subject: [PATCH mptcp-next] net: skip printing "link become ready" v6 msg
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230522-mptcp-skip_print_link_becomes_ready-v1-1-9d5f28f19440@tessares.net>
X-B4-Tracking: v=1; b=H4sIAAeba2QC/yWOUQrCMBAFr1L222AaKaJXEQmbZGuX2jRko1RK7
 26qn8M8hreCUGYSuDYrZHqz8BwrtIcG/IDxQYpDZTDanHRnjJpS8UnJyMmmzLHYJ8fROvLzRGI
 zYfgo7Dvtzy1eAiLUkkMh5TJGP+ytcnwlKXU67TJl6nn5XbjBvx5pKXDfti+TiiWgngAAAA==
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=X4TIglBqJI48/v/4h5i3yImTkteynfGXgIc7iyUjNX8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5sQdGWzsp1deyaEWV8BssaEzd4/yQgyzdVmk
 FOwIJqF1heJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGubEAAKCRD2t4JPQmmg
 c7bfEACXXPy9UOy5CGEksECKN12HCnFw34gexAQXl1t80hcJMuKgwSPl6BuUhd9joHBEsLAfLC+
 6n3VgAH+GcgfO0jaR5Yl2eBszczUzM0xfVBPtlLU6Z0iTDAtEKOlOZnniT3JMgNtUrm3ZCJ6AIM
 bRhVrxd6GlY8sVInoMXlU/RuZTSi+BCZN7e5ntNvJO353u3ujgCtKtsZxVt7hxb8crdyfMa57GE
 olyI3lQlWiIxQeloVDCW2fk/lDkaJS0oDknj7/xHcZWpxmRbWx7TzcrDWdeYwy3EtU/gnyS1iRI
 h+BpNXkpDkH+rN3YYrKuLDoOBt/e/QWWjS6AlB0Fgac4EeshLjeyf8+SK1rkfXLiKHov5aq1mkU
 Ej18LFyXmJ0ZRRl8NT6K6Y6MGPf0uNj2j7uelfIASxz2EPZbE1MDfyOlFeYvg+nitqhUMJUvO6Y
 z8JcslkRSW+QiCDhXTVSjVeGZ2qHrwbB0h/MZsmVdNqHrG7No4q0kbMHexzmhYEVjyG3fFh5kQt
 /zLLGKd/CIMMolgqbrjNThU0X6Kr8yCegsE3JrQrPVaJaIhPaQJcBG8YYMk4pTCm2LvAsYkCQoW
 2E6Y9TEM4QDyHQRoqrrk7ZJ0k2H+KAh9S/686ilETd5yhxj9UI0/DMM79d29QZpTICpe1fkRZ0F
 xUHd8+4HZtcehDw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This following message is printed in the console each time a network
device configured with an IPv6 addresses is ready to be used:

  ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready

When netns are being extensively used, e.g. by re-creating netns with
veth to discuss with each other for testing purposes like mptcp_join.sh
selftest is doing, it generates a lot of messages: more than 700 with
the latest version.

This message can be useful in many situations but in some, it floods the
logs without providing any useful input. The proposition here is to have
a new sysctl knob to easily skip this specific message.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/net/netns/ipv6.h                        | 1 +
 net/ipv6/addrconf.c                             | 5 +++--
 net/ipv6/sysctl_net_ipv6.c                      | 9 +++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 3cceb3e9320b..721abf86052f 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -56,6 +56,7 @@ struct netns_sysctl_ipv6 {
 	bool skip_notify_on_dev_down;
 	u8 fib_notify_on_flag_change;
 	u8 icmpv6_error_anycast_as_unicast;
+	bool skip_print_link_becomes_ready;
 };
 
 struct netns_ipv6 {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3797917237d0..9cf7b4932309 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3633,8 +3633,9 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 				idev->if_flags |= IF_READY;
 			}
 
-			pr_info("ADDRCONF(NETDEV_CHANGE): %s: link becomes ready\n",
-				dev->name);
+			if (!net->ipv6.sysctl.skip_print_link_becomes_ready)
+				pr_info("ADDRCONF(NETDEV_CHANGE): %s: link becomes ready\n",
+					dev->name);
 
 			run_pending = 1;
 		}
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 94a0a294c6a1..c9e82377a8fa 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -213,6 +213,15 @@ static struct ctl_table ipv6_table_template[] = {
 		.proc_handler	= proc_doulongvec_minmax,
 		.extra2		= &ioam6_id_wide_max,
 	},
+	{
+		.procname	= "skip_print_link_becomes_ready",
+		.data		= &init_net.ipv6.sysctl.skip_print_link_becomes_ready,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 	{ }
 };
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0044d87556dd..27179e9175be 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -84,6 +84,7 @@ init_partial()
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
+		ip netns exec $netns sysctl -q net.ipv6.skip_print_link_becomes_ready=1 2>/dev/null || true
 		if [ $checksum -eq 1 ]; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi

---
base-commit: 194dd0efe579cb5d3a746d248b3476f4b3fc0b48
change-id: 20230522-mptcp-skip_print_link_becomes_ready-af50c71a9daa

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>


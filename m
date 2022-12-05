Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499623CC
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 10:10:25 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id n21so26469902ejb.9
        for <mptcp@lists.linux.dev>; Mon, 05 Dec 2022 02:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2DCETTsYM3RX/uCMDMUvB1wJSge8w+AgZjwLW+QPI3E=;
        b=33rDnqulioNQoCIV6ywkmNHsDMUACU8Ha5ey2IXzfUWxVoqinke/0q/ghiWGIMay0x
         DR9uT9VXEk2RFMtTu+eBbjE8fZpvODz9Fe54f0TcDMYSKbs695XJcNi3KrEzmt/9TBsL
         2R+g+RFlw+DQaUZbO5+NTqLRJfhasKXkE/A9NyO2VklYqoPpkSpsmn74oYljhov/ocwD
         9AH9VhJf79iRWXkuKXkE3+SCuUtEseKUMWiKVniiGkU+5RTNRFrTcxwGZ+kgpbm8iGVT
         en5bbEnrop7C8SKj7TMcajxPBrWbo9cnj0JiyV8jWNyYRjlkICQUYMZdeyVWGnmEU2EO
         N+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DCETTsYM3RX/uCMDMUvB1wJSge8w+AgZjwLW+QPI3E=;
        b=ARkpOG0Dc8Qpwmwm/QIRKTuO3rKXUBFvBZMn8kDmHCplEUSwVBzD//LgoIWmw0yx/t
         kMXqOT+Asan5I8G8oazpdxrrBg62xcTg4A5+wzZH18YciFMXkulffkbXA7UbtRxrBSLd
         WpnfHXKVTCxmlOZV55TRM5vAXhM/HaxcpX7g/x5vXueZkjMkbrCQeWW9kavTG1IKoMar
         bHG+7euuQ4irH1IOm3tkfoEaqINxKLjIDgF2xMLX/GLa33wV0JD12OW9NGSTO+bu7z5/
         MWkqvMI15t6fvCm01mZrS3Lusshw5W+pwA52USIfE2xIujejVOqKBJJ2MZUXhbEDbnWb
         S+oQ==
X-Gm-Message-State: ANoB5pl1Vi5EnjQcih+iiBdWs78f4IWiTUQTiYHxZw/ErQvsYAhnwQk4
	LUjGZQa/pZyj/9U26OOfCvpxqMm4rFYmN/QlGIM=
X-Google-Smtp-Source: AA0mqf6if+0eVgLjiEbFi6x94HY/Bk0h84921ViWJhYgHhPOOk9L5K2W7cPFHJeK/qjdNVcoIdrpzw==
X-Received: by 2002:a17:906:fc3:b0:7c0:a880:dc71 with SMTP id c3-20020a1709060fc300b007c0a880dc71mr17863177ejk.705.1670235022396;
        Mon, 05 Dec 2022 02:10:22 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007b43ef7c0basm6035609ejc.134.2022.12.05.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 02:10:21 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next] mptcp: return 0 instead of 'err' var
Date: Mon,  5 Dec 2022 11:10:02 +0100
Message-Id: <20221205101002.2620762-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=DM5EzgQduzArom/zE/LOpW+4wnKbZXT3zfVgJhPK3PA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjjcNrEDZJxx3TgPWUkLcvJyki4nTj7abDTVdJvyjH
 agljFI+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY43DawAKCRD2t4JPQmmgc1IvEA
 Cmn8VDtVItizq07HFMMaHCFrKzzIAHk67ZjrE7lcdviXNBJTaF0TrUA3g6GfVq/LgJ1maMF9YIIp/c
 L7ApqGbcRv4zyhAgKaLXHkCywjuHXRGCll5HJk9DEA52566RaznvDIVGFvxCMf1/5mNQMBh9hapnHz
 4ZGE3O2lu4ITmaNRoKh9nr6R5ITPTpWI3FxMmntsyW6eeKAhpLoBWD0xyvF6at5UsycNgRIEwwVTOB
 vodkJ+TDPtWqJMMom+sMEcPFDUkqAzAJ42J00JRWOaIf3QjmxhapGrI8TANbqrZ0MYNLYiHckNt1QO
 cFHEvaYh6OkrRKCxmuvORMHTBpeZI/YJ0/1QqsL8cUFeTkKr4IFqb6ya2NpWKyFgVS90lx0Hu2yYRH
 Drp+XOu7S6udD7wEmSSpXNRYyVlxMFt4K5Q7zsnXZECU32D7Kfk825NEFGH2c5PWd7tb2E3fYUoavs
 nyw0Oenma4waBOYXDrPWN+O3+sN9+nAphVh6CclfCSxq//DpZirEw1L2MNrKSYsoh84ZeW6AZ0IyBa
 9qmiYaekKRUpNF8rmTRaq4hBEqV72iEv5BzKGS6hwVVgNLVWDh0K7FN+CW+8H34RjaDQwEPzsjj4VQ
 9NJ52BBb4+1wPIqraQNzGuDfBu2iBUgTb7VkmS3GMfoecztXgtbxNaKtVZOA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

When 'err' is 0, it looks clearer to return '0' instead of the variable
called 'err'.

The behaviour is then not modified, just a clearer code.

By doing this, we can also avoid false positive smatch warnings like
this one:

  net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn: missing error code? 'err'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/sockopt.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 39b0f054f39f..d20f1d969900 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1187,7 +1187,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 
 	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
 		if (!require_family)
-			return err;
+			return 0;
 
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "missing family");
@@ -1221,7 +1221,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		addr->port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
 
-	return err;
+	return 0;
 }
 
 int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a47423ebb33a..d4b1e6ec1b36 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -740,7 +740,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	}
 	release_sock(sk);
 
-	return err;
+	return 0;
 }
 
 static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,

base-commit: 9324c815f96dd77d23679e999edb875d9f4acd34
-- 
2.37.2


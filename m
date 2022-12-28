Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65210FE
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:09 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id u19so37367515ejm.8
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmkiOWACWTt0hLZDqv1AI1TNAWCah4XFf8P7MvVQ+Fc=;
        b=yLYATEIr2wRsUMXziTg/1z9yMMC4t3ynLX/ekuvOFLNZp4Ulp0TGRFVTDnOruHmZzS
         VpCPKY10m5O94Fv5kqBJ5LAcFprzQpchmsF8JZoNjsqKIkfuT+tB03/gwae+s8taPIuY
         9nrPG4N9NQIrPYP4dpU08QGKYkJVoa1UVb/aPDzLsAseRU/M1tyuefxJ9JbQm6C5McQP
         MTJGmONL7pVa+ul6jEIAxjDD+Guzl0sVnwdJpGKfNzeXFJ4rzeMiFXknrgMGvghjsOys
         ENN3cfGNfUDaeaZnYc8stX7zBCQAfb9MCNDGbCd8wOxTSgByLKmIYiOhGIWWDIPeIPsF
         Ob1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmkiOWACWTt0hLZDqv1AI1TNAWCah4XFf8P7MvVQ+Fc=;
        b=IB6DPooPG/yddzqkd3Q4nug3ipAAm7ICIZwvDA8Jt+6IQ0bz3QnkrJ3xlsMUfNHcWx
         ZS3ublomL3HCMrnAbPPu9wSCgT7dHCHTRF6zNQd2MWA0qbxDcIYhTnJx8o/u+DhITKBs
         ZGfzq56flcqv/i4Rk985SGbQG9yPOui23KeW0MZN1/MJlqK/ec847Uk3s2Ji0k041FdY
         MK7R/9rgQdyslV8k4UwPEIL+/HpKbbEJjTQk/mzWBwdeN1Tl9oHx8k2aTIxSKSeMcSRm
         N+gshaLpJ04M4p/CmOQcS6JM6t8CXSeJhWpWqmGog+nZFlhvhg2UWO/uqfmqOKuxKn6T
         ee5w==
X-Gm-Message-State: AFqh2kperr2663OyE1OZMNTCNx0knElyCCMU2hlH7hlFihl/h6OVABvT
	/fDkbu5IaVgJwlNsL3fnRnLpFGs6O2ZU5Ht5HtW0Xg==
X-Google-Smtp-Source: AMrXdXtNbOg16qbDevJcj51fHqiMpXWCMV3s5IAqdH2qEi/ekg8AuokXVHV+UuCrnMRP9OtwYCnHFw==
X-Received: by 2002:a17:907:d08d:b0:7aa:76a:fb3 with SMTP id vc13-20020a170907d08d00b007aa076a0fb3mr23393350ejc.66.1672222688026;
        Wed, 28 Dec 2022 02:18:08 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:07 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v4 02/12] mptcp: netlink: respect v4/v6-only sockets
Date: Wed, 28 Dec 2022 11:17:38 +0100
Message-Id: <20221228101748.2518303-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=5vHj++yOudegJpdjUjRNe8ThnfAp9dTH9plU+MPMpWM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe+67GABS4DEB4IbEEHE7Fz+I5PCP29ZUvcwrFW
 aZHmcsyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvgAKCRD2t4JPQmmgc5LnEA
 Db6/Ja2dFSI6X5Wih9CWKh1eyTACEYLt+kw/3T0J2RciHGSivGw2z5XuySU6XRPnzTE0tOMt55FxNg
 FhxgMfB08iHaknsZVqyPFBtRHMCQeT2jFty8c56KwOpr41KAGJgrkRFSqI9sct9DLv7d6VkR91b1pj
 +SYNpP/yNjfCB2zAvsWuy50oD6PNFsRblRRZaaYF0bCtCENUYF6ydkDRSSL0ifQlnlVSFxoBZeAWvm
 WPtE3gliBu9Eh5sDXn/GT5mcM5lkmwAJcsLwH6RCHsd6G4NCxKfb6D9dvuEWxE2Pl1sSwr97A6/pGC
 KfMgiaYdkvlglUx7VugJCtBe+DYjnyiYm8pwLTll1JvJNBaW7DTanrvbH8R45Cfs5DX7PfriHIx4YF
 uvfeggtKdq82BW35uQP7ojit16dYKL1CZJkDkWn20TTJkRCjSQg0Pb0oB28ip2cFWr3JYcLIeivLZv
 iPANOLDPV6YxjB6t5TcQ8XPnU6eZhz6BYjmKUKhDvjisHdG1QXImAJLVIOIFogk7Y53C1JWN646zs9
 H80hatqYlIPcQ4ysNlGYKVkfA5lvIZE/6lpMfw0Bykk0mWY5lj12+E+3o9Y4C429CEXpmNCwX/vRW2
 7Px2qeptvVqCF5eME6hTkhXRf7sgbyAJNW2grZCbNt/1hiwp8R97yZ8gc0gQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

If an MPTCP socket has been created with AF_INET6 and the IPV6_V6ONLY
option has been set, the userspace PM would allow creating subflows
using IPv4 addresses, e.g. mapped in v6.

The userspace PM will also accept creating subflows with local and
remote addresses having different families resulting in the creation
of non expected subflows.

It is then required to check the given families can be accepted. This is
done by using a new helper for addresses family matching, taking care of
IPv4 vs IPv4-mapped-IPv6 addresses. This helper will be re-used later by
the in-kernel path-manager to use mixed IPv4 and IPv6 addresses.

While at it, a clear error message is now reported if there are some
conflicts with the families that have been passed by the userspace.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm.c           | 25 +++++++++++++++++++++++++
 net/mptcp/pm_userspace.c |  7 +++++++
 net/mptcp/protocol.h     |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cdeb7280ac76..083f3f8322c0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -413,6 +413,31 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
+/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
+ * otherwise allow any matching local/remote pair
+ */
+bool mptcp_pm_addr_families_match(const struct sock *sk,
+				  const struct mptcp_addr_info *loc,
+				  const struct mptcp_addr_info *rem)
+{
+	bool mptcp_is_v4 = sk->sk_family == AF_INET;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
+	bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
+
+	if (mptcp_is_v4)
+		return loc_is_v4 && rem_is_v4;
+
+	if (ipv6_only_sock(sk))
+		return !loc_is_v4 && !rem_is_v4;
+
+	return loc_is_v4 == rem_is_v4;
+#else
+	return mptcp_is_v4 && loc->family == AF_INET && rem->family && AF_INET;
+#endif
+}
+
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 65dcc55a8ad8..ea6ad9da7493 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -294,6 +294,13 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	sk = (struct sock *)msk;
+
+	if (!mptcp_pm_addr_families_match(sk, &addr_l, &addr_r)) {
+		GENL_SET_ERR_MSG(info, "families mismatch");
+		err = -EINVAL;
+		goto create_err;
+	}
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b2b56a80e817..871ec3e93314 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -793,6 +793,9 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 			 bool require_family,
 			 struct mptcp_pm_addr_entry *entry);
+bool mptcp_pm_addr_families_match(const struct sock *sk,
+				  const struct mptcp_addr_info *loc,
+				  const struct mptcp_addr_info *rem);
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
-- 
2.37.2


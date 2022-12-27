Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0AF63B8
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:38 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id bj12so33525715ejb.13
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmkiOWACWTt0hLZDqv1AI1TNAWCah4XFf8P7MvVQ+Fc=;
        b=dlwD295Vm3zZdM97xahqqX5VqfGzJcOBNSUMk8aGyXqX4DEU1jBHyN9lMoBvu7RAOk
         aQ1jaYOeE6JoxAntLGIVJWQxeBRdUZSKhzd5KPTrqi/cSifGmdyGRmwI8DVVys0M8XgO
         Ktmw4B0e45TAPNFvR07vM5JjP0cCGo1rVAhVpvUh8RVa7olxZTz6StqITaWlmHLMvyoL
         9Fx4fninKuXVN/mhCsF4+vqdfEgqpJ6onbkSHB77ehK2gXnO3tfS1U9AtFoh9/qhmG9H
         D9jiVdoizNNKvyh5m2Rtn1R/po6ZQyWkDp7DNimjy4JOcIXZHAEJlTxxVFjWtnToe2km
         M67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmkiOWACWTt0hLZDqv1AI1TNAWCah4XFf8P7MvVQ+Fc=;
        b=aETn8S2vb4uZ8qwMtty6SAyCv7wOjqQObABuchG7fe+OsvI/raNRqRBe/nfPGLK8BU
         XchCMd811HXPhMcsv8DUItqg6DSABL10VE939i6wZ7eUFPoPw6UQfLgevQ3B0zo6P3oc
         erw7LCT0dYF6uiSNA15vgODPDgJ8kGO3rMuUed22GIruwry9xYm1tXSZkItA7HGnWf71
         njOHN8aEWwsvaFQI9vWTkExXnrMFb3B8H+wFDtE7sPnfVp9tJju4qCdjRb3kAu0N1Lpu
         ygJyclQowbL/aQgnvRTp4qr1CmqlCuEGav9X/HCXAi7wrwTAoh++CW9NqID7Ojp7644a
         00HA==
X-Gm-Message-State: AFqh2kpe0jgDwiiPJ5r4pjHPfNmr8f0QRYT6gw89ym+b8wOC6S/XfGvQ
	eO2PcOydICDHJNRxw4lL8Cf3PwDr4ou0M0Wqrst7wA==
X-Google-Smtp-Source: AMrXdXtk1JqZ2Hi4UErZ9sivJaJanvgetLemNei0KliqQMbYLu3pN2kSRH/LXBIsQDAVdsB6KujXDA==
X-Received: by 2002:a17:906:7714:b0:829:6064:bc52 with SMTP id q20-20020a170906771400b008296064bc52mr17342013ejm.74.1672165296766;
        Tue, 27 Dec 2022 10:21:36 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:36 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v3 02/11] mptcp: netlink: respect v4/v6-only sockets
Date: Tue, 27 Dec 2022 19:20:48 +0100
Message-Id: <20221227182057.2288816-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=5vHj++yOudegJpdjUjRNe8ThnfAp9dTH9plU+MPMpWM=;
 b=owEBbAKT/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd567GABS4DEB4IbEEHE7Fz+I5PCP29ZUvcwrFW
 aZHmcsyJAjIEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3eQAKCRD2t4JPQmmgcxTAD/
 igSDNVT4hQiDAyQZO+RPe8hpQx0axIFMamE6kFUFdY41zCqmHqMc4kP7rXuoWqXI6PbKCh4z4bzG2M
 DlA952GWiVcF4hWH/97+EuAScrjYofC+y8fIyPsnR5GohyXaVEAB89Jajtgx0iluaygNhJO9W8W1uz
 CDqxWJs24h9OJcSnleG+LM63Jk9corqzkYXD2wUZhembDgvn8ms6qzkfZ4BlbBvIstUof1Sc0zEDQz
 JJianOe/Kf/1mnk3zXWONW3QZC2ytHCQjxApaXpTTTrAZPd8uhRz4McoXPlWI8qi5EOm+WQdbO7z0D
 cUB10Wt1IGu7WM8fxj2OWwebe/01GUM8Z0CS4VpJwbo7sFA1ZkwjlNkrGyMyCKnwppK7BCJsmENGc6
 O8RA+B/J4El+zNAzpdKj/W4GYVdI3lAtjJIVdz4Wvi8lo4irq26JeUseW1lA5UmZJI1rt/jiAjkYLo
 sR2YV2WqCG0I+ejALJoHQAWWtuAS4HzKdO+Ejp45AkIP9+gY+Dx+/3phxDTtTTNC//hWQ+n5IhFf0K
 zfZt9qLBPmFY5ryeb7w8kSp+b5QCUNTdLvkNLfwX1KNSIUVK2qNPZVXba03vyvwhqmeQ8/mH3grz06
 XKG+3+iIoRahjkDZNxzmqrqYJkOvPZ9sBp7wFXS2yuk3JhMa2JfKjYq2CT
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


Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63930AD53
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:15:57 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id s5so49480463edc.12
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyBM6679GFfybRCkLJqvCSQQKrdRQeFiewhOr1JMMoc=;
        b=kA4EROhCyPoWb1qTjjiTq9OiOUWEx2rAvAH4DO79QErlyNyc2346OZARFcM875HqgN
         vVmogCRl6NgYIiZJ/WFaKvM5rrXr+q0qGlLwVS67+OvLBUkkGFSh0+maiJ+jRUzHzzLR
         C8HTGBh1YSRkRE53lzSqVlHSn8g2u+sPUYDY5jqHrg7MKoU2EslBg2MC9/8CDsNf9Krp
         kpJm5+veG7X3AkN+6G+STxALcwn3NfJ5e07TqDjn6tG/DMZtf9TH3/Gzc3Ar0lfmf9Wd
         Wsne/GGbPDOoy90rpD04AIZs21VhR3ty+1Oe5BtE0W4l4J0zqYhZ7OFGhTS3ZaMdkzMJ
         MH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyBM6679GFfybRCkLJqvCSQQKrdRQeFiewhOr1JMMoc=;
        b=Y70GhQ3gDin+ApLws9uk0WC3Gvi7AzhYRz+VCpRp5Ja+aDdfkdoMhI8c90NtGcRAsx
         1zjTO9QPbcjkNsg/S+R9BjFFJWLwONQMgZ0/S8tvgP3frWoHscHWhieyZNRcMUFRpjNp
         dHf4xu8PoIlXn+H9Ku/vrQiq3tw158lTo3fvL27BK9oqluMJIINi8/rbYJFQllzVpuU2
         Es8T4dc1B3bLwozfkQZTnW1glFrwDo7j14Si4kLQ8ksxj36Q+iasBbhBZ/pIreth5PmS
         mUlaHbCuMoW0ZleHitGAKJT/KivfFvClgGiDyNSXEj6NOVmn56fAgPR59gHgviviuqYX
         nGLQ==
X-Gm-Message-State: AFqh2kqgiNsI3E3wMwxlfPjboQxc0vIyS3WLa46sQryexj955eJg7sD1
	JWulBJyfhYqtGM3/2gWyJNuFvvWsUK5f+6032JA=
X-Google-Smtp-Source: AMrXdXsVw/xsVUyFqXbLqNbk282hYRC/ESZIntsaUBNuP7VwhLETzb9jhTLcKlQEtw1YlCdmkdiPKQ==
X-Received: by 2002:aa7:d04d:0:b0:47d:b4e6:a631 with SMTP id n13-20020aa7d04d000000b0047db4e6a631mr41930286edo.7.1672852555474;
        Wed, 04 Jan 2023 09:15:55 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:55 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v5 02/12] mptcp: netlink: respect v4/v6-only sockets
Date: Wed,  4 Jan 2023 18:15:16 +0100
Message-Id: <20230104171526.1416746-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4219; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=qsWwAJBOfxLF5wyiKb7fnddtqML/5Rha0v2lKGRP2Ks=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQHstWObAbcukzQPUMqzT5yokcNmb3hB9AnTAPp
 jbJn14KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0BwAKCRD2t4JPQmmgc7vTEA
 CHwpfwu4F2+lhzcTFdKHxJaIzt6Tt9sSQfAou6AQ+jyDCciAyYfnrU0ehxwRqbjjhqOa/KsE/DF6Mr
 FO0O+pX3sa7cUb5vnTdCK7mKuMf6MXd2CLYaK6MOE9th/D9jxDh0LkXBAA16GpQJYITSDhC7yBjFbB
 vnO4VFTk4/PjPc9mFL4G0JNLlQO1J1tdXIs/WPa+ZFxMPe7d+MhpdT8ngpP1+zzxFEC7LrZShu98C5
 obJ3UnEOG63w4PpGuFa0BukQWdB9gvpvKP9IHm4Wv7pdFOlsSrbUvlP9QPN6AWdEW5sJc9MTS8jmVe
 mvwyGv9/5y0XVFIMyXo1aZZrlPCC6rwmV9SUnGT940DApHG1L1kdGTBVgmkQVThxn27x2Ocvb/LXta
 uuUIV2Sw4b8adbArfjfJ10kTPRPIcaxJa4B7xfg47wy0rW14IZSlFq3I8TYuGATZNL7/z7+3MK2tz1
 KnrJ+0QX0aJeU+q5O9v9QI4uLU7uI5FlJRw/OziksJbvZwMIH7qj3QL4GtnW2FJNjBGIPwL8z8ApTM
 hviGjCmsMDMVfnr7jEQ3gOCmcVUM0sGCdDsTtGQQsu7R3ZEp+nlVApoMks3wrTamMKb3HruUxiFTE0
 4aVwQoyiu3hyY8AH62YkBHzgowPlvwRFtsNHHr8ZT3bcjBXrMAEZYlddd1tA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

If an MPTCP socket has been created with AF_INET6 and the IPV6_V6ONLY
option has been set, the userspace PM would allow creating subflows
using IPv4 addresses, e.g. mapped in v6.

The kernel side of userspace PM will also accept creating subflows with
local and remote addresses having different families. Depending on the
subflow socket's family, different behaviours are expected:
 - If AF_INET is forced with a v6 address, the kernel will take the last
   byte of the IP and try to connect to that: a new subflow is created
   but to a non expected address.
 - If AF_INET6 is forced with a v4 address, the kernel will try to
   connect to a v4 address (v4-mapped-v6). A -EBADF error from the
   connect() part is then expected.

It is then required to check the given families can be accepted. This is
done by using a new helper for addresses family matching, taking care of
IPv4 vs IPv4-mapped-IPv6 addresses. This helper will be re-used later by
the in-kernel path-manager to use mixed IPv4 and IPv6 addresses.

While at it, a clear error message is now reported if there are some
conflicts with the families that have been passed by the userspace.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v4 -> v5:
      - fix typo (s/&&/==/) in mptcp_pm_addr_families_match() without IPv6
        support (Mat)
      - more details about the unexpected behaviour in the commit msg (Mat)

 net/mptcp/pm.c           | 25 +++++++++++++++++++++++++
 net/mptcp/pm_userspace.c |  7 +++++++
 net/mptcp/protocol.h     |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cdeb7280ac76..8e0cf6275e94 100644
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
+	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
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


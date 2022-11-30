Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9363AF
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 14:07:05 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id o13so3117165ejm.1
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 06:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jypnv7wptQURs7eFnZrKwLAnNbefpkWc9aDC2tuITf8=;
        b=rWIZ32Mn4YU11VZPjBYcyjpGALFr0mub2FeUmrggTQ+QArd5PjZ2OQOHNox+jJYez1
         JwvJUHP4KnlgMNgld2+iUuVk2e1sGApkV2Y33JkOzyLY30lRyVCOupISgOiPqgS6MwOy
         FHP4DOTMxrx3BsTLsFnXL9NEtEkePZh+bfOlGqMtRm+BRg1QswDK1HyaB2DPdNWpAsE6
         mjQxMLmkVDsVWSWCG/GkCPozjvZ+yUD1/DWROmDrWJoWmeeAIxFkXhM6UX1faGUk8aCc
         8bqIJlZyMN7ame9ZjpyS7loSQmxTVLUvUmELdT7Pd3kC78AErumMGTm7GwlyWu34Nr4X
         DMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jypnv7wptQURs7eFnZrKwLAnNbefpkWc9aDC2tuITf8=;
        b=1z0ZBrR+LQvTUS2RvGWYP9kdtn+B09GQZ79uqY7p9gxsZZlD4W2OLhSVv/We/yUsbJ
         e6lBZut6qQM3m/b/5VN9HdAIePG2kYCdc3n3EOs+Wi2CdgADhQ1lEBjv5rYHHfGWr9fg
         hc3EbLtsSFU2x21sfiN18XRJWcF/OqoTEbeYhRXEVY+Psfz9nfU+cHS09mqmjQJDrf45
         tWNfDsCufZSvct72zpLgMamjWNeBk+pFB0UWEycFKxoohVuCe4wG0HDp/FwWh0ihClTN
         AS4DjFU/+aHqJx0Z0UerUYQO1hHS3Fk4W4blu32SKw/yJgapORX2I59FFcEn/XAVd7Jt
         W81w==
X-Gm-Message-State: ANoB5plsr9pwwPsSYBE3zCuM5xOzjIGDZCBGp1f/fEhJUHPm/jydlmUk
	hRdXYbzbWPnQow3N7TsaJbs9+2aWaoTlhOj2zAE=
X-Google-Smtp-Source: AA0mqf7GHMCp00Y7SecKSmhD4vcmJrOgglpaXWfNNt8kKNntvyMlY67sp3ifPr/EITblAUBOA8X0ng==
X-Received: by 2002:a17:906:448d:b0:7ae:37aa:6bf with SMTP id y13-20020a170906448d00b007ae37aa06bfmr51496092ejo.481.1669817224788;
        Wed, 30 Nov 2022 06:07:04 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id mh1-20020a170906eb8100b0073d83f80b05sm692454ejb.94.2022.11.30.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:07:04 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 06/11] mptcp: add pm listener events
Date: Wed, 30 Nov 2022 15:06:28 +0100
Message-Id: <20221130140637.409926-7-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130140637.409926-1-matthieu.baerts@tessares.net>
References: <20221130140637.409926-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5398; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=LnmyaHIci1tYgRCMKF8BiZsWwBqNZm01jB01Gdm9oE4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjh2NokNuPz8n5gfzPjJehB5RFek7IJw3lhjKPHQw3
 5vs8XKCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4djaAAKCRD2t4JPQmmgc/WWEA
 CBznvHePDjzNkcpqIwrlw2lL7Bs1l/G7rWbrVWfoPJnqRpYwZRlw+0yWYOYkazXeoK5jPMMSnVMLeA
 9SWwQOE2I8VqZnQDarUiI1fxr9qBhP/t4V4Mams7hCLQlZ8UFu9ezJYEDP6ihkPShyOJJ+6EEssQUE
 fJQCHGqLDkn4Qsx/S59UY+dx8mFi6tB+nlSSdhakqnjzD1ABg5nK6wayi9A8zDUOul5fdlUNPhlja0
 h8xB34UerEil6aoIaDB7iM/1iHJB5wJkS6T8k4aaCveFH4/uvWxGEzkRFbwYqWXzZRuAb+XyKIcjKo
 ps6e/EWE93ga5OvI0HvS2wWIfMEV5CYEYfyNMn2xBKohnljUzowX5pCDABKaulSNL/V7LScEBROrCt
 ntQ9cthDUVsT56DfevVXKD7+s2UYD+4/G4iysZ5u2Pjw5TO1oA1xVX+uP48VcLw+DtYCirnxtfU8WX
 YghSCkNaMELqV8SUkcmnUGiedlQKarv6IyVW0Oc5RV2XP08zWD0TIj886D3mr8XmzmCqk4lPzYpy03
 /RWNGi8D9A+NDSNT8Aa8cGWb9yWc1+vzmOmvkNdvESVxkzfWWc4fW3P2AhiPTPzsYchWOoDdtHl69f
 AT9rDZC8dEhobuE9zDmis7qjxdHI1NLMoRjoNEYFrf+wgRDKrIZIbOVVSk/A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds two new MPTCP netlink event types for PM listening
socket create and close, named MPTCP_EVENT_LISTENER_CREATED and
MPTCP_EVENT_LISTENER_CLOSED.

Add a new function mptcp_event_pm_listener() to push the new events
with family, port and addr to userspace.

Invoke mptcp_event_pm_listener() with MPTCP_EVENT_LISTENER_CREATED in
mptcp_listen() and mptcp_pm_nl_create_listen_socket(), invoke it with
MPTCP_EVENT_LISTENER_CLOSED in __mptcp_close_ssk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/uapi/linux/mptcp.h |  9 ++++++
 net/mptcp/pm_netlink.c     | 57 ++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c       |  3 ++
 net/mptcp/protocol.h       |  2 ++
 4 files changed, 71 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index dfe19bf13f4c..32af2d278cb4 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -160,6 +160,12 @@ struct mptcp_info {
  *                           daddr4 | daddr6, sport, dport, backup, if_idx
  *                           [, error]
  * The priority of a subflow has changed. 'error' should not be set.
+ *
+ * MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6
+ * A new PM listener is created.
+ *
+ * MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6
+ * A PM listener is closed.
  */
 enum mptcp_event_type {
 	MPTCP_EVENT_UNSPEC = 0,
@@ -174,6 +180,9 @@ enum mptcp_event_type {
 	MPTCP_EVENT_SUB_CLOSED = 11,
 
 	MPTCP_EVENT_SUB_PRIORITY = 13,
+
+	MPTCP_EVENT_LISTENER_CREATED = 15,
+	MPTCP_EVENT_LISTENER_CLOSED = 16,
 };
 
 enum mptcp_event_attr {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d66fbd558263..eef69d0e44ec 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1029,6 +1029,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+
 	return 0;
 }
 
@@ -2152,6 +2154,58 @@ void mptcp_event_addr_announced(const struct sock *ssk,
 	kfree_skb(skb);
 }
 
+void mptcp_event_pm_listener(const struct sock *ssk,
+			     enum mptcp_event_type event)
+{
+	const struct inet_sock *issk = inet_sk(ssk);
+	struct net *net = sock_net(ssk);
+	struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+
+	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET))
+		return;
+
+	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	nlh = genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, event);
+	if (!nlh)
+		goto nla_put_failure;
+
+	if (nla_put_u16(skb, MPTCP_ATTR_FAMILY, ssk->sk_family))
+		goto nla_put_failure;
+
+	if (nla_put_be16(skb, MPTCP_ATTR_SPORT, issk->inet_sport))
+		goto nla_put_failure;
+
+	switch (ssk->sk_family) {
+	case AF_INET:
+		if (nla_put_in_addr(skb, MPTCP_ATTR_SADDR4, issk->inet_saddr))
+			goto nla_put_failure;
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6: {
+		const struct ipv6_pinfo *np = inet6_sk(ssk);
+
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &np->saddr))
+			goto nla_put_failure;
+		break;
+	}
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		goto nla_put_failure;
+	}
+
+	genlmsg_end(skb, nlh);
+	mptcp_nl_mcast_send(net, skb, GFP_KERNEL);
+	return;
+
+nla_put_failure:
+	kfree_skb(skb);
+}
+
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp)
 {
@@ -2197,6 +2251,9 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		if (mptcp_event_sub_closed(skb, msk, ssk) < 0)
 			goto nla_put_failure;
 		break;
+	case MPTCP_EVENT_LISTENER_CREATED:
+	case MPTCP_EVENT_LISTENER_CLOSED:
+		break;
 	}
 
 	genlmsg_end(skb, nlh);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b0d387be500a..f6f93957275b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2355,6 +2355,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			tcp_set_state(ssk, TCP_CLOSE);
 			mptcp_subflow_queue_clean(ssk);
 			inet_csk_listen_stop(ssk);
+			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
 		}
 		__tcp_close(ssk, 0);
 
@@ -3647,6 +3648,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	if (!err)
 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
 
+	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
+
 unlock:
 	release_sock(sock->sk);
 	return err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8b4379a2cd85..955fb3d88eb3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -839,6 +839,8 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
 void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
+void mptcp_event_pm_listener(const struct sock *ssk,
+			     enum mptcp_event_type event);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
-- 
2.37.2


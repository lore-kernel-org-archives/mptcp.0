Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792971
	for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 10:08:04 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id s20so14752392plr.13
        for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4/gph3PV1+3NPTNuDa4fpizd1F+YOmLHx2AU6gYqTU=;
        b=u0+hd7YfFWxNtUA3m9nEZ/J3CwkqYUBFJlek9UsjwpDbg6KocAu8nRdkhLnxSLv8RA
         Pqxllga9CTpWtG7S0dtDZKKbPfYicHLFhIrbZ3sg8zV90jPMMh5X2bRgpH/r4cY/qShE
         Qwh3jNZbX4W92OkV3f0lnhioGvUkGlNqNv35+Ks2Gg0pV1Rgv+FzHVnlQ3wp/LAiY+wh
         2q7LwFMiv1Jcu2oXX1724iATpY63F45D9PYhFUv2MVftb/m8xHlxPEBPNhVgfuhc3wzr
         Lb3197fvo0d9p2WZoQA5d6LmSTxkob1GdJh4fiRHYIen9USjyN+5QKdRH22voCdGrXnY
         jBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4/gph3PV1+3NPTNuDa4fpizd1F+YOmLHx2AU6gYqTU=;
        b=kIHAnNTyVuvewqjkOD9mhI+BkqbsxuHY1VtE7pvFSHIovnEkfQJ1lD551TSm1Edn4N
         WrKbSjquWToX4kLLsTbf6tUPyDIaN/7PuWoz4L2Jvlkzu4IP/QDcz5vyHHM4wOvZ0Lxv
         UCOVQOhFeyDKIAswjwTjedw9itcKnQDoMfHlsaMKGrHAgzYVT6ku0UhdZqnLjXWCxqD7
         98cl9LwEckjIZK/lpjvUEWnVMxJc3x91kswl26z2Ok4CGaR6HOADu1bIDHcHTU5Sk7Ps
         XI3b/TCltzq9CTUBUJsfJwQKpor91zWgC7ZFzey2Y6aVZ25fFPxTS8bNXgJ4KOMhAOVa
         Obkg==
X-Gm-Message-State: AOAM531h0wtveej+xufwYI22OQrBm9CUzrM1xmIecEJ0MJ1vTG0rILBT
	mmtnqZrzC20fxVSrNGHDXdlbrBohKlI=
X-Google-Smtp-Source: ABdhPJy7TGSVCcHyFCu3ryxyJ6o28CBzXIsW6iWyuK2pqTttMVziQ/EAoJG3T41BEJRE9+zzPZVUQg==
X-Received: by 2002:a17:90a:1747:: with SMTP id 7mr25641186pjm.109.1619518083330;
        Tue, 27 Apr 2021 03:08:03 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id w18sm2245476pfq.133.2021.04.27.03.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:08:03 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 1/5] mptcp: add a new sysctl join_denied
Date: Tue, 27 Apr 2021 18:07:53 +0800
Message-Id: <b1aefbc214bea1e5cef3dcf3c1c0b5caf502734e.1619517696.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619517696.git.geliangtang@gmail.com>
References: <cover.1619517696.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new sysctl, named join_denied, to control
whether the joins can be denied.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 6af0196c4297..dbf4df3e6950 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -24,3 +24,11 @@ add_addr_timeout - INTEGER (seconds)
 	sysctl.
 
 	Default: 120
+
+join_denied - INTEGER
+	Control whether the joins can be denied.
+
+	The joins can be denied if the value is nonzero. This is a
+	per-namespace sysctl.
+
+	Default: 0
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 96ba616f59bf..4613bf42397d 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -19,6 +19,7 @@ struct mptcp_pernet {
 
 	int mptcp_enabled;
 	unsigned int add_addr_timeout;
+	int join_denied;
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 
+int mptcp_is_join_denied(struct net *net)
+{
+	return mptcp_get_pernet(net)->join_denied;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -52,6 +58,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
 	},
+	{
+		.procname = "join_denied",
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = proc_dointvec,
+	},
 	{}
 };
 
@@ -59,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->join_denied = 0;
 }
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -75,6 +88,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
 	table[0].data = &pernet->mptcp_enabled;
 	table[1].data = &pernet->add_addr_timeout;
+	table[2].data = &pernet->join_denied;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d230a75af631..a14c1ba85212 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -524,6 +524,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 
 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
+int mptcp_is_join_denied(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- 
2.30.2


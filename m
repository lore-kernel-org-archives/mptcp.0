Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1A4414
	for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 16:03:01 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id f2so11807279wrr.6
        for <mptcp@lists.linux.dev>; Tue, 12 Jul 2022 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUJdyZVT6IogiSbDeXjCH5l0X9u0if5VYTvtgAXy7vo=;
        b=PKq6EEjFYepO5cM7WR3ftMAniIxKLwt+8KuH7cFhGiR08pAAccvFNZq28g2qOsmo30
         SJrYt3qadkWJXdna+dJ6bLWs1ppBso4/1BF/Sr1NBmkdkHhvqoBeRUAENVjSqDfj6EjD
         KwlMFZ+p43ATHXss2WZZNRVSrM7T6ZvZ7eoiQXXs9tsOy3+7YT3jsud6Wj8C/I1eq0FC
         yTKWhy4ep1HHl7psKBfg4FjbkGXkniTs/67nG3vYlMbftpbaqoC0GaePYD/Jg0AZKLgR
         vV9YYc3jqXgrM0MRy3SRSgcS6xHzg4LkLphiiftPZWyVFkEgpsaPr6AetdNcINu55JQ1
         UGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUJdyZVT6IogiSbDeXjCH5l0X9u0if5VYTvtgAXy7vo=;
        b=Ej5siklFEUUiABLabEpn0wQ7oHOc3DrCrgewyk4KUkFoBQa7Ak9ORubW3CrA99xxmK
         S1/gscMdUUlC+EWVcpSiNu9jRtAbXyiqRnaEXmuuWewJUvESo1DfxvlEbiFddytrr9dO
         u0xP95GMyGQNWOYsnyLVLRkRbWyCFVGQuK6cr/EU231U8HoQvK0216hSMUtPzt2hQ0Hd
         lM2EpDl+1LYlzGv0nhZpmYJwel05IQGgU1i62noW1Y7qi0BSavsESP+l82oagwqPzANU
         yNRGTlqxqHFD0U0B8meCbkej2qYQz3ZhxLzxJlDZUlOLEnTydFd2NdwVoazTSrmCq+WG
         kCfQ==
X-Gm-Message-State: AJIora9RbS3eKzQm8rFhA70v+sb3J1djCZ+nqJtNoZLKrAYWuPoVOgem
	wKBM3CWwhvNU5ZU/KiKz0ItjwYawvkLC3wX8
X-Google-Smtp-Source: AGRyM1sW++dwlN/mT1qZErzGLc3V8TzNS+1vLSct2Eqdmuh4TeBaLkGuaXQSmsV7BritTCxuATllBw==
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id m14-20020a056000008e00b0021d7e9767edmr22391288wrx.343.1657641779658;
        Tue, 12 Jul 2022 09:02:59 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id i15-20020adfefcf000000b0021d82a6095bsm8464751wrp.95.2022.07.12.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:02:59 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] mptcp: add mptcp_for_each_subflow_safe helper
Date: Tue, 12 Jul 2022 18:02:36 +0200
Message-Id: <20220712160236.3668376-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to mptcp_for_each_subflow(): this is clearer now that the _safe
version is used in multiple places.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_netlink.c | 2 +-
 net/mptcp/protocol.c   | 6 +++---
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 291b5da42fdb..62471aaedb6d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -796,7 +796,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		u8 rm_id = rm_list->ids[i];
 		bool removed = false;
 
-		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow->local_id;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c92f91cb2c8d..48fdef304309 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2338,7 +2338,7 @@ static void __mptcp_close_subflow(struct mptcp_sock *msk)
 
 	might_sleep();
 
-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (inet_sk_state_load(ssk) != TCP_CLOSE)
@@ -2381,7 +2381,7 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 	mptcp_token_destroy(msk);
 
-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 		bool slow;
 
@@ -2886,7 +2886,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b9333e7f380a..13b76f86f749 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -315,6 +315,8 @@ struct mptcp_sock {
 
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
+#define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
+	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
 
 static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 {
-- 
2.36.1


Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3B70
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 04:29:26 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso9563366pjb.4
        for <mptcp@lists.linux.dev>; Sun, 27 Jun 2021 21:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxaQ+GJRqHodaj6AytjciXjP/G8uW18Xv1J4KH2BDF0=;
        b=iL5MaumUvsHshUwcMt3jsnn0xBhy51vqEQgiKYMRWJ2OLNoKVDL/Ysr4gdsBL/bjm5
         6eKq0a39IjTInI4OJ31W6PuO7JTRM1VHWmO4HYxwGDmzB8fC1kS7wbFq2jH99QFa+/aB
         Stn+QlQO1elBHKbfNl2uF65XINUeu5rLAr4g6rSEQ7J9aGBBJEo3X3BjrHM3fqnr6ed1
         s/+dB02fQfOp65z5fS8rVJ2YqKpZR33N0Hx+og4an+dzp+zM5CiJM7Q4dY0kKUZOSytf
         K6efcQq8zasdE90pYpAcgz4ytK53oJQRhAa5Ph0wBbX3s/xnHK0Q/OsLEXgA1zbozCWv
         PjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxaQ+GJRqHodaj6AytjciXjP/G8uW18Xv1J4KH2BDF0=;
        b=kaUzljFZKmym0tNfS/5f/cdB4GcnW/aVOjRcN53IrAnWrHvdiqWFvUgPOC9+H4i+Tk
         G57v7W3Zu7aLHuIPBEr1K2nUxDvy3uoqrRNRuBsGsWbbZ/XMgauzp+4UWU/llMJQbSiw
         N5aY6l8YDGQUy6JTdb8NatpQdvuq7zUS0HBpSAwBz2IUGqxldI0BdDQ0hxnMB6MqfOaq
         SgfT8hgZashowBZMLzB+vqW/y0x2w2jZCJXl1lwaeZ93x8pZijzNrAh6HU9tR815mlg4
         NL1c3P4IDm7zioROp/YIdACSGXnza69/Y34/pGfDhvicWcicr64CJP0rPDVrhq8OiSO4
         oOBg==
X-Gm-Message-State: AOAM5316ll+vyTe56VmUYNJh+SnECCCIJP8IqSN93+6D24uLXiIqwUqc
	BZH6E2HsSas2pQnJx2jDX581jTIRr8WuKA==
X-Google-Smtp-Source: ABdhPJzigM09Y+q0h3AMFW0HLz8/wgBifVLAw8VWuGO7JoNabY4ouAGcTpuQWmSdHbnfH4iw4rCOmw==
X-Received: by 2002:a17:902:ff0c:b029:11d:3e9e:41ec with SMTP id f12-20020a170902ff0cb029011d3e9e41ecmr20892803plj.1.1624854565954;
        Sun, 27 Jun 2021 21:29:25 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g8sm12837391pgo.10.2021.06.27.21.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:29:25 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 7/8] mptcp: infinite mapping receiving
Date: Mon, 28 Jun 2021 12:29:03 +0800
Message-Id: <699d4e2d58c11360fd7244e4e4aee8c7f01ef189.1624854005.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <0e01e10358c89896ad265d9b57cfe4995965e445.1624854005.git.geliangtang@gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com> <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com> <fd3ac7612efa93564019e8542bf67ed38ef06627.1624854005.git.geliangtang@gmail.com> <926e95605f1d2a7cdc02b99a1701a1dddf1e6424.1624854005.git.geliangtang@gmail.com> <0e01e10358c89896ad265d9b57cfe4995965e445.1624854005.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the infinite mapping receiving logic.

Added a new struct member infinite_mapping_received in struct
mptcp_subflow_context, set it true when the infinite mapping is
received.

In subflow_check_data_avail, if this flag is set, fallback to a regular
TCP.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fff2f5021619..4ee97e9ceece 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -424,6 +424,7 @@ struct mptcp_subflow_context {
 		send_mp_prio : 1,
 		send_mp_fail : 1,
 		mp_fail_need_echo : 1,
+		infinite_mapping_received : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1;	    /* ctx can be free at ulp release time */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d46c171ef9b0..987fb6b55145 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -965,7 +965,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 
 	data_len = mpext->data_len;
 	if (data_len == 0) {
+		pr_debug("infinite mapping received, data_seq=%llu", mpext->data_seq);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
+		subflow->infinite_mapping_received = 1;
 		return MAPPING_INVALID;
 	}
 
@@ -1179,6 +1181,13 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		}
 	}
 
+	if (subflow->infinite_mapping_received) {
+		pr_fallback(msk);
+		__mptcp_do_fallback(msk);
+		subflow->infinite_mapping_received = 0;
+		return true;
+	}
+
 	if (subflow->mp_join || subflow->fully_established) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
-- 
2.31.1


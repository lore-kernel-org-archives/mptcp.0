Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9870
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 06:44:55 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so1477109pjo.3
        for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 23:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9hFy4sAejhGqa1MPiu2YiftPPOD4fOpINDQDiSuH+o=;
        b=CtpzZr0yivLZ+JWIYvSzGT2PZVW63cxRu+WwkhthvdH3s8dD8BWMvoTCxQC+Wsu6CZ
         G+KAzIyKoEs388Ek9T3xn1GrrbGHuoO6ba9KnwlvVR5eMAtTlYnFSBjdQgw+pFCaNLo9
         b+kTVKBYn3gWz+0RvTbJ+mDw/d2tmkPvOdw/oJ2RlbYWw1BV/SeQsIbJp7FLyHbA3n4b
         MRsXPkZ8LfZQwhVsBO3B/+Ve1rmm4eJLWVv4w4azMAZDPr7eCEHsBg1aywmgS3MI/WuN
         DC6EnO+gf8/PKKgC/5wVi97F9NgfV9e+RzBMvdUgGhAEItvQwy45BHBh0v5vyheImJN4
         jX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9hFy4sAejhGqa1MPiu2YiftPPOD4fOpINDQDiSuH+o=;
        b=Lsu+X2I5R0SQv/U2dvlyKbSpxHbwZC0hTJGb/+BkBHhCMkuybWtoIio4eHT3AJvppD
         hHYeM3W87sR6MFsqrtzyu78bY3yJ/bFMNH86JhBjyIU5FfkXm7oVkO4sv/elnh7JLsbJ
         w+wugaRSPYq3A3zHm5VoFMQqPUMG/ydNkjntI08RqaRmGLeYFJA31angNvOGtdnbH+8K
         0CCRK7kS21DlGyTNvSauZweGF3OYUcamZmSJgRN7ynpmCNg45t3GkHHNTr0Sdx4aAWO7
         4ve89AoMME7CfqTIQzWB/fXrSkj3E6ykECCJt7qreY2KUVGTr5jA0mWRymwGQEKKvutq
         x30w==
X-Gm-Message-State: AOAM533cOZkRiEJSHvB52GfRFl05vYUNpK0NdvZuskABWQ/VuId93jaD
	hraO+U/RpFWDKuT1HQAy1GpN+4mz3DQIVQ==
X-Google-Smtp-Source: ABdhPJwqSBQAUvVttUZoGZV61ArIDijrlqRIcp8lQV47NcYAcTpLvNNe3+iSadAcrE1h/LNTWrCXKQ==
X-Received: by 2002:a17:90a:c986:: with SMTP id w6mr2950417pjt.158.1626158694953;
        Mon, 12 Jul 2021 23:44:54 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 202sm15236606pfx.75.2021.07.12.23.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 23:44:54 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT"
Date: Tue, 13 Jul 2021 14:44:45 +0800
Message-Id: <7eaa18f3391aa9862bb8274f6288ed1888af8f72.1626158161.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the debug info for "send ack".

Don't drop mptcp_pm_should_add_signal_ipv6() and
mptcp_pm_should_add_signal_port().

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e35720317ae..2cd6caaedb08 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -543,8 +543,11 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		bool slow;
 
 		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for %s",
-			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
+		pr_debug("send ack for %s%s%s",
+			 mptcp_pm_should_add_signal_addr(msk) ? "add_addr" :
+			 (mptcp_pm_should_add_signal_echo(msk) ? "add_echo" : "rm_addr"),
+			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
+			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
 
 		slow = lock_sock_fast(ssk);
 		tcp_send_ack(ssk);
-- 
2.31.1


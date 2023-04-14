Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9929B4
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 15:47:22 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so17965167wmb.3
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681487241; x=1684079241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+DYIjU6I16ahs9ojO7PJA1gBnyWy1b9YKTrLd6I+3A=;
        b=4ID7M5d63Lb3U7c35N+eucaFO8dTtTHS8lYWblB4FRza6pUJTGJmd3nzaec0gS8Q+B
         TLzhYkH9y1XqUMh/KWndBHFwTnTNYY0kHrTkLjISs1JYMDZusFgKYwryZWS3U/2wolr2
         B8g0Q/AYAiXuJ2IzbE5B6VfGxs7JPEbatfHjsOhRC7GmFhmCeED6xiZqZWGkuOhHTW1o
         WOaGTOfDfVCIli+JSAwKVCyrQFOTl4LJ9Sy5MmBygDk9p9gBXeeMPAFUk8JAeHap0i4y
         pO2HkCwMWi90oaOEMt/R5NXWK+aJsBYB6bNhLpHszpX8yAm9jqYuUrEMuVDFqPvAQu+o
         OuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487241; x=1684079241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+DYIjU6I16ahs9ojO7PJA1gBnyWy1b9YKTrLd6I+3A=;
        b=Tb+AZByZLkDe8b9ECBCfGGl2d7A56X57eH8G2435Lgkn2RO8ZOm/7707HXY5YlFSNx
         qrRyTZXrerVEREfcXZIPyzWCPJt71gmZwT3JrXhbgHIejc3JZB70j6U03rY2iXPVougt
         w0uPSVjNWQkqBejbEQisQlcyXH6+roTsDWTQk5MFAfnNjq8SZrqOVWn0rgNgbapE081V
         zIEnujZYc/uPuLUYDGTtYDK2v0CSs3uM8qcKCppyAd1qRxz1Um/bhdGwiddw01/t5Qe+
         vM/qfWt4jIOlrQGjfCafs0E6apKThuVcsUxiEQpYzDXGF3m7WEELsxuBCYX05v3lIEsp
         HHXA==
X-Gm-Message-State: AAQBX9cc73OZKqrRtyv86Pxx2BHnGoJCXfTRdpTydQghX8mx3m/cCv7P
	H3B/nmMeIwymzwDnMTrNjpMKFQ==
X-Google-Smtp-Source: AKy350a2pFZHSYI2Cs61wOr3ZE02/f1Ft7kJ1/y0Uv4GxwlVz3xm14xyBcYCuyI/5r8nMpzingY2tg==
X-Received: by 2002:a05:600c:204c:b0:3f0:aeac:2f9c with SMTP id p12-20020a05600c204c00b003f0aeac2f9cmr3054597wmg.7.1681487240924;
        Fri, 14 Apr 2023 08:47:20 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003f149715cb6sm1034298wmj.10.2023.04.14.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:47:20 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 14 Apr 2023 17:47:06 +0200
Subject: [PATCH net-next 1/5] mptcp: make
 userspace_pm_append_new_local_addr static
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-1-5aa4a2e05cf2@tessares.net>
References: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
In-Reply-To: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1836;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=xn6nYYGzn0RBwhlUBtEUuUOZaLPe5YmFSoe6Y1JgLjw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkOXWGV0Q+whOEFb9TdMJNNgfTb7WByJGEl3RHb
 c8yjkzLtw+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDl1hgAKCRD2t4JPQmmg
 c4uHD/96LwkaJxFO1uZFMjroUmhb7BYvg14lCgz5jkWQLzcMb773Z3WawsSeohAZwLXdV6wEAPf
 2iSgOnnzRHYZ1qKWnyfjKDGsuGmBcnJ4AtNhpIabkeivgab65SjSfzKpOpJ9izwn/b9lGbYK/fN
 Z5a/81WpeBsfhH7ZPdheta7cOdi4OzZeXTanZfnynlSUz6LdW+AGp15Fkctz3m+rmjpvnUYFOAL
 DoJBkYe8NhAYl2TBZk0EW3LWiYuogrI04ZUe4Q0D/i20uvDWHBfVsHX9Un5JnGYSXviOxyf+pt2
 XmZ16tCpecFjRPTS0oAqJ7pAEuzWffB5j/7/zndy/+0A/8nBeGOcVjySoMzMdhNH09ODAXGh/Dv
 kpMWXrRb7DdeHlzC2sNPSg55L7xpMM8+2xFNfFtJiaptqrg4uOECoLBy1S3X4WClmkPtjeO6Um/
 05psx+HYtz1/9ogjcyBC2bt7Usx8nJiMGFdu3mZ8jyWxBShVA6xA0Je8HQzABwk6r9u/7uIjpMc
 OPI59cMXC5+gOm1PsnkvFgj1c7OeI8VOToskDTMUogXTiiXMMUOWPd8+MR330bNbNF0E/qh/215
 9vEX+k8CJyZqgwF0UlSrBroGnLTQZvduW2kgmogVBrtkWOP4m7ZMRhYAttho+k7EQzz9DkoaQ4M
 Wccq/XOL6KbbMaw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@suse.com>

mptcp_userspace_pm_append_new_local_addr() has always exclusively been
used in pm_userspace.c since its introduction in
commit 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs").

So make it static.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a02d3cbf2a1b..27a275805c06 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,8 +25,8 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
-int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-					     struct mptcp_pm_addr_entry *entry)
+static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+						    struct mptcp_pm_addr_entry *entry)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e1310bc113be..c8dd24feabef 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -830,8 +830,6 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-					     struct mptcp_pm_addr_entry *entry);
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);

-- 
2.39.2


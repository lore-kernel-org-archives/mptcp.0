Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9073236
	for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 10:17:26 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f0a00a5880so20203145e9.0
        for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681899445; x=1684491445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=exPiBWIdwzcDShp2L+JXabpml6A8YfkZ6eZf2n18zB8=;
        b=A2z4WMohhUD3pENnaCbQiIdZbaAFJAuB+DUfc04JKAhdKxgn/Mi83IjPlYIJKzSaFU
         RFOhOtKWZtAjSIXw1ckukcBTdZcbmM1k7zp/JEh/tn+GONVF2OUlXDJnRq/u2sDBC3GS
         6hl45w5N0u+5kKz7ZUNF4sER7tnRfd2RRxKln6CVe/Sd0kh27xAnoxhH8OdkAB6ZUvqR
         DNtkC2H/na2/CJjvK8p6GVI3xHUrHjIKrigspo8eaPfIETQ2iEDqrxmRLYrefw0b9DPo
         3JculFndCiyYe7sUILyKp0eiKx9vnLmCi7QJJzXVZ6fpPw+GehTH1RGXJSxK+j0TS2w6
         n9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681899445; x=1684491445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exPiBWIdwzcDShp2L+JXabpml6A8YfkZ6eZf2n18zB8=;
        b=YCBAE8OEY3el8BNVCLMaK6xmkT9qlkfX6S4dV8+aR6i6W6JzVBj7DZH/pDMf2YHJHy
         FnscZ1x1jl8ipkfdN0+ZbAGjqvxAsqWSmQZ3P91SZPlKedeXwqt+5QDBn7mfcSQ59QZw
         MvJSfhsnem8eDqGmttP1/WpChMOM0VUiDvsP3y0hIUaCbNhikZsaa29LM80Zp55s7a3k
         +LugB9FxyQID7tyxXAXSCzKfXlmc6jrZf02U5D5gWgsr4bWlF+5YL1gpqQyvInAJgTQ8
         bzKQ9pTpz/HWHerU38ZY0k1s7F+l8V9lmUOmVwjjGOU8WGprPmw6ooBgMv5+LWz2Ns21
         djdA==
X-Gm-Message-State: AAQBX9c4HblK9sv/1bPZDN9RMTyEvFzpVSn9c96AP0rwwn28FOpyRSMT
	+uedAfaRgbV67DvVBuKNqhhvvoZKczhjkKh0025zEEan
X-Google-Smtp-Source: AKy350Ycf59P2uShdTqaP1zRVR6X3kLY3ea/soibFKdOC1z9s/GOd7zpbE7fiq9QtmNg5J+xcBrizg==
X-Received: by 2002:a5d:49d0:0:b0:2f9:1224:2475 with SMTP id t16-20020a5d49d0000000b002f912242475mr4354157wrs.68.1681899444965;
        Wed, 19 Apr 2023 03:17:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id l26-20020a1ced1a000000b003eeb1d6a470sm1727605wmh.13.2023.04.19.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 03:17:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "security, lsm: Introduce security_mptcp_add_subflow()"
Date: Wed, 19 Apr 2023 12:17:14 +0200
Message-Id: <20230419101714.3347358-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2175; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=lhMcnQDU3leSelex6XJobqUGiATiOq4ng431dWPvNvo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkP7+mO/Qd4HPEwIvThnmK9XRIK23yWSTkft1Hl
 chv9GRzqHSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZD+/pgAKCRD2t4JPQmmg
 c9bwD/99t8BhnU3tBskZw7O/sMPlDfaMiqcigsZbYg4QAcKsPBdnQX3lg6gNhXgBqWJI0Ey3e5X
 37w2IB+gbQbFCYtVKsL7+iG5c5GE71L3ZJQVjlWht0Mspyxh4R75M2fRAEszmkU0TghwVpmxqBE
 0/fjJDKBPUh8qYLyTLu0sHeDXr3u2Zc0HBeZoSyo0Zx0g4x/1HdStO07gtb/gUcJXq/zgLvxuJ2
 5Uai42YxT/jRVXMfp7xHBa2X1xXvURkdAQi4podqbZb5aV0/isgjl69LxDCzgSwGN42w+vVU7Ua
 5lO4DmEOi60lT9vUTyRP0XaanfNvwhiQIYMz7b2Dz1WRiHIKclEHMGhrbK9TpTjrUvWrCH2lcKz
 +R0FLvmD+IENF0ZEJGIgzPL2Iw8cikHLMjm9W8HLrS5++XHVrG14hQbgZbcfErEhph2sJLq+JKk
 KUGGh0KtPcQh4lYNtaTaCjxJu/ZDu+HdwOVvKTL5FEBb9uR7ZJ2fTrxaMjwhijFOBSc08pkiP8d
 a34fvfWM0y5H1OI0O0L8Z9vAA5JXSOdmB8TdXC/eBQCuSYviduUHW4nYLJs5OayuKKMe6FKexHK
 V84m57/j9rZ/LfoTHdUdDvonNePxA5Oo5rfNiyd4BZ4a2c2wby27cbvoObXXdsqG1mADc19jazO IXefMGO9KGq9GpA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

lsm: move the MPTCP hook comments to security/security.c

This is similar to what has been done in lsm/next, e.g. with
commit 4a49f592e931 ("lsm: move the SCTP hook comments to security/security.c"),
see the link below.

By doing that, the patch can be applied without conflicts in lsm/next
branch.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/commit/?h=next&id=4a49f592e931
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "security, lsm: Introduce security_mptcp_add_subflow()"

 include/linux/lsm_hooks.h |  9 ---------
 security/security.c       | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 333b21095638..6e156d2acffc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1096,15 +1096,6 @@
  *	@skb pointer to skbuff of association packet.
  *	Return 0 if permission is granted.
  *
- * Security hooks for MPTCP
- *
- * @mptcp_add_subflow
- *	Update the labeling for the given MPTCP subflow, to match to
- *	owning MPTCP socket.
- *	@sk: the owning MPTCP socket
- *	@ssk: the new subflow
- *	Return 0 if successful, otherwise < 0 error code.
- *
  * Security hooks for Infiniband
  *
  * @ib_pkey_access:
diff --git a/security/security.c b/security/security.c
index 4e56893aada5..1e99200ed0c9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2494,6 +2494,16 @@ int security_sctp_assoc_established(struct sctp_association *asoc,
 }
 EXPORT_SYMBOL(security_sctp_assoc_established);
 
+/**
+ * security_mptcp_add_subflow() - Inherit the LSM label from the MPTCP socket
+ * @sk: the owning MPTCP socket
+ * @ssk: the new subflow
+ *
+ * Update the labeling for the given MPTCP subflow, to match the one of the
+ * owning MPTCP socket.
+ *
+ * Return: Returns 0 on success or a negative error code on failure.
+ */
 int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 {
 	return call_int_hook(mptcp_add_subflow, 0, sk, ssk);

base-commit: 0eb4d1a28182c9af28ba970a8a899a2be5407867
-- 
2.39.2


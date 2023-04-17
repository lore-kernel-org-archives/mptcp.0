Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA046FCB
	for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 13:41:50 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-2ea1257d967so1438501f8f.2
        for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681738908; x=1684330908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLbwXyGF2ICFWeOo+CTJP+u/of4w3oz07ZbCzJUp8pE=;
        b=d+xrhKATDvnm/KvcdK1K7WIlSQr686XtlCJpaPnqCgYyRbDyKrqo1kawepYf1f8/ZT
         OSoZZ6Jl7hewIjkbGnH//SSqfFp0WVIA00o7kqhLi1a+lW/B7bMBB53pNhQNylo8M8F0
         Db3UHhKyeL3G4+US6xDkAv6lpFQKcU6yTYaOiyRScUqwRM6IE67pK7KdivR/m9r2zsTj
         CQAHHl1/wHQ0BvwbAdkMNgnodak4zXa4SaEgMWKm+VrdzDfdsZtqYY31x79CFzrIxo+Q
         jPOOTEokNOkga8F/2DLj7mcN3Q1BGuqaMj4ntAOwQIVeGYH/EABLysbOqJKssIVMe3fi
         AqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738908; x=1684330908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLbwXyGF2ICFWeOo+CTJP+u/of4w3oz07ZbCzJUp8pE=;
        b=RGgHPtYTBXM1VzRarMrAwFg3INKeZek1RTaQfH7x0y09lVrOqqLuM9anNBtWabQBMp
         OU5HPpKu0iuTmjsiW+a/srB63coE1tlrkb1wlJOoncLsLbVBeZXLOx99b9orJEJIFvm/
         pFksOZFQcM/0Rrn8IRsasOC27Y+kJxWep4HJ/I5s0sZCAJD2qFG+z0LciadIYBiFFh5T
         OZv4EH7CkZmZgbWV9Q8Iu8j9FL9U2TDEoeNI8wcruB+lR0vLoDGT30GFV/k1HQFsOp9j
         dkIiTcoIetaVDSXgtGp1btCzTiFWsVgdZ6uzKyqFs5rGB4pCpH48XccGTkjSHrm7OawB
         S2XA==
X-Gm-Message-State: AAQBX9e6ACtXNCYBdNeY601VlEwfcT2oSAlVZbyiMg9Q+2LIZG276+FC
	1nSmvSSWIJ+bkeKD/8KuFkqbyQF+AMhPhSt3eQc=
X-Google-Smtp-Source: AKy350YInhi0IGM6LqE66pC8mEkoF5M56GBj9+JUXjTy7yraf6+I4+v8xHDge+xBOleABEePfPYpNg==
X-Received: by 2002:a05:6000:1367:b0:2f9:a798:602f with SMTP id q7-20020a056000136700b002f9a798602fmr3178972wrz.48.1681738908393;
        Mon, 17 Apr 2023 06:41:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id v3-20020adfe4c3000000b002f459afc809sm10562777wrm.72.2023.04.17.06.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:41:48 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "mptcp: fix accept vs worker race"
Date: Mon, 17 Apr 2023 15:41:34 +0200
Message-Id: <20230417134134.1636540-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=22Ek7jX4t6HTIqVD4L3XablVlHAJX+J0QjcADAC29Ow=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkPUyGggbtO186HeZLHLfAHCnDXBnixp/qKyyLU
 wCKFRWt6VOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZD1MhgAKCRD2t4JPQmmg
 c6G/EADpSuYlX/jTJJqXFW4dVWqp3G1SKJWAuHGIQHb02/+iSCzWpk8ejWuSCrDrCML/VQkdDFB
 5I6EPNSuKz/3AK64jlBVkSl+m01mQ/qtNiZoajyHCyHXcRG2RqsAui3omX/sSrc9IYve60/Xazl
 jTa8uJpvxdqBEv7sDlQUK742NzMv4q1uXPvP+XHI6RGeCKuAoj7oW/n7X4fWwadVOiXqEbss7Qs
 mAgXXlWCe5aMipQ76D0GB0keHKV9HYbSc5ELMUYwAGDEO/tJrlbRfDZlH3vdYSBeFelCog0rVSo
 AGl1A7L71B/g//PLgG92kioAMarYfTj5pcWIaB+pKG40Uvj3uC0V22CB/nJOcOdUbtFi/w5iY/I
 yKbiu/TO41KKvWmPQnAT6AQHzeoPENH+VKiiLTcdDcC8ul1f9LXsUJWGCmyTkXfkHhq40tFGreO
 oUGq908MW4WABu3v61sQz+/rosO12w63Lv8TAVVWnqFUBHKahnZswb5Ns95LZQ9D7QKbhEAWTqO
 PNPZPmdSHhWGhU2O5bVhptTsGNPsTH26HdNQphubbB4H2VpNVMMzD2Omk8Ht8lZlxr792NEAevR
 nLHOgp6TrQ37C1omORUSqxL8PgEFSbrbaPGMzCu+fXFkRujFw5xlQPo23ltH4R5uYEptu2HVJJx yS+qNnLWWXILCCQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Just move the declaration of __mptcp_unaccepted_force_close() lower to
avoid conflicts when merging with the current net-next, see
commit ddb1a072f858 ("mptcp: move first subflow allocation at mpc access
time").

By doing that, I can send our two last patches queued for -net without
creating conflicts.

At the end, __mptcp_unaccepted_force_close() is declared after
mptcp_cancel_work() (but before __mptcp_close()).

I'm going to apply this patch and then sent the two fix to netdev. I
hope that's OK!

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "mptcp: fix accept vs worker race"

 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 33589f98473e..d6469b6ab38e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,9 +632,9 @@ void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
-void __mptcp_unaccepted_force_close(struct sock *sk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
+void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,

base-commit: 97397b840098c47088efb4dd3c8052e7bb989020
-- 
2.39.2


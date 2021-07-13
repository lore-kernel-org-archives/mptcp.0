Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1370
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 06:44:52 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id g4-20020a17090ace84b029017554809f35so717296pju.5
        for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 23:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Li6fufrZ4X2X7uE3ac0GnNCDmeBp8Jw1GBz771VZB8=;
        b=lSBep65um9g4I6chk8J80kkyfD2jSxIOYuIZfiyC7qpBXcTVPPiqoP9q5gOmei+gLq
         htsNgvT86wTbY6kiifJ3Ntf37eeIxKk+gNZz0ZTSb82xAahNEKpQYQZugjs/laaSMNDT
         7V+FqdmSd52Yzoc8OvyC911HCug1XdOruAjCwxdDSh4kRF0d/NXuyAwn1d1eXKWT5K76
         9b+ZKDuXXNiOy1DBvfqoz5UEkXLBCCakDPHqBB+fRTlDJA6xMAS9prVwFLPUIIeA6pfe
         IgebAuDxSWXRfkYYmKXIuEG0mPWXnj+Ohf3UqFGgMSEGucUX+smHUqifkr0yT9UVLAqz
         h3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Li6fufrZ4X2X7uE3ac0GnNCDmeBp8Jw1GBz771VZB8=;
        b=WAayuP9tmcl1Ne0oAk05AROnzq+mNcUibqqec4e0Q/cUKJxw/NkdBQzb69yFmouo+l
         hbVnOPmv8dtpyG5f8Pe15mWsbhVvu5XwVrNI8xyAyyo4aIzbBvcFolQCzG9nwwwgZpeS
         T9Ab3H7+2e7JSOcS5vFmg8dVlDR6J/flz09UD68xiP/Bg8lUtFa5dgijne+v6YfbkVzh
         obfH7tTCOOjajnSw9TKZOgjeqQjDWgYt9AWLJa8Su+RSdAH3qU5WGgJZDNuOykgsFoNe
         9U6lYtd1XQmc3RFSEABQkTZco4+EhsTaNxNTv+bvgUaCwYjgx1x3hDyJbpTvdg67Od4n
         /Cuw==
X-Gm-Message-State: AOAM532N96EWRCTqyS1/9xwnqlKtttqNkPCvYUPSeq12jjR65tnm7iK+
	kFfC45fkuEUGhQwT2rMH2hC49S+6OuBIcQ==
X-Google-Smtp-Source: ABdhPJwDPjNzRBQ9jsDNR9Xy9Pz2/cxMAZi6LcD1MP7IxJmO58puTqUtXNsMTMK2I/RtFDGMW7fpMw==
X-Received: by 2002:a17:90a:aa14:: with SMTP id k20mr18164521pjq.88.1626158691521;
        Mon, 12 Jul 2021 23:44:51 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 202sm15236606pfx.75.2021.07.12.23.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 23:44:51 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other"
Date: Tue, 13 Jul 2021 14:44:43 +0800
Message-Id: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This line 'if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))' should
be:
        if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO))

Since I'll keep the echo argument in mptcp_pm_add_addr_signal(), just use
*echo here.

Like the 'rm_addr' variable in mptcp_pm_rm_addr_signal(), use a new
variable 'add_addr' in mptcp_pm_add_addr_signal() too.

v2:
 - drop READ_ONCE()
 - drop mptcp_pm_should_add_signal_echo()
 - use & instead of &=

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c9622696716e..792940dbe662 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -257,6 +257,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
 {
 	int ret = false;
+	u8 add_addr;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -271,10 +272,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 		goto out_unlock;
 
 	*saddr = msk->pm.local;
-	if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
-		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO));
+	if (*echo)
+		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
 	else
-		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL));
+		add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	ret = true;
 
 out_unlock:
-- 
2.31.1


Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641B02C80
	for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 19:18:00 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id z9so31571091edm.10
        for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 11:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yN3NI4558XnAgcWdeQRXOWViZ0Qc4qBX0GV2hSfqTVk=;
        b=OAEMIXENSXzlqQC5H+Ye1QJhJN2jaDu5vkAGOKtL7/Au0Zlt1TXME9HD9E3HXKyE5K
         s2UvMQwfrX0tiqPM/5XN9LjCJrdFrImfMdMEAu9/6DXSUj/i6tnI1U/ueP56zk2V6Zgx
         GSsyZtfay3ERxq70iKMWgF4Ip0XGxeZaVbw0JGDPjxgFjHWycOksHWydHPZm/iabsJeI
         CEgS0lDDuy8JZ/ZudA9xvQHiAs3s2REgCCF1GFIrJnalb6Gr/PMbLHc9amN4k9vHNNWS
         tsxQlT8bqgDi/ajwnddv39ihnGUxSE/7i3nIHDAS8bDGOy4ccpv8Jryshhbr0C3Lp470
         qf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yN3NI4558XnAgcWdeQRXOWViZ0Qc4qBX0GV2hSfqTVk=;
        b=koll4rflxjUUapmzsmJoV9Ee+q3VaGFiLqGMjaY65Y1xBKUivKNkZgaRAl8HACjXRw
         UptWMgxTgSm7zLOUEAYBT8Li7qM5xH+P0plDVJs1JjzP1z1Qf3WPPThy90rpnbu2fLpM
         FJ+/gWgt3ssmXHRygj6Rkx5j/qy9ieyvBjWrdiib2ZB2+RzSprNSXU8cB4DN7pOP4JRX
         fjzKgfEYueW4H3Z6WrQwR0bSFPrIV1/xiCfYbk7FMzSSxRvtfd/9JHzxBeh4498HiPc2
         K0n13Vcg4+hlcy1O6U/Ga3xlzzEl7pcK2nhtnRGLz+VsIX1z/fTz11/W9Vk1/qo8WFpM
         1aJQ==
X-Gm-Message-State: AOAM5311gTd2rq4JsJ+e2pgGfxZJx3AO44oHq1I1vA6pUoXdtDKyNAsh
	P4WNBAurn9JFx/Pln3KhkdcEHA75SNA8vZz1
X-Google-Smtp-Source: ABdhPJyHayKTCtfVS4F93b0qcWPpQhEJLuTktX2dojBeYDYEP/ypaJayo5mhWbmjzTpUnrMhkhbeyw==
X-Received: by 2002:a17:906:b003:: with SMTP id v3mr26153027ejy.770.1640891878502;
        Thu, 30 Dec 2021 11:17:58 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id m6sm9918244edc.36.2021.12.30.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:17:58 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v7 4/4] mptcp: allow sending both ADD_ADDR and RM_ADDR
Date: Thu, 30 Dec 2021 20:16:51 +0100
Message-Id: <20211230191651.1831507-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
References: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is mainly to be sync with what is done in mptcp_write_options()
where after having written the ADD_ADDR option, we check if the RM_ADDR
option also needs to be added.

But if we have room, it makes sense to write the two options in the same
packet. So best to remove the 'else'.

While at it, also mention that mptcp_established_options_add_addr() can
remove options.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d06855e66007..c08d4b04458b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -863,11 +863,14 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	*size += opt_size;
 	remaining -= opt_size;
+	/* Note: this can remove previously set options in some conditions */
 	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
-	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
+	}
+
+	if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
-- 
2.33.1


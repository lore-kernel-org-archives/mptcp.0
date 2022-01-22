Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D162C9C
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 09:32:03 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id d10so6768193eje.10
        for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 01:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tlDv4gZbdVacz06p8V3Lhy23EGWDxyl64uR68uWlQWo=;
        b=RyMKsmJG3bI/EYmjyFQT2E9wZdBzPAiEJ6FrlYesHgskqHJUxuEWwatuodgojZyvw3
         UUhHCqRiTLiU5b5igoPYCvdvlZR4gjI0aBccP1DLh+DT8/yUkRWsv4/rVBzbpQm1++Zq
         pgBQnHt0CwNlN9hVjap+DKGqM8ujXJ8DC6ecohRMwRRI4lzo7pMaBcYxSbG9Ixw94QdJ
         ABSGDCpF0P35hbbwiaRvmwtDz0WLXdVTTp1HxDPnFIU/EL+cnRIQO0xEMmons+OYIDP4
         0R/i/WkFZwzXp0F06TpF14ILjjbr4afgSFAO46MfBM8FE3Rx0bRYKmweIo0SozGMG98P
         nrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlDv4gZbdVacz06p8V3Lhy23EGWDxyl64uR68uWlQWo=;
        b=SApoAcqT136lnGgZmZzr8zQK5iA+Nw9EgWEfe574j3O25tSrEp8GaR+bYIv9aacmV4
         W2byV4yE9Tkg32XbS3rnaZysWvPS5BA4LxaXSII8nO1rNKxB5uMnVc3v5sOebx46S5Y0
         QHQw1iEMkKL+OB9bQuUf1NRBnuq2njGLyXT0BG1vO9RJ5NkTXXILA8hAwm4nxNQ3bWZK
         9Ar69onscwA0N2JEfi4rizGKjuNpvqHrIaxWliSkemg1hoXWZCE1a6DpPFbqY4itmh+x
         16gXMOK+hcLs+LQHP8j3AYlWNWCbKQeJ0yzjW0t/SqD61MjkozgSADA90saX2VYws+I4
         thYQ==
X-Gm-Message-State: AOAM530F6kozgmtZA1ktDr0QfXYKIi1Z9K9LjAT0cV5e0T+eoBzmts7S
	p6tcjWTwuWLvUJe9zmd93rengX0tcvtUW8+M
X-Google-Smtp-Source: ABdhPJzGuSO1XdiOnJ2kCJqd/H0kCOfMr9v2VZFPFeGiDreV8HubOoaouVppvQ9z9yUmVcQPNUVQOw==
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr1019666ejs.42.1642843921147;
        Sat, 22 Jan 2022 01:32:01 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id e28sm2776994ejm.94.2022.01.22.01.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:32:00 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net 1/2] mptcp: mptcp_parse_option is no longer exported
Date: Sat, 22 Jan 2022 10:31:34 +0100
Message-Id: <20220122093135.4023846-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Options parsing in now done from mptcp_incoming_options().

mptcp_parse_option() has been removed from mptcp.h when CONFIG_MPTCP is
defined but not when it is not.

Fixes: cfde141ea3fa ("mptcp: move option parsing into mptcp_incoming_options()")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/net/mptcp.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 04f53352a1c9..8b1afd6f5cc4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -218,12 +218,6 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return false;
 }
 
-static inline void mptcp_parse_option(const struct sk_buff *skb,
-				      const unsigned char *ptr, int opsize,
-				      struct tcp_options_received *opt_rx)
-{
-}
-
 static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 				     unsigned int *size,
 				     struct mptcp_out_options *opts)
-- 
2.33.1


Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFAA6D17
	for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 17:26:23 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id lo4so33033136ejb.7
        for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKDqC0qf2HE2EYnAe9lC+o+DzVjMeIUlCSY6yBX4FMo=;
        b=hLM8pAI/3yK5H46Z7S9lWBtqnf4j89U9ojWMKZSETsl0aJqAPGdPtXXTDGY5JwPy55
         FMFMwcmiKCXHNhgsyte2HV1xfviSEFD1hgkAN0P3Nm1n3ZzqjIOwkWo4mQTqQcO54z91
         UhpjRjM5CmnmMEDTVLWycUy6SUgAmBGt+1hx5wNMZqUKkM0yWLfIyl9GInZ3zreIutO+
         Rse8OBajjrT29a8mM0XFy+DfqJ/TBRj48lTXDt6MTPAfhQTLfGgnxU+C8jAjhU2w8A6W
         BDmcHZwAZibjudIOROl4HQuz0JX2bZngiQzS0fv9J1HoBVK4FDv3lCJsuUN+zQn5AoZb
         lOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKDqC0qf2HE2EYnAe9lC+o+DzVjMeIUlCSY6yBX4FMo=;
        b=eG9N5dF41D8rXmQkm/GTS5J2bmE6t3WcV22T6ReZACNP7N/mMikamACI7eSJbIjiXa
         Pws5BAiGdGjqz340IBPGavpPTO1oyRSlP6izzoHkcji34LsAPcjDs9kY3aIkWRsq+nsT
         1WV1jn/H5t6sWQFPwJoDYcHlPgYVLZCbIIiXC70VcUtFBskrBO7B0+MPEEOd5uWc15by
         xdMatmI+6j6m9Oqs/2KDC1fJBwJWg2wp+9UngeHdUhiWZJbC8k27lfrNRj8EiGmvDpxx
         J75gVN+mZaHZqLe1XKHEz4JmjBbSDQIJGfejifPabr/M8ERVJN8mf3gbpC6GxkM2X2d4
         Cd7A==
X-Gm-Message-State: AOAM530TZe1167udi60ix2Md1GXihZeaCXEQAh1NFtJ0Om3jX680y7rx
	EvY4/y4XqQAcbU0PJ5gwMYadvRZAkxPTD9tKqH8=
X-Google-Smtp-Source: ABdhPJxfwDxmhx8KSK8uBVSJYYif5nmA4kCPFqDDRTojxCbjxVhAfRSHhJnbx8nEbxNsite4Q2KEfA==
X-Received: by 2002:a17:906:3aca:: with SMTP id z10mr17188014ejd.53.1629134781336;
        Mon, 16 Aug 2021 10:26:21 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y2sm3912981ejd.111.2021.08.16.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:26:20 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net v2 1/2] mptcp: check for HMAC presence in ADD_ADDR
Date: Mon, 16 Aug 2021 19:25:47 +0200
Message-Id: <20210816172548.2339984-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
References: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before switching to a "fully established" mode, which confirms the other
end seems to really talk MPTCP, best to check if the ADD_ADDR looks
valid by looking if it contains an HMAC (no 'echo' bit).

If an ADD_ADDR echo is received while we were not in "fully established"
mode, it is strange, best not to switch now.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d94ff50c29b3..a83550de54db 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -954,7 +954,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		goto fully_established;
 	}
 
-	if (mp_opt->add_addr) {
+	if (mp_opt->add_addr && !mp_opt->echo) {
 		WRITE_ONCE(msk->fully_established, true);
 		return true;
 	}
-- 
2.32.0


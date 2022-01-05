Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E52CA1
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:32 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id w16so163988884edc.11
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7ANgkGtQZK9Nc5HOgbMT9n/B9bvRtpJxNwtwFZ96e8=;
        b=OeTbLxEeprlPuXg4XRF21QIxiZX6MAX9Frfaijxy3V9Tm5fcxTFQysWs7BexG5W5Nf
         vLER8pxm9JfR/Aj1KMrBPOUI9B+UnuvfTfXQzxuvARVkywW4jvTHu1cG0et6KlA/E4xl
         BG3PqfYiks5I3JHEdO62piXJIlSoMwedwILfkeAafZMI3P7np7HG+urD7zX1SNH3gzEs
         sbVaq4chH4if10NlmmvaEzFECAUgblktPiQy/P83H9DV6I8xbEDzxdcy5kW7U+5JQh9Q
         oq/7/MbKXX2gDJAecaKbUv9qF+QDe9+qjBoPvfCqLN7BmPqqzZXJLS/9zbMU/I14ExIv
         v9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7ANgkGtQZK9Nc5HOgbMT9n/B9bvRtpJxNwtwFZ96e8=;
        b=iGzguaqEQ0GxPFWIckIBE7mlbk8i8MQc5vMSYO0s7Q9bpLpmaym+jOivgink5g/itO
         7tgtDvhGGynpO1SE2j/+wdT2FqNID//1OagGpAewyiqj3jjdO9WDDfju+SlocDmjTGRj
         TPackxPFmXYYzBmTBFpwWXUAuHbrFJDQ7rJxQYxrKQv3WJ5ah/lO4HVV6NT+HCQwJL2Y
         2CXdvlxjozkxw2hMT1cenH3xRK3M22SnT2kd4GFOcj4O0HahzU4Pw5gvlFd5E/0jHsgs
         18Wd8kl2th9655jt2BGBqBVB6q7XygerkngtIsgSSFs3meuEt434sNQMsYcXaFFYrYRK
         pueA==
X-Gm-Message-State: AOAM530MgAy+z4KphZRbJnU7/6g4SCRM6WPklGuHyxFZAuxpoP7RJTN1
	WHQtdD+yrPXOMAIiPBbsGwbQJAgAHvb48CFa1s8=
X-Google-Smtp-Source: ABdhPJwaVB9L+jCi8GWusCK5tZOTbY4ZUe/CcZ9VdQMZGMr44B50/k5AZ2tGSN+RYb1IGrOhc00vVQ==
X-Received: by 2002:a17:907:9621:: with SMTP id gb33mr43352125ejc.394.1641398250318;
        Wed, 05 Jan 2022 07:57:30 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:29 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 2/8] mptcp: fix opt size when sending DSS + MP_FAIL
Date: Wed,  5 Jan 2022 16:56:56 +0100
Message-Id: <20220105155702.165123-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220105155702.165123-1-matthieu.baerts@tessares.net>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When these two options had to be sent -- which is not common -- the DSS
size was not being taken into account in the remaining size.

Additionaly in this situation, the reported size was only the one of
the MP_FAIL which can cause issue if at the end, we need to write more
in the TCP options than previously said.

Here we use a dedicated variable for MP_FAIL size to keep the
WARN_ON_ONCE() just after.

Fixes: c25aeb4e0953 ("mptcp: MP_FAIL suboption sending")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index aa3ed37bc59a..36ab69906af3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -845,10 +845,13 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
 		ret = true;
 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
+		unsigned int mp_fail_size;
+
 		ret = true;
-		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
-			*size += opt_size;
-			remaining -= opt_size;
+		if (mptcp_established_options_mp_fail(sk, &mp_fail_size,
+						      remaining - opt_size, opts)) {
+			*size += opt_size + mp_fail_size;
+			remaining -= opt_size - mp_fail_size;
 			return true;
 		}
 	}
-- 
2.33.1


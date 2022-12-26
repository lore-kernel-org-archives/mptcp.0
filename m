Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCE7E3
	for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 09:36:36 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id qk9so25165802ejc.3
        for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzlZyunipQwcK3f21UzjZnIndMnmoN4oFFTPZjGSTZ0=;
        b=LaoYcOaRYblwJ/KTz+DIA5sfqlQnnQlzaqCc4wV4fDEMOvKRcos/GLMG99Ig/a5aOD
         wBSy5ynIGGX2PHjC2/rcmAAs/R+k8VU+hkt/XPiW7KqBwHMOC5b6d89/LHqbCgqRZ4dg
         AYW0HC5nc+4K4JtFax9wnXkSOMQOwRcgmpumRySU4WiAQkpg2xijoKvuz8RAc+hXwlq0
         P73NB9V8MO0j4Y7oKgIuur+XXoJQhJko+Fl0gJujD8MPZ2O1LOzgCv4IrI/PWexhVdUv
         q9VtXT5C02v8+hBt9ePY6os2FI0ASQVqF+tVwSAHjvvZApFssbBGf6Ed68Sdaej6oGjY
         y0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzlZyunipQwcK3f21UzjZnIndMnmoN4oFFTPZjGSTZ0=;
        b=fwbYpas5X2n8/jy2W+8DATCzr2mKo8ExRL0wzADJJ96/QreFJ5oBbE44hBwh90s0xH
         yWAzUoJKwyz5R/28tGFwNzk8FPQXbG+MVNJILLZ2WLOKCKwS4MpsUX7t5MkIFhlSfOCH
         Qi5D3nhmvNu09oXnhrmuVN4GRnQiD6zII07yErpGupz3ExvkTqo+JT336Aol0ccitjPr
         L4zhm6uooSo27uqRtTNfid8n06zlIQGtzfEVdTe/bED/M+J9xMRW9mXQUHuTbq+cvT+K
         vxw1uYa56dhUuN4lkqMcqSRcfWGbCHsawUZ9SQAy5kwWqDz4NOKYKlYmv95paD0edTxx
         whiQ==
X-Gm-Message-State: AFqh2kqJusSyLn9FFURR37L9amGL1uFRl6sNitSK+N0aCKb+JiPjbHkk
	DMLvKORUR68AX426/BEAy0sb/jagsLd2Ic/7RSg=
X-Google-Smtp-Source: AMrXdXuQZcmhQkn2jVk/bDeEp43EMYhnN/k7GzFLswrdYHNcRnC7GYThrPLPmKwuFnSqgbMFuvURgg==
X-Received: by 2002:a17:907:d48e:b0:7ae:b2e4:7b3f with SMTP id vj14-20020a170907d48e00b007aeb2e47b3fmr15650628ejc.8.1672047394501;
        Mon, 26 Dec 2022 01:36:34 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p15-20020a056402500f00b0047eeaae9558sm4407233eda.60.2022.12.26.01.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 01:36:34 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-iproute2] mptcp: add new listener events
Date: Mon, 26 Dec 2022 10:35:58 +0100
Message-Id: <20221226093558.599103-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These new events have been added in kernel commit f8c9dfbd875b ("mptcp:
add pm listener events") by Geliang Tang.

Two new MPTCP Netlink event types for PM listening socket creation and
closure have been recently added. They will be available in the future
v6.2 kernel.

They have been added because MPTCP for Linux, when not using the
in-kernel PM, depends on the userspace PM to create extra listening
sockets -- called "PM listeners" -- before announcing addresses and
ports. With the existing MPTCP Netlink events, a userspace PM can create
PM listeners at startup time, or in response to an incoming connection.
Creating sockets in response to connections is not optimal: ADD_ADDRs
can't be sent until the sockets are created and listen()ed, and if all
connections are closed then it may not be clear to the userspace PM
daemon that PM listener sockets should be cleaned up. Hence these new
events: PM listening sockets can be managed based on application
activity.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/313
Cc: Geliang Tang <geliang.tang@suse.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    No objection for the names?

    We are currently limiting the name to 14 chars. If we want to have
    "LISTENER_xxx" instead of "LISTEN_xxx", we need to increase this
    limit. I'm fine with the current names or with +ER.

 ip/ipmptcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index ce62ab9a..2338ba53 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -454,6 +454,8 @@ static const char * const event_to_str[] = {
 	[MPTCP_EVENT_SUB_ESTABLISHED] = "SF_ESTABLISHED",
 	[MPTCP_EVENT_SUB_CLOSED] = "SF_CLOSED",
 	[MPTCP_EVENT_SUB_PRIORITY] = "SF_PRIO",
+	[MPTCP_EVENT_LISTENER_CREATED] = "LISTEN_CREATED",
+	[MPTCP_EVENT_LISTENER_CLOSED] = "LISTEN_CLOSED",
 };

 static void print_addr(const char *key, int af, struct rtattr *value)

base-commit: 1e994cf69cfd55fefd000565914fd85e3ec150af
--
2.37.2


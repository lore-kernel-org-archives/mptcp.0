Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64CF4C6C
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 15:26:23 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id x18so4454102wrm.7
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=td7eeUdAoD+sboAvcQa/UeCUj1r6FvEiNL/P94CpwKo=;
        b=dnjXBBoxQEcsJ35HWg58CVDXUysNQIoIeqoEQRZSU6ymQaUfAG/dud/14b2VvYinYp
         RV2toIzYYdiOayx/qevsT5nMFwaceZvqeX4LUoFTyMyyDKxyJehBlKJTTKhQ7X604zmT
         CctSY99KwGDghaecVqKKoxdBg+0PUlultYFJUsJu6oF9PrwojZJKlSH6R8jFP9X94UoG
         RJpZbgYwAeP1H/mYgQreK/dse0uF3i8FQONvKN47FC5+togsebnF+r/Vx5HqGTPqiQRO
         1jLOTpoLRUQZo3hbzYstdTwUpH/L/qHEb8fk/jlry03GKUK3wvnEEADgAV53uQ7tHlho
         ZgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=td7eeUdAoD+sboAvcQa/UeCUj1r6FvEiNL/P94CpwKo=;
        b=AdK8Gpr0Cm9DoVHPEF6LuJ9UJQ1bvOHDNAxWqTVG7brgpOC3XUYuB8VTwCO8fOXKls
         N//9PQPx/eCO6FwtlbJy7ngRVZIpARpp18qlD1/H/FHuHYsd/BuOZ7WM0lnr9RP4WVQw
         cqiSxTfuiMC8E0HOj5A4eJ+jUz/JjqAIoyT/cxf4yjBTw3sfiaWQIzBnNKlSTWWozwW/
         4cE4JfKg50zcEUROAsyT6oBLFmLJ9DJ/BmVUS82njPSp5fumbuqYyE/zS+BJuxc6gttx
         aR8NWjQNScJ4GzfaG5CtXyJR2MhaP0ghHWX/fs5pOobKGnpOcIvD+IIOdYGzqJu3ZbCi
         xUbw==
X-Gm-Message-State: ACrzQf0GWgWUlPGL5nJ16xn9orWPDk/ii+Ok0jKXMRRXdrfvHVN5ITuZ
	0GB47HN1hC0Nc0w6vYjsvBZjoWavuJ1rfLGlJwSJXYHEA9AQ6TO58bGYAc+JLb+lX/gSQ/Eoiom
	DR61PZnaU3kIju/V1/BU=
X-Google-Smtp-Source: AMsMyM4/yVckasR7Uh9OnPBnX/rQQ7cCbJ1vvUYuobUmVRYoqFsB/QeZODUA9Hxyuy5jyloWpMNKzg==
X-Received: by 2002:a05:6000:cf:b0:228:e37b:361b with SMTP id q15-20020a05600000cf00b00228e37b361bmr17677997wrx.374.1663773981984;
        Wed, 21 Sep 2022 08:26:21 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b003b4935f04a4sm3994435wmq.5.2022.09.21.08.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:26:21 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v1 5/5] mptcp: poll allow write call before actual connect
Date: Wed, 21 Sep 2022 17:25:39 +0200
Message-Id: <20220921152539.1851441-6-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
References: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

If fastopen is used, poll must allow a first write that will trigger
the SYN+data

Similar to what is done in tcp_poll().

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aa6e13949b23..308a09b3c0b6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3733,10 +3733,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 {
 	struct sock *sk = sock->sk;
 	struct mptcp_sock *msk;
+	struct socket *ssock;
 	__poll_t mask = 0;
 	int state;
 
 	msk = mptcp_sk(sk);
+	ssock = __mptcp_nmpc_socket(msk);
 	sock_poll_wait(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
@@ -3751,6 +3753,9 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
 		mask |= mptcp_check_writeable(msk);
+	} else if (ssock && state == TCP_SYN_SENT && inet_sk(ssock->sk)->defer_connect) {
+		/* cf tcp_poll() note about TFO */
+		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
 		mask |= EPOLLHUP;
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>



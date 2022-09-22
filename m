Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C703C26
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 13:56:38 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id z6so15752464wrq.1
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=4mTVb33SQX6GPn0CWDxmkK/0imHagQT+Jol7Om6Wbnw=;
        b=H8GFC6bbtBF2qw0PLr0r0F5yFb4OnJ4a9Q386Hdb+FdFkhZinpA9nrX5T9PGxcWAct
         M+Vby6A1G+MC/0LGkx8/n1P92wuDvfonDwYoiA+UgELWzsgUa9FFE6kNfcpRSQfvW4rF
         ejqlLeGbZgG0q4MOMdwfovIvecUO+XOTKkS6j+8HS4jTu5w+akyZ0r5h8ieRenJn3x5Q
         7XPmYN1Fl+Thhexk+tUhR1waD4wV5m4YncHhL1XtNuRTKMZDsqk1ILtydDV0oRV/YqwP
         Ki6gvntbK2goaFaTS2GQbf4Du4aSXNh+mQPKfQ/ryftcoAnzjOB2B+L7oddnX0h5wdZ2
         lWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=4mTVb33SQX6GPn0CWDxmkK/0imHagQT+Jol7Om6Wbnw=;
        b=ETIxr2P0u/LnAzP/K29ZO59rC7ehvikq+kkf2XZrJTGzGQcM7oTxuHHqYKrylRdOQX
         CxxtrQqPqUE9/OOpMKy+ty9FlNPT1JNQxWifkLHKPxV1h/UD29JVuungfoE+kZCpW9IB
         49qlOQ4B72Q7MSBpDk38kDpbs8pkdukmScLdD3ggtprkbHNumfCF6y9ZqFXTCLhqy8SM
         j0D+pFVbD/vlCjciSK1jbPDdft7MOefouwwCv5rMzkxeRTdLzou0WQuwWJA1jmLvARgb
         +ruE6Kk8ke6cTB3RYO2Z7/a7zmYdXN69nnJZDiXbasIbos+mEkZcsgTJA/UXRydyzXwe
         yvdQ==
X-Gm-Message-State: ACrzQf3rR1yO4mvxCYrBlb4DxVQVIH5AGpbl+H3y42mVRyZwAEwdsxVr
	AE9S9ARA2BgmoWRzXs34rBnqsbU+g0C3sq03Mz/HHIe6nnFTf3LaHAmvNeyLwdG25yaemu/Fdob
	h7mO71KUPDXwL7OCJCxwDWQ==
X-Google-Smtp-Source: AMsMyM6bYjdUCVnTTYsh+bSw2w/6pJUtC/2Qd6MGQ8fd7cTNrWZvucCPiM9TS1usfrtXxiToxxle+A==
X-Received: by 2002:a05:6000:178c:b0:22b:7f5:c724 with SMTP id e12-20020a056000178c00b0022b07f5c724mr2112360wrg.384.1663854996553;
        Thu, 22 Sep 2022 06:56:36 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b003a844885f88sm6577053wmq.22.2022.09.22.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:56:36 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v2 4/4] mptcp: poll allow write call before actual connect
Date: Thu, 22 Sep 2022 15:56:27 +0200
Message-Id: <20220922135627.2019807-5-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
References: <20220922135627.2019807-1-benjamin.hesmans@tessares.net>
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

Notes:
    v2:
    - Using __mptcp_nmpc_socket() without lock on msk socket was unsafe.  Instead
      copy the defer_connect from mptcp_stream_connect() and check this flags
      instead. (Paolo's review)

 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f5f20910cd83..0eeb8115c9d0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3616,6 +3616,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 do_connect:
 	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
+	inet_sk(sock->sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
 	sock->state = ssock->state;
 
 	/* on successful connect, the msk state will be moved to established by
@@ -3754,6 +3755,9 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
 		mask |= mptcp_check_writeable(msk);
+	} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
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



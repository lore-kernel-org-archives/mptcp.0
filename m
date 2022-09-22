Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41863C32
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 13:56:37 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id cc5so15700265wrb.6
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=f3B+f8Lfmy+gOo9uZDCGPmY0byFX4mkSkoKXcctGEoQ=;
        b=pf71WgE6isL0CIrkCrI/3o45lRyxoHelWAZjg8Q4YhapLr2KsQ+dW+9QgfZhwEa9J/
         xBagz1pgvsiyLnJ7eR6MrpfbPg/QJX1rrWRtNqrIAfnFWAnMSbrww+6yK/LfFJN6QEGN
         C+pWigWDQmUh0w/WfLyeLJy1eBr4uGNTWKxDKMIrSiQtYzu/0mD8DECHDtl73c4OTEBr
         E19IK2gr4dhE8VJHgHTV9V5s0gD+nSAHiTOqb1x6MjrSsBazqpLlObplWBTjPoibTGXa
         jmZ6dO7XK0NEsZc0b8pJ5a3pBkyeg1ffbCxmSaFmIrNsq0hMbi4XI/i4Uz2ITsN4y4C1
         XLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=f3B+f8Lfmy+gOo9uZDCGPmY0byFX4mkSkoKXcctGEoQ=;
        b=T4HnZtSgV1A9LOGMgHjo7uAcf08FmCjVGgY1c2e0JxnsjESYN971I4zi0nl/bz/Vj6
         AcHSv3EUKE6w/FZVnCCWaKn632U9vbIDzcL7vMjrWB/h33xJ2BJYaVw49MAhSsphjbVr
         hILyqSczKQTj28nPhgSm9/amkBkKjBVoXMOgb2Nei0rz2NyppiE1AdApLADXR0/V5AOo
         wsGELzQsWC2Ig2J33LYn/zgMUAYW3klN6IqjInnbLM2dQpg4oCIDfWF3UZzgSUeaTpP6
         3iZYals9Ybuetyene9+r1BG4K65bhJcoljtccEI42UO/IaXSUFB1auq7aHQc4j7UI4ln
         pCCw==
X-Gm-Message-State: ACrzQf24rUvwWKGPCCCFg0cRTAgIApISpX4QCitlCTrwBdGN1QuuLtQV
	+pUUdV/CoGY+4MtJ7R6MyVdR/+SABELf2MtDHQ6KmpmiXki7XSqW4BYnViytE8TQNI/5F2mpX3j
	UtcjH8xXP7Jgu06keliM8cQ==
X-Google-Smtp-Source: AMsMyM55G/j1lW18emOqK+yutfpq04JnwPCwmJ1HbgTfABToUxIe7padUputjC0YxKizszLFJo4AQQ==
X-Received: by 2002:a5d:424a:0:b0:228:811f:c1a2 with SMTP id s10-20020a5d424a000000b00228811fc1a2mr2089250wrr.262.1663854995733;
        Thu, 22 Sep 2022 06:56:35 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c34c900b003a844885f88sm6577053wmq.22.2022.09.22.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:56:35 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH mptcp-next v2 3/4] mptcp: handle defer connect in mptcp_sendmsg
Date: Thu, 22 Sep 2022 15:56:26 +0200
Message-Id: <20220922135627.2019807-4-benjamin.hesmans@tessares.net>
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

When TCP_FASTOPEN_CONNECT has been set on the socket before a connect,
the defer flag is set and must be handled when sendmsg is called.

This is similar to what is done in tcp_sendmsg_locked().

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---

Notes:
    v1:
    - error case use latest patch from Paolo (propagate fastclose error)
    - I believe the use __mptcp_nmpc_socket(msk); is correct here (instead of
      msk->first but would be nice is someone can confirm
    - add unlikely for the TFO check
    - propagate the ssk state to the msk (Paolo)
    
    v2:
    - Question from v1's notes answered by Paolo.

 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d4e197ec567..f5f20910cd83 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1668,6 +1668,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
+	struct socket *ssock;
 	size_t copied = 0;
 	int ret = 0;
 	long timeo;
@@ -1681,6 +1682,27 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
+	ssock = __mptcp_nmpc_socket(msk);
+	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
+		struct sock *ssk = ssock->sk;
+		int copied_syn = 0;
+
+		lock_sock(ssk);
+
+		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
+		copied += copied_syn;
+		if (ret == -EINPROGRESS && copied_syn > 0) {
+			/* reflect the new state on the MPTCP socket */
+			inet_sk_state_store(sk, inet_sk_state_load(ssk));
+			release_sock(ssk);
+			goto out;
+		} else if (ret) {
+			release_sock(ssk);
+			goto do_error;
+		}
+		release_sock(ssk);
+	}
+
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>



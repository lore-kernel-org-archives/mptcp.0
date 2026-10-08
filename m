Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138A8379C37
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461773; cv=none; b=aqbwrKxEtz6Hw3uJQZ2Su+Yf0l4GO6oxSlf4i81Plb12JgC7Fi++BbTskfIkH9Uo8MFPi5mf9ULl44f3q9vhyMl3oqulC0CVbuAxtk+9c/WL9q28qYCCLGcMpFBz3cPR+2Ofd41l2HB9L1QHS0/HDgFEazDh9DzRnPdu14H9Nfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461773; c=relaxed/simple;
	bh=ZJUlsBAMJ4wa/6NMwaiK1D3a79jRDWecB6qQ9vbrpVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hkNYho9NCxGZgHzyy76+CoLwPOWuaI3SLdr9EMwEOcbZ7EayrdVa2TL22AJT6qbmdhH3lQKoFUy0sYLBKvdqjuwycsqDAgJsIyye6wCkxSAOjwtOoQwI8l6ihHrshtKO2nTiCFLzECd56b9Tv8K24D+CveAWFBI/0mdXT16gZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKWaql/J; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKWaql/J"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14fc585291cso1400868c88.1
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791461771; x=1792066571; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/UtBqMdo/BbBymsOtvtWXF3SEQCc5YUn7zmVPnRSDAQ=;
        b=dKWaql/JvSnb4H9KcMmlOBChXyLjMm2YS/IiTjvHVadPtxMfOy9E9bf9jh6MR0TELu
         NA52G/nsoaGknMuynZ0NJHNCz4z4Vv7h9Fx6G1FXbhMXfISHpOwL+ztqAT5FYGhYC6T7
         quSPkwMj8xzBXaItWYZqGDmUxNkTwNlZDmqjZ6Qfx494kSlaPpz8N7rKi4tNAV3U9s6h
         fxu91C39EJH5GWhxRO3olkb4EqHfSc17LMY5LFHJrXotya8iknTpEIsZrZddkjG5UQXR
         ypx2+s0vKfPuqfxwwSe2oAVzNhlwLrJDV2AX3ILMPOuQEtfbb8UuJIXjiLAWNyUqH+Aa
         wzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791461771; x=1792066571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/UtBqMdo/BbBymsOtvtWXF3SEQCc5YUn7zmVPnRSDAQ=;
        b=cljbnyeAbtSXQnIm65xaN4fZao5gGgnpfGoLMRBbWf4i4RrniYUFarUlTOkNaJnjWn
         socytLPSXJ67ik9+72/xA5x3vvjMOqVp+/qubl3PhCGb3dEnprWrRr37ukXfiuopS60L
         dMH5OnwIzIqQEDevprs4sqYsmLgceZLNvmp5p965s/sIQ/jXLKHLG2TM7i7QHDJdy0BS
         7sikfy6rKn10xM1WqTcjhyozZjrOeAGYkoqJqGn8YjYMSgrY0DjGk3XtDxBTC6aXgY7x
         gcRZAabmju7Ruc4EyhU9var4Ss74zZQXKG6sWQQ4WffFpW+0KRjzy3qKKXp+NQ+v1B+F
         e9KQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdMI9kSA2/I5IQKXacOJugkgOLnn6VI3iGujrYF8sxUiusxC4N/tdQkXf3vCgr8bwqJBj9Dw==@lists.linux.dev
X-Gm-Message-State: AFuF++nLFdjlNOfPvsPXqIQfKFzD+wIPuNuut7KX9L2K2wO0MiTAScze
	C/L4rRjNA1+v4VSA7fbsDmETgGfOJcK2IqnEVbhGos8Xem9Xdpzx1esw
X-Gm-Gg: AYBFou3NPQddXJOttQAagnjge9tzU7eK4MjlLYRB+HZX7c+ygbnpGOjFJnWc0K+K/qi
	utYtNW8y6bgmK76iCrtYWof2ikXeZTbLv1G0FAp+eTMotwICC0IaugTLeoI2DnYKMVfBgCM5+uJ
	1JEbUZ0UXVeXKXjQN0yQlzadyfq95eBPtY7US8MqfkOywi7b9oDZ2woHq0C3mZO02v8ddWzwcRj
	PWoj1hHhcCWLs38o3lsHLI26vb0Yutfc3+I6HeWhz0vmtIzucYOzHaiCLtHscUTHSoWd0YA3oI6
	ZGqfyUPVxJucpdbYQJY+wHByS6Gl/P1R2geGyBoLaAAfve5mZGfUQfZ8IW2iFA2GJqxmsNorrhr
	3VwwIBURFxEoWIlbIJj58mtHvig8r4YZpdcsNB+595AI+ve0XB+rTXBlt/fi204xpPyu4SF8UBA
	X5XXweVEPRuauvkeZU23ICAhuo/3UzBjunJ5YjJQ==
X-Received: by 2002:a05:7022:43a9:b0:14a:33d:f581 with SMTP id a92af1059eb24-16204a7fa14mr8972298c88.22.1791461768967;
        Thu, 08 Oct 2026 05:16:08 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616980c3b7sm14096967c88.16.2026.10.08.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:16:08 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: matttbe@kernel.org,
	mptcp@lists.linux.dev
Cc: petar.sakic@ink.fish,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH v4] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 17:46:02 +0530
Message-Id: <20261008121602.206507-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (after
consuming the client's SYN data but before the MP_CAPABLE third ACK
arrives), __mptcp_subflow_active() refuses transmission and the data
is queued into the msk write queue.

When the MPC third ACK arrives, the subflow transitions to
TCP_ESTABLISHED and is marked fully established in
check_fully_established(), but because the third ACK carries no
DSS data, the queued bytes remain stranded until the peer sends
more data.

Fix this in check_fully_established() by checking if the subflow
was doing passive TFO (subflow->is_mptfo). Under mptcp_data_lock(),
flush queued bytes via __mptcp_check_push() and clear is_mptfo.

Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
Assisted-by: Gemini 3.7
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 net/mptcp/options.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ce0de02f5..b865ee6af 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1042,6 +1042,15 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	/* Passive TFO: the application may have written data while the
+	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+	 * it then and nothing else spools the msk write queue when the
+	 * MPC third ack (no DSS) arrives. Push it now.
+	 */
+	if (subflow->is_mptfo) {
+		subflow->is_mptfo = 0;
+		__mptcp_check_push((struct sock *)msk, ssk);
+	}
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
-- 
2.34.1


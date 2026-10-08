Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E1387566
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453196; cv=none; b=h4PR7rON6eoKaKhEdN8kHwiHpOR+QHMYCBnOVGGodvQA2p57RRj0S3e+MJ6VkO8TZ1FMOCbiBBbMWPWRF++J7SWEqpck7ZfIultcsOlT9RYzHH0rKSBEl12LVOQzYiHS5ia9B21ow7PYQ9Ka2ieXda2I+w7ZN+fU4tjzeTJxPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453196; c=relaxed/simple;
	bh=wUjYNkz1DPayKi6xom1xAiMmjrkORcjqSBD+DP9E8q0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N4Pv7B4bZEWBPlvB85okW5dShAbqC1RIEw2D8UNHB51Omr9Q5DS8OmSr6gyJgGiq2WM2Vh3/d72gILetJFgHFbghklrQ5MA3/TXecvaoajz36QzbZHD1yTPqeIRpvvFNT9P1U1INCTcoB1yZ50tOyrRPkwqzaBqQrFhFlkFWxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYzJVwXx; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYzJVwXx"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35115b52125so3624307eec.1
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453194; x=1792057994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9YmqIKYdaFgNycQM+T7TwOEsRpUEkjHzmaTjKIGKx+A=;
        b=MYzJVwXxmr6+zuFOmKesH2DPsKWIgT79XSJpyyoygYE9Jl7XbP+5NtPzuFospcueXb
         FTeebb1px4jVJfnfn4lBuCzywICHD8AZyDZoNwgFbZs13D6ZwilS4avI/QGk7f5Vp5SG
         08CBEG07n31FXn/RcwDp6+WjpvMbnN0l86gECdRqcBZ9KltYfLdlxzee+KwTto54dI51
         iwPBpMuD4G4aD3059C5pEEx4Od7L9UlFSDITW1yoCAM4pmfUeTGUWD6ACMagROD2cFHk
         gHH6SUff+muQHUBz01cIoHS97kwGZ4pBwpj/p9sa8krp2ejav1qAXS3es6CocphWuO5W
         Xrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453194; x=1792057994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9YmqIKYdaFgNycQM+T7TwOEsRpUEkjHzmaTjKIGKx+A=;
        b=ZPxlhwn3CllBSadwReaW1IGQfPI4xxQ4iWaxerNbTmQRCzkncRf5A8unKnKiroGn6o
         F8BACHWig4OMyDUU6xh6avC9xKz9xSozVRWG3PY9roTI4azG94DjeiXf6moA2DxG3rSl
         yX+7X6HSe4g9KvkHCNu6tgkPwBmgISlBrZyM8pDsijSE/dZ1ebIp/7tvFGem8hfxxOzF
         fIAdCs795uq6N+7yDvIkN+4EW/p6VnhbHIvggY6LcDTbpFrNqUR9yz2oQ52XIXers9S6
         YUu/0jDTxlFws8337I4MztTYxrWFcEa+iOVycaTbE7xAaBf4F60EBsd6BvbQU4yB6slO
         oRlg==
X-Forwarded-Encrypted: i=1; AKwUvBzHpKr4xEcpyLcxgT2p/x1UPpIa2zBzFCc9cA0/Gqi2XJaHdwfWKqheLK9uMHCvrVnLdlvt3w==@lists.linux.dev
X-Gm-Message-State: AFuF++lIOtXlIGMYdackFL/FXHopFF+jiIgevlV/3Cs+8iJdOsLu1uMs
	0cBflvDxxIjaDv7dPiKIbJ1szZlelJpukKqxwlSyw5Gl+S14oQP/zGRd
X-Gm-Gg: AYBFou1kggspplwxfBZ1MrA0gYgqQZWqfy2ZmO9S2rDXtdZBN7lpDCxBLUy46WyCGOy
	JpwnncSN6+zvacaEIJAFCvzmXbYCMEibsBgCakZy/PEVCsXFp2nA2weLBk/0ebW7AgqsSXJtQim
	90kWYUmDN8xb8gjGzljGmFJHJitvrAlo/uQzBR+5OMh5ReXvO+f6/EJ5tdCcwy2OiFmUAaXyrN8
	sgtMUA5Ns0FnF/J3O2hCqrB51r/oyJV+vAhOkq1swuUBMBBZUsAswszlbyORZh+xwMguBt/Ul35
	kf+ESPSI+9wOclfAgfEtRdWsuQmOSZdNhpVKzq7gzqeCzOjlqOdBFkXfSBSIZisc/49mXTmWEau
	VQgIi058PcJUSS7RVbYC7kB0w7oYa16N5MzsuvZFvGZVhWad7S/lOV1bOYqrISMDLxDI4nl/MGh
	XDmbyZfWwIidTITohVDNIvi/DmgDN9b9HVzlDNmFyKLA8nchb8g/E+Tpy+u0nU1r4QJmDgh+LdV
	Dcp0y3m
X-Received: by 2002:a05:7300:d194:b0:33b:a766:ea6a with SMTP id 5a478bee46e88-3515dee3e47mr5439589eec.32.1791453194219;
        Thu, 08 Oct 2026 02:53:14 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afab2c5sm14137064eec.21.2026.10.08.02.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:53:13 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Petar Sakic <petar.sakic@ink.fish>,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 15:22:31 +0530
Message-Id: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
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

When the MPC third ACK arrives, check_fully_established() marks the
subflow established, but because the third ACK carries no DSS data,
the queued bytes remain stranded until the peer sends more data.

Fix this by:
1. Invoking __mptcp_check_push() in check_fully_established() when
   subflow->is_mptfo is set.
2. Setting MPTCP_PUSH_PENDING and scheduling the MPTCP worker in
   subflow_state_change() so that once the underlying subflow transitions
   to TCP_ESTABLISHED, pending queued bytes are immediately flushed.

Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: e00b63056fb4 ("fastopen: only mark MPTFO subflows with SYN data")
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 net/mptcp/options.c | 7 +++++++
 net/mptcp/subflow.c | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ce0de02f5..d5238fa11 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1042,6 +1042,13 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	/* Passive TFO: the application may have written data while the
+	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+	 * it then and nothing else spools the msk write queue when the
+	 * MPC third ack (no DSS) arrives. Push it now.
+	 */
+	if (subflow->is_mptfo)
+		__mptcp_check_push((struct sock *)msk, ssk);
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f0a6725d2..f499073a6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1894,6 +1894,11 @@ static void subflow_state_change(struct sock *sk)
 	if (subflow->resetting)
 		return;
 
+	if (subflow->is_mptfo) {
+		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(parent)->cb_flags);
+		mptcp_schedule_work(parent);
+	}
+
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
-- 
2.34.1


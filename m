Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502C3D5C07
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803411; cv=none; b=EBRsan5+kwP1i0p2nF51Pi1yZELnWHn37GMlZOxBElPZFL2jm1cTwB0+/5ne2gHxUY0DzX08EC/7I7Q53p9M1Y8DkDTDDCFpK1S8hB9Xw0SrvStwP89jzDu7MyRhoGJdCQ1knDhLyMA3KD94ToOy8pa3sCBP1RowamEM/NwyP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803411; c=relaxed/simple;
	bh=Oa0TSQ7I8bTGE1JPXYmsqkfYJmseisnQn3OwzMiRFo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJ8b3HzCQpfzjxGB9VYuM43cYDRLUyeJDjT28zRhAWd2m/t/fr/NfjJcwzdRa3bh9bUeVQHKG93eMaIA/mjBkSrtePERNLudP35VWaxqycQ/tTZQU1NQ/Trl6ydFqT6bLwk+iPXqqRDbleRXZRJJ/VyifEF6u4Bu+qFK6EVemWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGPoUD2e; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGPoUD2e"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6f8a519e215so34504eaf.1
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791803409; x=1792408209; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=elokP/yjwGHyCN2D/1O9kLO9j2Xf5I6wfEusS4KJGlU=;
        b=SGPoUD2eU8/E5i0NnpTvaTmLwLWhlWwfz00HBq2h9K4pBLywfFPryqCUDW87R+LQsI
         17d8gaXIGf5ZDbvkjbpagIiChmy5JlQH3H8M0DeQoMkS3wArQPOREBjrDvj3y8B4BfEZ
         HgoI8ISqFsOPj1/F700wBlJVm2rluPGgdnbsTbFGkI5ayAfUZ/9vmnCCqaPHLtyt8+14
         jQrt9GIVCcsYLPD+gxRwXs6cdFNakBfl5PJTe3EYpSdvYC4ei+OVUBFtIPBkirG4pxJf
         kojj4ruLKXjwDtRwFcRb8G1Zujk50F2YqxpDoYosTePDBot4wUnBmg39m+zxT/R0oPX5
         GSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791803409; x=1792408209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elokP/yjwGHyCN2D/1O9kLO9j2Xf5I6wfEusS4KJGlU=;
        b=SyY5YOift+ABWqEF788XYBFFWFLk4JAmhxhrtTsEWGw1H1TmYA0OZPqh/yfTXwdOEk
         N9tT8mCzfW9rmuVB9GlAJgh3XFUPP2HzJ71QRuSqBSoiWpDpWP+ZvpVfslRoa3ucS/NK
         Wu3KCaFSXRvyK6pED5Otd1F6o7EzzhaoUZE7mZxHpnZiVAh7mGxk+LZgcV9Lcy+5ME3j
         6aHA7pn1CHdE6pGkGFjxFY9Uvnnf0DRZYiAf0XUsbtLshAEYLHr91u5esXRTISDXzqvG
         sIsxar+vgTUg7AXvrT4UAsogmcncq2HFEhJHEylcaX3TmhUGYHcigcAE+cHAY2WWe8q3
         KOnQ==
X-Gm-Message-State: AFq9FYK3h7J52GL8Ln5uGYhJMsPQ9eERXHA2tgIu7qEqjanayUhq+D1i
	B7cxzO3K/uc0/P/eae/qzFaEjcVPalaJK+hl92y5dEkMMTnMDaMWRpnSFrGE0sQD37g=
X-Gm-Gg: AYBFou18CNRwEhLXW4SR8bdyr1Bm/X0ftRoqzIfwZOJw9tHbE+hrHf3BoBCtcuCsLJR
	nOKY+hiJrsrSY3tpPPcnYekLj2reb36rK9MPOHc30tc23K/vBSCOUDqh0OlpWELbsjNtKjOur1r
	clsTof/XTm5PUAC6oFzGYxuU5ZD9EXDS87rLzvER8cWnrzQ8hz7S/PZks+QRRAuGTv/A7o3hdsq
	VKQ3Z4S0xnVC/M7EiSJ+IMITkMhSc0fXRkARVcNEEzahYuHp144Mw+TSnxM74lb3/Ds8TrvZxez
	nh59+T+bcepiHTaUrCAbkGqaRZq876B1KfiBWlZhSACHwkUet6zk5U6Rbvyjt2XYTFJ2ok2gcBI
	bO8SM4FZdm7P9pkPxel95G1nW9lKWx7SBSGfLuRZoL0va4OQkkw38JgcTwsnyCuCyi8tffAI91h
	JVeIqPJsPiOJt0gPoCzhPL7oktaBkANl4zFPMwhzEErguYZmYR1xbijPbYqAyPnSs8f4SlYmOQB
	pDpgYwpOnsXHfUpx6M=
X-Received: by 2002:a05:6820:1c88:b0:6f8:a519:d932 with SMTP id 006d021491bc7-6f8a519e138mr58051eaf.53.1791803409023;
        Mon, 12 Oct 2026 04:10:09 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a822ef24sm8655338fac.2.2026.10.12.04.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:10:08 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	petar.sakic@ink.fish,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH mptcp-net v2] mptcp: push queued data on passive TFO subflows becoming established
Date: Mon, 12 Oct 2026 16:40:01 +0530
Message-Id: <20261012111001.542847-1-rameshkumar.t@phytecembedded.in>
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
flush queued bytes via __mptcp_check_push().

Suggested-by: Petar Sakic <petar.sakic@ink.fish>
Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
v2:
 - Reverted moving/clearing is_mptfo since check_fully_established() is
   only called once and is_mptfo is read-only at this stage (Matthieu Baerts).
 - Added Suggested-by tag for Petar Sakic.
 - Rebased cleanly on top of mptcp_net-next export branch.
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2bf368670..f5a258c7d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1043,6 +1043,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	if (subflow->is_mptfo)
+		__mptcp_check_push((struct sock *)msk, ssk);
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
-- 
2.34.1

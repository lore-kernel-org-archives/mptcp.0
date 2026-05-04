Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030C168BD
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 04:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777869656; cv=none; b=A+7NGZJqputQNP4us6ExtQYjAvSKYxLAI5lIrIeD3fizcPCFoq8t29ZUPewg27HqP1+w+mNCGWjsyAtzrFrODRzRwxmb/72EtZuHeArjA6GCtgl5904PSnivJPvyA3S40x0JyLH1xHXrSSo1oZyR5S7e15c9yasJZF8Stg8bIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777869656; c=relaxed/simple;
	bh=HizQ6TvuO1HYtzXojp7jbHVA4Qoiqdrp6ul+43DXQ6A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UaBKscYM1ie3S4OlPH6QgNDvV5nyX118qTZto2M+pb1lca4e8fY4m6CzpiLEKA7bju1M5FKidtmg16u1yfOco3F6ENbA1PVoGf8n1vrbXihppFF+SGFZZhbydj4bNG2UKcbH3IlZZ7Z/DghCRflC5ZhyqdfSYw9TBgS+DNAzZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZvdVEuV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZvdVEuV"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82d40278103so2203664b3a.2
        for <mptcp@lists.linux.dev>; Sun, 03 May 2026 21:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777869654; x=1778474454; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ttb8w3CQV6iVqVsFXjgzWtjKHF9GZgeNzhdQr8BWPYw=;
        b=tZvdVEuViHAunEaDQsaqPEVbFlZmoKRAqZnsD2QIlFx74uUuJsiAW3NYB/WbY/xgeW
         3beYf5/UZi4aRgBt2F6Rt7DTL28MlaveMADbpbFvVV7tqLJEXVcB9FYNcoidHYqExH2f
         w8bgqHs2tyU2ULHMkXS9fwA996QiVxOiVx+8xHi07P4vHzv1Ig0oOf5Kk71G32r/ElLz
         ng5wky+LoY84ZKDMGyZ/jOQIUqs3zip/KwOlM18MPUq4cCVDbH7hF98lBEYnhBeHc+VV
         7fZswsySTdXq1xjm449w+McDj0hyTDINgHWDsaKT2zdgitnNkkWTzw6BAu5Y+cdGEqdm
         TpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777869654; x=1778474454;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ttb8w3CQV6iVqVsFXjgzWtjKHF9GZgeNzhdQr8BWPYw=;
        b=mEWbLs4PVLHSb00OeZtKiSY3oLoRjeBEwOAXBh6OkxPW78Dh53/0040D0a2GZh/U7T
         6fSV3aXTllIYKYKPQx6KdZUsLKrddDYcR5CBAamGXErQYn2ZqosQSf1rO6t6AUmRa7/3
         kdNYfT7Qcv2UTTfwpxsDY9se+mF5bSAV5nDyePqqu51mtOryQD2dBkD8CmD2O29gZBp1
         4MACFmUl3sWdv8iah0QTdFiQZ1iG4iFjB+4mP+5d02O040KGdxfnRhNbVT4lQ87y2eVC
         WHtHU/2r7usr9evPFQea0zQZPIx2DqJQ2XiAX6H9eyBMi/twl57yf47wid9Vr+sc2PlM
         cj2g==
X-Forwarded-Encrypted: i=1; AFNElJ/r3Toh8aW3TUX2dSD5/UqIB3ZPgmpvn90CJ8NbulFMJC/pKJEl0Q+zGecrW1wTkQbtGscZgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKQ7R4iuPWtc40E6OyQq9gctZ0gzgSJjr1+EUDsvPQspcV7sG2
	ogaCFBGkH7mvblc23u+kRLYwa/G7N6CVlo4EJj8bTSVeLt+r/IUYF3fAB6fOwyoygiG5IBYefNt
	4QxgsNg==
X-Received: from pfbfr22.prod.google.com ([2002:a05:6a00:8116:b0:82f:4183:2832])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391a:b0:82f:98c:1465
 with SMTP id d2e1a72fcca58-8352d1fef15mr7176108b3a.27.1777869653883; Sun, 03
 May 2026 21:40:53 -0700 (PDT)
Date: Mon,  4 May 2026 04:40:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504044051.3725846-1-kuniyu@google.com>
Subject: [PATCH v2 mptcp] mptcp: Clear mptcp_out_options in mptcp_{syn,synack,established}_options().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Keita Morisaki <kmta1236@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, mptcp@lists.linux.dev, 
	syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported read of uninit-value in mptcp_write_data_fin().

Since the cited commit, struct mptcp_out_options is not cleared
in __tcp_transmit_skb().

Let's clear it in mptcp_{syn,synack,established}_options().

Another option is to move struct mptcp_out_options to struct
tcp_out_options.cleared, but this memset() is not needed for TCP.

[0]:
BUG: KMSAN: uninit-value in mptcp_write_data_fin net/mptcp/options.c:542 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options_dss net/mptcp/options.c:590 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 mptcp_write_data_fin net/mptcp/options.c:542 [inline]
 mptcp_established_options_dss net/mptcp/options.c:590 [inline]
 mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 tcp_established_options+0x312/0xcc0 net/ipv4/tcp_output.c:1192
 __tcp_transmit_skb+0x5dc/0x5fe0 net/ipv4/tcp_output.c:1575
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
 tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
 mptcp_subflow_shutdown+0x164/0x690 net/mptcp/protocol.c:3137
 mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
 __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
 __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
 mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
 inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
 __sock_release net/socket.c:722 [inline]
 sock_close+0xd6/0x2f0 net/socket.c:1514
 __fput+0x60e/0x1010 fs/file_table.c:510
 ____fput+0x25/0x30 fs/file_table.c:538
 task_work_run+0x208/0x2b0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 __do_fast_syscall_32+0x2c7/0x460 arch/x86/entry/syscall_32.c:310
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable opts created at:
 __tcp_transmit_skb+0x4d/0x5fe0 net/ipv4/tcp_output.c:1536
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499

CPU: 1 UID: 0 PID: 5855 Comm: syz.3.4 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026

Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/mptcp/69f44505.050a0220.3cbe47.0008.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Clear the entire struct mptcp_out_options
v1: https://lore.kernel.org/mptcp/20260501061939.1808489-1-kuniyu@google.com/
---
 net/mptcp/options.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..02253c1a9f57 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -403,6 +403,8 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
+	memset(opts, 0, sizeof(*opts));
+
 	/* we will use snd_isn to detect first pkt [re]transmission
 	 * in mptcp_established_options_mp()
 	 */
@@ -846,7 +848,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	bool snd_data_fin;
 	bool ret = false;
 
-	opts->suboptions = 0;
+	memset(opts, 0, sizeof(*opts));
 
 	/* Force later mptcp_write_options(), but do not use any actual
 	 * option space.
@@ -915,6 +917,8 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 
+	memset(opts, 0, sizeof(*opts));
+
 	if (subflow_req->mp_capable) {
 		opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
 		opts->sndr_key = subflow_req->local_key;
-- 
2.54.0.545.g6539524ca2-goog


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A69340283
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885978; cv=none; b=TwPEm8covpQl+s/PcO7oqYMijT/AOR8iCFgFu4pq8ZOQ9EhqJrXI+t+vBz/T+9oy38KHSaMYJNw/+LHrfL6svyX3x0oUF8fb/9f5Xj5DBxg/0Mr1LCHQCBqUUZvQ+yGJXBaJFM9JlteLAEu9gtnVp2toiw3r87UPd5HiGm/ca78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885978; c=relaxed/simple;
	bh=NfyIs4r1RmgrqdAK/dzuhKuMZkiSsrlo5xBa4j5Etxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=do1Xp3Nt8U/I38SLQr2aezgryOAV5uGaDA22fBjA0OUUQZr1Ho+ZXpIImBVcPrUQkBz81cjJLHysvBu4QVpebFMS75YkfnX+f57K/fYo0y8M68dhGqmCsLbedCNI+OtC2Yxr6UXEfI7nsODMkKyR2nuwoGkX9XM6gEsKyUQdmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjqgR4d+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjqgR4d+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777885976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ed8+x5fk2bTgmxIWiyQyKsdsvnSwnGiy1Y7X0I2gcJc=;
	b=ZjqgR4d+6rH5loK+bmCmjirxGzJTNzYJAFtWyt2MIUHc+USJYlu2giPdPgd2ckbP91RQ94
	g5dcs5qgfHz05icYZvpRrqoUGFooEn9Un7Tlb6kTFAHw+QX6nqaK5qDA7cgbVhLSxHVngR
	skfJJ7/1mfjQGHf1p+iS8BU8SIGXmY8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-aU6gpJBtODqm34B-CvUeRg-1; Mon, 04 May 2026 05:12:54 -0400
X-MC-Unique: aU6gpJBtODqm34B-CvUeRg-1
X-Mimecast-MFC-AGG-ID: aU6gpJBtODqm34B-CvUeRg_1777885974
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a5adc141cso19095005e9.0
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 02:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885974; x=1778490774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed8+x5fk2bTgmxIWiyQyKsdsvnSwnGiy1Y7X0I2gcJc=;
        b=rYQE6FXj8yJW3StxV2Odw++IVqzCg9a23VjZgjeLrVGEtEd/VO85dUkQW6ztD/ejjy
         ohIubp1HM+AMVwx17i3jR1bYeOgOv7yURHm0elChRse4PQZtdjeyYy/VR4joscyhXpr2
         aKCvvbODuGydt5Gc1qV6xDlmgRZlkwycO2YVswbqvwLN4jpRdJHHx319PEBQFf6AOFe1
         yKmssXSTsntg2Ugca4uGkiV+qcC0Up9Xq1wWcendLK15fFY5UqGvJPN+3r42g9sV9z3q
         mO2+IzEet0al5ylI4DAWXJj9pU2xXWe0W7BSKd99l1Tdh1RX0Tmg4BDC7vG4/m8/PASV
         55GA==
X-Forwarded-Encrypted: i=1; AFNElJ97T1no2BAxcA//cpcYkrI4FwAXewEDobrUqt+o9t4BfW+YX2ChQZzy1UcEoTWcXiI1fXIh+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxaa2B9vRbRtKJUl993JcAZ/o59w9U4gXzWrLLGHGfM+qcxpZ9G
	bnBvpGL8rymIgPXotnuI/ueS2/VDIW/QyPdEa6e2430nF9efuBA/NsnKRkO8hLXTBnIwQcdccM8
	r4e0jurFafQKRbb4cdsTAcK02Te4cj+uAx/OUKKSo387pAusWHT/OA9/r
X-Gm-Gg: AeBDies0uZgEmq6UENUva9fCieMGtV93rAJDx0pevWT6fA3KZIZ0ykfusYiHkUnImOt
	fSrLED1R4ZWUW5ljsfQGF5p2rwHu07uzN89s5AOuanr/Av+LwkljXh9mFFA0QTadSsTIRz9foLN
	ivloTIF6adQspw20K4H37LerxYy3AA62xdysBOMCTepGbVnuB0KOh8wA3/WUuf/bKGz1fNkt81f
	6EaA4JqXYvtLL6viNN/DUvbYuOwFCS+zufVZx+AT10F3RzWseQflf9VUQu9OrKQad/KADxPsZ3a
	xpBkMoWarmfZG7+Emetu0V5jdrxLCtZv8aaTKarEdu+y82bjo2XjOpZh8sW7FCPJMExpNibXWKi
	aCkLYtEbMdf1VF3lFSv84yYqq+p1E9ZdYehtMO7fj0dSTgkYgrs28Zp2rUWuxZZs6Lw==
X-Received: by 2002:a05:600d:15a:20b0:48a:5ee0:7781 with SMTP id 5b1f17b1804b1-48a8607a721mr183608195e9.16.1777885973615;
        Mon, 04 May 2026 02:12:53 -0700 (PDT)
X-Received: by 2002:a05:600d:15a:20b0:48a:5ee0:7781 with SMTP id 5b1f17b1804b1-48a8607a721mr183607785e9.16.1777885973132;
        Mon, 04 May 2026 02:12:53 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7d0besm24610293f8f.4.2026.05.04.02.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:12:52 -0700 (PDT)
Message-ID: <6d342ef2-d480-4be6-afad-a3841cf205a8@redhat.com>
Date: Mon, 4 May 2026 11:12:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp] mptcp: Clear mptcp_out_options in
 mptcp_{syn,synack,established}_options().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Keita Morisaki <kmta1236@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 mptcp@lists.linux.dev, syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
References: <20260504044051.3725846-1-kuniyu@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260504044051.3725846-1-kuniyu@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bb-uM76i0rtmeuYOAgVJoTq5TVNfMUPJVe4fNE5ICjo_1777885974
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/4/26 6:40 AM, Kuniyuki Iwashima wrote:
> syzbot reported read of uninit-value in mptcp_write_data_fin().
> 
> Since the cited commit, struct mptcp_out_options is not cleared
> in __tcp_transmit_skb().
> 
> Let's clear it in mptcp_{syn,synack,established}_options().
> 
> Another option is to move struct mptcp_out_options to struct
> tcp_out_options.cleared, but this memset() is not needed for TCP.
> 
> [0]:
> BUG: KMSAN: uninit-value in mptcp_write_data_fin net/mptcp/options.c:542 [inline]
> BUG: KMSAN: uninit-value in mptcp_established_options_dss net/mptcp/options.c:590 [inline]
> BUG: KMSAN: uninit-value in mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
>  mptcp_write_data_fin net/mptcp/options.c:542 [inline]
>  mptcp_established_options_dss net/mptcp/options.c:590 [inline]
>  mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
>  tcp_established_options+0x312/0xcc0 net/ipv4/tcp_output.c:1192
>  __tcp_transmit_skb+0x5dc/0x5fe0 net/ipv4/tcp_output.c:1575
>  __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
>  tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
>  mptcp_subflow_shutdown+0x164/0x690 net/mptcp/protocol.c:3137
>  mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
>  __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
>  __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
>  mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
>  inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
>  __sock_release net/socket.c:722 [inline]
>  sock_close+0xd6/0x2f0 net/socket.c:1514
>  __fput+0x60e/0x1010 fs/file_table.c:510
>  ____fput+0x25/0x30 fs/file_table.c:538
>  task_work_run+0x208/0x2b0 kernel/task_work.c:233
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>  exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>  __do_fast_syscall_32+0x2c7/0x460 arch/x86/entry/syscall_32.c:310
>  do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
>  do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> 
> Local variable opts created at:
>  __tcp_transmit_skb+0x4d/0x5fe0 net/ipv4/tcp_output.c:1536
>  __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
> 
> CPU: 1 UID: 0 PID: 5855 Comm: syz.3.4 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> 
> Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
> Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/mptcp/69f44505.050a0220.3cbe47.0008.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Clear the entire struct mptcp_out_options
> v1: https://lore.kernel.org/mptcp/20260501061939.1808489-1-kuniyu@google.com/
> ---
>  net/mptcp/options.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8a1c5698983c..02253c1a9f57 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -403,6 +403,8 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  
> +	memset(opts, 0, sizeof(*opts));

I'm sorry for the latency. I think this is a bit overkill. Back than we
tried to avoid memsetting the whole opts, and it should be doable to
avoid it - at least for most packets.

AFAICS the in the relevant code path, the egress skb has no extensions.
Something alike the following (completely untested) should be sufficient:
---
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f816c26cbd14..63bbac884f18 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -583,6 +583,8 @@ static bool mptcp_established_options_dss(struct
sock *sk, struct sk_buff *skb,
 				map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;

 			opts->ext_copy = *mpext;
+		} else {
+			opts->ext_copy.use_map = 0;
 		}

 		dss_size = map_size;
---

BTW I'm not sure that the sashiko report on V1 is relevant/true/correct:
if such statement would be correct, syzbot would have reported the KMSAN
splat on the bitfield set operation, which happens earlier in the code
path WRT the actual syzbot splat and is hit on every packet.

/P


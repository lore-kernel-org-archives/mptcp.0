Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707E70
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 20:44:46 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id og14so11104457ejc.5
        for <mptcp@lists.linux.dev>; Fri, 04 Jun 2021 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dYQa5q74ycIl2BiINyvO1GPXOoL27aVnZ3Si06LsuTA=;
        b=iyjB7q5pxiVSbHPKiFjD1A1lo2tCFC0PzldxNdGDVOH4m/r5zEjnZmtKV3DuHlElke
         tmkDi7Vn1B9Mu6mK3eq996zwiVq+yYm7cJKRuJ/xOKdoo8hamiWjD5CUrk6tDJtcy6Ec
         DzjF21AtYov6W+pL57980o+9RjBSUy9Zbav2Y9Q71+QkdfHYSDNoJuvtWTZ3KBnNHkSH
         vru7efDwulOS/ttSOmWG8lTeisaahHjx5k1QgaB5LpLImeiKIgwjejxVjTRvyDevC82o
         sb0zQU+RqLUgdbn1Zx+HmOXnRxxLNWJvoacv3CoTTlu4N0xspJbxxrwaGhH9XPJZ+a2k
         RdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYQa5q74ycIl2BiINyvO1GPXOoL27aVnZ3Si06LsuTA=;
        b=YrDD+VIWDQM2Rpu5C85LQKKDHaxz7SEqjNSciSztb/3wVe4CgMRlOsaerjDGIcoDYx
         IDJrCizQzEdN/koVWgQ+J5iUhMYvkE4SbX2VSGBlwgfq44cOn1Cd4qRbTAy/S90uE5+0
         VjJjRtzU6/AEd95+cShS6gDRAljHU9Io66NBzN/FJEpilslcR9gEBQKPy4GgYeiufRLa
         l/+a/B+Mo4Px5+deZPDolEE54P2r3hn5TQwbx9Y7+dN4DvORLNWVmb/KESViCSFZeCXM
         iVLH+RZMt85xL8DwVAsIF2bGg9kp9jJJxvVpXg8QywrE3zSSW8lJjZ4LQ2cfMX6nbZPu
         J/Jw==
X-Gm-Message-State: AOAM530xt0+cz2jwwdrcRh/ehy9zwGF+SwZ08w/F/AiZHjmFKlRVebhr
	YzSAMMBHoe3LKZNdbFw9Oh74Lg==
X-Google-Smtp-Source: ABdhPJzHK/D7WBg9UTeB4usEor+DI4h+u8I9J1Xsz5xdS6CuanQcKM7QD79/Ew+p3ag8BMnWMmOcUA==
X-Received: by 2002:a17:906:b855:: with SMTP id ga21mr6084098ejb.550.1622839485548;
        Fri, 04 Jun 2021 13:44:45 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c047:d46c:d45:3868])
        by smtp.gmail.com with ESMTPSA id oz11sm3269147ejb.16.2021.06.04.13.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 13:44:45 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Maxim Galaganov <max@internet.ru>
References: <392efcf1d0b83807fd888c2a33be75aa54dbb472.1622734919.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v3 mptcp-net] mptcp: fix soft lookup in
 subflow_error_report().
Message-ID: <af941fb3-2c24-1940-0c7e-90a450dac859@tessares.net>
Date: Fri, 4 Jun 2021 22:44:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <392efcf1d0b83807fd888c2a33be75aa54dbb472.1622734919.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 03/06/2021 17:58, Paolo Abeni wrote:
> Maxim reported a soft lookup in subflow_error_report():
> 
>  watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:0]
>  RIP: 0010:native_queued_spin_lock_slowpath
>  RSP: 0018:ffffa859c0003bc0 EFLAGS: 00000202
>  RAX: 0000000000000101 RBX: 0000000000000001 RCX: 0000000000000000
>  RDX: ffff9195c2772d88 RSI: 0000000000000000 RDI: ffff9195c2772d88
>  RBP: ffff9195c2772d00 R08: 00000000000067b0 R09: c6e31da9eb1e44f4
>  R10: ffff9195ef379700 R11: ffff9195edb50710 R12: ffff9195c2772d88
>  R13: ffff9195f500e3d0 R14: ffff9195ef379700 R15: ffff9195ef379700
>  FS:  0000000000000000(0000) GS:ffff91961f400000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000c000407000 CR3: 0000000002988000 CR4: 00000000000006f0
>  Call Trace:
>   <IRQ>
>  _raw_spin_lock_bh
>  subflow_error_report
>  mptcp_subflow_data_available
>  __mptcp_move_skbs_from_subflow
>  mptcp_data_ready
>  tcp_data_queue
>  tcp_rcv_established
>  tcp_v4_do_rcv
>  tcp_v4_rcv
>  ip_protocol_deliver_rcu
>  ip_local_deliver_finish
>  __netif_receive_skb_one_core
>  netif_receive_skb
>  rtl8139_poll 8139too
>  __napi_poll
>  net_rx_action
>  __do_softirq
>  __irq_exit_rcu
>  common_interrupt
>   </IRQ>
> 
> The calling function - mptcp_subflow_data_available() - can be invoked
> from different contexts:
> - plain ssk socket lock
> - ssk socket lock + mptcp_data_lock
> - ssk socket lock + mptcp_data_lock + msk socket lock.
> 
> Since subflow_error_report() tries to acquire the mptcp_data_lock, the
> latter two call chains will cause soft lookup.
> 
> This change addresses the issue moving the error reporting call to
> outer functions, where the held locks list is known and the we can
> acquire only the needed one.
> 
> Reported-by: Maxim Galaganov <max@internet.ru>
> Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/199
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

- 9f1527adae81: mptcp: fix soft lookup in subflow_error_report()
- Results: ff4906881c2f..2049c3fa2e07

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210604T203735
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210604T203735

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0D79E3
	for <mptcp@lists.linux.dev>; Tue,  2 Jan 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sM4+eUTY"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4676dc16009so427194137.2
        for <mptcp@lists.linux.dev>; Tue, 02 Jan 2024 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704188912; x=1704793712; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8BwdK6YAGL0fyC0pzJgp2omqYHIyDz0pIenuqiZfUq8=;
        b=sM4+eUTYRxeo+JoETXKDGmDqocC6dsZoNU+Z3ACk1ocNj3n/6vY9wMjpg9xgbNQlnc
         UoZG8+eRuQ9T0pqnCUyyU4Lzr25wU1qO2mXUNNvL1x83rj2p/WvQI4gV6sY227QsEhq1
         mGQ5VikYNAUwleph89FX3mtGllciqjV4GVggYQDQ6lG1PwdFv8H1QFK5sZHyImk+vVdd
         TNmNjjLDrLdVBn90q5IbnNIeq4cAip2UIM0THyCLaoLiox06UYOkzSQAM5b5m/SF5E9z
         46OUyZh095LfNv3P9d781Dp9tPq5zhTx9e0xxuqws1CztePqgs43SwYdvoLl94P/ghDy
         euBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704188912; x=1704793712;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BwdK6YAGL0fyC0pzJgp2omqYHIyDz0pIenuqiZfUq8=;
        b=cHZftPCa3t5Sz0XaU+lXFRmE3u1PHbujZndO9FhtVKaj7FWD4Rr1W0vLw68Gw7yALc
         wltDmVKDdGnInJdfIlCUwpq710Jp9WhvbhU2bGuInGlZRTOfoGeh5dG5XBeIEdwsdwzi
         R08NgAPH3c2P0dBba9UEP2xC9UHxAvl8cTYWIjmn38Ru98/QGyTS60JBpPqS5a2LaqL9
         rGV+4QwW4ta7QBhuSPIsakIhRK41UMfxNZXEH68S4aLTf4mqYJBEXPHq4jKNerx8/DBu
         Jnk8TUlspADiIBfBJ9hHH/5QUWLIfZE3MitQx5ybMoyUhiKb+ktOaSoPVMD9PZKLny/A
         lTiQ==
X-Gm-Message-State: AOJu0YxR8aZ+Nn4sLGXk3EqXjaGVEDlymGt/xXupVNam4cUprUPGx/FO
	fYYIe0uRrPyvR2mLTQNMo41qaRPcyvmbiqhPKRjh5vd7b1wJuw==
X-Google-Smtp-Source: AGHT+IFqJ3kfP7gJIvjcMWI/WCjonpd/SdBfDjDRDLdxHJDmUEziWZ3Ly+i9RK1H1NCK7B1+eRzjTLt1Q10pf9eZY6k=
X-Received: by 2002:a05:6102:304a:b0:467:920a:c249 with SMTP id
 w10-20020a056102304a00b00467920ac249mr91022vsa.12.1704188912393; Tue, 02 Jan
 2024 01:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Jan 2024 15:18:21 +0530
Message-ID: <CA+G9fYvu_estw19VvZDXVXGmuXg87FZHk3x7ZNLM-KTGOmXRLQ@mail.gmail.com>
Subject: selftests: net/mptcp: mptcp_connect.sh - Internal error: Oops:
 qdisc_block_add_dev (net/sched/sch_api.c:1191)
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Linux Regressions <regressions@lists.linux.dev>, 
	lkft-triage@lists.linaro.org
Cc: Victor Nogueira <victor@mojatatu.com>, "David S. Miller" <davem@davemloft.net>, 
	Hangyu Hua <hbh25y@gmail.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Following kernel oops noticed on qemu-arm64 while running
selftests: net/mptcp: mptcp_connect.sh test cases on Linux next-20240102

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
---
# selftests: net/mptcp: mptcp_connect.sh
# INFO: set ns3-6593b550-fBKovo dev ns3eth2: ethtool -K  gso off
# INFO: set ns4-6593b550-fBKovo dev ns4eth3: ethtool -K  gro off
# Created /tmp/tmp.vFrp4xubYR (size 219663 /tmp/tmp.vFrp4xubYR)
containing data sent by client
# Created /tmp/tmp.FrEUtOwsBN (size 5630063 /tmp/tmp.FrEUtOwsBN)
containing data sent by server
# New MPTCP socket can be blocked via sysctl [ OK ]
# INFO: validating network environment with pings
<6>[   32.891365] netem: version 1.3
<1>[   32.901072] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
<1>[   32.901926] Mem abort info:
<1>[   32.903342]   ESR = 0x0000000086000004
<1>[   32.903768]   EC = 0x21: IABT (current EL), IL = 32 bits
<1>[   32.904589]   SET = 0, FnV = 0
<1>[   32.905415]   EA = 0, S1PTW = 0
<1>[   32.905914]   FSC = 0x04: level 0 translation fault
<1>[   32.909254] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000103097000
<1>[   32.909914] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
<0>[   32.913724] Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
<4>[   32.914739] Modules linked in: sch_netem crct10dif_ce sm3_ce sm3
sha3_ce sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables
x_tables
<4>[   32.916764] CPU: 0 PID: 438 Comm: tc Not tainted
6.7.0-rc8-next-20240102 #1
<4>[   32.917555] Hardware name: linux,dummy-virt (DT)
<4>[   32.918608] pstate: 63400809 (nZCv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=-c)
<4>[   32.919392] pc : 0x0
<4>[ 32.920396] lr : qdisc_block_add_dev (net/sched/sch_api.c:1191)

<trim>

<4>[   32.931258] Call trace:
<4>[   32.932088]  0x0
<4>[ 32.932626] qdisc_create (net/sched/sch_api.c:1390)
<4>[ 32.933207] tc_modify_qdisc (net/sched/sch_api.c:1792)
<4>[ 32.933791] rtnetlink_rcv_msg (net/core/rtnetlink.c:6615)
<4>[ 32.934280] netlink_rcv_skb (net/netlink/af_netlink.c:2544)
<4>[ 32.934859] rtnetlink_rcv (net/core/rtnetlink.c:6634)
<4>[ 32.935411] netlink_unicast (net/netlink/af_netlink.c:0
net/netlink/af_netlink.c:1367)
<4>[ 32.935981] netlink_sendmsg (net/netlink/af_netlink.c:1908)
<4>[ 32.936544] ____sys_sendmsg (net/socket.c:733 net/socket.c:745
net/socket.c:2582)
<4>[ 32.937121] __sys_sendmsg (net/socket.c:2638 net/socket.c:2665)
<4>[ 32.937677] __arm64_sys_sendmsg (net/socket.c:2672)
<4>[ 32.938283] invoke_syscall (arch/arm64/kernel/syscall.c:0
arch/arm64/kernel/syscall.c:51)
<4>[ 32.938852] el0_svc_common (include/linux/thread_info.h:127
arch/arm64/kernel/syscall.c:144)
<4>[ 32.939395] do_el0_svc (arch/arm64/kernel/syscall.c:156)
<4>[ 32.939913] el0_svc (arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
<4>[ 32.940388] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
<4>[ 32.940968] el0t_64_sync (arch/arm64/kernel/entry.S:595)

<trim>

<4>[   32.943570] ---[ end trace 0000000000000000 ]---
# ./mptcp_connect.sh: line 856:   438 Segmentation fault      tc -net
"$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay
${tc_delay}ms
# INFO: Using loss of 0.84% delay 16 ms reorder 99% 26% with delay 4ms
on ns3eth4

Steps to reproduce:
---
https://storage.tuxsuite.com/public/linaro/lkft/tests/2aO5JSOqobe3WwSEQP81LncHQ7c/tuxrun_reproducer.sh

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240102/testrun/21857563/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240102/testrun/21857563/suite/log-parser-test/test/check-kernel-oops/log


--
Linaro LKFT
https://lkft.linaro.org

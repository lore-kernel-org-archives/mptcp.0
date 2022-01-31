Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76292C9E
	for <mptcp@lists.linux.dev>; Mon, 31 Jan 2022 09:04:10 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id s5so40786265ejx.2
        for <mptcp@lists.linux.dev>; Mon, 31 Jan 2022 01:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=kPULZygv5D2jzNg83Fpnd2ERkN0qdncN+Wk7aAMOsv4=;
        b=LLggaHTWbbcxEznYN6NhaPSn5iygCL1kD3cv8f/c0QgjkLJ4muRKrlzXZ7e7P21lOG
         5ml/2ZssQE6HK2hFeONinfq3tn2QaVB0QWVQw9pYFm9N8IYgpNecpkkp4yg8ml0EME3A
         euregou2VG28MvAOZsny1DrVm2Mrs8Ww2DKSw2t02hypOhZiyazBLinw8L0n2Mapved/
         eV/Lm7yQN42tkz+N0nL0/BGLhsIrNOVgSI+2pyK6vSKsFmNIOCKkH4okw5BHqB489wrW
         Ybz+vw6zH33ySZyV3YUpcOoryURnzypJFnRrn0vyD9DJ27z/5vu9LPsCDUvsvERtk26q
         a4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=kPULZygv5D2jzNg83Fpnd2ERkN0qdncN+Wk7aAMOsv4=;
        b=EdhpDeNcm6QBpyZ9yJpUXb3yHBJvdIZuxg3cQd5zEUOvXzgc0GJFKSSCzuh49RIrKs
         dIcRiRMjKtxkx1nSrZsYH/tIUmnAFd4O8zpOv+SFwn1QYZmrh53QK9ypr8Mbph3bBlHn
         2LMU+LswM+MFSsvooFdzZ66ZQCmOo1R5G1Y9KMFh6Fbt4Atm/AdsKme1Nmn5H8F3+6aY
         Gags4PGSeWP6tmWfkpIkPU8amNg1etnAuwoXVOLKIq23zb5urFINjJsLwhto3XECTwCY
         FgwgW1+kWnQZkaTdeH14i64CQggEmhTT+enaciuhnZYSRqY2GcIEUUaWzkQsTlT5Yuam
         q3vA==
X-Gm-Message-State: AOAM5332MhTKN+QMwSzAnc7uRcVZujlLnhR+SsWxsc0MEB861X0LgIfj
	0XyWF3KvO/qwL+QMAajsEYNeK8LcPlZ/qw==
X-Google-Smtp-Source: ABdhPJwU8FYUqr+i9CSE6hadcGDygE4tjRKXC3RnM0PmPrboIb/HdgwWSh0uR27fEvNvMbs7ad052w==
X-Received: by 2002:a17:906:5d0f:: with SMTP id g15mr16550848ejt.751.1643619848193;
        Mon, 31 Jan 2022 01:04:08 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:daf0:2a8c:b440:96c5? ([2a02:578:8593:1200:daf0:2a8c:b440:96c5])
        by smtp.gmail.com with ESMTPSA id kq16sm13068524ejb.163.2022.01.31.01.04.07
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 01:04:07 -0800 (PST)
Message-ID: <90560547-a3dc-82ae-8322-65f17f5b11f7@tessares.net>
Date: Mon, 31 Jan 2022 10:04:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Recent backport proposals from the stable team
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Recently, Sasha from the stable team queued a few MPTCP patches for
v5.16 and v5.15.

You can find the complete list there:

-
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.16
-
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.15


Some patches are fixes with a "Fixes" tag and it makes sense to have
them backported.


Some are "clean up" patches without a "Fixes" tag. I guess they have
been selected to reduce the difference with Linus' tree and ease
backports. e.g.:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.16/mptcp-clean-up-harmless-false-expressions.patch

In this case, this patch is needed to avoid conflicts with another
patch: "mptcp: keep track of local endpoint still available for each
msk", see below.


But there are also new features, e.g.:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.16/mptcp-allow-changing-the-backup-bit-by-endpoint-id.patch

I don't know why it has been selected but I don't think this is an issue
to have this backported, does it?


The last one is a fix but slightly changing the behaviour:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.16/mptcp-keep-track-of-local-endpoint-still-available-f.patch

I think it is good to have this fix even if I'm surprised it has been
selected. Do you have any objection with that?


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

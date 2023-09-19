Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BB7341AD
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:45:16 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-79329a8f78bso201536139f.3
        for <mptcp@lists.linux.dev>; Mon, 18 Sep 2023 21:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695098715; x=1695703515; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cJCtF+0LbvOjUyaPfLiQhY5TK4oVMXnw2tgjL3zm1Y=;
        b=VU2PQYcuAOyuLvsu9dS1PWz4/acOZ7WQUAKN+vJ81t2yreTVUss+KbBfgDWLdH6cCw
         Xp/sPR9g6pMq2D5BE4bFQl03wHp3y8D4dIuT+2PFwpD+0etfsm0xNd31wpduGLaej/zp
         e7CRqDhfkUijGIM6CBEYJJE+vtA3HkiPXDGuVJRwzl7qQw84H8iRzjgytQ1cTW0zDx8j
         p9tkwhBS2MAcl+xjLFltI7ffRp4wcfzWeKZg4/zM/zMyB9h+SAFOvgq0dZFeau9M/rDh
         FlH3xiPs0EvMZ0xTytMSEggGXCwBPwAVgK3wQVcLRI5YemdfFaSQQsDGHG3V+lEqefAL
         mk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695098715; x=1695703515;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cJCtF+0LbvOjUyaPfLiQhY5TK4oVMXnw2tgjL3zm1Y=;
        b=wNsO+540psxaKC9dIk0YiuzneLKat7EwcyM7TbHw2uzzP45minRMXaIlyHt1XHh84b
         9P9UeEXDXHpiaaGPoH+5Ko2fDrWwRB5yEPIHvut9a06CusHQNtboKSfllI50OUxJz3Fk
         3Ai8fpcvgV3Hf31DsJ6UYabIxSmn3QuzblaKn+HOYkc0u68tthxyICdLeZDDzGWJ72So
         bGqHa+OMmnRSFRKs8GfIv8kbSO8lEqySB4Zq/dFVj2Bi1UAjtbZyO+ZVa2riikih3LSH
         VGCGZLlnPD3xk9r123U9uPb6a/UY/0cBFzQxSg9MCtaO6+dEJK1L914MC3466/8EAHtn
         Y1Tw==
X-Gm-Message-State: AOJu0Ywh5OgWB/heXQTD3jvjYHvey8F/QNTesxYq57nhcLJ4dNiY2Xjx
	w8YnGNSrGw7kf5Uhomgh2w==
X-Google-Smtp-Source: AGHT+IFjHLQOg+54kNJuJq1rAVDnwnm4KW1TbOtyszKKJoPky/xlnSGDf4MNQxBSbt1z4PZm/WASjg==
X-Received: by 2002:a5d:9c46:0:b0:792:82f8:7402 with SMTP id 6-20020a5d9c46000000b0079282f87402mr11906143iof.16.1695098715470;
        Mon, 18 Sep 2023 21:45:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.122.243.91])
        by smtp.gmail.com with ESMTPSA id f21-20020a6b5115000000b007951e14b951sm3302272iob.25.2023.09.18.21.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 21:45:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <32a7f528dfd2ccb083f99dcec9ad8b3ba9717686.1695095289.git.geliang.tang@suse.com>
References:
 <32a7f528dfd2ccb083f99dcec9ad8b3ba9717686.1695095289.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_lib_wait_local_port_listen: Build
 Failure
Message-ID: <d9d64dbf-675e-1582-94e7-b2a74b8d585d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2023 04:45:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/32a7f528dfd2ccb083f99dcec9ad8b3ba9717686.1695095289=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/6231100070

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/39f55eef61=
1a

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6123847A
	for <mptcp@lists.linux.dev>; Wed,  1 Mar 2023 18:15:42 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id nv15so9881512qvb.7
        for <mptcp@lists.linux.dev>; Wed, 01 Mar 2023 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677694541;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQBTJWm2qmBJvNPeL9A+7Up1fFa3PZLHExlDuBy+Wv0=;
        b=qv2i/oyq1eXBIRIyhlfdm/UuPiTpmwD29P45Wy0LlidcH9gkpn4EVG8JlgEHBRl3S1
         82LEPzxFKRuGT13WqbdH5DnXxu/rWHO+ETX25ETnYsso8JSU+qlXVZuT7SVdIPHyarwA
         cQZgr/Hk1eeOlr2F08VJjP//2xCTzIvNzOPtGFFNClJIJHDGNfkobeamnBnzOw/ai7w9
         nGrIUCG6JrjBK9KOmOGFs5bCg19N/80LInGLSk/GBE6QphV2U3+3rZjRi4aagt/EtbJP
         8kewfKaR1zhXfOjj3D/CIygs4Y8MasV1h4LDtQlm3LCZ8LiznlLz1c+xQ/FDYaQKIdsp
         ZMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677694541;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQBTJWm2qmBJvNPeL9A+7Up1fFa3PZLHExlDuBy+Wv0=;
        b=h9z7J5N8Fb2FRbeSjRnlEobvcptQMrobes3eWwi/RM/msKiz45lgKw40I+mXI9Ix55
         Yi6uCOLs37bwAo9rdeDubFjgNLHO8zlsKQta9vhe56DS/Rls4H5GQr8dW0YjWurL2tTv
         fp8yRzmAFyMcBwqj+GV539PNPH/Y/4zEWnZXeGQ1veLGfXtTYJUIjaKa1WQruatewAyG
         DDIpB+8qANK9BF0tqusR4Cb6s2yf9M7VexHcNU3hrD6R/t+lkifJG6HqrMKftLdvyL4w
         APwyt4SM9TMFViec1AtAGgKj40vdgQEMLUlA9/1FV0PxZ8W9G68x+mqFit919d3pZb5k
         1dkw==
X-Gm-Message-State: AO0yUKV9ldflHZmarvP2jhD11kuHENWDLCPlZ44aq+72LjaP/yDb91sv
	I6vpf5lKZlqHECwsxcPiFbAPfJbF43fC
X-Google-Smtp-Source: AK7set/tIeGDACgPHGb8H5K4ugzLMsLSytqkZl8ZxlopkxP79IcwzshoNV99zCQCfPrJ5V/SAfv59w==
X-Received: by 2002:a05:6214:2268:b0:56e:b7a7:40da with SMTP id gs8-20020a056214226800b0056eb7a740damr15413126qvb.12.1677694541534;
        Wed, 01 Mar 2023 10:15:41 -0800 (PST)
Received: from [127.0.0.1] ([172.176.229.21])
        by smtp.gmail.com with ESMTPSA id o3-20020a375a03000000b0073b7f2a0bcbsm9255788qkb.36.2023.03.01.10.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:15:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
References:
 <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible memory leak on syn_recv race: Build
 Failure
Message-ID: <2bffe27c-fec7-a0c4-c002-c21a4753a94a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Mar 2023 18:15:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/4306566553

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6b3b8fa6b0=
68

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

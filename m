Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9AB2F4A
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 12:36:10 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso799123otb.12
        for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679661370;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm1srzXxMBOCuOsJdyGyTRiv6Is7mON5Ek+0opy8jDU=;
        b=efsH7dAHpYiqkzo3D5zJWXaXERvpeYj2FqKYQHEcDncZZzSP8v84sq8GCIhKey3mGa
         HGHxHC4SYcdYoOhia0kF0sqZPB/zH6LMel1ihQxEw5yfAeQjFQn0PgCnWmqVaSa2HYAd
         Nn4P2rD5NyJ0JAubhr3xOwm1wKU4JgUVmCwPvhc7OSyuWghUtTsy2HuvvSN7syx1bg38
         1tmx2nDtvNf3b7UddK6LIqTg5b4eLLlSSDgzsZBuF7XjAJiFE6J8AxNwGEGh+PAJsxYA
         MdUayKQeZYS0w0DTIF3/Ny0EvPefu9KPlNJ17KleJhXIpKnxdu+jeclPcWUemTtqm1Xf
         x6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679661370;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wm1srzXxMBOCuOsJdyGyTRiv6Is7mON5Ek+0opy8jDU=;
        b=MugV1iqhNYcQtRbIQiO8ogY3073ePZ/hZBFuuRGmT7QToaOjpvtd/wjRMzI68SPKAq
         h2A9j+CnmvfgdX29sHUo60n/rM+w8N36FMPoQERyXarHPkC8dpoCBfMrfzAVyDl0Nhrv
         WcSRoQUIFlu2A/4seB+pRKp+rinORUR8mwq4GlBZ5OOtk7G5VqVIZ1PzGjgzFeFk2PgS
         8+iY/jR7Fg9/nR/x/AXi0wVDXeKCjtWuDXuSPPveZ5qizhhKfwQwo/hMpc9VtjaDaJSg
         1vmVBrDVeTF1MTP32DhplW/7ZqpT1T3kag/8zVyzKEhsNVGsBnCjRhXP/4TpREWS7dAt
         StNA==
X-Gm-Message-State: AO0yUKXLllkszYp51X+fGf+eedGMIsWWP+jWzzHA90C4gmPj1UVepuR8
	Btfs2qqsItgP5vBWRZ47rw==
X-Google-Smtp-Source: AK7set8QH/6TNKdRfdSS2BcSJn5kqYfdgtFF4X7HjNAL6tumoUMQ9NWT2FrYDNsgs5azA01nYtNBOw==
X-Received: by 2002:a9d:6211:0:b0:6a0:4857:e119 with SMTP id g17-20020a9d6211000000b006a04857e119mr1029971otj.0.1679661369945;
        Fri, 24 Mar 2023 05:36:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.185.204.71])
        by smtp.gmail.com with ESMTPSA id l11-20020a056830154b00b0068bc476d777sm8645569otp.13.2023.03.24.05.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 05:36:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
References:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
Subject: Re: mptcp: stricter state check in mptcp_worker: Build Failure
Message-ID: <82c1169f-c2d3-c0c0-9dc1-29aeed0f5760@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2023 12:36:09 +0000
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
org/project/mptcp/patch/10b158069455d831d9efc547bcdb3a6379234f1c.1679654040=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/4511130601

Status: failure
Initiator: matttbe
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/d79b0ae2a9=
66

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776281E507
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 23:20:06 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1bb575a6ed3so298095fac.2
        for <mptcp@lists.linux.dev>; Wed, 09 Aug 2023 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623205; x=1692228005;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLMKj5BHKFAcV7v3K/OnIMsb3majAhtJmnf2EsWanVs=;
        b=hn11Eo6DBS+EjXbFvGesdQsNMEZOu1WRHaJUmaA+mpCgNmZVhA2FejLy4eM6e4zo0t
         YnrmWK6lhpYizqMjpwygw78A3ChOD9+4ID1aj7Dwtsa8ZH63UXy4qvBLSokgGvPa9wXE
         A3MHqtvGsPLrdwAoHabLxhtM+6nmEwYNCMHvihNszZwwI4lhvNqIFTxPz+QlbDx93JHe
         1kvPqlh6N/FuXyuaVCgFAdzrjRcxD54+602QQu/3a9Al0uWpuCInOehhZJGRAZkX+oaR
         FFPFSJzcz8g99TtoAM/H002+otMHPlE/fCJOWL/ZqpHhd2BGyKwiXCTWXsnbCc4wsRgV
         sSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623205; x=1692228005;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLMKj5BHKFAcV7v3K/OnIMsb3majAhtJmnf2EsWanVs=;
        b=EskGnsRU8erR7ycTl+pHMh8F3C4x+tJVdJbRCLG0tMLmd085uG126Pk+OZC8I/+656
         QIZvWCOWpcnYPEx1tji7ScPBO+wU2vpMu+dgafZQtTzHzX6dSw2c1MMzvV80g9Dm5anh
         lGMCkgO5BuvNRqI5/guOJibl/KlSN15WvWHRs10FUCQlgKAukf9t8qmtfcqb42NPCcbZ
         4W8TcDa0TiVm7ZfQjerwb7qNrjK84ZsnEaCZ7IciiZLxRMKE9iTfvnTbuPvzJUltpfoP
         iFm4nEJKcdRzfBH27k+vWPcVe93IT5ilm53Gl8lG+6f5PyafT5u64iqhdwvLKSp80pCi
         r5fg==
X-Gm-Message-State: AOJu0YwMqdtLNx5tGVzTxGRiSaGStHjpKZLCZlKnPI8qoBBVX9yUHSU+
	OHIo02GxBIsmGNBaqpkKPQ==
X-Google-Smtp-Source: AGHT+IEfs7z3/hEiIXoG9tCpb5qir7f8cCjiyujnbFI6By83xCZR8KICAEUT2HNv1xjIjXsRG979EQ==
X-Received: by 2002:a05:6870:e3c9:b0:1bb:6cca:3468 with SMTP id y9-20020a056870e3c900b001bb6cca3468mr821526oad.47.1691623205353;
        Wed, 09 Aug 2023 16:20:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.173.225])
        by smtp.gmail.com with ESMTPSA id y17-20020a056870381100b001bb919237cesm159811oal.3.2023.08.09.16.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:20:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230809225918.21523-1-kuniyu@amazon.com>
References: <20230809225918.21523-1-kuniyu@amazon.com>
Subject: Re: mptcp: Remove unnecessary test for __mptcp_init_sock().: Build
 Failure
Message-ID: <eec230ed-7af2-c055-5c6e-9c70ff454188@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Aug 2023 23:20:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20230809225918.21523-1-kuniyu@amazon.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5815022877

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e7b0047cdbb4

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

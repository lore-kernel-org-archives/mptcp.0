Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3419503
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 10:01:11 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-75d461fde66so341179785a.1
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686564070; x=1689156070;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3KulueSXclzt064uBVRBFKxmZvdGtwhPgqCIRt6lng=;
        b=UrAmdCgdaC4ZrM1j63YgDHvHVmlWqBg4TwDzcVgapIINe6gu7mKhZoA6ZtY99NIGnD
         0KIUy1mexC/uyl7GF9R++zbP40ixD1F3cu0T/AP6Vk5Ed0vgdEuQpGdAdT6vLdKoi+EZ
         RQtHSB21FMeuOcmCm0s8gSy7+7tpSch4wKbN3+P7igrZYm/UQSkYmEul1g3Oal8Buvnm
         HOfAfNTrorMy8qRoAbC88WtuHBOKpgi3K/WDG9jr/CY8SyPrW6RHDw2ojL6Fzio9PSDM
         OyZqG0BZIYBBVfY3sSh0N3Hsfn3tnzYhz3I3H6c/2gUzm6HhMKtFNBLMgdaTnP0XGN2d
         mhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564070; x=1689156070;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e3KulueSXclzt064uBVRBFKxmZvdGtwhPgqCIRt6lng=;
        b=J4N0OtQidS7bt6XBC5c+nF1hjNGg3uvyPkjTWr1BOaqc5q7+R0GXISMGnocrFjzV6C
         PZxr8J9Hk61+VMKFq7XVGqJExSJArP19C/ktAbsgXD9x4ROmqds8kAMSK987qiv9oSHV
         jgIEWFcwxyv8CvvrszzIiEI0/bDW4jLh8+u5gnLvR2+TfuvpmCcwn0YtcA1ZNvFFN9cw
         ULqO4aseUayl8SelDTuQcMzmkd8kMtkYDRRxxn6r/kNxKww2bIQ6m/qfS35f+rtkaNAT
         majtuGR2s1FUD96UdxjeyR1PvjIqMNxZX+agjV3+wV4FA5ibgrzN7Qp1EhObmYYyufSB
         iNUg==
X-Gm-Message-State: AC+VfDzs78KW39CKg6ca3Jp6L/1+ZcMj7mT8K6E5phS5Gk/OJalDi/3L
	yCPwyafuWhPiSKXrf0QqRA==
X-Google-Smtp-Source: ACHHUZ4KDLas6lNxNrtZNJ4L5NaircqKRhaf9OlFom7axb3QZqZV3izRQoHIjOdi7ehKX9tKPmq6Nw==
X-Received: by 2002:a05:620a:6749:b0:75b:23a0:e7ad with SMTP id rq9-20020a05620a674900b0075b23a0e7admr8179282qkn.14.1686564070179;
        Mon, 12 Jun 2023 03:01:10 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.202.169])
        by smtp.gmail.com with ESMTPSA id n13-20020a05620a152d00b0075932cd3ca0sm2758785qkk.69.2023.06.12.03.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:01:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d94672114f94dc029fdb4a721d54c200521e180d.1686562577.git.dcaratti@redhat.com>
References:
 <d94672114f94dc029fdb4a721d54c200521e180d.1686562577.git.dcaratti@redhat.com>
Subject: Re: mptcp: convert netlink from small_ops to ops: Build Failure
Message-ID: <5da7b880-3501-f3fb-7559-02779d4f6a04@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 10:01:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/d94672114f94dc029fdb4a721d54c200521e180d.1686562577=
.git.dcaratti@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/5242115507

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7c8f791a2d=
25

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

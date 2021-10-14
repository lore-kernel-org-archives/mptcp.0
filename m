Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440172C80
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 17:03:20 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id k23-20020a17090a591700b001976d2db364so5243639pji.2
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=o7yvna6GDa7or+3iWwlJ4A1q93X5Fa1reOh9ICEp/4c=;
        b=ZNf3KFy0CLZEHjkuQGZcCX+DUNRQQ5xemjIQgfgRzT79YKt0XVbP0fB9+obUWjRSuf
         /5/kZ4HXp0n3vBC4D9hI3i0A4ZYR103oKL87Gd+26J4BMy8cQPS6daP5Fr4ly2AjovFj
         9iFV6kd+HHemyGRw3WH3pCXl0ZyjJS+KzNet7HLHQHcfDdR1CmGF3pUqDl57eMLllsAx
         qlssa1Yur//aZrMtMZY0SJJPa9wsS/qMSbjWZHyyNzDDQoDk9PMWF3ni2t55GgAuVlwe
         RzR+a0onOFlbjP4b01SB8ttT7yTVa+k7N+AQ/Grya5KhGWdU2FDe/6vreJWMoMWI6mY+
         Fd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=o7yvna6GDa7or+3iWwlJ4A1q93X5Fa1reOh9ICEp/4c=;
        b=v+UholebFsvIGMREFi7tR3eemrGt9nzcLXK4It8I/8olFSqsdcfsfxXBRF2Ci0c/Zr
         T+n9aN9hCUg/ntjfM28m9Mux6e+IuWaTMRDNGPKSIXnNkizxVRscJCsk/bIDp17D8MD+
         Y7xQ0Ikgaf9hDXgqT0ZO5Vgl1K7J24t5Dt9pPfrxvIlZgpu4VIjQAaO//9yDbsteglxb
         BtNxIW6FYA4BEwK6SVfwrPwTcfaPZ5mq5vBrit4RGLSZVX+qxuXy1AANN/YD+X0q9rBh
         EKMtPqfH36z2BmwDisYdTSXrwmi02lMSfEjVDJ3flmsnveND8onCAicKw+zHpE4Uwn2d
         NtVQ==
X-Gm-Message-State: AOAM531eHS7Jqb4fdENGo0Ubu+EjlhRGvbupd4chzjL5n0XvTXKCam8u
	cu9buBNA8Nla7lYZY8Vh14vYuOiaFnIt
X-Google-Smtp-Source: ABdhPJyk7pZocCxSRQHWUGaQG5E6LYXiCj3EmBz2YQOuoOFPWlb/TjRTbL2n6gCrEZdC2EUIaKy/MQ==
X-Received: by 2002:a17:90a:fb4a:: with SMTP id iq10mr7318972pjb.117.1634230999740;
        Thu, 14 Oct 2021 10:03:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.77.158.135])
        by smtp.gmail.com with ESMTPSA id r130sm2944790pfc.89.2021.10.14.10.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:03:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.pabeni@redhat.com>
References:
 <cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.pabeni@redhat.com>
Subject: Re: mptcp: allocate fwd memory separatelly on the rx and tx path:
 Build Failure
Message-ID: <f499b07d-2d73-ddec-860e-1cdff112fa85@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Oct 2021 17:03:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo Abeni,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/1342749505

Status: failure
Initiator: matttbe
Ref: patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com
Commits: https://github.com/multipath-tcp/mptcp_net-next/=
commits/patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com
Tree: https://github.com/multipath-tcp/mptcp_net-next/tre=
e/patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot

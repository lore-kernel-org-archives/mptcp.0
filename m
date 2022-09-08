Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09633C6
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 14:10:10 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id h22so12939520qtu.2
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=xRPrTnZI6QLZwDzrLXtaTjlntHsImKWMFSKq/UQh1XQ=;
        b=Oc2cLFiZw4lmqWnefUUFr24kx5DEM+8HxRu3v739V/K6KBZku3gVSTGaQVHup+EQto
         ncLWgQZxOnSQ7VVIh/RLbVIL28ubDyIzA3iToeIcLVm4N4j5H4vhds18E+xOjyisRMM3
         E//J0WB9D+H/7RpbSgITi/keTNHl1Oe24ILmDSAWp5wzeaUw41gKZXLT/O14sI0oecF9
         GGKjkGEnMeDCKxebRe4OBlUUNW+ATLexFguTMWFjMb4WH+hs8xYSQo9zFbEMPq4HL+fX
         Ge5PKIvzxg28N27Q6UF8evHFuagjPQdqFVAXw0Xqv32hxNRFiiZulOQ+iKSSsFmLHHSH
         B8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=xRPrTnZI6QLZwDzrLXtaTjlntHsImKWMFSKq/UQh1XQ=;
        b=HD5D+v0ZYwxy8ysFZYub8IEHENgovFBmlx+BVO3oSwEk8pUgiYuJ8jPNB3NGi1ZdZf
         JfzODTfgLGHhTVQD5+vUsSoCrhb2Dl4SBIcD925UueHAk1i4gqmWrUi/ceGDUb4Q3lVR
         vDGAtGw0avt+fxXCPEYiQS5A8CQaGW9zgOSvsXYEm7S6m9GoBvgTdyNBcSo4yn4+O6Ug
         D9uBv1pA6WNmiVWCULRq1Vepmjq8Q2COXPLlXb8HxHlZC77qxgmMCtNPFvAcbw/2lJl8
         DwHW4QrKE/7v6v91Tsfzy+WGww9pugvOIijAlQmRt8MUI4CGtNqUdEyEYbq38YMIoUFd
         SrhA==
X-Gm-Message-State: ACgBeo2ubE7k+3yWXSQJ3HODRMwjlhRGtiDmkKX7O/srozlhitcQ6tHs
	fSySuOGiuHoYy5AJ24aHJw==
X-Google-Smtp-Source: AA6agR7t1IfQccxqU/c+PPkC2xD+CyTIyfCksASk1JFP8vTSVYy3prHoIFbT1bMYFVWGJ70J5/D1/A==
X-Received: by 2002:ac8:4611:0:b0:342:faf6:351b with SMTP id p17-20020ac84611000000b00342faf6351bmr7930230qtn.343.1662646209056;
        Thu, 08 Sep 2022 07:10:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.152.236.244])
        by smtp.gmail.com with ESMTPSA id d22-20020ac851d6000000b0031bf484079esm13999280qtn.18.2022.09.08.07.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:10:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220908133829.3410092-11-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-11-benjamin.hesmans@tessares.net>
Subject: Re: mptcp: test TFO: Build Failure
Message-ID: <c0d54b09-ae1a-03dd-908e-b7afb82eda33@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Sep 2022 14:10:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Benjamin,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220908133829.3410092-11-benjamin.hesmans@tessares=
.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/301561=
0232

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/64da39cf5e0a

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

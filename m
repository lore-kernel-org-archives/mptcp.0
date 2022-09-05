Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19123AA
	for <mptcp@lists.linux.dev>; Mon,  5 Sep 2022 05:24:27 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id p187so6096625iod.8
        for <mptcp@lists.linux.dev>; Sun, 04 Sep 2022 22:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=tY2F4UOdQDaNj3VP90CEL+vsIrrBXVM9ELPb821oLFk=;
        b=etSd6aQRS2MhAvHqtFuDfkmJ205Hxji9gQ+G6YB6LoCunFukZvVZq/0SlkxxqmBa9B
         P1WG6Nno5Q3odNiaq70rfllvyfP4p1obE1scad7pgWgjOLQ/ugfSIDG/kpAFl2uQ6hUX
         l5wnll1L8IuR0bn2tkN+hEr6Dmrk1Z9TVG7BetOCoDhUwAZVx2NWUxNsJhHmiS13BhXl
         Vwuhkgi1XZBju3VD7L43KcUGm+/YWQUHaXAd4uTertbeZF03S9IbCcVQdK02PM8wk6So
         Un6tqON1KboFHO6UliWMB+06huco4OXo76iNXaPMcAfpLsSMWLb3zLVOc1YzV1iAC9gl
         B15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=tY2F4UOdQDaNj3VP90CEL+vsIrrBXVM9ELPb821oLFk=;
        b=PJ2GIQSTFENUbu5PaqtuUCj2TFCdLGS4DAMuAVrYsuv5NBVmCYj+ME4u04jcmBjMzb
         0wQt8ybwmgtbpBqZ9lAvRc1qkIIt0DhP0Q388GkS+ZMZWn6TBFYzBW0saWbQg7EN7dWT
         hz40/jZ/Hpyi/mrPZepoMg4Jl1b/iK2cRH8tUY7/zja7EMwtnbL2UYJKVqPwikXOPOqn
         NhbKDViaFn8LZ/QCkx1E7CBBpSiVhPhHPcM7PoGSLq9KsPLAFrs2AYBFHan5+EoAt+aM
         aAtqQXPDFcG6qVJrUk68eaJKEsvDWCEG5Dzzkz/fhfOJp2raG61ZSO8ftzVCsq29Viy2
         63/Q==
X-Gm-Message-State: ACgBeo2jiuUzIChjBF0Foz9hBF8dMHD0s3y/AGqRpTvbUBX+/q+ox7gm
	T3UKftxajDaeJJ4dH2qOpw==
X-Google-Smtp-Source: AA6agR7PchBCNzsYfhFUy9QHbu+uwTlB1Su3jKnEBizH+w0Pw7e+3uWBqicp0LuneNafsFty/k5rMw==
X-Received: by 2002:a05:6638:480a:b0:346:a98b:1764 with SMTP id cp10-20020a056638480a00b00346a98b1764mr25555816jab.108.1662355466379;
        Sun, 04 Sep 2022 22:24:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.67.25])
        by smtp.gmail.com with ESMTPSA id e43-20020a02862e000000b0034a6d12aa25sm3750149jai.4.2022.09.04.22.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 22:24:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220905050400.1136241-1-imagedong@tencent.com>
References: <20220905050400.1136241-1-imagedong@tencent.com>
Subject: Re: net: mptcp: fix unreleased socket in accept queue: Build
 Failure
Message-ID: <1bf50475-3fbc-4ff6-c63a-d97dbb085025@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Sep 2022 05:24:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220905050400.1136241-1-imagedong@tencent.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2990914235

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/447ae1cfe0f8

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

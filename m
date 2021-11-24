Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19E2C80
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 23:01:51 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id d2so5869913qki.12
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 15:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=DZ5/4jYstvd3d7pNzJRhxiIaflhRKyL23nZ7V33IOto=;
        b=RFpiq07lJojv9zt40AakZyMn0JoPr3DSxvcLepmLfRPitzuJ592GEiJiOc973AOVsY
         tiFPM0RtHL3DCbHigGV/RiXXInkeXaS/0qCqhSwKE+vSPM6WFj/GBe8nwUyGbPwAzE7c
         k+kmwtfmQQasAOhkZ22TTW/DpDU4tMAeU6lEBUu0nehiD2RRKmfDkfG5bUvBydtzwzpw
         t6gbWJdDjuoWm+11DIj+ul1SBjoVpEP44iSTVjnfaIPui/xl/jcoS3C9paOJ4NjBxGNs
         tH/ynNTHOaLOT/1Q4GR3K2cF5hUUI5o2o5YxbTPj90pLqNuEs4L9EBKVisgSBJ5pC7JH
         EDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=DZ5/4jYstvd3d7pNzJRhxiIaflhRKyL23nZ7V33IOto=;
        b=LucXXPwmceZSdw/SQz08+llGk4trO2TsQWRwVM7Bkfoo2bjHMnkE8vZ7N5rJL661en
         B6bufTz9YaR07nMKX1v5I+nEg7QhmC+EP6P8M7EdvcUkAN+DWWc5qwJrUHp62K/AQwcy
         u7fY72Ou8diU9wxv2d6k35iQNPByhbfgrGBTYhDuATyJx7+3AXsdVM6yfe87hvNr7FpW
         svVuaoMZDSmTkToOJohJnwOUAZBzd9ErTDic1jOK2/BRTvMQXZV85qM6QuooMfVVmx40
         TVC294RgRFC5b6ZP6V0W3IX6IkSQoBNJh3Lhetd3P/Gkf64m/3DMMySfkJAT3DIJaEAe
         O08A==
X-Gm-Message-State: AOAM532AT33Gx74RBE56ZjijJNQ/VkyfoF8vTUN6Q/9x6hY3+OcC8Ts/
	+YvLXZhTdOb78QLRgOWeKg==
X-Google-Smtp-Source: ABdhPJxpuS8hStIX2kOy20SxgQzdQM2/UK1XwPioFn8UQrZelFPiDROyteSJfm6gi1kXOSogDqsQGw==
X-Received: by 2002:a05:620a:4441:: with SMTP id w1mr2161634qkp.619.1637794911008;
        Wed, 24 Nov 2021 15:01:51 -0800 (PST)
Received: from [127.0.0.1] ([20.124.100.162])
        by smtp.gmail.com with ESMTPSA id j21sm539991qkk.27.2021.11.24.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 15:01:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <44593f9acfe286b9d18973e13877c1e48a15706c.1637770883.git.pabeni@redhat.com>
References:
 <44593f9acfe286b9d18973e13877c1e48a15706c.1637770883.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add tests for subflow creation failure:
 Build Failure
Message-ID: <79a736a8-6ebd-390f-b108-fdb440b919a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Nov 2021 23:01:50 +0000
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
org/project/mptcp/patch/44593f9acfe286b9d18973e13877c1e48a15706c.1637770883=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/1501462418

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e6316e20ae=
3b

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot

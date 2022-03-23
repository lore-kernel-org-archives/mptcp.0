Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8166C5
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 18:50:29 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id s8so2135952pfk.12
        for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 11:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=RHcdVt1V3/SYLV2LtasPrIQOIbo3y2ILvqkSfAiz4rc=;
        b=iaS/emBia9MAF7D7lLDOwTTJ/d8JXYICInvxqPB21zDLZTF9mBZ6I6KR8EWbr1GjXX
         T0vkrR8xKEz2z7bVp1qcNCH3boj9LILF80zKzJw/NW66TtBUHHuaT2CVkg9Zjsss55T0
         aGhfoQbQdESjSge5VX7v8mmTCzRZ7IALzXQ7jmmsJCT5nmHHN8xf2RhbGZWgZdXO31dT
         NjaAA0wCyZd48Qbtj6IbsobT/dAbiunZvmxTGYMPPYesIiss9Yf2363dpZ7P+hUnkXgU
         gRZJ/D0nJMTTuAwFlRT7d7e6xOvCrofuks06qD564KJ2jZLFq5xmi6d0+n6ANBWoO6ni
         a5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=RHcdVt1V3/SYLV2LtasPrIQOIbo3y2ILvqkSfAiz4rc=;
        b=nRdV4f/pyQ/9hIlhbcMMdgOhaNzEBtrG8qqzAzk9pDehkYQuRRcf7qifJ4cuqRNAyo
         BOVbkXjhTbubUuVDcNia9OrS1oH4lf0pB5kcqCo+kHpUL/kmWmsvLATpGtkxB7gZRMdJ
         oUA2YSz+cNcAhUkzbZQupKtkbOgY70la/15tD8AkHUyzVTe5H4Dg5tL5N67+UHto02v+
         2djxmkYu7nS8sV4257ZwFFPn3QFvcORvqs79s3b37ME52c4s+UGBWxn2DL4TOWELO3ga
         B4rxFhEzDmdg5D4umUPwqHudWF2xmIthpicmecyetnecjx2qDL4aumGbfwrkTV/D1e/6
         z/Gw==
X-Gm-Message-State: AOAM532A4LSRp1XCnUlvDk1VzyWkpFq0dBXU4kDZesEF+WEgmpF6/WVs
	Tqfr5L6/bVvGJo4qeTpuhg==
X-Google-Smtp-Source: ABdhPJwHnPV23D9cOU2x8PAWjArxHxXkDbz63HHAHx2hTwBdfVvzckgdaTPR0/QOgYayPyu23UQqaA==
X-Received: by 2002:a63:525a:0:b0:381:eef5:c9d7 with SMTP id s26-20020a63525a000000b00381eef5c9d7mr1014647pgl.106.1648061428606;
        Wed, 23 Mar 2022 11:50:28 -0700 (PDT)
Received: from [127.0.0.1] ([104.42.71.62])
        by smtp.gmail.com with ESMTPSA id j14-20020a056a00174e00b004f776098715sm599340pfc.68.2022.03.23.11.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:50:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <60276cb27a70bf7c789700fad30f58bb26921585.1648030937.git.geliang.tang@suse.com>
References:
 <60276cb27a70bf7c789700fad30f58bb26921585.1648030937.git.geliang.tang@suse.com>
Subject: Re: mptcp: add pm_nl_pernet helpers: Tests Results
Message-ID: <db47fa6f-cb0b-d3ab-84d0-feacf6125822@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Mar 2022 18:50:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6261383590313984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6261383590313984/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4755605503082496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4755605503082496/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/62d099638004

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)

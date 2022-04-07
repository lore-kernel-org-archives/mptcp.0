Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D320F5
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 07:35:47 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id v2so7460560qtc.5
        for <mptcp@lists.linux.dev>; Thu, 07 Apr 2022 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=J+DyLujaPjoDmp6Gblu80G8o850GCMzrAKGbEBQ6+3c=;
        b=alRsKF8mLAZlzH+DfwXRKXF1+ll7jprusR16QJL4V1xVuxh7cLwaRMIA9et7l5d6hA
         NYWBSFjwKxiWmBUIQ3xWXrp8zGpQilAp69R+ld63n8Zb8jC4Ci3PJafxKmIzaFopcYYl
         D9LUbm9OnP3dr/IoHHX/v3qbLOLeiMY3EtxeVmw1kM29+9XmfshjUvgsqLv8KMWr8WDX
         Tq+kYIp76iGetN1qPf1RxdvesHCVbRldD3hwYtT30yJ8ZpOkg0MEApvXsYX0M/1kx66g
         TcnBl1u7+AOayWn3qJ8dOmYa9ioxCWoHKZqv5fkRJbqhFaugRo2QXFtrA6wyu/QdvFQG
         z2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=J+DyLujaPjoDmp6Gblu80G8o850GCMzrAKGbEBQ6+3c=;
        b=vPgaxFdneO5kesSOE1pT0drYT7KHSCgrOY+RrZTH1bJwB1eHgPDYdUlun0nW/Ms062
         wGECbBe3nlSqtc4wks09FCnQud8GDklKshXLJSKbu1QYRZMpldW1YOSuL+aubCpageiP
         GeIVpRClTK+WL5AO9B7m4GMC6uc7xHCRL4pu4ESogdq5hUgo6Y2EVUIuepwi0xOrvR6C
         c/2svyF+DBjFTwmRRxxyAHNWr6vvZWngdVBRNUyovPCSsOeGi2EZCoVzMxF7BJOJkkJN
         +Od780DfLf/6fVB4h2/sXqqAwNFvOuCwdFfiCqSCla+56gBzdWFmSi35e2ZFqa1+AjhX
         ql7w==
X-Gm-Message-State: AOAM533o7HPWCw2MlD11v7FFGgyGN7RG+EIxkNsacfib38WiHvoX+iGc
	hamXciqJ9qKtPWMtmywZ8Q==
X-Google-Smtp-Source: ABdhPJw0ZYCxFXHUdGk9rwf2PyFwHTVAqv0WjEJID7D/aA9qVynYCUYV7PoMKLifpKq8ZyaT6AInVA==
X-Received: by 2002:a05:622a:1496:b0:2e2:3188:9db0 with SMTP id t22-20020a05622a149600b002e231889db0mr10794486qtx.446.1649316946755;
        Thu, 07 Apr 2022 00:35:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.71.97])
        by smtp.gmail.com with ESMTPSA id z203-20020a3765d4000000b0067b48d49c65sm11508368qkb.95.2022.04.07.00.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 00:35:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e639177ebf8e08c94df288a7b0f430718de81b5f.1649303876.git.geliang.tang@suse.com>
References:
 <e639177ebf8e08c94df288a7b0f430718de81b5f.1649303876.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <28d94849-2e24-c81d-243b-e1c5d7f5a97c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Apr 2022 07:35:45 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6286185919152128
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6286185919152128/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6423686008799232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6423686008799232/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0897208a28b5

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

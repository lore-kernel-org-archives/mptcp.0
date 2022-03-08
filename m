Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC913227
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 14:38:26 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id eq14so8810274qvb.3
        for <mptcp@lists.linux.dev>; Tue, 08 Mar 2022 06:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=8XsDHRrTO2FznmsUmV2zRIdZ9h4Cl7cD+YdA+vorwjA=;
        b=cVg3Cg+M4Lx80Hlukgbb+OiHORNpHDaQ2HHk7DUWZcD3UEJOroacC971W82xAOkgmB
         FyiCoFL2tO2WuF2xfz5zmPX7jjV4cLMGugwhq0XPfbfduN1aUngjU3BlfRfDcFHTRQL5
         gW8mrZ5zc2o2FkfJwfbl6xnOoNyqEi6X1DQRTujMkYKtnjEi7niNLE1EPLcyZ7b3I8/s
         3kyiBqRKkFq5SRr0e6RN/2Q3LytWoXtVgLYKX7uEL1RfGIAj9nBR39i8jfkstlcEVNec
         Qa+oGmr/KE858FN5twlg/F2KnbBVNXLMl5Hqd5L4/Qe6fDNoeueoMFr1LL76tVzASJ8s
         NSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=8XsDHRrTO2FznmsUmV2zRIdZ9h4Cl7cD+YdA+vorwjA=;
        b=TRMnyV+b6BXTVyoq2UmLXwbZKbriRLBPwwHXJ5r3dAoG6MrQL9mS6Wl7fZ4qF0QN0p
         nwuwscunX/8sRV6sleZ4Pi/EnI7u5XmkgZC2QuaTEd5kJ2/B+z8H1pcY7ICWodDh6lkO
         K+Lcld7bKyUcsdrMsYqr1/e+CKhk/8gUYOOdeoZ8algHHL+VA3msWJe5qsTAcx7vERn0
         LPkXlOQTZFq86rimcZwpVbqm8qd28ydrM+WyPOo7IgAi7HbfvbuIMFv5UHxy07/NLGtl
         EfWi70+BM1r2MlUWB/5cvUjXXMybOsNf+25ENz685GJuLa9SxSpP3XYP3gnxalFrVN2a
         Vl4w==
X-Gm-Message-State: AOAM531b2qW+fy0MqPIzgyc0D2oX8pgoqHgUfsd0iKQjpzv0phHGC034
	vdwp0Y0KWMITeKsByMrhSQ==
X-Google-Smtp-Source: ABdhPJxuv+KoaoR1q0WBD5/AP3X7sQz8xO8KYFiMIzjvNIIoNp9x33oZV3bjmGzgTGQGIIEyogzLNg==
X-Received: by 2002:a05:6214:627:b0:435:2dcd:d6c0 with SMTP id a7-20020a056214062700b004352dcdd6c0mr12399245qvx.100.1646750305354;
        Tue, 08 Mar 2022 06:38:25 -0800 (PST)
Received: from [127.0.0.1] ([52.177.182.78])
        by smtp.gmail.com with ESMTPSA id u39-20020a05622a19a700b002deadca652bsm10949719qtc.34.2022.03.08.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:38:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <72ffef207bb0a4cdbce2c1bb5bf9c892b2d9a1cb.1646745228.git.geliang.tang@suse.com>
References:
 <72ffef207bb0a4cdbce2c1bb5bf9c892b2d9a1cb.1646745228.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add skc_to_mptcp_sock test: Tests Results
Message-ID: <71fbf060-57f7-8d91-3510-91c33cc6778f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Mar 2022 14:38:24 +0000
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
https://cirrus-ci.com/task/5592245201010688
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5592245201010688/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6718145107853312
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6718145107853312/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b210c840857b

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

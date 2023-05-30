Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0820200AD
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 19:38:29 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-256e1d87998so446002a91.3
        for <mptcp@lists.linux.dev>; Tue, 30 May 2023 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685475509; x=1688067509;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYRBgCFPfBfnq7RzB0w5hvupzc6mM9T1FfYcnra7tB4=;
        b=MjlVxe21wyYi6tzhYge2QtD+mSBrW4N4n3pWr29acG2Z2xW7gHx1cleeVi73M29gTw
         FmOofZIy5sAd2KvcukmbglLhEzIh/DGAZJFtC2ltNPYlcNudnyxCYLslMXq/xFPTFfV6
         MSUTql372RFTMYby0ZnpeMq9p71FdWV5o7Ln+P6hMV+4o0Xp+ZTZXJCkU1O8g2wa2wLl
         Uc1jFFkwHQqiLAam9ek34BLMTzHUDakUOaJaefHdi6O3dtPVtoMA3jg5byYCXffWFxaW
         kHzy3jAWxFadrA7ea0ePyUctSH2k+NXIfpmieB9t4SZ0+GJowbzTwMq8QhyoYG0ilUZX
         uXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685475509; x=1688067509;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYRBgCFPfBfnq7RzB0w5hvupzc6mM9T1FfYcnra7tB4=;
        b=Nnaop0XeSv1ZnU8UnMI0WthmSWyi+vzkhLSyDf/o+XzJy+LZHKQCVDbX0zAnXRtAx1
         vHlhe95W0xDMHBAWGtIbgbGxTmP6jxtZTFdAU6onu5PiQYzpUPbhaYENUCmg3AXl4KzH
         PU2lD0s0slwILFVrZDX0wOor7xkKwhxeK6v0YxxgaBeYBtT55saV1108GehOPC0xJDAz
         pCtdYQiTFayIXJobx1cR1GMS8JzH+RvQCFt2V0WURtf/p9TwdtafGRdTsvep9yuFi3cW
         ut7Al5yL4Pg3FnO9MEGuSz1O/4GMAZlb8u1kfYpEu5T1WYi2vbTJAeB93gtUwLiKB3F1
         rgJw==
X-Gm-Message-State: AC+VfDyJSUSM8Buzi5rPnKMGYvS754Sob01ObbZ5stBhppXAAdD5ADET
	E/X7TvZi1MDN+Jf77P8daQ==
X-Google-Smtp-Source: ACHHUZ4Kx+YpcVVoou8mOaBDgy0sFoJtH7THOU5Hd3UG+n+MCM5f68b7xxFvOdhPCrtkUb7uR/yXIw==
X-Received: by 2002:a17:90a:ac10:b0:253:49d7:ce19 with SMTP id o16-20020a17090aac1000b0025349d7ce19mr3136942pjq.18.1685475509197;
        Tue, 30 May 2023 12:38:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.73.50.88])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b002500df72713sm11193104pjb.7.2023.05.30.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:38:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230530175403.2434218-1-leitao@debian.org>
References: <20230530175403.2434218-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <ddfea6e2-4636-1dce-946a-9ee45b93644d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 May 2023 19:38:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4661059747840000
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4661059747840000/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 5 failed test(s): packetdrill_add_addr packetdrill_fastopen =
packetdrill_mp_capable packetdrill_mp_reset selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5325149604413440
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5325149604413440/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6349909608103936
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6349909608103936/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5314839199875072
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5314839199875072/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/594d5a8a3320


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)

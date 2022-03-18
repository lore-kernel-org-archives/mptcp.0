Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAEC15A0
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 00:29:21 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id q11so7798787iod.6
        for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=xeKI8PctTus2T0pSG5Pe2gbsHAYYfroXQjuuSe3MlLk=;
        b=h2NHnCRlLcZmliGrqDT/X2fTbVmQ7Ct4OSoU0Uf9AbL67hwwggc2qXQiovvH8PwzqB
         OG3T8R2i7Rpv11ZLKtoQFdz0FpEyTVoFQzKYFO8JJRJfUz6MR83wpsCT2pFmk7p5Wnpz
         AIwVTRdLbB+f4gxKi81v8/6gFybBzyc8fqqdS25bfAEQOS8SyRrJzhL/0xjo0MocOpFE
         bd2Pg3ruF9OyTQA/MqOrbwmBWwuOGoF5/rcw2AK/oHVDc9hkQVMvWx8eBfQTI2zruDGz
         aOZA5/iy96/0ZkkWmBqb3KDfmtEivbiz1D5+WsartwK7IQG3qBSQnHxm5s9Ekivb9CwU
         fWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=xeKI8PctTus2T0pSG5Pe2gbsHAYYfroXQjuuSe3MlLk=;
        b=vEj+OXOQP361kriBycCuUBRpkaHmeav+HffgBe2dLT2Kx3RyEfs+2s1dox2qU2Qy1V
         z5e0B37jRgq0hO3RYd9px+fUzTs9HWs3NcjB7akLtYY67SYl4Xu0QAuEe9piIDRze4wq
         RxlCdqU/zRp2MXw3FxyeHXxyuDdrl4bx7C8ivJZ3miv29hzZ1rsxccQjmc+wjjQVCjd/
         EkQMrexeIs/8pXIE5mfT0UjyFZ/Tr6jUbKw+t5tgG5uX8i1jsxK5SlcueD4kiXmjL3Dp
         DDGIBeRgvZc/foiCeVf2mmapIhUQvRG0GygRXcWBJFqL5NctB7NFSfC51vDO1eM0eZ8+
         SYUg==
X-Gm-Message-State: AOAM531ubem5SC8gqvwYmbfENiehHiAc7RUTNPW9nNrWzn9xnTQYQdAk
	9u16iDd3SZmf6j6rsy+sv68mf7cKqw==
X-Google-Smtp-Source: ABdhPJwwhVStm3mk0+cA+GqEfRJAPVV9CImltgegSUnjuae+LJUgAOc82OmY8cMMwgff0xFfx6E4+w==
X-Received: by 2002:a05:6602:15cf:b0:614:52d4:952 with SMTP id f15-20020a05660215cf00b0061452d40952mr3396769iow.185.1647563360421;
        Thu, 17 Mar 2022 17:29:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.69.136.130])
        by smtp.gmail.com with ESMTPSA id m11-20020a056e021c2b00b002c7c5e0e7ecsm4320351ilh.60.2022.03.17.17.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:29:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220317230449.763778-7-kishen.maloor@intel.com>
References: <20220317230449.763778-7-kishen.maloor@intel.com>
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Tests Results
Message-ID: <c2fcfb82-c460-b4c9-84c1-3b02721c13a6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Mar 2022 00:29:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5798682065895424
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5798682065895424/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5235732112474112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5235732112474112/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e48354dd8d21

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

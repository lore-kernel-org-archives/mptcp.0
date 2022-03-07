Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4C7A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 13:28:09 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id k92so4368793pjh.5
        for <mptcp@lists.linux.dev>; Mon, 07 Mar 2022 05:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=J3C36Zgmp69bT9LMOl40SHvkbTI8gd0K8gyWJdO2aeQ=;
        b=E1oAMovtYcDazJmLzw6LgoViw87jn414vrBytY3RwQOiCAURA3jMP/kd9Q+dZa1btM
         l4nQaSYjLH2mLnIwB1U1Ow+nnyeqyz0gyIdjbjdmHq08xBMSGKDgMAOeqds06yTTVEpk
         PwbvNZoi7Nzby1IICzk1hRUBqn5yPlohlBB09uyckayzE/4dIZr+8libR+HSJUi+DvY2
         yMI6Ikgm/nL9uXZ8NJ6u/IJlu3Ip/2+iHYsj+YpXYJH6YHion5AFmNurPwScOzTDhRfk
         8wuRCX1PcoDtA/orJQGJuKxMSOGf+fqyDGMtrO0cJxGng5uAhf8/23QKu1otzhk/qqiG
         bdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=J3C36Zgmp69bT9LMOl40SHvkbTI8gd0K8gyWJdO2aeQ=;
        b=fgq2/0r2ICqBgJEMC/r9EELLl4r6roHvK6Fx4XkcELycTwbb3jAPaNhNok7BTmyEKI
         r7s3OP9dXryHfrPABnz5TzUJBJ887O+8CcGR9GZg4Xd+1TgEZScoBGZabymdRUFijfgP
         ffPebtu1nxfYBURekpSBwKkODCxkF8vFNmeuxi4c5TeX2NeztI7NBr0CSFsm61t+pPSz
         KmbG0W8Dg6lHclqNqgjfjdu/2FVwOTs+pyXF9cN+NhwDHHu0jLdkgNpH/uIg5qGMLyuS
         j24nJGgVY+X518wBBUF1sNRUtGKYaJH6y+uzpEzzS36sWvpVPBaN7e0vO7ZM7H76/rnd
         28wQ==
X-Gm-Message-State: AOAM530onWdg5o2mrxHkONT50tAyCs4xMKU24HOG62q6/A9vnADbtPs4
	FG4Yvtcyia0Kbevjt3g+gg==
X-Google-Smtp-Source: ABdhPJw4OfmXgH0bCjq1pLknBwpvnuPQRVWoJympwPGFRWiX5U0b2pG4OU+/IJaqN2bkqefplPPjfg==
X-Received: by 2002:a17:90b:3a91:b0:1bf:261e:7773 with SMTP id om17-20020a17090b3a9100b001bf261e7773mr18030628pjb.155.1646659689410;
        Mon, 07 Mar 2022 05:28:09 -0800 (PST)
Received: from [127.0.0.1] ([13.91.82.171])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0b9700b001b8f602eaeasm19066243pjr.53.2022.03.07.05.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:28:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <59d5dd61358bdee3d5b1a95208461e20e006b8fe.1646320786.git.geliang.tang@suse.com>
References:
 <59d5dd61358bdee3d5b1a95208461e20e006b8fe.1646320786.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: exercise bpf_mptcp_sock(): Tests Results
Message-ID: <6650f770-9968-1d8f-51c7-5495c37791c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Mar 2022 13:28:07 +0000
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
https://cirrus-ci.com/task/5047871987777536
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5047871987777536/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6455246871330816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6455246871330816/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c95f5f7ff117

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

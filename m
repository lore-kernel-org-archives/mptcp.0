Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28E2C81
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 16:14:11 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id i1so9229128qtr.6
        for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=DBGsBfF0MXPW0n/Q5ReSY7zxtl5a/Hp8Pdj4W/g+mHg=;
        b=eA4TRVOfWPQOV2Gy5DHmZTUgM77iZAIk3kqUJciOkgRakPWzAzYYaAXsb1ixliMTFK
         MIzGPvG7SDtccIPpaJ3Im+5j3gp5c27MvLkHdoYHYDElbSGKY+V2VJ1kmg5/H5vh6r2i
         FtMi3Lvmvr7+QfUVWzMloKHB0i9tIkUSJm/MBSMSUN9IO8liOEuGQn8/Aq/fwMZtleZk
         MaSlt9Da2CONTIiFeeATqT06Z//ueNrb032Y7Pn5RDgXdoFGYM+EO78KYiKK5jIlcKDo
         viEiobb31thQNKRrL0WWp3uWiHfLWgWTDPLC4zR99NhYMVoKK6Pa8E8chbnCV67keeZu
         lDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=DBGsBfF0MXPW0n/Q5ReSY7zxtl5a/Hp8Pdj4W/g+mHg=;
        b=CddKlsHu6x7ynZkH82XXYEqjp1VbZhZiXgJEquc7JlWOQarzfZpHsli+FYzL7pMDE6
         2/bfyDfJ7gcNgXMFJJIaGDOqElfLdDPyq4q/w0QtMkuZwAwCduT9TqISWY7lmQtWaX66
         7IFJo7hZHTipaDsiH6NktrW/HXxx8NU/L0YjzSwhex0yqDnKIlxq9Cyu3ZxBGqZG5GUv
         +VHzn+osxzmFjEffdLk5eM+gwen9BG2Nqu0b5+pauKoMOD7b4cCPchLKVJYRWDDBmMzE
         z/d0rqmSFDCAti1i8+uNPkKXrFPNy4aGAxBrxf75v13GExSpqb7WjOlreJo84eXaEeMy
         yRiA==
X-Gm-Message-State: AOAM533pyFo1MMD52MWUH/QN3/X5/9qv/OTiFcAg3Zq/b19Ep26r4Obb
	y9Wnl8wybFX9FZwRA+nOJA==
X-Google-Smtp-Source: ABdhPJw3lJsKw8NqUms4o0/iu0dVoy5S27lr4FUC/P3CHAoJRsVRTYdggqFlGheRfxNRuFTxIRfNcw==
X-Received: by 2002:a05:622a:18f:: with SMTP id s15mr14730242qtw.189.1634314450680;
        Fri, 15 Oct 2021 09:14:10 -0700 (PDT)
Received: from [127.0.0.1] ([52.170.136.212])
        by smtp.gmail.com with ESMTPSA id b3sm2772156qkj.76.2021.10.15.09.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:14:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
References:
 <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: more stable simult_flows tests: Tests
 Results
Message-ID: <cf608aae-13c2-4fc2-699e-fe51a9ac401e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Oct 2021 16:14:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5651869834936320
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5651869834936320/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5088919881515008
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5088919881515008/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/661a4e488a66eef53c0e94d15b13

Please note that some efforts might still be needed to stabilise the tests
suite when ran on a public CI like here. It is then possible some reported
issues are not due to your modifications. Do not hesitate to help us
improving that ;-)

Cheers,
MPTCP GH Action bot

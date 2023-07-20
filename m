Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5817AA4
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 11:16:03 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6b9b427b4fcso523910a34.3
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689851763; x=1690456563;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR/FaU408GRN97gBOko14+An1offVWqFCJw6VB2yp/k=;
        b=HPdCKOCysjkRlMD5KhxwZ2/L+B0kBo7B7VJFWa8+V/xiy+P0QIdoCv9XOe2xPDDivT
         yq8Zf7y6JWj5N+dq8goYnypNr1zD4R5xyG2xQD43bEcIt0LMvTJyAXnA0UkL+Mm0Lc0m
         CE9kaqxjBi8FZbhftOLP89Mwy42TA9zli/lf6CJb+HIfEjLjemRIpZh6e6W/LWriy/UT
         wBCxr9ScQzh00rNUCPnVGlZLbs3S46lGFj5zI9yoL7h5tUs4gODSZoNeDqNV3ObK4Sls
         kp4scIarORTbMjSd2GKDYP6NvUvSSJKE7YXLui3SPkbHapjDOsy3kzNz+EScpf//p8j3
         tEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689851763; x=1690456563;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SR/FaU408GRN97gBOko14+An1offVWqFCJw6VB2yp/k=;
        b=TdQupizBGPxBd01VZjrQzhO205aBoimLIupScU4Nbv62CK+10drWNSe748a8unatex
         aCMXD16uoGT73JfYcsUhSK8ZKVP0zNyxqQ4CMT+TkvJ0/moWHPt46H+Xh2ZD3xlA5AxM
         2V81LvoR1XVVz1Rqs9Xg8UyiaphUTHOi2XyRzA0VN54Bs7xctg2STW6cfLdVxHOm0QLe
         rVuVq4tKdXNQZqo/aAPSz0/eZtBZYDMnit9HjZCh0bCd+VVfoEob7Tcuegt0QEh9/FmN
         6p3PT/oX5Df0CEWUO0dIpgPtgrtNiNMSg3HEbWgABuzG4y/EIMssG+OBlDw/s1uuvbYp
         wWQg==
X-Gm-Message-State: ABy/qLa+rKSLDj4qnazUflibSlk3gwCRnZb8H53ivuiSyuVbnaYocWCd
	4WCDWWrR4lF8JmDBDwVqvw==
X-Google-Smtp-Source: APBJJlGxxcCCcxlOFARvQFt2IDiLpw21D1ooJIzVkC9gPdlO9PCCCFWMG0tzjfm5/vcnJQVH5jFtXQ==
X-Received: by 2002:a05:6358:9214:b0:134:c279:c829 with SMTP id d20-20020a056358921400b00134c279c829mr11835483rwb.18.1689851762602;
        Thu, 20 Jul 2023 04:16:02 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.230.176])
        by smtp.gmail.com with ESMTPSA id s123-20020a637781000000b005635bf2f09bsm926455pgc.42.2023.07.20.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:16:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <099977f9fe49d41ee0aa2eddefe5e2e09da3a3f1.1689836587.git.pabeni@redhat.com>
References:
 <099977f9fe49d41ee0aa2eddefe5e2e09da3a3f1.1689836587.git.pabeni@redhat.com>
Subject: Re: mptcp: fix rcv buffer auto-tuning.: Tests Results
Message-ID: <3eb10edd-53fd-6a67-d792-a51936fc0860@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2023 11:16:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5749017578045440
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5749017578045440/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4904592647913472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4904592647913472/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6311967531466752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6311967531466752/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5186067624624128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5186067624624128/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f5a06b3a8217


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

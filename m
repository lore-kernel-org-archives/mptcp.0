Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879B2FB3
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 20:55:46 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id y15so2846381qta.13
        for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=c66qSwY1qR962uydTy6bzGLeBMgsWB3vHg/0q5ppIg8=;
        b=K9quaAKNiXEqw0v7zTn35u3OCo2VDMdqgKMot2w4JKEHpHhfbjye65ogje5GzgHUdY
         dlMbCZ/yjz2x9Mg2h6Fxl27yZsgJQwHaXXw4iosefmCRnfmSmKmYFlPlP+YNM2ci5J+f
         mzW9SbOSOBk15Fm0bJ/hl1iaD5ylRBGVvMthHkhLeOHUNriX1fNr94gS05FQMV9dgN9t
         N6erC3yLEGM6M/TY+Qk+yIWQRP3VhZFXq80U3zvCbi3XbEDd6hKS+7CmIEiamPxRJv60
         AzyAbTnsgcZ3pvVtVBBWa7vtppURPD6eOJcUb4fDKtkwzMtMsnGp9yxrTHWsRqAkc12R
         PSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=c66qSwY1qR962uydTy6bzGLeBMgsWB3vHg/0q5ppIg8=;
        b=dQg0EeRwsUgNfaLDtG8cfEFcONNO5+gdP3ucwrOEnL/kUjU8O265WBts22TVKexnCy
         6Kpdz1N0hf/ZvOKKRc2KlHpMrxpCbRiIQ+hD8COWjLvTHJHUufDoGs/Msv/MhaE5yv90
         eLd2HBQKgGuLU5Oxy/v+JjdGlwSU07xnZpxHM7jrBb2aF9bvN6DrjshSghvFb0zX9e+y
         4Hg33VDEJYoZ1RZ5m9obEDYmddnGyp1MIp/ZCXD5W3VbOy30u5qElIEd2HPmX9fH8IzW
         MMEfI6VGPA5GiiXh2471eWVPSb7cHLAPvN7q5XldlhXEYdq30Dy618/SUM4oj48uYxB9
         QxDQ==
X-Gm-Message-State: AOAM530pdZ9jiB2slLu8kkfO48YLtrKCCeqxffVC2n6qn7WwT11iru9p
	6rzoRsfzzXA0RH9xl2HYig==
X-Google-Smtp-Source: ABdhPJytz9h9U4hCaUulZM4zgmi28pSQK368ScV5Vs6YO536XjV0fKkGxnT1LlnHhlQA3M084XY9Gw==
X-Received: by 2002:ac8:5883:0:b0:2e1:c6f9:a12f with SMTP id t3-20020ac85883000000b002e1c6f9a12fmr1399279qta.439.1647464145112;
        Wed, 16 Mar 2022 13:55:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.167.154.24])
        by smtp.gmail.com with ESMTPSA id n13-20020ac85b4d000000b002de6fe91d2fsm2052329qtw.68.2022.03.16.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:55:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220316190747.634325-6-kishen.maloor@intel.com>
References: <20220316190747.634325-6-kishen.maloor@intel.com>
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Tests Results
Message-ID: <e2b531cd-2927-ad69-81a5-c67b689fddf5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Mar 2022 20:55:44 +0000
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
com/task/6221660377317376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6221660377317376/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): selftest_diag =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4814285493764096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4814285493764096/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/42f2a78166ac

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

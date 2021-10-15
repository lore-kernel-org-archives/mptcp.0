Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D37C2C82
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 16:44:53 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id t16so9311097qto.5
        for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Y97PDzrFjD/w0PhsF0WKw5LtsUI/4Tk45fV3blOREbM=;
        b=JOVHPhHZDqJ2GtFwF5zwZR+xMGBITxDLD2gjQtoJzwkMWdlCvkj/w8aZitJyTF8LTt
         /0ndIFNCbzxxvRgITLC938C2qIn8V0O8WYbHsDnK4JtpUWvsuzAs+CPI1Jbabm7Sj4No
         wdV+ZCudskO19a+qaophQVyR/uvO/nfCHpWA0INib3U6+HkhzVIZEzb/8g8NBqLFJQN4
         N87qyepGpb8bXn2gcsZSbpE2l8zP9+EqI05Clj7jePR0K+l7o705KdbTS/h/qY3y+etH
         hPdyizgo/bQzgpAKzmkMUwXncEqBpvHcuPfGIcVMGJD+iTS37b53G8d8YV3ngDGrBYTi
         upaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Y97PDzrFjD/w0PhsF0WKw5LtsUI/4Tk45fV3blOREbM=;
        b=WfXLl/a4SuC9hHgnGaWAlWB2hf+c/cCDSLm8PRcBHne9DefrT8ysUjX9kj0caWAQUt
         FKxOb8qFr4gkN1hhvYLsuNynQAUss4J79hzkaU2txU/cGaULi/6UsHUTMOdb7KaQRd0+
         xO3XO5ZJF3wtTx+CkjoKIJw+y5is5VTAJI4tnCyazbDyR6Fp2rWLo47IaEXzT99MyjOz
         CV2dYfZrcWwCvSlgf0QC0OLZGCLerlWwYkMHvnVfDY2AqwnJS4Z8oJSe/3SSZINOZI8/
         DcVtHTefZFSmHe30+K1svAuUS5D0McnmMsOcSztpie+50K1Prgf6IB8yoQZDROjH5vGg
         2tFw==
X-Gm-Message-State: AOAM531JSOVlECJe5nkzGFv5V+QtRd7rkMo4TsTmTTnDOik0UXgqSRfB
	fjLDKoDehHliKkCWHcKyz3G2kfdvlC5T
X-Google-Smtp-Source: ABdhPJzteCiuTelavdH/XexDbGEqJmTJo/G2fQZEWYmvjkvUAcM3KCYQQKYZgb9EBbwGb/w+XrUxSA==
X-Received: by 2002:a05:622a:1301:: with SMTP id v1mr14331265qtk.233.1634316292038;
        Fri, 15 Oct 2021 09:44:52 -0700 (PDT)
Received: from [127.0.0.1] ([20.110.32.205])
        by smtp.gmail.com with ESMTPSA id c9sm3010303qte.16.2021.10.15.09.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:44:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cd8cca4fbfa3bc1528ed6923cb4b660fd20e8e88.1634312286.git.pabeni@redhat.com>
References:
 <cd8cca4fbfa3bc1528ed6923cb4b660fd20e8e88.1634312286.git.pabeni@redhat.com>
Subject: Re: mptcp: allocate fwd memory separatelly on the rx and tx path:
 Tests Results
Message-ID: <ce232dd7-e048-20af-d148-d27dc5d5445d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Oct 2021 16:44:50 +0000
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
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6112689895243776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6112689895243776/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5549739941822464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5549739941822464/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/749ef178d79a03a9d786ab3b1e76

Please note that some efforts might still be needed to stabilise the tests
suite when ran on a public CI like here. It is then possible some reported
issues are not due to your modifications. Do not hesitate to help us
improving that ;-)

Cheers,
MPTCP GH Action bot

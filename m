Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB332C80
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 16:35:33 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id w10so4106895ilc.13
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=+0Yr0dg/3fbSRTfn2LZ0mtAd8HAXMq3MZrFISG6i9CI=;
        b=cuNQGsGhvSeJuMMjl1J0YNLIWa26hrClVB1Bugx6UvQNw5KC61H3t3kEOEV366WDop
         HSQY7+r0ih/4JHByLpcNGoOjuePAM06Ywe9pTrNmVPaIH6xQG/eyxUeW0FE9mI8Pdu1M
         R//khhe1fbFeyNmJabBEN7lVVw4hR+vjmsQJSR6B/oB5NFXLQqyDOkYVdLtoNw9TM0xw
         ojvcRR581+rXfH5T7V2wg+TMJnw5g6gRBZSjOo3rljvO0U2E1QJ7NzUgN5kjCO3YCPy7
         pMPmM1Y9g0AFY2Ap/P6cPicARP45Ss/2H/jMIPurjgQD4vpFEkYJf9hH5bAFqP4A4ng8
         xG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=+0Yr0dg/3fbSRTfn2LZ0mtAd8HAXMq3MZrFISG6i9CI=;
        b=SAdJI/C/EhIF84q3ZMsBX+1Okbt2rcoNz4KkN3jlupfddGTU9vW5mbe9GnLPnNSvEg
         uoyT0J/tPRESjZu3+bB2QW8pged0jolgEZECi8OJxh2+1cBNE56t4WJUxQPoayioHDFN
         KP1eIBCKP8adiHz3Tbu4HS7ldxO/uiyzTMRknARLs097fa0PdfPJ4IU4zlRYsfHLQfzc
         93nzbFZqZwZ9B7cRQrN3ghSoGx0fy6+qC37t1l4trJFWY33xl5mduZe74P1QV6fViwbW
         /tXeFYwmUHnYSDQpIK2weSSssvKk7gEdo+Im7BvD9ApmwGhgUDBPGK1u+sj5d+96anl8
         e48Q==
X-Gm-Message-State: AOAM530Zt3haV1cM/DNZPW80hJ67fA6uwrbJzjS4OMcuBukWIY0fFVSF
	vCcD2xtM3RWuxaq1BqkDhLt9XDrp+OmO0n4=
X-Google-Smtp-Source: ABdhPJzyzXMjCJDBn61pCuE8pDzgOpxoIxUilpadxqNoIA5AqSfBKYiyz0k024qQ/W2mIInJyR/Tyg==
X-Received: by 2002:a05:6e02:1c43:: with SMTP id d3mr68015ilg.153.1634229332354;
        Thu, 14 Oct 2021 09:35:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.67.229.173])
        by smtp.gmail.com with ESMTPSA id r7sm1369280ior.25.2021.10.14.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:35:31 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
X-Google-Original-From: MPTCP CI <noreply@github.com>
Content-Type: text/plain; charset=utf-8
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <Matthieu Baerts <matthieu.baerts@tessares.net>
References: <Matthieu> <Baerts> <matthieu.baerts@tessares.net>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default: Tests Results
Message-ID: <edc5da08-740f-646e-03da-cf7a5b7577b6@github.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Oct 2021 16:35:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- :
  - Task:=20
  - Summary:=20

- :
  - Task:=20
  - Summary:=20

Initiator: ghost
Ref: patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com
Commits: https://github.com/multipath-tcp/mptcp_net-next/=
commits/patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com
Tree: https://github.com/multipath-tcp/mptcp_net-next/tre=
e/patchew/cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.=
pabeni@redhat.com

Please note that some efforts might still be needed to =
stabilise the tests
suite when ran on a public CI like here. It is then =
possible some reported
issues are not due to your modifications. Do not =
hesitate to help us
improving that ;-)

Cheers,
MPTCP GH Action bot

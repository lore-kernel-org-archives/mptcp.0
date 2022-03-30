Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB57C
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 19:11:10 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id p22so25953800iod.2
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=FQRMRbZDl6MjVa7h/FZkPwWOApesMYXAHkkiEwqfeVs=;
        b=LfPvQe7f1AuvIH4hn39lxbLFqIDofeftO4RwnvzsWJB2mgMFC75R8Wl+CWiMo1dE2V
         /RRZ2owMxSCeGKQ/Ekvk74ldYXOajG/D0vFpKx9RPpm9DCAYaJkITUGBRY6wFNr7dxJu
         Ip84ikBzuPy0vWNuwe7pdilGxHyVS33m8A50XtZaFQYQpvsNnzqRe3uqu/kFiKwdNFYC
         NdWSb0cuZsFBiajmCmOYiBamg48KsAS0Jq9l7KCuDOSTvkhb508r61x4l78d+ysSwovl
         LSlBXNOs3gil3GSbrGYXGjk2ct27xLjqydFjjn8z3SKey+9ZW3nKD4PFsl5kDa3ajZXg
         9Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=FQRMRbZDl6MjVa7h/FZkPwWOApesMYXAHkkiEwqfeVs=;
        b=Cmr0w1Zkv1xXBs3817IZAEsksrQ0BOEJvuTRI9V3kM1PvYxpjqWCtj4EHBa1/ju+uL
         BSi8AdLJvfCEQeBItdEmLQa0PtRuutiI9D/plDOa0lqn22UDV5/sMMZrVDOg8CU+d+AM
         wD5R91QPwY1wnlIP00UF0kZcp1buFZhY8cxEV91YOFWTVX74q7gnmFOrT0YzAJfD1pxa
         evVIzfEK6QbT9TAJn1QXXr1jiRt+J7g4nfMEyXvUXOAj3Cm15l8R00E88CmsQbiYr5T1
         hTkhrHYN8T57RMELB3jtML+wM0Q2/N9pDwqbbcAPSr/E7P4GPwbb6VVNIkFEC8J0UYRA
         8sKg==
X-Gm-Message-State: AOAM533CoXpR022zqE+8UJhdUrJ0ox7ipMpJVoxSNgNRqy7Zyc7QWs3Y
	g3JgPPeFyxrrRYwBjToaFg==
X-Google-Smtp-Source: ABdhPJxYR18VozIEio1DR0c99ynnfur+64LvoZ7cmOwjcmL84VdZhXpiPWVX9UQ0o8lcsyXvXpTj9A==
X-Received: by 2002:a05:6638:14c1:b0:319:dd1c:e179 with SMTP id l1-20020a05663814c100b00319dd1ce179mr782043jak.64.1648667469617;
        Wed, 30 Mar 2022 12:11:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.23.239])
        by smtp.gmail.com with ESMTPSA id p18-20020a92c112000000b002c9cf295661sm3173442ile.78.2022.03.30.12.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:11:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220329021401.1196466-7-kishen.maloor@intel.com>
References: <20220329021401.1196466-7-kishen.maloor@intel.com>
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Tests Results
Message-ID: <dc44cf64-8f45-26e7-0fa1-512373e6e24d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 19:11:07 +0000
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
com/task/5288976587161600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5288976587161600/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6414876494004224
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6414876494004224/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6a130a46e54f

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

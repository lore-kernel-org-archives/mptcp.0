Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADD3B37
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 12:27:55 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso16485040pjj.2
        for <mptcp@lists.linux.dev>; Mon, 07 Mar 2022 04:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=ymHU/1RFe3NPUT/Yb8gznIN7kuAu5ICKL7MLJxFaszs=;
        b=WSwvLfhpb0U0ZRDl+f/sM/CQWvYxvhxr4ZDn+VU7LdLDqTb87b6osiLJzuA3xXBah7
         Nci0EJ7zZl+b+gMHcYVz6RM3nQUzStrftWhv5ajiWQDeBNHWvpJIK6xEG2ZKS4x3tsck
         eKXNwaKIkBFs3q0OZ8FRGPQyeRnDwhqMDM5U7e09Wnig1x55joTHwONbW6QBiWjIRl1b
         09eTkl4r6zjqiX8RoTRa2bE/8i1+trSMTBMKZZPwin9+ME+YFw7+bZmgcQePMfCV9S2n
         pMq5tc/aeVUn5grD+P+8fVsLVShTA8Y9lVBc9cEGS8bWfneFKMws/Z55wwVY40f2ZkCd
         RwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=ymHU/1RFe3NPUT/Yb8gznIN7kuAu5ICKL7MLJxFaszs=;
        b=AUGe36bHFbieXLdf9xv7GKyq7RBVyjgfhfE1dqRv4gXkCSKtdeSNzwTMPG9UMMeVQx
         YgoMdyD+lZEUA7/VH7mK6L06xzCtbkuJBEXBJ1rxUaUvPP4+sL428Hpj3HHebFTqG811
         0StkLnvW4CAUhHccmQOia6n7Rfdkd0pOphArD6bB/9eEEsPXWomYBTORGZ9cPAkTmkZF
         7KGimxpnZGQD90S7MfWBPHHC1mhqF6P6yclIlWorxLRucVG0+a5OLnjOibdFbcE6legI
         rjvhE/UEIyjU0BupO9hxxSNg3r5p1VEsznidwUgffRINjlQgQTLagpGKQ+0gNHd23yYg
         fGRw==
X-Gm-Message-State: AOAM532/MC9BCBXYuytWRW4E7wTYVaSTco9YAKqaBwAvrPcAKyBljeqU
	QSRzt1+O22u6J04jKZw5xw==
X-Google-Smtp-Source: ABdhPJyanLVyEPLxbEz+yl80t7+QRQLt14lRtU0OSMQIp52BUmYv3MyiLoR29SQ4ciZKiAZ/92OgQw==
X-Received: by 2002:a17:90a:1941:b0:1bf:3918:d49e with SMTP id 1-20020a17090a194100b001bf3918d49emr12667768pjh.136.1646656075182;
        Mon, 07 Mar 2022 04:27:55 -0800 (PST)
Received: from [127.0.0.1] ([138.91.182.83])
        by smtp.gmail.com with ESMTPSA id 63-20020a17090a09c500b001bef3fd20b3sm15474214pjo.18.2022.03.07.04.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:27:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
References:
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add skc_to_mptcp_sock test: Tests Results
Message-ID: <0720f256-c7b3-fbe3-0542-7e667bebc7ee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Mar 2022 12:27:53 +0000
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
https://cirrus-ci.com/task/6330772855455744
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6330772855455744/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5455940454449152
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5455940454449152/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5890857c7ca9

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

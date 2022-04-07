Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C57120E9
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:42:32 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id bx5so4495760pjb.3
        for <mptcp@lists.linux.dev>; Wed, 06 Apr 2022 21:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=L8ukNCdhovfh3BU/WKjdQKCYXH7WkkqdDEJ8fXDg208=;
        b=FGp3Ii0vn2wFr9tfDntZwb2vFelIcMvxAuFyj85jDhlEcpiqhdf2z2y3wcsrbH3+cc
         pUcW8tgfD8DrID4iYmcAIIUEqVfC632vAeWhmZb3f0v3Yb9aKhanUfpaPY5lwmDNcqTD
         9/PelE06fUiYcVIuonuMIz4BICiwVshKHoGqrstS+wRc02h1QTwTsREJTEWK4Hs/bDWk
         zTXkOM/2SCIR6KTHju1XZwj+WzbR1c/+RE+voik/w6eXJ/cVqZeSPz0o5YnLBzcBFM9c
         xhrVX11xoduKDW3KyjsLamRf64aklAE/QIuwA1taR9e7EXC3DJk6F2rv0WoA9U7j3aQ9
         esEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=L8ukNCdhovfh3BU/WKjdQKCYXH7WkkqdDEJ8fXDg208=;
        b=trB8zAkNzlUpm3Rg7hjMzkJ9FuDbJIkwruUtbqcXdE2yH7AP4Xqro6FudgSs82v7xP
         aTQatomPot7As93MUjeOtlVppDtq3WnF69jwxsAFia5LJGC2J6ZLQieECOTxAaWCJ1tn
         tIva0yMsFIj5REd8tsSp+V/4gXFEYDLiksoA8Gn/p25LwEF20bhw8J2PATfUMEV3IjYB
         NLA9TbprodtZZ1u2GvDZJQA9nOv6XFZX2qZ9nKwFolS1UmlTbMhVlsodUUVKpqJ8fcso
         tJ7XcyqTCrl9OB4hUplxGfkgmAk31FSach4sy9VKgg5eLFrm/QtGvIP3ZYZi6k6uwUQQ
         51rw==
X-Gm-Message-State: AOAM532ZrQgulC9NZBxRpHhn87n1xNCHEamlpcTBgxm2WKSIXkszdERv
	8TmAYazB9gWNmwJ27s5wLw==
X-Google-Smtp-Source: ABdhPJwoSx1y/aNbdXrcrdbBlyD7z4KQtpvArL2NaWFwlOGmv9KmBbhUQpDNyNFK66rTTSUtGbPmSA==
X-Received: by 2002:a17:90b:1082:b0:1ca:aac5:5553 with SMTP id gj2-20020a17090b108200b001caaac55553mr13793776pjb.235.1649306552037;
        Wed, 06 Apr 2022 21:42:32 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.14.132])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm7268191pjm.13.2022.04.06.21.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:42:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220407024241.1757334-15-kishen.maloor@intel.com>
References: <20220407024241.1757334-15-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Tests Results
Message-ID: <8a0c8ce0-4ad6-54ac-9c21-5f8095247505@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Apr 2022 04:42:31 +0000
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
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4903032201674752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4903032201674752/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/6028932108517376
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6028932108517376/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5e7ec49ba116

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

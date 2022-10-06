Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028C1FBB
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 13:53:37 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id gb14so994216qtb.3
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=K0RO32ZAz7Ba8X6rMcPPx8yxm+r9F0XM7QlfWSwFM20=;
        b=Lk1ljYkWwHJBeAR6JOp4pJDj6pME/Bs5qxzY8jsT3/5eTU1CwY1wl6CSGUPviYiW7p
         vIuDj+XNNA1WspkFT0gXEq6V0UWUVYhlMOPdWpS0Xi82vyPm4bHhBohtLa2lGwGtIFfH
         MCkN5i/FDUftWpHPbQxT0j2QAjS0aROVzwWHL86nITHcL5x/FP8A8ac99IP4ioG+Ct7Z
         VAJ3cNC8FnOzHXGmJmBFxLr8KaUYqBSjgz2nzhULbjrPUXasPDhSdH7JClu4CJgFKIn9
         dgYQIzCW1ZlRsSGOd9wyG7GTZ3x8bYR4JflYisi9WYuwDYObDIXIuZDzQj/hxeKG+Nb5
         7Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=K0RO32ZAz7Ba8X6rMcPPx8yxm+r9F0XM7QlfWSwFM20=;
        b=gnB2/SFqLHnjlbnzn1aEEVlb0x+RSuE2fB92JexMBo/mltviButHjVh31tbIyjcKGb
         j+iIEWQQk/gXXK3h4NIbWGSnINm1vXd/hg2In833v7JCRqFNoDC5Y+uef4MjeVt/anL9
         FiKaKmc5eRoPHNT93Amwqvn36U2u/cQOoGTBLGX6ifJy9kiVVWyAnetGax0xrpT6k2TE
         Hp5iDsEJETgSUDs6t6gs90RBUrauzp5HcDJoLr7Fctl2PxjKYnMunMJRarzVcvzniqaS
         qoAbXYsOpbgwH7v3XWD2kzc9Yvcce/F2ssm4IDsnQZ8T5nZCD8Rr5ZuOsQmISW+uPh5W
         SYew==
X-Gm-Message-State: ACrzQf1zm2GCic0+ZQr9eZ2zcmXZJaDIXhOBSPBvsAUYf42+E2Ve2xJA
	kA2GJ1GyARNX7IxuIRYqIerD9gZUx9vmTwU=
X-Google-Smtp-Source: AMsMyM6ZnX39rBvTDw28FhMNhpcNYdRZN9wlHDAcbtCmYCTBeOH+okpfeZcqlLcTXbwh3oszLMh0kA==
X-Received: by 2002:a05:622a:106:b0:394:433b:2d19 with SMTP id u6-20020a05622a010600b00394433b2d19mr80145qtw.388.1665064416299;
        Thu, 06 Oct 2022 06:53:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.114.37.70])
        by smtp.gmail.com with ESMTPSA id o2-20020ac87c42000000b0035cebb79aaesm17504031qtv.18.2022.10.06.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:53:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com>
References:
 <c74935435f59a6120f62c56bd5e1519c30d269bf.1664915909.git.pabeni@redhat.com>
Subject: Re: mptcp: factor out mptcp_connect(): Tests Results
Message-ID: <545dcd99-6ac4-e015-60e0-72e1cedbf7df@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 13:53:35 +0000
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
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5314134781722624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5314134781722624/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6440034688565248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6440034688565248/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9d11d43b8e21


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)

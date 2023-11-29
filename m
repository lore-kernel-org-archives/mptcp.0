Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837135689
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddPI8Z6h"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67a545a9462so11452056d6.0
        for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 20:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701231952; x=1701836752; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuDo0o6yrNSRecKFDKuoLVqUmc4mszvDOCDzGk4f2pc=;
        b=ddPI8Z6hweRt6NNszMjGGr08WHEX2BsozUjKo+2OcP+p1IX+nQxdRquQ8f51cwlcw4
         ST5nM/KBEKg1jlTwxlQTWtj50xJq9tr/AZwcacB6uKCo2md1Q7c6KNEo9BtHd+cT8UQu
         gwNpHFbyYHioRwYi5sbyW7MXmtM1cgtbIBYjwa5FDmlGh006CjT5fLvBg8UkSGOEqnnN
         BEuytQiMUHJSW/JQG417shS0VR1K47vmkTNlgdcAeZHrHNkefjAgRErW82B2GiKBT8iC
         +yvcLYckGdkV9ZM1prayvf06ZQ3wlqv3wcL+jahfev9IM1Ukeslkw/4pYxtdI7E0qOHK
         1ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231952; x=1701836752;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuDo0o6yrNSRecKFDKuoLVqUmc4mszvDOCDzGk4f2pc=;
        b=eploRiAjAgAEYMIdPi1CCNbnUNXtU4tnv/Z2Yvdybin85RmLwaDi6tEokscnNIp0sF
         OoWYfmCqynrJA8miv1hOsdr8trFPthsDYMCprCnWbGZce/nrV56Os6/uCKX9G2hY4r0y
         SN4fpXj0l/EZxSTf+lMFxTN/tcIRX0TX3gmZ3wF8lQ+vdDW1j81zcifK0lg3ggYtNyqZ
         sPqJRyBV2OTpj12koOJFOtNEJvJwWQ6yqkl3SFRxfi//11oZLUp5xz+YFZVNrLxEkv9v
         9fKHb5tE6WnLudmV0ekCibOf9/MTAwsUJJugT6zxJ9LPzYqaN9vbPZlUcmb7UOiV07q0
         zjCA==
X-Gm-Message-State: AOJu0YwJnYbzLdWspuZNEmxRBumAcHM8DeVSWRavFUGFk89e2wUs5nbB
	d7kL4brVq4lR0tlYiI6Tow==
X-Google-Smtp-Source: AGHT+IE2RixoLFsv0nrUecpyjmkfeDdN2n0csocCcPWBZ86rxelonVVLNPiv7zpg8FysD+fKZGLBOA==
X-Received: by 2002:a05:6214:1774:b0:67a:ddd:e16a with SMTP id et20-20020a056214177400b0067a0ddde16amr19253753qvb.58.1701231952378;
        Tue, 28 Nov 2023 20:25:52 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.6])
        by smtp.gmail.com with ESMTPSA id tp20-20020a05620a3c9400b007659935ce64sm5057985qkn.71.2023.11.28.20.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 20:25:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bfe28bf33329bf157f8b8f9ff49b398003c487cb.1701230012.git.geliang.tang@suse.com>
References:
 <bfe28bf33329bf157f8b8f9ff49b398003c487cb.1701230012.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: join: check CURRESTAB counters: Tests
 Results
Message-ID: <f4b1eacb-4ebd-414f-40fd-6b9543b0f404@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2023 04:25:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4926830960967680
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4926830960967680/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6052730867810304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6052730867810304/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5489780914388992
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5489780914388992/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6615680821231616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6615680821231616/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bd08b7494cbb


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
Bot operated by Matthieu Baerts (NGI0 Core)

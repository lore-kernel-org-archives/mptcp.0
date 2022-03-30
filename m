Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906302C80
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 21:10:02 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-deb9295679so16106644fac.6
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=OO/FQ0kpOGz883Ba0VXp1BJYHYg+bh7K42DhTMFt9d0=;
        b=F3VCbhXFWEpqRmewSn8MvbC2BNqW9H1Nt606nokWvXVgE3E+YMNH/uoSQvvUxK9t9B
         rYC5r7VsKkr+RN4reSaGXPg9duzrfzSegSf3lkmyrnFsufwQ/IUURqwg0AgCOyVqgqjU
         GKHAykRIFgHZaZtRwr2Zr8544vT196whgqYWaUoUuf/SyHH4EvxLoA9PFt1K6hRopUob
         itP1Zq8wZfG4F6iINaL6UHtKRrNhCxMeyqSN5Hl7H+HS9cpbP6L43k1Tpw9htAOXoO9V
         FynFPCP/cEH6aJ7KNEX6icS8fYRBcac2+OjQqlvcRAOuPQ14rG0ZYpQ1DTqOM3yt7bpb
         Bn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=OO/FQ0kpOGz883Ba0VXp1BJYHYg+bh7K42DhTMFt9d0=;
        b=HUwOTztIgcbRcNIWSio4+DUy8UHvPfGTClUjlByFwFHLJTnonqOJwmb6m0LVZkBsTe
         R7oNmTCfa80H8AKfL5Uqpi5z/LCMNQrXvdWzUhJNTzJPjlzB7gVt2OSLsugoQgzZWv/O
         skdQjxjOMAkpZuIeR80HGSiGdVFvmMHaF9k26toAjt2735c/6znNY1S8+Sk8I1qqDr7J
         xbSCgNof+Xlz/563pOD0g0Dz0E5Nj4/su0AV/2EM9VLzk0iasZi0U6SBf8hsMDDHh3l5
         +xmZRG0ntH9NEee4rKJ0w5vokwpvepiYLN5oxlzEcMulNzCMxJlvH8BTOGpxqDToKSv1
         KIXw==
X-Gm-Message-State: AOAM532c7rTCRFWxw39JRTR5jsCRcV3sQ7TwP1v5rwCci09w7dTPkB0g
	4qW8HxReRmfQDB4k0uFxrQ==
X-Google-Smtp-Source: ABdhPJzl/NWsuHa/7E1h5ACHn3QOykJrVBjCapyJqJx1V1nt7DpNZTLzfTUnnS7rDPwOr05LzId7rQ==
X-Received: by 2002:a05:6870:b28e:b0:dc:ff8b:9d43 with SMTP id c14-20020a056870b28e00b000dcff8b9d43mr921695oao.223.1648674601629;
        Wed, 30 Mar 2022 14:10:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.188.166])
        by smtp.gmail.com with ESMTPSA id r10-20020a056830448a00b005c9344dac06sm11505129otv.19.2022.03.30.14.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:10:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <50798e945994585b9c9c5443ce991ceb3dbc662f.1648459866.git.geliang.tang@suse.com>
References:
 <50798e945994585b9c9c5443ce991ceb3dbc662f.1648459866.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add mptcp_bpf_first test: Tests Results
Message-ID: <f1192195-fc78-2dbb-bf9d-e4b3caf7f581@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 21:10:00 +0000
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
  - Critical: 1 Call Trace(s) - Critical: Global =
Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5323883229216768
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5323883229216768/su=
mmary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/6238759346765824
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6238759346765824/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ea9e0f5c2dfd

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

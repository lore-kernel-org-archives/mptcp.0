Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02D7C
	for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 20:02:52 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id z7so26140954iom.1
        for <mptcp@lists.linux.dev>; Wed, 30 Mar 2022 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=f9VGmCvAJDxqkQ+oRX3OYRSvtlXXG0oa0E9rCBn+c2k=;
        b=DJEC7g30G6NavZWRwfE/q4MH83MmH5NFOUv9hNKiu9ZedpF1jpIwsG1xh3/R4f2cap
         MJ5f37TVW82neLVIuWG0t+oyrjhWGatXjVLA4zyXimcenwf281IozOanYIGlsh7NWyz1
         jr33kgKYXmfZERZp8tfF57YXcz+xlIKJOoFogECfWhzq99ZI1zBclNrAUjDk/op3oM7O
         d7Zs04ajww4N50VFQJ55yhR/eb89qxnw+MSs/IE3CJySgjabYIrowHDnXZyCz9ANWNZ+
         9NI0ehnQ5uFKlTDOP+pL/FNLyT/3BDb8pM6uc5riauxhhQRYo9qG+9NmOzlIZeoAMS6F
         CH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=f9VGmCvAJDxqkQ+oRX3OYRSvtlXXG0oa0E9rCBn+c2k=;
        b=JlXX/wA8I1nJrmYz3aO4UcSsFbeoeoXvzuCm/ECfEX4Fe++xAdSEeh8Md3vt4ehhER
         B5/A9PhESgIa1LU9bdke3/5pkL++QpsCRcHORR756wWUf2a/oe/XJBLbfaYzJMUrWSJO
         0ipQ1h73W0nKDaY0obE13leRIOCADMLCdRuI8jsQ1ykZ1iijfo0O5YjCpJHZ2r1Oru/9
         ok5tboY7ylh837f0/a7YNlEr0l/8qLVF+WQ7R3WID9IGI/GlxIYOY6efi0xhYsA95qlw
         gO6MVhuFbq2ldWK7N+NIlY3D8C3Hs/bVRjJvpf1IqkhqQSCn1Mp9m2L0NydVBbhABnR/
         O4/w==
X-Gm-Message-State: AOAM532Xhr1olkKV5vWtSK62X+LtWGPnkbc2kHWv7RwXX+K6tP4fxuUC
	ttckahhiA/B1xzjMrkAQJw==
X-Google-Smtp-Source: ABdhPJyQwHLffr967nYC5vroQNovV7JQcJd1iedsGHQ+Kca9NxBo4Qq8elu3hli9c5UhFvzwcZC7ZA==
X-Received: by 2002:a05:6602:1355:b0:63d:a9ab:7e30 with SMTP id i21-20020a056602135500b0063da9ab7e30mr12895144iov.119.1648670571490;
        Wed, 30 Mar 2022 13:02:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.18.177])
        by smtp.gmail.com with ESMTPSA id y9-20020a056e02128900b002c9ec7ff291sm1018931ilq.53.2022.03.30.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:02:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cd7338125a956912da5a431eef68b6849e44c0ae.1648655695.git.geliang.tang@suse.com>
References:
 <cd7338125a956912da5a431eef68b6849e44c0ae.1648655695.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_add_bpf=5Fskc?=
 =?UTF-8?Q?=5Fto=5Fmptcp=5Fsock=5Fproto=22_part_2?=
 =?UTF-8?Q?=3A_Tests_Results?=
Message-ID: <f09e2445-1553-8c0d-c304-f872dcd9d50e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 20:02:50 +0000
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
https://cirrus-ci.com/task/5321973076066304
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5321973076066304/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): selftest_diag =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6447872982908928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6447872982908928/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7823dd114e75

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

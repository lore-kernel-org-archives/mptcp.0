Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F56AA3
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 17:42:24 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id h24so10799782qta.12
        for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0d7ZrY6+OaGcTRpJco83O9v/VTkOPBOgu8zhPygJUY=;
        b=oGA/PgPOe/VExuh7yI2nyjpMtnrqT6yGt1kyTYEQua5hA+bSzydpUX17+Q5pPVj04b
         YlncWY9MqqddF/9d7GkHV2rVneKjChRWM71izT1tb8XPHkKNuXpNonaDT5GefvrZTvms
         3XCaX9sQF0QJAqyeqO3qmEIXb4Dv5AmTFyNdiYHH9LTyg+yYGjwrpwue0Ec9r6a1Vozb
         LmPpfMYGS8muFAuslXXoy46jSFXxBotMQ2bSbBepJMNyNz5HpKAj/r15yPyHXk/cz+Jz
         iR5dL2/gtWfa/mFtzQAuZ2JBvjAeipt/k0Vz8YFHlG2syHgTysSr8TEhSTgdynzd/vUk
         ic+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0d7ZrY6+OaGcTRpJco83O9v/VTkOPBOgu8zhPygJUY=;
        b=AunSz5goqBcebXb3W91vBIjlk2KMQkNnGOdx9uU9i+PVKRZzS+EAO2mnNErWqOd97P
         jmfgxfSCY4RBsZ0gMEUG9xIXDIXl0y/nKUWoFP6IiXYdmrbdBaE7jfQk1PZard7cgIO8
         vNQpx57O8k125CcJSfzpzzeShaanOezs03Eufp+2ff66kHEU2eXPEl6Qr25WxQdAYfZg
         AGzEWhiS4kDchY/8s6s11crL/zWwGgjSGqIpIhLhn/JbhDrLBbs27xowMC+FcJKsSwFM
         /V+XZC8hVJp3PE7P+ptC5v9IccDQM8Fkyw6+VSRyO7QVhsYZjlKX7d2tZA1gyXeRpNRO
         I2uw==
X-Gm-Message-State: AFqh2kov44q7jEL8oyZAPqW04mmSAU00UqyxaVXNPuN63MeKT/Ozon6A
	0Ern682i661SH8RPIsb3Fw==
X-Google-Smtp-Source: AMrXdXtyZB78bue6QDjiS8z7HL6e2lNzfllB2uOiAPfdZ9kvwUVAXFsyoiMyDxxRPWK6rohPdidUWg==
X-Received: by 2002:ac8:7ed7:0:b0:3b6:3260:fa1d with SMTP id x23-20020ac87ed7000000b003b63260fa1dmr70001380qtj.45.1675100543516;
        Mon, 30 Jan 2023 09:42:23 -0800 (PST)
Received: from [127.0.0.1] ([172.177.6.21])
        by smtp.gmail.com with ESMTPSA id z20-20020ac84314000000b003b960aad697sm867268qtm.9.2023.01.30.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:42:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b9cfd415281fc206300a3adbcdbd36047facb31c.1675095773.git.pabeni@redhat.com>
References:
 <b9cfd415281fc206300a3adbcdbd36047facb31c.1675095773.git.pabeni@redhat.com>
Subject: Re: mptcp: be careful on subflow status propagation on errors:
 Tests Results
Message-ID: <d51d85a4-d78b-6cea-ac14-7f9374ef56b6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jan 2023 17:42:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4854224215867392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4854224215867392/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5980124122710016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5980124122710016/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6543074076131328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6543074076131328/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5417174169288704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5417174169288704/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/390fff044f6c


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

Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E094C82
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 14:06:37 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id n12-20020a9d64cc000000b00616ebd87fc4so11899260otl.7
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=6BjgA45zi8yXc4jjn1R4jMlzLFzv2WMhIOTurY21NpQ=;
        b=i0uE9IfYE4BJLLpnAZT9LMrPobF1/mpz6YJ7sLLgTkmygqsSn6O40FX9d4wl/oZyBh
         xAx9NT2uDenOdRwCSYWZxjBhwKx/n48NvPIIPLkduloPI5DBJZHs7tEQqeojMlUA26Y8
         RuWL0G+K9Jp7UIZA64IvER1jpncACQNuHBDPeiNXaIG0FXRd+M4hqySMqXA6QQ8HWEz2
         eBgOT34NbuG+MJjHsYCM2icCA7tx3u84S0ks0JtleLcvYvGLTCzW609NiU1oWuxFuolV
         yKFh/KpeAS41WxxCBN7VItcFh6x/tpvZweSDRqeb7g3Qx/IgWJx7Z1q4XqEdsXrh9pHN
         3GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=6BjgA45zi8yXc4jjn1R4jMlzLFzv2WMhIOTurY21NpQ=;
        b=7YKPYJDJFSVLzP1p4OSZskak/pncfjEfZ5xv2a1VTvledS5CjLhFSE0CTYRWeGYjJr
         d2fjvr/29FPSZRXkB/QKfS6Z0GH9f6658ALilQZfdeTS8tKAy019oqwaWDGk35ULlIq0
         gO3zLlo4pwf+MCXuEC162PXUC8Cv2XNWwO3eqN1O0OhnFvm6vwpEQaA79cIlsoMCnuyf
         PYDrGRErmu/SX53GyXeifMX50hSNxSzcFeTJCXn8hgHqWbnFiMlvWcPzC7jNQszZUrQO
         OfpQTbKzqAPIivL+3hW4cpEVoBfTEmMORiKf0Bsm+yAarIYukclUgvVbF4+Aj2HAYoge
         WdfA==
X-Gm-Message-State: AJIora9I08QkfObQPWun2DgRCTAqvu9db2oQH9jVApfH0iJ2+pY1+Ye4
	ziVYC0jwY5G9vfnoTIsPPvp00jIFu+vc
X-Google-Smtp-Source: AGRyM1uXUoMB8MhFoLfVTTZdGwxlsyAImng9IQfa0c/SBrz7kaHC99q91nCUNCoyEY2+J4B/kGCl6g==
X-Received: by 2002:a9d:e86:0:b0:616:be57:df48 with SMTP id 6-20020a9d0e86000000b00616be57df48mr17161759otj.345.1657116396326;
        Wed, 06 Jul 2022 07:06:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.202.98])
        by smtp.gmail.com with ESMTPSA id u21-20020a056870421500b001019fb71e4bsm21673764oac.17.2022.07.06.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:06:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220706091706.2679400-1-matthieu.baerts@tessares.net>
References: <20220706091706.2679400-1-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: validate userspace PM tests by default:
 Tests Results
Message-ID: <5da0c5a4-4c7c-7352-c514-8073be66339e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Jul 2022 14:06:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6585815751983104
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6585815751983104/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5796690794905600
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5796690794905600/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/795982e1ec62


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

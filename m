Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A14A3E
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 14:02:06 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f2a4c51c45so21492641fac.9
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=/YYONLSCNKinuFNWfyFuvxO39oOcmG8pN5sdwl3g+vI=;
        b=lD+sPmZeVQ+UELPfJj+01IXrTBqQ1/pn9Gv87Lnaf+3RUdTEqgyepBeZjjizyhmjMo
         fEidUgp1RBROYDpNzy8Y7DZnPGv/cI4zbCsRoxe4af/lskipMix9Jw+0sxqxYtUgSZEL
         clTy+E//e9NDpWCtdzjTd6fVwQJK7phyamY3iFqDu/hUsxUa0+JwO4j9SjiFI+l6nWsV
         8tSQJrQ2osLwhcibMGn864gVvQ2eOLi6K7RYulZ8eswGOcT7gPEiIWa8+LajG+KmLuut
         nr2jIuay5fo7pvmbb5xtKAIBnI3WoxjC0gXJodJp0UZHtt0rqHMKdAI48E2UciVYYknV
         TokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=/YYONLSCNKinuFNWfyFuvxO39oOcmG8pN5sdwl3g+vI=;
        b=hkp9C+uk3+UH61/CE8q0YRpLy2BRWfIxEnjkc5lo+pVgGL2mWHgmor1/SVPXnGth45
         71MqGBy4r2renLA5zXxoN4CrBJ5wO0QbUfNvumVPSw92VEC3GYsCLxp4U+GfDNqUNsC2
         cD9mpKuFSoj4B6Tjs5WgVsKj04hXaK1xkWLeol19X8nC/x+LHsTzOEvip2X7OPbovKgz
         zvro0w8H7pE809uw8e+uUiFwbSeZ2FWjhqUeFJIE5p0AXqVO0LONAe+E7q3gCliXH1t6
         XEEhHWy/WgzOV4xneovbKQ4Jtz2PAHLfv84X9FS92xUC+Sgc6hViQK35GREPvqAxXY9e
         X1Cw==
X-Gm-Message-State: AJIora94vwKkosjsnGz80ZQRexf1CyKujJKsJYv2XqSv+h8I6XLblPRw
	Z3CJeRGbTtp+mm2Fzz0zCw==
X-Google-Smtp-Source: AGRyM1vnvcBubRF3aGxDRQW8k3Mj4fCx8Jt93Z0zd1BakO2NlUqE3PHbANzNCEpgQ/b7n0Yt86+vgw==
X-Received: by 2002:a05:6871:68d:b0:10b:f47a:a7cf with SMTP id l13-20020a056871068d00b0010bf47aa7cfmr11222041oao.83.1657116125384;
        Wed, 06 Jul 2022 07:02:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.150.149])
        by smtp.gmail.com with ESMTPSA id t39-20020a05687060a700b000f5d8d031b6sm21127766oae.49.2022.07.06.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:02:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
References:
 <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
Subject: Re: mptcp: fix subflow traveral at disconnect time: Tests Results
Message-ID: <a623b059-a449-fcc0-e22f-a17ee4dd3362@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Jul 2022 14:02:04 +0000
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
com/task/6553371904573440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6553371904573440/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6525527967137792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6525527967137792/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d9e83c59b762


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

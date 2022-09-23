Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3123D90
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 15:21:51 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1278624b7c4so726163fac.5
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=lCkCk1/5QloGFcZ00e19eNBAkgrEK1SNqkDO5Wb1nmQ=;
        b=LTya1tZLdy/OmqP1ug7iHxnhAGYSnL0r52FnsQCHitZP7W5UPNkUUTv6U1QFQJcQtM
         BNgUsXxDXPTMbjaWyTK/UqawbA/moQPI8wjOrj7vOCI2dBXm7OZ7mov8duJcWxppDz4w
         vQo0Q9yopNt8yrz5pgyiu6oL96eWP1XgFe7pAoEO4IImBwt8yUJtmVidcD4pEU1HAA9B
         4IVxqqvq/tOOuH4zcry9U+9RJVsb7C/BLPd0/KcqnRfXJ41seECBhqvlsH60QskC1fjs
         sLe6uh1WD3jRB0lozFSaT7j5kJWSSp0b8dg2qq20KIpi/QjSs3+z9/tMsV3AYNmHx/5r
         fvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=lCkCk1/5QloGFcZ00e19eNBAkgrEK1SNqkDO5Wb1nmQ=;
        b=TDUjkL65zDPqEknrHla56v1pjk6urrInnV1vqyNBkqMYL9mNC2FdTQEQd/1aqZOeEJ
         j07l7gCICtg9lwYz1z7VpVdIscvp6IbP6816dm3PMJ69STVRZ0BZxA4F3Sr4ODiOLMGu
         BfYn2174DyJUZGBoaJE4Eg0jVAKufCXrAELHTcpDGvSkznnrMKWaixXTgW5ZNNKf5zV9
         NqM+L2SafMIBSfsLjh/VW1rg4amFeEqWADZDFKDDfyRqMHtVFaqZfxJKVeVdDCK1LN0C
         qrrkI1BeD3QL/4Xl2crdSDimrnDgYeH72fKhydRuzuCEWRwFSfW50wzOVcLhcaB2j4Lo
         WG2Q==
X-Gm-Message-State: ACrzQf0I7NIIfC9HnpxW2sj9UavgtX/jv6Ih+sWMxMWRV4R6556CcGek
	hR9bjWRF6LPpbH2yFPxeKsn8kSot7noP
X-Google-Smtp-Source: AMsMyM6B5j/YGVN5ldlg452OADYnOOP1Djs9HVHTSwCqT6jKjSJ2vyDN8rbr2wrV9C8JR+M63eItyg==
X-Received: by 2002:a05:6870:8191:b0:127:e021:9f3a with SMTP id k17-20020a056870819100b00127e0219f3amr5147937oae.164.1663946511065;
        Fri, 23 Sep 2022 08:21:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.65.28.245])
        by smtp.gmail.com with ESMTPSA id s136-20020acaa98e000000b003504e119b10sm3738222oie.44.2022.09.23.08.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:21:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220923121913.2135229-5-benjamin.hesmans@tessares.net>
References: <20220923121913.2135229-5-benjamin.hesmans@tessares.net>
Subject: Re: mptcp: poll allow write call before actual connect: Tests
 Results
Message-ID: <24156619-d1cd-c52a-04a6-7d36e33d1feb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Sep 2022 15:21:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Benjamin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6212834240495616
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6212834240495616/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4805459356942336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4805459356942336/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7b3c63abc725


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

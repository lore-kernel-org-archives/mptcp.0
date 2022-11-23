Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1B4699
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 17:17:03 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id p12so1117180qvu.5
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 09:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFhmXRZmf9nXx18ytKlFUOlssRqBQojg9KqjAvckWcE=;
        b=jdKrfjt/YjM0ZQFFUjRaSTbSDzbx8zLKR+W8uRF9MAUDhjTHcxOXRSWnSAY+vKmnnk
         d2zf5BK2RcCf3ezmhfHWxYxDsD+VA4S7sjDWc6WyFOWdemPbnWe9Sz+GK9atCJlCyMAG
         mv0e+2+Wi20A50MfAihkfCK9oTGD/laMCIteJHvOUfgOUjD2maILFgkm8YN9Sv09AD+/
         Om736VJrv5Rtlsagf6sHK21BudsBwJI5r5G4vz5IwFTvvCyTDfBd4z9iJVL/2oA+Hhy/
         bZ09bcMxtka72hOPYLchNzo4oeVR+P2CBYXFN53zINHZx8TuXHUUdiCc2V8h2CuLECXU
         zJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DFhmXRZmf9nXx18ytKlFUOlssRqBQojg9KqjAvckWcE=;
        b=tn4EV7tOB8t0918cWpmRLpJ8wCl4aX0xEH/HGW1+VaLoSiq9/pz1J0CNW+2UTsgcHK
         w+7+myLK+5pLE6l9oDB1dqKqAfAKzpr2a3NZC6Hx4pfCxIDxYeEjCHSd34y3BwmEH/Zn
         9Yf3/Rf8noeAm8iDLp+uXD/mALWqdJUX03N+Xr/647gLbI95m2Y/biUzta6AgOtxvVjo
         pWtT6Ya9mEDAZNofpN2UASWt597CI6igwryolVavQ771f3yU8Xnhk6LkqZ3IPjnqj1rz
         CEhy9djpJ9CvhwMEeydSk7rcWlVVfnwBINRmEPTFNQd5Tiys5T28V1Mm9H/IJzAXUdt8
         yAxg==
X-Gm-Message-State: ANoB5pnVkH3IqvXUvbc6JvvQbmbqNsadf0hc7ftArW+uZohOYPHjUmKi
	sK0WOPLmRfXtqffnckqboA==
X-Google-Smtp-Source: AA0mqf4hbqup0ttyRnmVRu6dxrtmmRLar42conMeTXgTZeiUAackgzyvODXL1tCMIdY97eO5FK5mQw==
X-Received: by 2002:a0c:fe47:0:b0:4bb:e74a:f640 with SMTP id u7-20020a0cfe47000000b004bbe74af640mr9179049qvs.36.1669223822804;
        Wed, 23 Nov 2022 09:17:02 -0800 (PST)
Received: from [127.0.0.1] ([172.173.198.202])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a258a00b006bb82221013sm12499643qko.0.2022.11.23.09.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:17:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
References:
 <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
Subject: Re: mptcp: fix sleep in atomic at close time: Tests Results
Message-ID: <101e0b8b-253e-d121-2a35-2827c7c5adc0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Nov 2022 17:17:01 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5289200753311744
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5289200753311744/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6415100660154368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6415100660154368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1b888ac1f43d


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

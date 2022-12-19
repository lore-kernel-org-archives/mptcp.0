Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E829A8
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 19:10:33 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id h26so9698031vsr.5
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co2P5idy3/oTrGq4uSvNHpuw1Ub5TBl8ivqXqWCkPJM=;
        b=X7PVwZLNgJuiZz8sfRG9amxxyj5VDMdaU8Mks5lJO/7RjY4/qtGWim7563NXc4RWqp
         fCdOgb8/5stS/UJN8dj3cV8UAw+8NIP9teuKS0tjAovAD0Jlum3JN0wxqw/elgQ022Do
         ph53IH8QI7tFeQbATQMTDBMB5FrOG7DY/zWjC35AJt8Env2f1jx9cZ6DOSv2mfXQlb4R
         FUlQrSy8lBcre8SNFrVQQM+ZOQQIrhBuf8xLz4TqoDgejGuIiSrgs2JkFRrmRr8ozmRy
         qYFbaQ1gG691GKNkTjOpfJtrfbbL5i5/oHeD1b7wj/jOG4MU5ECeHuw89vjs7lwsrLcL
         MpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=co2P5idy3/oTrGq4uSvNHpuw1Ub5TBl8ivqXqWCkPJM=;
        b=iGHiDY+/2ISNapRir+eJDD0hbOE2in+FAtUH3rmiTjfvz3zoNxTFbm3jD9mgnJHJye
         DoWTuqBXOV7qI0jAI1x1qtvgD8YzJvwvKNia281eRK+Tf44FrwmjW3uWFVXTsaNIV/Eh
         RYhQ/bGdUHemZ7LZOrZyLyN3uVeLpkRVC5aAj8YK6djIvjDwfpCPvXb9z+rUKeuRBxny
         qMAFNEGj/NUFLEt7cLAx07wceFfJXzu4T+hcWViWzEQmoJybZ2LGxGMCyH4njexYcGke
         Q6TdcdKmWCbWVff0kxosY/2hZhVZEBbP/XqbYN6OyvqfvJzJZURp8PlYWPLOAGlODK9S
         XDCg==
X-Gm-Message-State: AFqh2krI5LgdtYLn0Ce00YfDPFNIYfXyrqPYJs+v3S2T9cbd1Q3SMwMP
	l4F7MYgWEwOCXLeU9CVTsEBCXFK+iFunFPU=
X-Google-Smtp-Source: AMrXdXvcVVytKHR8c+rXzKPCIXKjjgXSP4eAlXRDIxvRatvoTkUlIxfpdS2ZXTAqZCEwIw/UbOvclA==
X-Received: by 2002:a67:5fc1:0:b0:3b5:3d73:97c4 with SMTP id t184-20020a675fc1000000b003b53d7397c4mr7708962vsb.33.1671477032691;
        Mon, 19 Dec 2022 11:10:32 -0800 (PST)
Received: from [127.0.0.1] ([172.177.155.147])
        by smtp.gmail.com with ESMTPSA id de36-20020a05620a372400b006cf19068261sm7552814qkb.116.2022.12.19.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:10:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
References:
 <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
Subject: Re: selinux: Implement mptcp_add_subflow hook: Tests Results
Message-ID: <551e778e-1094-39eb-791c-b108e866b4ef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2022 19:10:31 +0000
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
com/task/6575725860356096
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6575725860356096/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4746138511736832
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4746138511736832/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5309088465158144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5309088465158144/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6507154962644992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6507154962644992/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/86a067dd1f5c


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

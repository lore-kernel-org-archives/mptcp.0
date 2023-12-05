Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654668B6B
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePT/y6RV"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-77dce4d41d5so324541885a.3
        for <mptcp@lists.linux.dev>; Tue, 05 Dec 2023 10:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701800386; x=1702405186; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4qHY+gIX4ijJuNB4Wtu1689XLtNDl84X2aNhC5n+gQ=;
        b=ePT/y6RVPJ7Sj/3UpuCWXkeah2ExOPi03+cbz1QnjL9PNUJNzhgjpQFWKx9XUfY0a8
         KXaK/0iplqASgMw0jUi+z0ta9Fja+ABLV9LrUqhDG2kpgy5MMsFWoPwAdwE1mVgLaU03
         +YwF/HDZtGn5R0nXd0Z/dcNgF1c71LMhGwJ2DmmYPnSx/qczxYfw85KrTz8yRTor8CeN
         kmgyFEi7grIRMuEE73VMYVXMFpCRT3WuK73igHE4TrHNjw2Zb7LA7CZ01FOa2EOmc5/D
         rfeYaAeuXalWPUphtcHz8s/KoGr6Z96yf1yGE57qUm4pFSu/SlapMnqKtLUPk+bl1Ts9
         XqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800386; x=1702405186;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4qHY+gIX4ijJuNB4Wtu1689XLtNDl84X2aNhC5n+gQ=;
        b=woRQ0NO9/k0z8GNKa/RIUpxyeSKPOxNYK0MyNym/x7gPDGrXemFxw5bDsvNPYjoi/+
         PUVRRCjiuOpuBNhaqYwmmsP1C6xy3GMHtjR5Zq7KBQ6Ge057q/SHAHjytdhu03GfTjl9
         aKF0Y1XIcclaLtoKlKB7vdSuOxiLovKJHWjep3GTL9fFZfmKWHmFaRJBTFKdxPywNLKV
         ApPMLl5twXxZr+5SdVHzHVNPpHkDd08HZf6Nqp8GRn1iBXuYWvNWixySMzBBDAg3T3Cc
         n6tATq9M59/3evUz4EJGaLApKj0kSMk/+aWXfR/Z8RpigH1d4X5/ZGnUwiNZie9BXVdY
         R8Ww==
X-Gm-Message-State: AOJu0YyNod1Ts5+ntZzIyahlBc/emBio36dGi/7GZXpFG5lRcGxXF4Uz
	xdu3MKLchTbalcmxkwY24w==
X-Google-Smtp-Source: AGHT+IHSrH6B8H0wqmdi6NM9ffQkN1kdmczrWmEjX4Sxc4n+txQEXbNla3eSB7YU/1LiX/rrpQ5IAw==
X-Received: by 2002:a37:ef12:0:b0:77e:fba3:7577 with SMTP id j18-20020a37ef12000000b0077efba37577mr1428380qkk.111.1701800386457;
        Tue, 05 Dec 2023 10:19:46 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.110])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a24c600b0077edde498d3sm3556746qkn.89.2023.12.05.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:19:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231205091221.2657807-1-dcaratti@redhat.com>
References: <20231205091221.2657807-1-dcaratti@redhat.com>
Subject: Re: mptcp: don't overwrite sock_ops in mptcp_is_tcpsk(): Tests
 Results
Message-ID: <033e3701-8501-a11b-181b-3d7453410883@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Dec 2023 18:19:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5343194284556288
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5343194284556288/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5061719307845632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5061719307845632/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6187619214688256
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6187619214688256/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6469094191398912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6469094191398912/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d8d6f517221b


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

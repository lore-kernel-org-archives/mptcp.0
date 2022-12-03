Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFAB10F2
	for <mptcp@lists.linux.dev>; Sat,  3 Dec 2022 00:16:14 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id k5so6342625pjo.5
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 16:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krboBoHe1okN4mqztUm27bmVYzCnHj6Sne1f1uLqmOs=;
        b=Se+Dr5u1PV67YhPP2cmBHSUdicfsMZr31wO+A+rEWOlIp6BK8GzGhnNCkRB6Eyj13M
         gRlcNFVJf2kj3QIQP6iMLPgJT5vG+3QIBSzB+S0ejJpCzSe6Y7M0ksSqsdG3bParTP7D
         JakYocZfT1x+D5yO5wrRyGrQkn80RKRxdOXLt4dODA9Q/cO2e4vY53FILCgk8aNzdcIJ
         2+Fvvr8Ja2jLtLX4M9zeqqCGz6Ro59SFXG1Px7tU7ZrAg6t2nQ0KZ7vK5avI2Ne2rUe1
         Jg/PFkwBKkqTVPK0sQZWHlhdhFUV7lk3XHfjF5EGSrnOJY14EWepk/8wbv3quNAlIIwV
         Cmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krboBoHe1okN4mqztUm27bmVYzCnHj6Sne1f1uLqmOs=;
        b=SlBTF3nBl8vS6JJUsCG1O484Hnqow3E3zHvvPwPAUmpYOsjsiDEIIprcjG+rnBesTq
         fuJg58qOWw/yRufTM9xrx3YrCVmr9pBig7FrIbFb4k2pr2te9Ke/e5cUf0EbJ4P6ZQee
         kGm2LVWA+SUpK4rLRifhLuftv1tcz4z/e651Lw3tuzUI0mtqbduG/DCioaNFwixQrEp1
         /sbCqEmv+y4S/oQR0INM8eOFNJixIlxXWcgJSoxAzsdpnN+e9+lYbzlwhxXN0/hGXprL
         XpolTxdLtiPrsUZ9dc+0ClMhn3A8Q24zEa9AnAIlHy5SRuRlio9WxgtoycXMfm+usfCs
         wQDA==
X-Gm-Message-State: ANoB5pk05nu66ME6UHBDbK42bS2PdgtqhD7mRgdo+fA/tFghRfaLustY
	vNQvp8VXy/czB/SQHh4T193WvPR+C9nN
X-Google-Smtp-Source: AA0mqf4kQii5pg0jmBBE9lOzOEelpveh8pxSMYWtEiKe5sBBG50pJK+Rp1hAnk5jLK6xfcBPRzGp2w==
X-Received: by 2002:a17:903:41c8:b0:17d:b9c:cd64 with SMTP id u8-20020a17090341c800b0017d0b9ccd64mr56595725ple.40.1670026573695;
        Fri, 02 Dec 2022 16:16:13 -0800 (PST)
Received: from [127.0.0.1] ([40.85.156.95])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b00186b04776b0sm491540plb.118.2022.12.02.16.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 16:16:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221130094448.4119946-4-matthieu.baerts@tessares.net>
References: <20221130094448.4119946-4-matthieu.baerts@tessares.net>
Subject: Re: mptcp: use proper req destructor for IPv6: Tests Results
Message-ID: <f95d8b17-d7fe-ba24-da9e-4c844fd3b6e9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Dec 2022 00:16:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4825337440239616
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4825337440239616/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6514187300503552
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6514187300503552/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5951237347082240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5951237347082240/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5071165463461888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5071165463461888/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/66d8b71a4163


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

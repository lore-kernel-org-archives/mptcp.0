Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F013AE0
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5qAtpz9"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ba2e03e21cso2115596b6e.0
        for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 02:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702894610; x=1703499410; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bqb7AMSas/WByx5PRO2gLjy/O8R2vg08zzXjoKxiQU=;
        b=F5qAtpz9b0dP+wagOl2HkjldqEh9CTac2OMaWtEZTiimyVHvJYFjfhirrjX3vyPoUH
         asfBdZVmprIZJRx7JuInCaIw0hZPqAkPX+l/H3xJhOuedT825ROGYHWoeX17fXcxOhKK
         e/PTISTwYr2biEOV1ME5WOCJmbEuVxDVZc3QTad+9PVV1cS9kRUMnRfZ4Ps3EKKwwQBY
         Yk0t/8rOWFwILg6xH+2uhIEL1bqRiCbcCrXV8XGRye1MIlSjSEjHryyF0gX1xqx608f6
         7fYy9dHUeYZslEYU2jXVY1cIJOXowe9TJnTnhY1goeO/VsueoS+xaAB/uFu+dtIpXTxG
         D18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894610; x=1703499410;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bqb7AMSas/WByx5PRO2gLjy/O8R2vg08zzXjoKxiQU=;
        b=fBRoPOLdyaOAGUoLENRqcwiEXEZerelOIEzFYAjDGTjA+DMCn9Sgeo7y8q74ZcmQIF
         0+CF2aqCOR4NVX7KJ6bdHkSwtRZEpBAQae3Wjipa5EL2uoE1jTuE/oWiiXEaWpze0aBb
         mqX6qIzmg8kcMuSF0psi9ClY3a3rCD446kp41UCbOGEqDX03f1uqTLLtHfyrAxjSXyaJ
         bZsl2ug7+207dvhH9aAv0v3YfpXU2sgZTYOqb+76CIH1JCuwO2FFwWzxptabZVDb9/20
         8J9NaNaTKVkYoVx2AMwVraNte3YkX6O6vYIBhcHYgdJp549ZzguomrxqH+ShvS4ZX3gr
         lcLA==
X-Gm-Message-State: AOJu0Yw2RK9oGRptZSuwt5mMKZaRZ+mWMpHOhtC7+AcMyMWICEW/IOa2
	1kTkRsp4qAQPVJSu/+lATw==
X-Google-Smtp-Source: AGHT+IEkeMEMU2b6lSjZ8LwifwG2Xor3symjI4hjB7V76PsCXlJey989/Rs1ol2ceLfUosjDO/paJw==
X-Received: by 2002:a05:6808:2e8e:b0:3b9:fe1c:ce10 with SMTP id gt14-20020a0568082e8e00b003b9fe1cce10mr19506390oib.114.1702894609694;
        Mon, 18 Dec 2023 02:16:49 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.37])
        by smtp.gmail.com with ESMTPSA id eq7-20020a05622a5e0700b00423e6a986dasm8200307qtb.82.2023.12.18.02.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:16:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <573a8f55b47fb4aa35dfdfc49f1984ab7d232781.1702889134.git.geliang.tang@linux.dev>
References:
 <573a8f55b47fb4aa35dfdfc49f1984ab7d232781.1702889134.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: diag: check CURRESTAB counters: Tests
 Results
Message-ID: <2718c77c-b7c6-33b6-0258-83756b48d5be@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2023 10:16:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5273686110896128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5273686110896128/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6118111041028096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6118111041028096/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6399586017738752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6399586017738752/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4992211134185472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4992211134185472/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b3cc0559a864


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)

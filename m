Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6122063
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsruSkHt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d35a721340so4290955ad.2
        for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 10:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702491305; x=1703096105; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LFQfVuyTd50SaImooFNf2XpWoSgK7HE9kQXfM452xI=;
        b=KsruSkHtjfwICwji+ABKqoultH+8RpNCJnNq2i/PnDukbKANI4A/KZq+ZAbX5o6Nle
         bYOhHjv3qRDYupxOPdDTlRaazGCNit26KBXs5Z3edBuForjgoP7ULLE155f7MQXRR+S7
         7w89R56gI/PxCf0evvO2yfI8wxb8BjRfs+4xNa/6Io62jvetl5Rj18lyfQcQ8xuxxigF
         Q2nECvo4522gPgdKdngffRs+PIcqTNfb6kROFFixrUNIxkeC6aRJrk69E9ZfGIJQR4l1
         X906mNdTuxanQUXh2Ulk3gEqP814cYsqGHz4ab2JEcz/hsfIBnUx4FTW7eHIYKQVY7Js
         4gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491305; x=1703096105;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LFQfVuyTd50SaImooFNf2XpWoSgK7HE9kQXfM452xI=;
        b=eMS4ZlV74xFPeOeRrfoOv0V+k9prkBi7vHuSgRF1LBE/XhWODHaOqQjqYiTiY7KOY2
         JNJ0xHRc5ynMJGWx+dLeEaugZ2Ld2mAcCSBweXCtOFu0UD7KuEYHXBoIWFF6upd3LRlu
         ZCk2fyDdj1y/0BYiD3ds/+vhSLr3rLoERSjWGBnfxhg3HcjOSL9WUgR+ZMVMNq+hvOTU
         uRzaZg98SC+nM0eoluOqvwpWSznE9yEm90jBEamH8p9xTLt7YCan9JJgaKYBRNY3Hzpd
         TFbU9mH8vi63SfBpO39BHy1B+o26BVae+yCCSaipBpAiXRU4zuez8zvDeAcRP/d9wzsQ
         99Iw==
X-Gm-Message-State: AOJu0YzRljTrxW2uNKGVlrU6zwydGcqw1xY/JRfZ1OuvBlYMrhO4++wz
	G4ZWb+z55rYABj0KOTmcWHIgbwS0QA==
X-Google-Smtp-Source: AGHT+IFdM4EUh2vaK9rhrWOhXOFRWlKLGCXAH4w3j2bkZ3jjA5C2gNSTWARVB2tM80SOOxpMLmnTwg==
X-Received: by 2002:a17:902:7848:b0:1d3:6255:6c9b with SMTP id e8-20020a170902784800b001d362556c9bmr292551pln.3.1702491304841;
        Wed, 13 Dec 2023 10:15:04 -0800 (PST)
Received: from [127.0.0.1] ([20.49.55.68])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709027fcd00b001d051725d09sm1864879plb.241.2023.12.13.10.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:15:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231211120309.20752-4-max@internet.ru>
References: <20231211120309.20752-4-max@internet.ru>
Subject: Re: selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE:
 Tests Results
Message-ID: <c53b7178-5cec-554a-7ceb-0223b868df42@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Dec 2023 18:15:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Maxim,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6183200901300224
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6183200901300224/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5620250947878912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5620250947878912/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6746150854721536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6746150854721536/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4520739320102912
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4520739320102912/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b039ca39ebf1


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

Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A877128E04
	for <mptcp@lists.linux.dev>; Mon,  6 Nov 2023 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vws+RQtw"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7fb84f6ceso48915157b3.1
        for <mptcp@lists.linux.dev>; Mon, 06 Nov 2023 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284429; x=1699889229; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxTDVYdrRDtrLnbdGFef47/MY80RoGo3ClmYXtKHtE0=;
        b=Vws+RQtwdglJFboXROxSXayu/DT383aliPGwDa3fssQR+aMvomNnpRMVczHbsLsK8S
         TxI5m4yhNb03PlKobQoojTAK45JVMnEbxNv7Wf+fv39Ukgkfo2imY1D+Un+NfNT+QYZ1
         1RBhoPzAmCrfuNeAbWbOSSYq4WGKBxvSBkbQKcuRk/SBUll8v958PXGNRhMN893fiOJt
         AKXU0EN3q/z3DbCflbRkX11stBAmHFVKtT2nt4NY6B/KjDzBw0SGx9ao6WGfSa/BfLUY
         Ke5AqFO+P9kQseU8JuriIy7K25ESUV/ajNZnDHyvmJYqcHkOuAjHyDsrx7Rx0Xc/D0X3
         DjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284429; x=1699889229;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxTDVYdrRDtrLnbdGFef47/MY80RoGo3ClmYXtKHtE0=;
        b=CGjsqPg5qic+Kl3vCzOE+ySGmgCe79RhJhcEGj5GBPwLjT9cErI0a3TcSo5DZjc9N9
         cj2SsRDw5fSKbW8LXoMJOXyXKPkzyY7ePlBCkDiP9ooyR3CewscDWth3gDmT3np2nm5U
         axJ/DzvnUR+UWm0eFMeZzmU+UNUszYnDNqNnS6Ssbift5x6RsxElMfjcFzntPirKuNI7
         UP489lXxomAd98gFsxFSEAEJ66vTL4NYkSDFOSIUqZ9ksDRJTh9h0u0fCoZ6VD7BXt/Z
         8mWirIeVUZGWKf3UtL9YvRuvWFwlkAYBt6XElA/UhpT5y7Z1BgMhAnIZROaiirLiXnXf
         Cygw==
X-Gm-Message-State: AOJu0YzcvGj3AnjszpR+2FUHNp3HqF/qzIUaPY7K36E84DQ8TfTPJHZU
	Z6+i7Vwf6knqaY4kEqHerQ==
X-Google-Smtp-Source: AGHT+IGFOC+FePsmW6pHXdir8830YX4mIwuzHfC4d4lN9gpqouGqp5w6Kg+gmtXY3C7mNBrRQ79rJQ==
X-Received: by 2002:a0d:eb03:0:b0:5b3:2128:5667 with SMTP id u3-20020a0deb03000000b005b321285667mr8057769ywe.6.1699284429520;
        Mon, 06 Nov 2023 07:27:09 -0800 (PST)
Received: from [127.0.0.1] ([20.57.44.130])
        by smtp.gmail.com with ESMTPSA id lg21-20020a056214549500b0065b24c08994sm3508604qvb.128.2023.11.06.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:27:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3350eaf14a073538bf491f93fc852cd02ab0875a.1699280113.git.pabeni@redhat.com>
References:
 <3350eaf14a073538bf491f93fc852cd02ab0875a.1699280113.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible NULL pointer dereference on close: Tests
 Results
Message-ID: <845dfd45-687a-b808-24f1-f81677c6abf4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2023 15:27:08 +0000
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
com/task/5967971751821312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5967971751821312/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4701334356623360
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4701334356623360/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6530921705242624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6530921705242624/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5405021798400000
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5405021798400000/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/78fb6e638f64


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

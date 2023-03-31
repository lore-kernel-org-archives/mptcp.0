Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12CEBE
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 10:30:25 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id j13so20001720pjd.1
        for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680258624;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a44RivD132Fxej6fwqxks4B/5hiYATN/I6y/+/JpaU=;
        b=h/oz/lnSwhZwMpD3Lqwy2jBwVy+QbbdFpkgYkyJi1++ET4AMQqMaTSl6SPEHgrlWeM
         JWQBVBNMcWpkUMEa5H0Vo4N/ikXencDbWjjNGgKyR02P1NbyTSS+DdEyw5V3f+rNeT1+
         TaLKat3bcr3MNws5mevGb6vh7Y8lo5PcCxfaHDH/VBCr6XSTY9LwKdZLjclOjWy1QI9x
         zCGEazUcU9ZDdGY4d+56qFBOlpq88scgYTCIC5DxKtEZc0hSGFfgVYFKhR38MMpJWLrS
         ZMZugJV+30af3cBffM8SBkoXnezB/GyGtR9TJfTXk9vL3DMmx+jQCll1+cRfnDQrd277
         OeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680258624;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2a44RivD132Fxej6fwqxks4B/5hiYATN/I6y/+/JpaU=;
        b=N+AD+fiKfPOmbrbkdxF61pO6PbATl64ZCanHHgyp0tY7dRI+57zlTZxzFYu7rTkejz
         Bg3Y5dxnHED9Qn8UG2iYCrsjz5NoqBcRlIHEuG5Yb+CIinqF/lgokvg+Wkhxr/aByHvt
         zLaImHTYy2/8dSw91KDF3jSdfuGSM3+Krg15Fmct7iprbJBg5k7qmC6NfhNxqZjV/O+G
         wADH5fWTX6mk2DOT0fykAhetjeu4C8sc8h6EXFg/NxXOT2rLciIt97ugVt+Ab3akcLnq
         80GmOaYGp21fmxUr2dk6wOLq8STzD8WZG8hwFdG1wYBiQqOIiiTmmPqFswIOrq8nkv8/
         qaxw==
X-Gm-Message-State: AAQBX9fTGF6oIcwLn+LmPyXmPJiFfQMeKytG0nXckNMjAtpzkGPhsuAN
	vRHiH8LRbK/Nke86MehiFQ==
X-Google-Smtp-Source: AKy350Yx1Yjh9wgV6FyxRcTX7VkCAp7oKbMwOBRTvKBF4uCwvyT/Imj0tDA+5QaZb5NbiE+NiYKlvA==
X-Received: by 2002:a17:903:188:b0:19f:8ad5:4331 with SMTP id z8-20020a170903018800b0019f8ad54331mr33080742plg.38.1680258624421;
        Fri, 31 Mar 2023 03:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.73.50.84])
        by smtp.gmail.com with ESMTPSA id jl23-20020a170903135700b001a1faeac240sm1224531plb.186.2023.03.31.03.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:30:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <07059bdc844f97430ff5c92afc548485b1c20d74.1680253474.git.pabeni@redhat.com>
References:
 <07059bdc844f97430ff5c92afc548485b1c20d74.1680253474.git.pabeni@redhat.com>
Subject: Re: mptcp: fix NULL pointer dereference on fastopen early
 fallback: Tests Results
Message-ID: <2b00d2fc-41b8-46df-33bf-c743f728c8dd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Mar 2023 10:30:23 +0000
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
com/task/5973018384531456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5973018384531456/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5410068431110144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5410068431110144/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_connect =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6535968337952768
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6535968337952768/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4706380989333504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4706380989333504/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5d2768a16a63


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

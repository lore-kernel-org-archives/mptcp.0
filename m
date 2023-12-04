Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364F241FC
	for <mptcp@lists.linux.dev>; Mon,  4 Dec 2023 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7ahdoWC"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b844357f7cso2599535b6e.1
        for <mptcp@lists.linux.dev>; Mon, 04 Dec 2023 10:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701715708; x=1702320508; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXNNZ3u1zopcnim/mPfCEnGFEBl6hOaxuEyzcJQ+t2c=;
        b=J7ahdoWCwi+m8C2f8lwLFD/p5TBo/toea3wbYnNt2r7lhYT0mI8bYmjZ4PTm9og9ok
         t61gsE4B4TgtIUhPou1wzvdVHzfya+wmA2xIDpMADdOWQVYe53lOEiP7w0Iyy9pyDAro
         SKC92pobhIRnN1uaH8aEhlfwYJJcAyyxTwCP+5PG7utldozQkNqjP5PF4js00IlWp46U
         lhZbzxvdKnXmooz07eE0WIzY7A+aWWxlNA9NZJY028LtlDtmsqHXlmjzrj30+96BWj+g
         55llL7dNOS9ECxyfVMi7PjGzmGQuXGiZiq1Ddei+WswWjxtyr8R4Q6l3iQ6bkYezklTv
         9jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715708; x=1702320508;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FXNNZ3u1zopcnim/mPfCEnGFEBl6hOaxuEyzcJQ+t2c=;
        b=bWwrKYEHXUGLwEA5tQLE51FohrY+zQEXLfjN2VHl1h4Du5xU9KBAk10PcoZxo6Kcmu
         3SRNXF/UBZlaDsOVkOR0ufG8w3THsIIN/XcTYP5C3imgfoBdTd+ho5BxF1h+blmcicPk
         3WDunfXHxKGEDCGx7p/PdapZHXv0z0cW1+Of/RFKx5T0uWKdL682H7ldcFFYzrS55EST
         zsrGJCyN2xuRtn1SJrO6IcN5bhmj5+d2QRUswFReCjCblfhoSeuqfaERy85+jChUAL7v
         1R02PoRdzdgetupBtY8EC9FWP8buC6lC6EWpC1YfvSrkBoTVE5rx/DFvb+nE32oCmMni
         yjpg==
X-Gm-Message-State: AOJu0Yy8IlHuPX2P5F5sC6QvKWaiTv+YN2qzq+2S4GsIsR89b5QxCuv6
	moL7aXULMykkoatQmiE04w==
X-Google-Smtp-Source: AGHT+IGy9h2NGGGcJsxyJ3ZS/9nDBgGHr8DWYu9ax/Qgo11ShV3NkQRC7UIzrTSnVP70mF4XfNTtYQ==
X-Received: by 2002:a05:6808:20a4:b0:3b8:b063:6b8e with SMTP id s36-20020a05680820a400b003b8b0636b8emr5840549oiw.61.1701715707992;
        Mon, 04 Dec 2023 10:48:27 -0800 (PST)
Received: from [127.0.0.1] ([20.81.46.146])
        by smtp.gmail.com with ESMTPSA id bn6-20020a05620a2ac600b0077dcaba6709sm4391030qkb.135.2023.12.04.10.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:48:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231129113403.157953-4-max@internet.ru>
References: <20231129113403.157953-4-max@internet.ru>
Subject: Re: selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE:
 Tests Results
Message-ID: <4328c19e-83eb-8521-1e49-4ded0d6aa369@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Dec 2023 18:48:27 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6340620462063616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6340620462063616/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4933245578510336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4933245578510336/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6059145485352960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6059145485352960/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5496195531931648
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5496195531931648/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1963033034f8


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

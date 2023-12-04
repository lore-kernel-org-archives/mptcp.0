Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056C35EF7
	for <mptcp@lists.linux.dev>; Mon,  4 Dec 2023 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL9Xdqfw"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-423ed5fb48eso38930071cf.3
        for <mptcp@lists.linux.dev>; Mon, 04 Dec 2023 12:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701722117; x=1702326917; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvx/xrWgV3C/8xCRPRjF8/z065RkP4DQgVR73V/eTx8=;
        b=aL9Xdqfwnwj3AK5HabWa3d4SDEj3mMIDDBoa5pE6fuQETar7BEEPKOFnwpOEZg7Wyt
         +kJkSvsKxn/VO1/63oKQnZVXCEOIQmBkk7vsOJL26sDKag7Mer/6yc++zoiw3D2NjJDt
         fqwlBnus00UTmJbz7bvI4CTIaHjJmoV0ondPI/3QnGwZ3itBMcDxdq+yoT+Dd/VeY7TZ
         aXK5Zx8njdA+Dp6C23dpxg6AH1GtaZVgY1IFJ79T9nMNwZj4jg0Of7uyAsayz5JIS4LL
         BGMa254yr7b6iE9MFllxFWLcjLK+tn7k8KiWQqnDPokidPsFsl2k9iEmB8tpyTm3UgWc
         yWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722117; x=1702326917;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvx/xrWgV3C/8xCRPRjF8/z065RkP4DQgVR73V/eTx8=;
        b=hO5qt9Z2pKsc0i+WM1uON2B40/uSDbubu3/hGWDAcOd1lOyE8u0QNO56DU1Xk2W2iZ
         BquKY940cLX5eKlI3mDdmlQ2Et7RuYvfrFeD3Er+gMjVGGajfrw1w+UfMBo1U7ypGe1/
         5+IIXNb2s0YF97pWoq4LFpUHymd+VkbH+I4YJYS+22sBUk6b0yCecLaLjQLMre5Z5vC6
         XOIxR+nbzJQMI8b38VtYS2YjOJTMdflr9QFKQCeWuC9Ii20eN2PZXy02D9+AqE6yg9OU
         CrSOxoldJ32MejjfTtUjPYith4dwp6codO70q96Snhsnt87p5nDGkyLuxHtWoTaFteoL
         StTg==
X-Gm-Message-State: AOJu0YxBSvTd9/ZyWsI232hkjPRKG6KCNIJo82jjXC8vhOHTh9S1fbA0
	Fz8Y5pIo6IFMOrhttA6xt3UU0kHgyg==
X-Google-Smtp-Source: AGHT+IGcihiP10va3D47g7m4PS7ZUpBPrBCjOdOlgXm0H9b2SecYV5RH5pTuj7wgZtW/SsqOrvVxzQ==
X-Received: by 2002:ac8:7f4c:0:b0:425:4043:7621 with SMTP id g12-20020ac87f4c000000b0042540437621mr156307qtk.73.1701722117356;
        Mon, 04 Dec 2023 12:35:17 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.139])
        by smtp.gmail.com with ESMTPSA id x8-20020ac86b48000000b00423a3f5ea75sm4557335qts.21.2023.12.04.12.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:35:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <957643abf70bab8b5e0a79b7b93be7a32dc3e324.1701180969.git.geliang.tang@suse.com>
References:
 <957643abf70bab8b5e0a79b7b93be7a32dc3e324.1701180969.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <9a6440fa-be02-d34c-0e9c-940a8c73caa0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Dec 2023 20:35:16 +0000
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
com/task/4613003270684672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4613003270684672/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6301853130948608
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6301853130948608/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5738903177527296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5738903177527296/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6487375115714560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6487375115714560/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9a3366ece031


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

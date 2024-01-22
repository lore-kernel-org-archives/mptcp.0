Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEE4C65
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705895686; cv=none; b=CF4W9A1eokPrgtxkecPhnJdvC+wUv0cMZWKGqoaJduTPd12Z2bVpCtAVDPrFD9QR62nZ7ut1iBK0HXuUw62iBW5v7dRinFLFJO04B9lVj24DThwBwZD8MzKbVBeHq5Hqd3E4G0wrvwIHZ7J7aSphg18NiY6CdhMCHR4JiodZ2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705895686; c=relaxed/simple;
	bh=pd7HEpgthJt6HOj50p9ofB9RYdxjHFRMZyvpD76Ng9Q=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EZ7Dh+96kSxaiGrhKDuIf9FnYLzZFStbmJ1InC8OJELIMAWCoQqP2A8Cm1rfu74YqKo6AcJI17ivWnzbkiC/RM/uHCP39NrddQlGj8cdyypCLQ6vNm3Uo1gIGby0Wvuhl971YlZ/9gw9I3yZ0lO327JvJNXVVCS9NNISMjLLstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbJHwlBF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbJHwlBF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d70696b6faso24208825ad.3
        for <mptcp@lists.linux.dev>; Sun, 21 Jan 2024 19:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705895684; x=1706500484; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQOiXK8dHIj+M9pjV+MYS5exXlZo3WJf7tgLxKuL9vA=;
        b=dbJHwlBFULW7YmpjAKnfciRZsXn+taPNzitCuxFWPPiQPmAC3Wsgu84zvu5ZHO0bas
         NVyob8zC9lqUj41+4ZKHRbLnhRqdYKoLfIypDLtUWPgBrNQKaXIUMUjGq8vNlfjd8RiB
         ReoG3NydsTRtMNiowrjWBqXPtTSxCDrEpOvLcImJ321qHP9al0bQHbExyAgV/jmT0Ck9
         NaGqH72DfwMPdkWECgievjsBXXJd2NaHAn1QBNFM1ZYarHxUYB7wLD9OZGE/ik+do8H0
         mBGPq7990jWDa0cfWaJSsfj+kzd4BRfpXsO+jFV9GebJqGN6DoWIRh5YEqi2T9VeJp06
         /BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705895684; x=1706500484;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQOiXK8dHIj+M9pjV+MYS5exXlZo3WJf7tgLxKuL9vA=;
        b=edX53lNXooTERPaHlqo7ORC9kBMLMfOufux2Jb5d8T/zUJouiRqHcOZkUzgEhVoWRE
         4ZtJf799Ps4dQ0EsSpa3kOFzOdhhOe6Why/QeYmprc/BMahwJDBhNU/kxiSm9GWU6V5q
         PYPbgjdMDTXWoJVyAmqHSS/3YCS6kT8jre1epbRGJiHoVLWSdYxKHWropFPdiE5S7Bop
         ScQo8ojTGt0isjSjLgtkYlbPcm38T7Ym0xR/GCw3BolU42sFn3PKmeDph1oGeU7a6O5A
         7fnyON/Ov4h6ZLvtxN73HpPXN1hFAtTZ4b39i/RrNRSQ136cjaVUW2BhcJ9bN3zbnBQW
         YS3A==
X-Gm-Message-State: AOJu0Ywb89lsakRnCr320tKZKazfToJ0tjFD7dY7L+zdtvi10Ca0rEya
	PyO5cJoBVg5bTlNzb5fXORfJ0oQC3tJ29RZr6nMbJ0z/M/NmksU=
X-Google-Smtp-Source: AGHT+IFiD1bBrJ7dvxsbOBt9B3us+3HWpw5b5HKIMjp/Ez6j2JingI2ZnEDfR5HDH4jJw+W6LX0Uiw==
X-Received: by 2002:a17:903:2984:b0:1d7:5db3:b872 with SMTP id lm4-20020a170903298400b001d75db3b872mr144672plb.119.1705895684405;
        Sun, 21 Jan 2024 19:54:44 -0800 (PST)
Received: from [127.0.0.1] ([52.238.27.218])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001d706e373a9sm6208598plk.292.2024.01.21.19.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 19:54:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
References:
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
Subject: Re: selftests: mptcp: join: stop transfer when check is done:
 Tests Results
Message-ID: <b8bb2b04-6dd2-aafb-94c1-b70e5b294408@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2024 03:54:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_mp_join packetdrill_sockopts =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4673273665945600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4673273665945600/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5799173572788224
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5799173572788224/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a54e692a5628


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

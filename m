Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEED1339B7
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014026; cv=none; b=ZCegfhUhExRJ8tgx0VtayzPTpdRH298wpR9j49FWVecJb3tUQBy5d4+6TCdz8WJvFr7xWfhvJuCpqJhfEZ2C6D4PTFHwNdC6qbbWA66ugc20SOTpusD+wursL1HXXEARSRXOZtJjMG1NYGf0Qp9L0FoMFGApA/LVW/sij9GFDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014026; c=relaxed/simple;
	bh=iVRwnklsm4xOoCXcFIY51A/GN64PtvF1XP4nIYZklIs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EwJzS2GsLAn/pm+aDgsEaUetMITOGDMwohzJvVSNMlFA/yObSc3zfv16kxb0vUTuEeS4dpLPXjoWy9QnUVPYDFjRYApXBwne+/hNeJgzX+w32cXmQ3cwSFXqVIg0MkJB3f9JY7bomVwkOGUf+gMjRF0+5bRfgd29xh5IkMiq2Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOPXNl9z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOPXNl9z"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d953fa3286so8992955ad.2
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708014022; x=1708618822; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9DoZRE6UMfPdS9izwQ2SybkzH+hcLKlMVfaJAjnEos=;
        b=XOPXNl9zQY6FyEzmgJ/3NSA+MIW6nsbg0DlJiuFmjPUfe0VasOPhqfZno8r47Q6iVG
         O93e6AUPa2iN6Rp4w4xsSviHzuPbnW/AVAiJaLk4JF6+Fe8wf/AEEZ7N+2l3fZV1dH8k
         N7hV/RS8BWcmZFzeGsRcoIxp+BNIoFBjWG1A9eY/VrSQyttZXvAZw5K2rrA38hxUAkYR
         y3PedEXiNnj/+qrbKZZasUIQZEl6dsc/+NDkpvsvqT1Jrwd6piwUSYq4K3DOTKz4OoUX
         c7zqyXXmBidEthXi55M8D3ixgz8Pf9qMLViFeVKbxTteuFcjZCbstp4N7lR/RU7YNqIA
         Vtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708014022; x=1708618822;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y9DoZRE6UMfPdS9izwQ2SybkzH+hcLKlMVfaJAjnEos=;
        b=FKNbXR3iCjMVBQfORzM2ZfiOGAEqou6s7O7jfbvvvKYJ2NLzZJexy3C568BUhDJHlA
         w9aDi1xq58m96TZ4dxA407nCh0+soTipA1I73Jf6+gklIVTxtbpFP7vaEJy1pRhx6vgY
         VkoqLso8hiugJRAV/Vz4hwbcLl8zI+IvkBPQ50Eo0gZ57Ob39hMAStB8QcOf1qIf4wbp
         VDplDBfyVEM4yS8lQ/5N4CnZ6oBhYpgb7SmYgRaZgo0+1ofNufam82BZWYsYWeLbVgFn
         Qyn7qqd6xGVuFH4hZg4kK9TUYxE7yp8uF2DU9jYat6ZZY4Pytp6wiRtqEtKawCOy6G0O
         hCoA==
X-Gm-Message-State: AOJu0YwvBfbE8Y4eCBf3SFwCVmkr8JPiKOaTHbZSOvnoRdA/mXuYZqes
	iC9/GTOLpMfS7KlhaIjxIE+Q7r1YA3Z+CE216YTRoWdU2wZuQDeaK6Q7p2Y=
X-Google-Smtp-Source: AGHT+IGjvD5tJMXNcm7LUdkmweOVVk+gFaU9MAKycX5KpsMUFPpa9GCHQ6DKxEFFliIvJIXPKiswcg==
X-Received: by 2002:a17:902:a589:b0:1da:2122:be72 with SMTP id az9-20020a170902a58900b001da2122be72mr2082046plb.62.1708014021854;
        Thu, 15 Feb 2024 08:20:21 -0800 (PST)
Received: from [127.0.0.1] ([138.91.70.179])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090320d200b001d9606aac46sm1451318plb.212.2024.02.15.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:20:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
Subject: Re: mptcp: avoid printing warning once on client side: Tests
 Results
Message-ID: <44934fc3-37f5-4700-0e07-b00153b5bf87@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Feb 2024 16:20:20 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5453570070282240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5453570070282240/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6579469977124864
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6579469977124864/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/39cb90ad6cf5


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

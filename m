Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C2156963
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622288; cv=none; b=AtHxftul6Yv+8Lmb8gHqscn26Juq1v42oDOuG4gTKV8BAT+eFHHqhdnzU3tkhYGyHB+uboje0G92hFZRddn3Um2jy6EmmYXUapmlABHcC8FnhYJd1c5XoWPDT3xkjR5AUC6Sp6n2WMIcxnjsjzfUB26E7lDNu9ru7VP4hm3t0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622288; c=relaxed/simple;
	bh=18e6azjtrPjiANMyU/Eeh+iUMrAdZHGM/oHg5bxOLsA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LPSvSlvqocrATt7UBk7gJlukXbPjn5TIjPXKXl1OusRJPQlwDoTvbg2OZnHpgEwm1Gp8A2qS2M1sgi+7JUzQOvQQqGcoCHq10p41+8sSgViVmMSAu3b9aRzD6H91CbMdF8NokfvkvOkn2lyFtVu88wxlneYrMmTRYwwapsmpjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM1IR7vi; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM1IR7vi"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e2f12059f4so4015776a34.0
        for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 09:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622286; x=1709227086; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shsmkvXnjuIaparilZXkaZM67xkJOfavmzIl2T6yp6c=;
        b=AM1IR7vixa0Bsxyn9FQqGlr/QICWlaLEmcMri7SbuadF5bKnaw38ru48Ad4WC6pBGc
         RUTZMjYyzmNNAkeF5lteui1ImkBP9mHI9YIPlF0laoz0AsRsYPgVciBE1K/dxObUtlFK
         4xghaTfPJLoEhTzH2AoXEr4hga+/FNCthxpT2M3XZ4bTfe5d15IIFoWQ1roEMh3hkEZp
         7poP066O2VPzIXYL0/oGXdfy3DpQIwVrhIcMB9qETU0EU5YhnzOXDbDL2mF+ZqLUqvi+
         kV5qXlOaXfPuuzjEMddH6QiL94Ms2E2plXDTd0Ybik1qKsOh2UT6AVtr3Q2qypLxDdl/
         A/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622286; x=1709227086;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shsmkvXnjuIaparilZXkaZM67xkJOfavmzIl2T6yp6c=;
        b=WMdktDjwmq64EtSu5yLFktaOQfrPzf1HvivEPuU4jAUlEw5U0nR4qMZqxJPuLTBKPE
         4lKdamibM44CctphBYgg93v1sQDZPLhO6EG/C4lA8RL9SY65f+D8Go+DAJfgRVuIRL5G
         SgHXm2oNNAUXidlQLOhJy+2WMLw70PVs2+yPVa2S2dyWR50K65j9XClnMgCLmh2BAGJx
         JXZrhu4Z6YhSFnjQgMLw4V7QvwpmYCYUjY+SZF4eW/R5FlZqCeJV7Ipc0YSXAQ0I4mmr
         /MBykRAesyKxCIyItqV4Oef3G4gzDMUXvKflct4FaSF+w7jGe+HmfsXWKH6cLbyeGFPE
         6M9w==
X-Gm-Message-State: AOJu0YwzO9vdjkJbegTF5QfDfk4wejg8eAYMjCEEQFdPKKS7FMcZtGGV
	xAW9Nxu1xGCgA4yBWWUgW2YtQ9hkd58k1e43fOUQN7fjBHDvpts=
X-Google-Smtp-Source: AGHT+IGJ1KTFG1GUqEPhnOD6Thtvq71QwUqS45oaBUC3dBheQTjHVlJQ+X3emrPNXTye5eafHySS7Q==
X-Received: by 2002:a05:6808:140d:b0:3c1:5c07:76b6 with SMTP id w13-20020a056808140d00b003c15c0776b6mr14072803oiv.1.1708622285917;
        Thu, 22 Feb 2024 09:18:05 -0800 (PST)
Received: from [127.0.0.1] ([13.90.174.193])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068c88a31f1bsm1565425qvb.89.2024.02.22.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:18:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240222-selftests-mptcp-shellcheck-v1-6-fed8ba9e6ca6@kernel.org>
References:
 <20240222-selftests-mptcp-shellcheck-v1-6-fed8ba9e6ca6@kernel.org>
Subject: Re: selftests: userspace pm: avoid relaunching pm events: Tests
 Results
Message-ID: <c67c1936-3d2c-dc00-332e-aa2fd4191a62@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Feb 2024 17:18:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8007938586

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d13f3daee3ce


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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

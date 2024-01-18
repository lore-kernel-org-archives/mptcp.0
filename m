Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4229438
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607594; cv=none; b=qo4iNRs3gl6ba7VHjGJLn6tq2s4buyOYFnv3JFMMQjekrSO+T+nW/5nRiJDMDSCDZer5YTIIh06KHbKnbikTiY7pyvWhBFnTrXbLHoiIrapf73P/cF+zHs6xEb2ortTAoERXcl7n26orQMbKqeH87wR/aBiyrPZxrxhWs8Ci+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607594; c=relaxed/simple;
	bh=6wpx8c94XBS5FfscnJ94zNYPyy/aRlZZlgeBDqsatDg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hZhrDGqZoYqVmepfGL4ECIU3zeWAotT1daD0WyHPvZf1Rh/Fj0verzzMyUUtbvm7MFdvV1zTNa/QZkh9yHL/UddQXAr8vNlenQkzQeLid29RQDULfag89td3Qxc0UmM3xO4/NweqUlo2JjBbFphPyVxpw6v4RS8i2f/Z4KsrQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzmGuM+K; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzmGuM+K"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dd8cba736aso5509a34.3
        for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 11:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705607592; x=1706212392; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjhvxRB8u6CJzrIJVB/pqbxEhyCR7aQik+VBqfoVMHs=;
        b=jzmGuM+K9Nc1GMGy+aPRGOKLu8BR7RaEY/Gr4F1EQNgfkD4V7J3NyrJvy5yesAnHKE
         Iac9LrwuWZ5utTHoJs0ZgWTt/FQczGtaTJzAyW9L4fzM3UeQUQxj+wuKB8jVwy6JHJvp
         eaWyRVSvcJ2utxrOjdFyWyLeamuKlvTtQsX3k2U0WvEEiMlz6IKXfp9PU45IMhD1KpiM
         dCziUXVK5JQSzobBiAAH2F8hdyOvGHHLD+jICe09TK9WwgEIFiAD21n/MyRHico4/Lik
         /PSoUBR3N/ho457AhAGanDqd7fmvdu/HTGKZ47b3kgXmhZTAjYS6SlqYkqpbudhI26Xr
         r84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607592; x=1706212392;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gjhvxRB8u6CJzrIJVB/pqbxEhyCR7aQik+VBqfoVMHs=;
        b=XJplHwyWBoKAyBvzXE83D3xqs8VMHhzFPZGgZJ5spBSN8aQ2FgzIXZ9rp7Be0CSHCI
         6NagQcdRtnPni/iiVc8h+Q9KUoucml2VXm7COQNElk1/3kkFsXtSk+n7gqmW/bz7rkiy
         gzCPRDUXkiBrVNfDAZMI/btUeVt0LDwI5YG7p2shpxNEzyEOfhEke7xN1Sd0m789qu2o
         buyYa5WpOMV2kRGimDDa9JqsuYs+Vrp9auuLCKFGy8s0g3ptj31U5cUFtE3tKAG7DRoW
         wav7cZZsA14wlaveQsZtfegn53aailGJJnOVl46MxHuqzJGCGlRPiTmLghn73UX2Sf4k
         mD0w==
X-Gm-Message-State: AOJu0Yz49Ri7JECnacXMGFNgfc1yipTCw69WsMKz3lK3tT1JPkLNPfBd
	vbUN4VF8I8StWtaBsWJvETlYeSVSTiyVPHQSoDLcnzLqF0/5oEAIQnL0zfc=
X-Google-Smtp-Source: AGHT+IHhoH8UpFZ6ybLXyxqnohRuteD5Cdyr5JgolCjOjILtAvwNoybvZvVT8BBN/3uFhBdqLhn4OA==
X-Received: by 2002:a05:6830:7:b0:6e0:c031:681d with SMTP id c7-20020a056830000700b006e0c031681dmr1509462otp.55.1705607591552;
        Thu, 18 Jan 2024 11:53:11 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.99])
        by smtp.gmail.com with ESMTPSA id v10-20020a05620a122a00b0078321b70b05sm5512940qkj.101.2024.01.18.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:53:11 -0800 (PST)
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
Message-ID: <5a02fa68-a577-3bc7-88bc-84e2d1cc2e5e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jan 2024 19:53:10 +0000
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
com/task/4510682075365376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4510682075365376/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5636581982208000
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5636581982208000/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2af4c20dfe1e


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

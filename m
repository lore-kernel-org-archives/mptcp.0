Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE069953
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277921; cv=none; b=QFQxGqSvanqRU7483YN+Cmyetj1K+Fr99qDSaF296fijgWolrANc5yvzJOvb1BhGDmXT7hDizk9ApdVjq0LCNtEfqnyNJkGu9Mf5fRnZvPrPVQdLBbS9kbeVeRxjfp5ZJtGzkUHM2XSXXCXrNBmm8UDOikZNc9yS1XBl3B+DL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277921; c=relaxed/simple;
	bh=xLO8r7z9tPnxsQfNMgReBt1fLc89W9etTM8MEp4wAc8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=s0dWCucCOyN4byPraqYkVUheLLV4nzqQ2cF4Uh2hJU6BNDT2pvBTgdBfHEWESqPVNmtPNxHlnrMhlN55uSOEOw3isljjamGGt9Hp+7ppc3k6EVI1jqvcLTzDabJdHTdmmay6Gn0jJG8sBmcxS6SmdPsqyRGDghCNCNZr7FXswuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K55KCeTA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K55KCeTA"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42eb2a8e515so9389951cf.1
        for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 23:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709277919; x=1709882719; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLYfug6C4Ox1djZNW155XgC/2ETkTLKcsDq92quytg8=;
        b=K55KCeTANKn9P2tSZBI0iVC3mkgeJ9YJ0ljp62y3pzyFLMvh9c7s9nDCzBE+LthxCk
         Zhoe/IKXi/44m9Y8LFsQJlpF9cDSqZOgM2hlVwbgTEgrUSwvgvpxRD762m/r19in7Qqt
         xBQCTLQdIjtmrhApdC93IfdHZUdtsIZ5YImNNN6HjwkYn9K15GCYPRlCFlc7TCzCxZDb
         y06JdiF6RrO0Bfhd0NggTiJ84T4PKaBVmJ5f2jl0X9OyEsD9dBudNpyUXWUcEZTWditj
         uhURRF4QmtyEEvkkdVqIHJnR4VNyKaBh9s6bL1YZGPbec2svY05uXcHL79Sccx+HZ6e5
         VAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709277919; x=1709882719;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLYfug6C4Ox1djZNW155XgC/2ETkTLKcsDq92quytg8=;
        b=J+TOvr38esDO3kP8OKlRWZPK7n9VpR59fCF8yjvgQfXguZAZiLfCFbknArFYf0haEB
         MWuZXtTyFKpywFRiCr7Rg/30X190YOWa+DRXXmBwrpDNjGbRJjEeonsBnSkzecol8IAY
         BZVoxlMCoqy/xJ6nyJVKuILc7Cdl7pSWGczAmc2pH6OYlpnPNxzFOrNWrjnlTVLWozql
         H/RnQX0CGOwBA2iVHlrewoelw3tCv8QdYlaHInRLU+d0KdUw5gU2yABEQOcWJ9TR+eZb
         lFlDYO2VTEQr/D52JPdpN2/mO4MWckxUyRz6wwt/uJ31XVXmgjG3K4Pzq36axWlDVymg
         slRA==
X-Gm-Message-State: AOJu0Yx9aUE1CBPcXpR8ZuA/A+rrDFP9SAqYlQzo2BgQ/sonWkgrguWK
	Wleft+Bea34cHi0+ZLG2m329Ky2NuNxtym8OW/aG2+D9/4+MzVdfo1slM6s=
X-Google-Smtp-Source: AGHT+IGTce3k/3kY5bRMXx2HYtYQb14E0mRzwCKRm3WszHvSJoJ5gJgr5VDGs4O6c9DPyBin3cmyEA==
X-Received: by 2002:ac8:5f93:0:b0:42e:78b9:84ef with SMTP id j19-20020ac85f93000000b0042e78b984efmr991856qta.8.1709277918845;
        Thu, 29 Feb 2024 23:25:18 -0800 (PST)
Received: from [127.0.0.1] ([20.55.126.69])
        by smtp.gmail.com with ESMTPSA id d7-20020ac84e27000000b0042e61ef71dfsm1463637qtw.33.2024.02.29.23.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:25:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <68a686bc99d9cadbaf7413771092bca77d27ad46.1709273774.git.tanggeliang@kylinos.cn>
References:
 <68a686bc99d9cadbaf7413771092bca77d27ad46.1709273774.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <d82fa099-343d-27e6-543f-6ef64493f668@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Mar 2024 07:25:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8107562364

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6b9d5d83fe9e


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

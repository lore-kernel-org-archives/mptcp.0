Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D92BB10
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591923; cv=none; b=QU98Su7qP1Sw7QVkb1PFArO/Ext90zXF6aEtdmDvFIlje+wYaZqgyQDHYN9nucakR7vMJqrUsDurauJZ5dlKjjqasDjkzoLVh39tP8ENjORK7vSayr6i1a40q9L5tj2D5L5WUd3maOf5oQ3cHvQU3sxNnoHS97Dc7bIkuSx2uDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591923; c=relaxed/simple;
	bh=mGc5qpWV2/olrwBU2XTeg+UnyHTovraeVmgQUm9gB54=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TWqAE0RVbipaHOSIqfDPJX8MFGCszi/WBrrIqeEmdf0Mtg5E/1b031wK/6jhr36kQeXd4OvyU00ANIT55EN0oK09qptmX1pQmZ5o6dmGDhlQFZo31Bi6lHxNcxfm9TW9TefZbO252y3CvwCUfN+L6O7iH7ovonSCych7GHg1lg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQJo+Qs1; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQJo+Qs1"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c0467b94c6so4744238b6e.0
        for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 00:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708591921; x=1709196721; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvAvevVlG/SUy7tm54+NH5FCUADytf+HAZ0MIX8kqb4=;
        b=nQJo+Qs1kDu5LMxSy2ZEg7EDw567d5E2L6gwcw2M2kDUaLS2d2VoJ/CNl761z/g4BQ
         nlbbeYa5i0Z2a1NCHuWQYaSXb7Dl7M5Ig4hSSvxrF0Bjt3PdQzY96MeiLvDP4PZBEJoe
         sCd1aGpgIO/KFXQntbSwiZdxS74knHOnEMElpHMk3wfJkiIlvcpqicjH63AEKpMchdd5
         KNikJ+QHOyw6/VWPUeEP/FChEpmkg9wfeQPvs3QpypjMmSQK+PK70kp0iOnGgIKJKsTh
         tICLJ6D2s8WzZ9SiJpvHvnx2H8jkEK6CGLnxq5DWhZiQLg7h17kG5Puftn9jqQ8e3wmw
         WrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591921; x=1709196721;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NvAvevVlG/SUy7tm54+NH5FCUADytf+HAZ0MIX8kqb4=;
        b=UX3Jd6/NYPaf8wTczvvFWm9sz2G4+7xYcTO/1dJh9NLGfp/ObC8nM7e7NK0L8JjOzF
         8qbKm/7q07Nmr/i31tIJHG57jlLG8I1vMDK7vrQ7mFmGCANksefmnpyToK0LSYwtbWKk
         rZItI8bR7j/1nzRp9fDzF+PiSG1MrR89BvrUU/HvBIGvl21GXhQNahc9/ruhX9YPj1vj
         YRU4TxBoAD2g0P6obbS14MDQhcvrLkHzrVVXtn8e1Cs4rB7RkGCSX6uQ+MecYzd7jliG
         agJEBdapo4CBFiDEZBKJ78Mnp6paXtu8D1Iau+/3fo8Ijh+vU6F27EhxzZ2fkeWWbo/8
         Oj8w==
X-Gm-Message-State: AOJu0YzA0ud0jluTWbIXmcKPyXi3SEnNu5Stip2tiuMKN+mnqv8A0Qww
	neotEd09n1ONN/bRHJarmaL4EjonsJ3p2KXsmx664ePh97r5gAVMUEhMAmY=
X-Google-Smtp-Source: AGHT+IEugdeZCWEWdApCXSe8OVXyyg3uM3vaoDZR/CEi4S+uywOg/CW6YCQm43y3xxmMpb5TKc2gqQ==
X-Received: by 2002:a05:6808:198e:b0:3c1:6d6c:2e72 with SMTP id bj14-20020a056808198e00b003c16d6c2e72mr5810139oib.43.1708591920683;
        Thu, 22 Feb 2024 00:52:00 -0800 (PST)
Received: from [127.0.0.1] ([52.225.77.211])
        by smtp.gmail.com with ESMTPSA id s23-20020a656917000000b005d8b2f04eb7sm8557669pgq.62.2024.02.22.00.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:52:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <37d9862958848f8f3737eafd1b1ea0bdb63acd91.1708588566.git.tanggeliang@kylinos.cn>
References:
 <37d9862958848f8f3737eafd1b1ea0bdb63acd91.1708588566.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: don't exit when a symbol not found: Tests
 Results
Message-ID: <bde4ab3d-b024-0e88-e5a9-57b614a39d75@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Feb 2024 08:51:59 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/8001358412

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/13a7910a697f


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

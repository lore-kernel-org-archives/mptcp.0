Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881C171A5
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 03:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572411; cv=none; b=oAlxnHMKfzS6j5IH94TjpNmi8FB+XL3NYCTgaBxoIgNYCZFTFxXgGWGio84gPWyw/EMimfhld5E4bA0X66Xyahb4bCSNN2fkUdu9pUjHwELCsPGcTFODVYWyAXD4hW1kj40ymo/fLhr/xfOn1Ioj59VuOGAHe0sFEAKmOgYpWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572411; c=relaxed/simple;
	bh=L+NQ4pp2aARfF1jKWCSXLdd99RDr3aWCniLT6LlOdMI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bmBKNBOyQoh5iev9zlToTmlQgcFlIKKJGdYj7A8jMh39m9I9HlDHQ6NrZo8Q1QcMSgFzeBgw3WlYYqiMF+rUibad7QaBwFkvadShR1TPVLEnQdbCk6Qlbpi2RZBfk7gLYMHD4tzAYUSEeOPo/huUZeEr28aXYreKfAW3Sr4xsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhCI3BoT; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhCI3BoT"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21f0c82e97fso850021fac.2
        for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 19:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708572409; x=1709177209; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKr1gtckxpfPc/dauRKLt5Z4WWqKXVjWtHTcrjb/d3k=;
        b=VhCI3BoTes5gHpUPBxJPW4/YZOOuEsr0XJK8+5fUQNJ4Vq/zRPvfLOy12k/mA4vPsa
         Hglb/xvLkx8dXKCjLChxgYFoZnV4mvecuG5PPTk2zdsrV7/C7mem1/+yYVrYRtB/2HrC
         6Ki6BS9QmZOGSzhYmPV2Pf2M0NVW/1iYJpQbOJxpi0GuFDeMv/2TUcLET5CW+eSOb2M6
         RwNINXQoRvXkXYVD/SKYCUW9S2egqqSqsInCGitiGJh0hYRuycb7Gah0b1xRqYYCf6cV
         UF40dWTeDS4thL13nAYzNZ27HMn9h0RjwSKTVCAxU2nZ73wAJYQGb871lNNPSnz2Mj+e
         MIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708572409; x=1709177209;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKr1gtckxpfPc/dauRKLt5Z4WWqKXVjWtHTcrjb/d3k=;
        b=L3zz14/gZoyk4vyK8VsPitl6m1fMoxksFf0xiofVzF5r7myaa36/ZU2eZQTnz+3vcz
         8tsQAY0VTsYo7AM9XCw7IGGcKfqkFYB2tja4l9JUoZ7ONwh8hPi125wHLYKdMcIvpuqZ
         njV6SU/PrLsktUdz71PioW+HpG0SQLVb/843SkvTiGgzbmsaMFiabgtAlLcDrVqTSfXb
         +QpMY8JgDh3a/6+i9YmNv3rgT4kEcJ+X8SwWjdrM7QmjY9P+woEuDsot1Bn086aJ653D
         CjFXU7F5eFIQs5LbSpzIDsv8jnIh0LaHBtA4TxtmMu9FQW9M38FELkt+kI1Bj6gas45J
         nVtw==
X-Gm-Message-State: AOJu0Yx8A3JYQoJFyIRVNWxVirHUOUH6MXDajcPJ0iTuEm8yLwpwLUBY
	Ou6bLKcaB7e3tRHALOTJA4KDyxddPH1Ny6fICMd7vF/Cqus91Jk=
X-Google-Smtp-Source: AGHT+IHT1+DXa4GUSgU1ang51oO75J3+t35V/TaOqPcSOFSYVBoA82Fci3K3OgNvkLk6xZd8USzPnA==
X-Received: by 2002:a05:6870:134d:b0:219:f2cd:98cf with SMTP id 13-20020a056870134d00b00219f2cd98cfmr18923877oac.2.1708572408863;
        Wed, 21 Feb 2024 19:26:48 -0800 (PST)
Received: from [127.0.0.1] ([52.157.1.130])
        by smtp.gmail.com with ESMTPSA id q27-20020a635c1b000000b005e43cce33f8sm465322pgb.88.2024.02.21.19.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 19:26:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <47b5459f6b9b07c5a669d5a5233b35cf6ec601ac.1708532911.git.dcaratti@redhat.com>
References:
 <47b5459f6b9b07c5a669d5a5233b35cf6ec601ac.1708532911.git.dcaratti@redhat.com>
Subject: Re: mptcp: fix double-free on socket dismantle: Tests Results
Message-ID: <d135d7fc-680b-918a-69a7-21dd46124292@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Feb 2024 03:26:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7998762098

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/57dfa41f7285


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

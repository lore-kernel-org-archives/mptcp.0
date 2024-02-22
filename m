Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ECB3C087
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597329; cv=none; b=KVdipgR5i9DEEENjAhLLctDR5xolbt1JCgZNdYcu/Pmvhv5sugJw1o9X2HVxkW+Am93jshmNzHMssvjhr28mfl1KldvVCRabKaSALSJ2N/dfqedJg8i2G0cSD97iD1PvrByBZUGjjR4etWWtO2ukKV6/980s71hD2lJRyFZ+sVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597329; c=relaxed/simple;
	bh=TT8wv9Mc2vAXa6CZlVzbH/x2sj/NSHzpJSDRS7/BcYo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EtILlFbYklNMLq8V+aInSgGOXXJhVX2zUbsdebiiYAmCYdPQejSNpwTGYVNP0pMQ/An3E0/mEm8vKkEdwG2Be1t63/JBGXKmOPHslEUiGefC6suLquAE1lOmiCXB+bNJyze0Gkuh2Qc/lJcM7u5a1LiAchL4NKQwxg+VuScZST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEXgzK0I; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEXgzK0I"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7838af983c1so553277685a.3
        for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 02:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708597327; x=1709202127; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhVHDkEQPal8+rqHCaNdtq6ypbXLuz8Elz6JqOvdYRI=;
        b=bEXgzK0IUrIz3AxpQ7qRNj6Kof353uuNAglqRDtk55wsb3LGVTCKvyujOt3KXlJwee
         xqs289DCqVKbpQrGIszz8+/dWk0E6w7sCt3Yg0h5+/UC3teHbO7igLQhQ6BP+5lXFp3j
         vH41JQKfgA0OGdAizvI4Q8XkFwrUmNoHTStTOAZ0bVvj+f0D0LC7nck20Vf69WhgGDjh
         9/oqh1zhEUMElwV1tU28P/bJfRDoU3GZGZRi1p4RDoNPmqTWrsWoRDCo6ES+NRIYXWTF
         jWhNTCMilMkFhUq8UYzX64piEucnNvbSyx/np/C4+FOUZLHp74wGPM2GiHL5pZrYEBwP
         jVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597327; x=1709202127;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NhVHDkEQPal8+rqHCaNdtq6ypbXLuz8Elz6JqOvdYRI=;
        b=gQ8BvPDES2PcUsm3mi3dBOKeSgM1VcdWN1WGsjLaNw5KGP+EN8rre1T7LwHQxkV+jf
         YWcYUqAQyGwQgZR1Rzg7ntVgcmcLU7jihWHvadOyq9+bc46Ki6JV/8PTO67pdE1NNQ7C
         1GIrywwCLNHUqRANqJUGivY7brwt9OO92DALL3jLC8NN5FpXtDRpA8gNAmpI8nchCKoP
         MfniF9aaj3fQ0cbiQL4Xy7xPLPfHglLnEnjpcrIc9HsdNNy7/coYo/wEP1rfiGu4Hby8
         tCqQrKE9ETCZ877qKU7nCWm+0/EtPMmL2bX9S/IrOTYaTzx0lrU0kM0XdDuNaY+0arpN
         Tiyg==
X-Gm-Message-State: AOJu0Yx7ZugjJ8//G+rrD7+Ncpx/7MpgCZrRmLR65wB6BnaYHZVZXWa3
	2oFC2xSHENd1SkpkbEBZHrfy9SEbzl2ypdAidCQa70M3XjIft8A=
X-Google-Smtp-Source: AGHT+IGiHCeA5KeMCN17MuzAWGz8TohWNWa3/a28uuT435BMMmkYI9oHMq7UoJz/xFoqabC3luktyw==
X-Received: by 2002:a05:620a:2626:b0:785:dac4:351 with SMTP id z38-20020a05620a262600b00785dac40351mr25661742qko.31.1708597326910;
        Thu, 22 Feb 2024 02:22:06 -0800 (PST)
Received: from [127.0.0.1] ([40.79.247.98])
        by smtp.gmail.com with ESMTPSA id e26-20020a05620a209a00b00785da717d64sm5151238qka.111.2024.02.22.02.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:22:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <00b53a9b00cf4f35361806208f1214c030fad974.1708539640.git.pabeni@redhat.com>
References:
 <00b53a9b00cf4f35361806208f1214c030fad974.1708539640.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: explicitly trigger the listener diag
 code-path: Tests Results
Message-ID: <69621f6c-e32a-b1e6-c2f9-39bd75503fd6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Feb 2024 10:22:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8002395034

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4fe5b5cc4615


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

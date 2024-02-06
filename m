Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C458203
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186100; cv=none; b=sNW1n/dd/yjfnAiNCzhFw1uRWE31Try5gulE1LPig6HJkprUYW28bIM1ErtV/SaWOHSCEhEtfHLiWSeUDgBbbx86WlOVbQRpljWhifnVJcrezgkjAHc6zUULbyOZlpUvH2UvFTOdh17nvUAp39JuenXJk/uqWQTAfJFMQDfv0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186100; c=relaxed/simple;
	bh=XqwvGSWbw1JAyo3IGU7Tk6wPPOpI2ji0uZQ8VGOAK9Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iGT/NMxL5bhskt2+MusV+Ljtu/SiZPp+il2fXU33rcO8A2ptB9BVEPdDpjmy+yoSogj4CRqJdyRZARldCO+RaIsZukJLjG6u8YuPqHmNIgHqd4bGQHY3f6mbchPwno7B9vy4OxCEwVr7cn8+5wvW8KO7BPUCZ6MnpUdBYclRHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyLxUYwY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyLxUYwY"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6e0fe3195so4310136276.0
        for <mptcp@lists.linux.dev>; Mon, 05 Feb 2024 18:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707186098; x=1707790898; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aJSEQiIq2wC/091NQnJHWfgiRIN9XtStkgwEzBtIjo=;
        b=eyLxUYwYZFKwo5rhubIJhFOAc+flI9ZmjT5auJ4jT/+6yb8QeH4SFRO4yV4gfM2P8m
         ap6tCR9Q82l/s8TralzJOZdQ5lfvuzJB6Cnhvh2RoaesHnKm4+0VJyfQfcv7m4VLNe5m
         +rqX9cUPn73csgxNAGvHS6+3vZ4dFeByqSPUjIxp9z0JS8ovyGr6OZMnr8EbgTCncsGV
         kf/Uj7qOEawYnv3cWwWE20Rbcmg648mKAGMfMZlCp3VUtkcpAWIMOAIE0y49Ja+bXk27
         OCLkEYhV3THAuZAq1VGgBEz8ou4Jxi3Z7g/uRRiA4zS7F4AiUFUb1vcLSs/krp0WZhGK
         Cx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707186098; x=1707790898;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aJSEQiIq2wC/091NQnJHWfgiRIN9XtStkgwEzBtIjo=;
        b=njgqsSLLvBK5ysALl7O8IZTvcbQfONfXUP0Xig9Gn/024QPvlBd/Oh9lPHmFJq+oKq
         Zjy3RJl5ug5xue/NnXjLUbSx+DTClbjF8SUBIRLBakdU9h3VapiCbiW+M9UbnD78hF9T
         K8QsYTXph9zBFPg8PgT1Q+u9rnDqkTOmJrUuMMWFOrqbaIIEluap88kL9zsnJgfTbnMR
         AJzRsa7vYAt93hRoX/AmNPSVP27YRebCthPZ6VLEGnH1JuZlB3uJjGmaFlt60SmXNxyE
         njO1+oJTwqsm7Q2StE/IWzHiK3e9bShG1SqJBTIsXK9IA9x45hp5hD/chjqH4TucRFA/
         1kWg==
X-Gm-Message-State: AOJu0YxdUqeK3KX4hrn7CA7GUG7a5vbLXZhK1ZNim9q9Xs33Bvcyl0od
	fW3ZqPH3j9WB1g/wJKwZG3vjr96tMAQcLqHflVg0LVUnMFJk9qdFh8yQV6w=
X-Google-Smtp-Source: AGHT+IHsCOIb4rbgdciMk1YyvT+TDDrZJu8fctjv1K2qWTLZw5kpa9rID4oDsbJRNyYWhKBEKPXaSw==
X-Received: by 2002:a25:69d1:0:b0:dbe:ace5:c054 with SMTP id e200-20020a2569d1000000b00dbeace5c054mr365635ybc.5.1707186097866;
        Mon, 05 Feb 2024 18:21:37 -0800 (PST)
Received: from [127.0.0.1] ([74.249.5.176])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b00783fa567082sm506224qkb.71.2024.02.05.18.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:21:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
References:
 <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <82b79dd4-deef-3880-6274-760158cb1db3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Feb 2024 02:21:36 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7793464637

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/483bc6889d53


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

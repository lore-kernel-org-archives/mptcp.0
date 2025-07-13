Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63988278E77
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752425223; cv=none; b=SKkAaOJubxwZgZP8Z4wxbaAgn85trlkewFv5jqP3UxT51iKi7lemUqFMgFmQXwvY7tE5OAF+tYR5RQLGdxgbaQFYkFJR9tOyfl8agOsA6Mta/8Nk6viwWnQrC73SrkoI4w92WULXVa6qHI4ew7Qu5UwTrvw2uWWR7TiVsQxv9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752425223; c=relaxed/simple;
	bh=OZCMz7FOjycHW9gSiB58ytUYH4TDDD0oNNLoMdcsOkM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FDHEXz4Q1CicmlqMZ9j/ytrQjCFko718RWDw1/IKu5hq+ZCZHQuvCpT+kp9I7G4AuiU0UVkBLv3sYNM6/zvKTyD/3QHvXYO9a3WLOC+r0R/iYrLM0If4mKHaWSG0WQfPq11gLwShl7liOVtm3ioA8nIm7Ib8x7pRlrsoXM/mWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlKn5yV7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlKn5yV7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e095510a6cso179981985a.1
        for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752425220; x=1753030020; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzbwHj/TQCXEpr4IXX6RprRoaM/osUsTu0GoFgey9nI=;
        b=BlKn5yV74FtFeod187DaaLvzmUUDVdkg9uAipPObknGRYh+nDw9KzyPWL8z1YGiSOu
         ck5NVZJ/i9UmbAbCbXEilRPGnE+Tasp9HJlEhbpmB2eOiG+hByYSZUFpqeXPKDEKBEQS
         ca78zee1mfCOhIO3+cFQlQA18ZVrfAoNvJShuc0LHaAvT1uRArAlPfh+Xl979EkcESkw
         pPVrZpxCprX+QFwOWxFLam+9HypltW+s8Mgg6AWrf8NfOILLS1+aH0RByFDvpbpgddcl
         fFgLUT6CDelRR+RFubHeNU7tOnZTzO3IygrU00FtyrDXeyWYHEeIGFEHTBEZMl6csAfp
         qrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752425220; x=1753030020;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzbwHj/TQCXEpr4IXX6RprRoaM/osUsTu0GoFgey9nI=;
        b=RQ39A6HguPfVnVc5Yvt3NKwCvnqdePRhHeiCTYa7hE/ugTgQeweUWHtNMITKaEhYLx
         x/i42kgNmfMozAqh9i7TXWBnBGC4F0rI/0bqg0hW+H+bSxp95l9W4WY5VVD9wiA0ZdFz
         Cdh6qcYox0tTntBt9IvsQt+mbl6nWKcsfMz7k5AofxiF6u4/ovBo0pcGyzZGTTDmRFY/
         24nA0GlaXiaX3N2iBN5ExkOHKpixXVxFQSWjo0SJ0tm4E4qUlzyN6gN2B7YAjA2DAeLy
         kF6u2UD94XWxAj6f/Z4bY3EjfUL/7INrp1pNJVTLtX0c3NDu00U+eOEF1mlst/iyjODo
         /f4A==
X-Gm-Message-State: AOJu0Yxfs2osvladrrgvZZipAsAvcji5MLTC4vYyQeY8TvSGLE3z2yIx
	o/imz6Acq5dQz8KRyo0gsfXugNe41ojS5K/lpGGBd4jniLUtc+ftRxeBEvXOWEs=
X-Gm-Gg: ASbGncvc8Z/WCV16Mk+CF6/qBny6NYKOZhEaxnB55/QcC8OjXRCaGKTXWh8cAKnI41Z
	mcEzrYWGG1NUrxd03X3ib76Fivpjf71/NnYxbJ9s5l+aLFkpRidKP1VcbMPiKQ4FZiMFwR0NCqH
	6secCWcLHXdKEgQkWEG5/V1qzOc8tDBjbeS8F2sdjLVwNkfFJCdPIOH/X+Oq3FXXW2jSvaCM/Go
	J1xSQkdKEc9EF+H6e5eVGspKM6UHXAJpWameV6AWHHDO3AEpfSoz/TpJMtMclaPpvfPIxpRN68v
	0tq0rtitiavNZiLwr2NxCAXc3ESvKN6RCABHRga7G38HZ9PQzuM0liyY839hK5SmPIyWMT+5xhk
	zaPkeOwKRmZHoOAbVQT4GBImtBEAD2qkWBd4=
X-Google-Smtp-Source: AGHT+IGu4bHL6hxOnjGsBEMlfzv9fjyNvrRYVLb4FI9BRE6d3LQOEpqL0nWNuuFsrVW6DjjQDkROog==
X-Received: by 2002:a05:620a:3192:b0:7d0:9ffd:422f with SMTP id af79cd13be357-7de07957ed0mr1855755785a.54.1752425220173;
        Sun, 13 Jul 2025 09:47:00 -0700 (PDT)
Received: from [127.0.0.1] ([52.147.206.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde422e03sm421895285a.69.2025.07.13.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:46:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752399660.git.tanggeliang@kylinos.cn>
References: <cover.1752399660.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/9] implement mptcp read_sock
Message-ID: <b7cc08c2-d791-4c37-4398-8e2b34de204e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Jul 2025 16:46:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16250586338

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/551634877b31
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D981808


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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

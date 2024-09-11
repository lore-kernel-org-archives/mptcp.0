Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F5224F6
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049082; cv=none; b=NwQJQ9mFtaqkOYKlL/VB1/VT2eSXqX6dCHRf+BN1SgxB/GMGXAEuS3+EiM8+7SM3h7ifX1m5bQqmtAPuXilO66GfWmQJPzvlqAnQm7azXKIqQsS0X/4B4ah5YMkbcbegSTxmKWLaNFyBP7pXnxheu+nXU97CXaNvotLvCmU/Pr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049082; c=relaxed/simple;
	bh=ulk3j2RmpwPnVbWnXfb9hZMf8r984DANAwJis23Ea3E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Y8UHC3BP34680ENe1lq/kMQxm9WvoP/84DERAecsEb71Mj3AeYZ46gExe7XO7H0PraPkvTyCYTn2Ds8puP9rUmAFQXTmWbbJxgoFMNbzT6VxTwRYNt0kyWIoLjgrnLyrjBIPQd8fYYXI8LfuhUywNBwt/Y5oqbLZ+rGOhoZFfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcwXGic0; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcwXGic0"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso37600206d6.2
        for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726049079; x=1726653879; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuSlf/LTgFbs1sbEZKzrjGAE/7V3Xs/EB5fevYhb7bc=;
        b=YcwXGic0Lgz5ExWz3nZnK3wwQsZZlB1jGPNK/qvxCn3Pj+eRsfqINjOp+MkD/BV9oB
         crOlea4AEJ9QPBs+pDDmf0O/rPD9KjfNZmb25iW26nDJR2ACGzPV7NHvftP39z+ZzDF0
         ZobDB1k4ZQ9zHzE8e2FgacT8YrVs6Rk3MrtQFohf++oZ0Ff6TIFwSKfXV2Da0JapGK7C
         WDP9IG4SrVikVNde9L+1hISSouZ8wcWkC+AtfKQuVoA+JX9AD1GZc43p/kJXm9+w4+Dm
         C3x/ZR/lSFiKnIA4lkojapZ4ybFAPUnEAlCvnpURCqWvlkoPSlux7ZxfzeZxXGINUuE6
         W0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049079; x=1726653879;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HuSlf/LTgFbs1sbEZKzrjGAE/7V3Xs/EB5fevYhb7bc=;
        b=VjG4vxKvFkBT5XL2L27hE/gGM5i59OwUvNG2OGGweMsNMg4xx4BCEbJdgq36Snfkfo
         8mMqmpSPfqmtnsdm+lrWzRdGvMLFuUlTF9y9msKJ57ffrUvChbtmyxQIJfigttZvjpUx
         QSvjCbMyL5BBFMd3bUPyKaDpbvbibaBxP2JMM9lRstf1VKqmEmbzBEkIcwqEsbDL44qL
         KFWaimAST5QCd/cIRg0+q+57JoH8t+rSterI3BusHaTbj2R+fL2hRw2SG/qTejVso5zG
         B+PUMTGEkWPOCU6rP8JbuGTl1db650WwjXMH7P8ffgGzZGh/HW9sYwnJKGZIymIhGHTL
         hUUg==
X-Gm-Message-State: AOJu0YwRZyJrVZNw4lo3WvztU0YGQWsCCfvEOSRqK7Pu2n+gBGQCk4WI
	iyEut/UJNMrN7IvDe7rww2HvgMSk6IxhJ2JuBO5CLBUoRmfLuH0=
X-Google-Smtp-Source: AGHT+IHCeFnHkH5VIIuNbY4IEtNPbTDiW0XVD2qZk2/SucoIZHCayTY5cFMB7WCHuGgnMrlJJmOGSw==
X-Received: by 2002:a05:6214:5b01:b0:6c5:18ad:b465 with SMTP id 6a1803df08f44-6c52850bc10mr237806556d6.38.1726049079252;
        Wed, 11 Sep 2024 03:04:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.119.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474f8a2sm39966136d6.75.2024.09.11.03.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:04:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240911091003.1112179-1-ast@fiberby.net>
References: <20240911091003.1112179-1-ast@fiberby.net>
Subject: Re: [PATCH net] netlink: specs: mptcp: fix port endianness
Message-ID: <54f4392e-380e-1d31-db92-0e1923eec554@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2024 10:04:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Asbj=C3=B8rn,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10808837330

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a918e18ee437
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D889241


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

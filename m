Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59F46A4
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715824894; cv=none; b=AsQ0JDy0x44g1p18ytV0uxoASpMpUmCm0jrhvJryAh9Oc3INRW7hYP2fJeo9sN/IJ2CVcguK+9p2zeguhZyuF6MmKlYX1AYzbObZZDjKiB1+sfmtVzhz12wnONbtSdXPeXyPClGZCufCevQh3NnDbTlDUZ3X2bcMqpHw5E/ohN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715824894; c=relaxed/simple;
	bh=LjycalEDORHcBA0txnYrqRJjAa2iA1VcGL+SGf2UZ+o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HCHFErvOKqC7mQdZ6g9DY3861CTa67tYdxodVjEkzdpmKw9MG17pvt2eEMP9hSTBVqbbDX/Ct6Y+fwxdZEoJq8wwz6UxBvgvcbiyhRrz9cFCEYg2SnusJGkSN6g5nP4HhRikb/W1u+6V/Lzch+2hPzAqflAbeMon5RuiXuUxjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsw8bJk0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsw8bJk0"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b5de48126so34415226d6.3
        for <mptcp@lists.linux.dev>; Wed, 15 May 2024 19:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715824892; x=1716429692; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me2eRuVlpfU5vTlzItuFoivsgGZFACq8w8pNZepM/Lc=;
        b=jsw8bJk0EiMAUziP9RGhywx8cu/qpPOyuGS2xmQGN3DyyIXzAR7UB9Zxu+66kUF8ja
         VngMYnnrZWmYjOgQG327cB6F/DmDEkeoiuXJ4YYCOFkm5K5w9OgT0FTVeKEEuie8yxE6
         bT/WdVzCld+gfT0jKX3lspbGbIiqAaepQHcZZogz37ZqXoqI0U6njoYnBtOp9L5jtjbF
         6Kpbqq5Fsn2o664IHOhJLk7pify8gyo1mN6/I6s5XsQF/Xnd7JSelmI6UX5MhWL6mimB
         Xw9OfBidPuKEf0iNd4tCBsHA07kpx/0vkQVlRWM0q7d0PmmfpGIq7+clqoFAlU/5hB4K
         HUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715824892; x=1716429692;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Me2eRuVlpfU5vTlzItuFoivsgGZFACq8w8pNZepM/Lc=;
        b=dLFXBJMBXWyB6EqicBR03wFG42YIJoz/5kQvn2W+Rn3bSPjxnjee8AMRjyMJkuGLiM
         VT5qT/bZ3o9fy0FNH8P9YTZ/uvIoMpWhC4yayBPfYNeHGjNYTPEI2MkDYiId3yZFjVuV
         fuAspJcDq2cydm2YdSbnEhzR1fGfaWDp3F+KNTN/k4R4+4NunjepyycXSvC+BQMDIf+E
         TvBoT10sUufDt6EqYwG6r5KiIFVzwY0G2zGHJ3tSOaNlg+5Sf47CMEokFoIuEig9FXt+
         7eJUp/BYyQD9Xn83YxJZeRNa55FSox6wwb+mg8X4TxnPjwjDgDFfhoidwNLZru0Y0aQe
         mU7w==
X-Gm-Message-State: AOJu0Ywhzm1/QhdLSVhC+1J8EBoaWeRWsFtNmcOZC33I6klOEgasne0H
	9ipKPL4VhawN0YtEnwlOO5rv7dWe75ZOKYOXKr1g2NMH1GaHzkxiQWOh
X-Google-Smtp-Source: AGHT+IG46hlPW3iJz1gvY5dyrYhqx5D19ozKwWqHnGW8zAgeIWJBjGjuej/Hz23ljAqTxOUgIiyXUQ==
X-Received: by 2002:a05:6214:3206:b0:6a0:8610:8e62 with SMTP id 6a1803df08f44-6a168161716mr203605296d6.27.1715824891726;
        Wed, 15 May 2024 19:01:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.95.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f20570bsm69777326d6.140.2024.05.15.19.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 19:01:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715821541.git.tanggeliang@kylinos.cn>
References: <cover.1715821541.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 0/8] add netns helpers
Message-ID: <63c4079f-1da9-f28f-7668-bfd81b096a8d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 May 2024 02:01:30 +0000
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
- KVM Validation: btf (only bpftest_all): Script error! =
=E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9104996269

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5396ea8608af
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D853539


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

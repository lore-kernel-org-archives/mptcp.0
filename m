Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC746BA6
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343138; cv=none; b=h9X6vrdl3x7KtUHtGcJhiBDTAUKvMjTz+eHTH8k/0uEqDUAbKPqsuNYvZLOp7HEWzWVz5g6Au2zqX41knOitHEae9UE6l4su8m50ue+W0lto9xznCVwP8MzVV2bj56cGrEKzSx8hHoxzc0Q/Y0h2uOzvTZyHLo2TNlW52PdXhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343138; c=relaxed/simple;
	bh=Hc+KNUVVKhf+Vhv8LDG9izL7bG+3gubJWu2sOIWkAaE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TUU0BJquHEQr6CidRcuWQJkdo+abIhoQ51Y48Met4rJ9P9qr3jMFrj/YxBfNJCs78EVGSOpU8eBSK+UNMnj9iPJiZB7MolIOBE1hC/KfTLzL9YhH9ZmDWkrD43Ne70HP3O+ElJv6h1DzwwnlfbraTEcl4JtnS9dfY3eU9BhPrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9BiBUsc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9BiBUsc"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42f2d02fbdeso31837501cf.1
        for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710343136; x=1710947936; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9sH9hCLJ7cPNLcFDqR1B7GeYYcHA2ft7tMRn7NeIbI=;
        b=T9BiBUscP2NK6pq4SYpcKsBnyntSqx9Gevldal1epXVv1UF9gOk3jh49/g2hFUgeSq
         Zvp4P9gKOJe8Uum9iuFqUHk6+qUqq7WwS9oPE9RLMFdk1SZpA3nOUWWznSjJ+mh1zf6d
         hSIogoWmUdUSnePBmFR5lmJYgitogHZSOaiOGvnjPDeETrDwQ00pZQ/CHGyyfr6zz3GJ
         ype9LB68ZinZQuAQ4OnnFUN6wORwamjhqnvL1WiFde52zwM6m/aLzPZw8QaQnTAvMmUE
         sdBA8IvREVjsP+d23CamkaVYFSzzon7ITwXTjwzvE96CGvBb1D9W99LG/1lndeZ19qhw
         PC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710343136; x=1710947936;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9sH9hCLJ7cPNLcFDqR1B7GeYYcHA2ft7tMRn7NeIbI=;
        b=U73cjdVdszo+LnZX3g0nXs/eBxw81xIHGzaRquER6fPAbreupQ3cQ33g4IiTPDpJcD
         MtEZPug4YWlXjIjl9RgGGV7nRjDB1ZBhqf9sbXRBjSDRbTB3YfF1CHaStEVs5CrvyYsQ
         WuL2vZmo+jq8goZlcecXD1mYA2MHmLNn4WvBjznEk2nPLdDwn/MO0vGhcUJksSdOpnT5
         gINZ5weODunavvVnJ+3LkjdHwhjQuiRZInnvSSGEGKFcIbNdKDvqzUKCkX1Y2uBtdftz
         a1sN8KG7HyBASwbvfSDIysAYSDuLUmzG85K7Sncn6TS8zTPXK8l810lyrfohIIQnU671
         rrsA==
X-Gm-Message-State: AOJu0YzgZiMapynLfEDS5zgynLOfNGxaTfFPIx2phQGoR9zdNQ2NS8ld
	6C1YDDOosFUkqB3yvagMIeUVyGGbXM92kDXDUh7qdZsd8R5XowziPoUufGE=
X-Google-Smtp-Source: AGHT+IHUxBdj0eVKbha+WW0NupmktQ2rwSi8YCI7fGsN23PtYVmiLkGczxanGr/MA70JoIMAwbj9vg==
X-Received: by 2002:ac8:7d4a:0:b0:42e:daf5:1b93 with SMTP id h10-20020ac87d4a000000b0042edaf51b93mr17591494qtb.39.1710343136103;
        Wed, 13 Mar 2024 08:18:56 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.137])
        by smtp.gmail.com with ESMTPSA id u25-20020ac87519000000b0042ec8412342sm4904671qtq.80.2024.03.13.08.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:18:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <82de56f853e291af0f6474ba21a366c895ad8e5c.1710121590.git.tanggeliang@kylinos.cn>
References:
 <82de56f853e291af0f6474ba21a366c895ad8e5c.1710121590.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 10/10] selftests: mptcp: netlink: drop
 disable=SC2086
Message-ID: <a4171fd3-1ca5-74d3-982d-27658069a1a1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Mar 2024 15:18:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/826651=
5899

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aece08f21837
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D834175


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

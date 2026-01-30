Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE113959D
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773542; cv=none; b=CZFtMYaAhnsLc7eNlNtp7CXaJeflSrRCjACZMeFjXVt4nYIP4pOeaAUfbEnx+tOYGpg38s3WXA+GsFcf0jYANnz2mLoNYSDxGBS9P/pxhoXnMa9om8VZNJBN2L01QFIcbpjjtby6mUc9icckRZMq27sqCghAVy9ZhOBo3AQXCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773542; c=relaxed/simple;
	bh=kitfX3ta4MEdvawt6t0ltEPQV3/vOkwzFOW7vJ14fC8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=A/HPHUkRZmiLYhs3/DYbvYu9R2sMAHVHieWbm0nOVwe8Bawp7sq4hVRFftWyOdmcnr1KwDsf8VPal07wsin3Vzp2o5MRKZLjGcxHTktHE40c9NgQ0qAGHUNyaGgHcu6/trVUdnqb9I9ELLkThdv1FWrSLOsrdLIg+oA8l91qDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKNtmyhW; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKNtmyhW"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso3172965eec.0
        for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 03:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769773540; x=1770378340; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zi3u0knOwmTtD4Vcid0NJ53f4DOkkvUG/ylzlhGvOJ8=;
        b=dKNtmyhWq3Twvdz/KhUgDDXiEKcVpH2NOHNq706MErzQiBVkFbm1Ng7V12pRRUeqqN
         Hu8CWMzP6PYFyyTsdM1QIdKMlRnWJC31sHi4zNaMxHIcxc9Rz6+n18i4ToJH18XUaXBr
         EIi7R8R/SpLJ7IwcZseWpk7t0XekLlgTSKwIuLc4j6sUUJsZat52G8jebZ7S2liO2XEa
         irjBzLyYrfBRPC4CFu1SyqImZm86lEYmCu4ZBvrL3D28ZEC9t7orY97TgQIoGfUGxOnZ
         vJn7Q+bbdXzQCnHZvuyeyDnYm/eYB+VcVrfMypepSVSdSWKK4+eyAQcT2CGxHeCfV84O
         kVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769773540; x=1770378340;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi3u0knOwmTtD4Vcid0NJ53f4DOkkvUG/ylzlhGvOJ8=;
        b=rikmrgqt7EZMtmSn6pp4ZMs2n1kg+vkQh9fOs9Xyowj7k6OOX1wo3WZ3MFoWnygZUm
         NEhYc+RpW8481iJFAbbQSdQ8ZguKZ1oey53b5bOIYZKq6Wlu2XmL1R6ovks6sKvYHR1l
         j2QCUQgvLzb5BMjILqPEuUXqF3GsAVN9f9dzXvRboXCKDS1HqGtWpaSjhTlq0hVM29pt
         J75VP6JyBYa7zbPn8WW8I73A91DByRdZGhbgkG7rx41OK7pND0/zvo+cKm5andPU0+uO
         rzuz5+pgdwQS/XOrWrXZjuLxKTnUlL5nOELMDBJjZn4odlqjzgbZ6EUa6z9fst4kd5Y/
         wL0A==
X-Gm-Message-State: AOJu0YzarL+XOuQZOK5Ru0MZoNiKvpZ5vWwDzLDkFIn/BZ9vqstO4r7l
	ENMX7uBIWv/F9e/SihcyahRB4s+OAi8FrPqADQ0LoOmuh6ksREbPrri1m/onUovkFQ==
X-Gm-Gg: AZuq6aJL8PS8jCHZIbIPeAhca9L3UqmU+AWh2i18l9O8IcVoXAGAmt8pRmii5W7V23q
	M8yefuCinzWo15sFCl52f7hG0YCa39IJ6eE96I5q8OYDdkbZgqi9zjesR1ZoMCFl58HOZckBeSC
	20eSChqbV2Gdfs1sQboCoATdXJDULbQZwLgmkqycxN+hex5eN/AFMJJHfIupQNgvXbsJiy5SpJZ
	7laLG6u33pGyKOmPWTJJ/N8XD9KwmmwBIU6Q2W+cejLaBrmBHaKnEP8S18Fle3bs1kVhx8EAbMK
	qBWno+HNkwOXMyLkHD286jRjAosSEHw/xFIqNADKIHe2L7leMLnqpOrBojy5qa7ady26meT/wrb
	dd8LFGR8SIO7pdDcF9TU26a2fUpTxLvxTbNoRnC0F45DnmUr1xlQsMtaAVEdA9Ue+vcXpfiWIuE
	iZ53sEwaCaVXdpHus/MZeblbq1
X-Received: by 2002:a05:7300:6da1:b0:2b7:3780:8116 with SMTP id 5a478bee46e88-2b7c86329e4mr1271685eec.7.1769773540061;
        Fri, 30 Jan 2026 03:45:40 -0800 (PST)
Received: from [127.0.0.1] ([104.209.11.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfaa8sm10360181eec.4.2026.01.30.03.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:45:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c24b6414ed2ec128f8ed00be9aa84e0a33c484e8.1769769757.git.tanggeliang@kylinos.cn>
References:
 <c24b6414ed2ec128f8ed00be9aa84e0a33c484e8.1769769757.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_add_splice_io_m?= =?UTF-8?Q?ode=22?=
Message-ID: <777fb24c-88c8-1743-5cab-47a59337d2d0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 11:45:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/215133=
86911

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d48f3ead61fc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1048930


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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

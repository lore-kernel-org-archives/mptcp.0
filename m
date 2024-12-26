Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7D14D29B
	for <mptcp@lists.linux.dev>; Thu, 26 Dec 2024 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735209269; cv=none; b=TC4OafgQERAHPRc/MmZVzy+8i45L4uk5zhdoSbgwOVr0hli6fP8g2qUXeHzrE1ljrJBm+r+fEiKj8zOXlHe1fwdScguM0F7X9DuJhnyZq0GZl4XIQZeSEeTEfQ3sKU6+ditqDegZDmVvH4qInOEIKhY8IPxL4hUA67+kEPzvpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735209269; c=relaxed/simple;
	bh=4rvCVfLJiHGvQneFmsdR25+9QqAtCsylgpN+eaFc0LE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UKQHGSpCh74Y6uFWV8KGsnjzxFVfuzP7gTHqnOJIsCODBPpmAHWRljT6IGpYeGgROyFBrOyWxCqxcrO9zpP6EfLk4pSIs041A8O8QvFVSWWfw23ot3YayWcRVDmoXQ2PHJosELHBMyr70zr3a/DirS9v9+ot+fphxp+fDdC6xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwoUuOf1; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwoUuOf1"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6f95d2eafso630921285a.3
        for <mptcp@lists.linux.dev>; Thu, 26 Dec 2024 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735209266; x=1735814066; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8eyD6vEEoaxU4j32BlaEa6+8JStUlcJeiRExcAuD2M=;
        b=WwoUuOf1ciLOBqa0U9YvBcGkaz8rQbEP4erPINSrSeArZ5ImJ+4ZpCZGxWSQGKPg17
         64DWWuWChVwurPOXW+WuxGR37Mvw0GZgrCNf6/q/P3JpkJwyicnmZeoiuZr0iWrYKJzq
         AGATs2nn3YMg678XhcYgjlVe3lZIzzCZxkXdHxy3NoSWt10T2SQfg3spCE1TKrzuuI9L
         kqcNXhcg4hqw/x8YbIs0fXYpWDw1PGUpNybl5CdT0bexXHf/d9SWvjdh8So8B0LGqWZL
         HwJEAvsNopqq95Ls6k3NRCiJCiRtuLlfMLBWxTpDB8H41a650uEtJn7nTQZnXutXNcb4
         ezSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735209266; x=1735814066;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8eyD6vEEoaxU4j32BlaEa6+8JStUlcJeiRExcAuD2M=;
        b=SVOYCVBdqVCeeDoSR/9pYIbsVjqJgPAO3XcwTFx1imscZbubHvo9v6MH+BsVcIN514
         nldwUWihgXg7v03/DFDxddM18BntLyM+EarFTCi6SVw8EhbPLt7hTEz/xpGBCfVB/Y8Q
         WE/0VmV3DU5ngUPYB06q9MdOoSThShCROrwoCDcb4Org5OKQKbL8JjhdqK9dE5sdnEom
         s97kSUTc3Wlhr1dZbV39fFDPDQR/N97d9tP3tkMS3dxwI+B0WzbD7NjQO3B6bVGo+XAm
         DzIvqI+bvj27+rHnyC0OhrqplKsTIFhO9P7NG6NLygih+aoN9Zu1NvIDFLbS2xjh1+jv
         DzHA==
X-Gm-Message-State: AOJu0YymKisgk7qvZWH4TgrjclbcdPMab3OjxPiGbcR43WgoBT5XPZuL
	rcgqHX4qCyjuitACAyHtdA0KizXma0+09xeWehSVJk2De6kjI6+8pGfAPtY=
X-Gm-Gg: ASbGnct7OXGNwk+/HZD9jNcMrf8eqoiRaSiz0rqrScBV97Qtn/HDOQV4CWMna2rYosd
	qsElKu8jpAdKqdbZ/Wrprr1fUA262ZuEaqf94hXmv1zxtPgn+jqogtQeuK1/gBRU2gHsixp6wNq
	Vq45IVZpPoUKjjjgkCfAvS9jXF8+s2oYZezttVddTNz7CavuIAcw2QikBvSk6/SeZAJ3ZXKpGOw
	fj9CYVculyaXilmG+Eshgp4UdQnrtztRekGQescJDp8OAg7WQ/3KLQaaVWTEDcdJt/XhiM=
X-Google-Smtp-Source: AGHT+IF+Ibu4tuUEhbClg5taXqQOABGiqvMZKlv7ijknQnX462O32ud+hybLv1tU+ZZB2vteSW9n3w==
X-Received: by 2002:a05:620a:1a23:b0:7b1:5672:5d46 with SMTP id af79cd13be357-7b9ba73a35fmr3675761085a.15.1735209266171;
        Thu, 26 Dec 2024 02:34:26 -0800 (PST)
Received: from [127.0.0.1] ([172.200.22.134])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4ed47fsm609749185a.121.2024.12.26.02.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 02:34:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <35436a387650236cce065f198b89bb5afb23f708.1735205514.git.tanggeliang@kylinos.cn>
References:
 <35436a387650236cce065f198b89bb5afb23f708.1735205514.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] mptcp: fix for setting remote ipv4mapped
 address
Message-ID: <9a67f8db-50ab-3e3b-ea62-c8c462a142d8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Dec 2024 10:34:24 +0000
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
uns/12502439231

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/349484af26de
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D920953


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

Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622D2BCF5
	for <mptcp@lists.linux.dev>; Fri,  6 Sep 2024 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646456; cv=none; b=DFX2DkTkZ41IG/kqDn6bTl2moHeFwQX1377SraegwNMN+3SGVIJBCFpQdYgWN50bHRfiOlZ5rqcx6oI1EOiDAJSoG9G0eSeH7B9FQ2DkXettlxOl9YNDNmhbRHTMOFlX3WxwjUfWgtrZgJbMhR1LnFwrNm3jk+vL44+nL1RAD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646456; c=relaxed/simple;
	bh=FeYSNo5czcg3IR256XszvQ/6OhPYsQqriNIVtd7SUDk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PrhpzCZXjIWcbKHfOnlVjdM8NKqU9ut7Y+VINWQPsK3z8APmKlnCudJMDSNQalKzRIlLwcRvwrxJYSoCbK19XfPMQlNLqa0UdkFvuCmvuXLw62S0nhA772WjEtOIfA2kHdPDSA8cwk480FuE9cAHlG+gaARsJUuVbmPmhGmj+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U84bt+GG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U84bt+GG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2059204f448so21526145ad.0
        for <mptcp@lists.linux.dev>; Fri, 06 Sep 2024 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725646455; x=1726251255; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CihCPYV/1mLJJR2EtGHL2SpqR74ISLo2o213PlCmFY=;
        b=U84bt+GGZOWtzR5S0SbEKGXje+zHa+a+9iUSx9ABXbW+5Vb2cd3pQxHzFUYQ9Vw8gy
         UZ2Q4Hf6kOM/O3DXVvuVexrQZXuPdhddRvaJHyso5AbaSYLzJvGTzV4QeRQMBysxR23c
         IIWnyvzpKfDJEpJc9lwzbwzFmcdzDXKeWC37SEYzkP9jGCeao1KJUwqtaTV2sonyUhKy
         qlSkmzJl9yftAmivNqOe4WgekvwyDlkwwlIi2o0P+Y3LHV+69Ed4n5qbZL/ObaZf4eO4
         pEu0bPcqwATqltH03xkgDsak/sc63NEy6HJMFAiYB756V0rUqvZKbx23nEPrfJZbjP5L
         ofkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646455; x=1726251255;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3CihCPYV/1mLJJR2EtGHL2SpqR74ISLo2o213PlCmFY=;
        b=GR1x4aseon8eiHR9oQmHScPBJfkkb8KJefwpBov4IMGUed6ODNwcB3GDe82Mx4i5PO
         XccnIImmNoaNCLxyqFcWh3gT1bzYFoKDxHyw0GpB1YQsxJqvzLfkjgttAGsUnf9VBiIS
         nN0IJwEt7E3bzgpUNYIXTHt4dNBVkCxb03avYIX1cf/ZS9F+eY+hjKJRmpENbxdTpyMI
         rLdGR/xDBGjZanS/fn9EHAwIiWd1UsIt5awEZ2ccRnXDbbnzwp5HsWHvcbvBFtJb0lax
         xxePdjbpaihb/Jxq7ayXrqyZ18dNhZBVegxn2vYTQxcROM3ZstcclTFyQCoFJNlEEhd9
         /rOA==
X-Gm-Message-State: AOJu0YyTTOspleg2Qyo09yp8d/el3wkUYVMz4GXNlgdN9JOH3fKKRpvA
	6G5v54Czz5MGPHAXB8K1W6Cu5dRJKm40FTVpzGAwsS7JhlPfRpo=
X-Google-Smtp-Source: AGHT+IHvZ6Y4npRk5hr5Xdt3dNcoh6d0VpmoRFCWke/qGmd2daxpBJxBZpxXvIdLv2WmW6/4J4fp/w==
X-Received: by 2002:a17:902:d50d:b0:206:a3a9:197e with SMTP id d9443c01a7336-206f04e16fdmr34637235ad.4.1725646454546;
        Fri, 06 Sep 2024 11:14:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.24.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea67bd1sm45814205ad.247.2024.09.06.11.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:14:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240906-selftests-mptcp-trailing-ws-v1-0-03421b02c48e@kernel.org>
References:
 <20240906-selftests-mptcp-trailing-ws-v1-0-03421b02c48e@kernel.org>
Subject: Re: [PATCH mptcp-next 0/2] selftests: mptcp: add time per subtests
 in TAP output (part 2)
Message-ID: <673d3126-c1f6-21a0-b867-6185ae100a3a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Sep 2024 18:14:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10742659832

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c061b56c6627
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D887838


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

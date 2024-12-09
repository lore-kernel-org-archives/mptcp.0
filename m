Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430A215F60
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737946; cv=none; b=ntsS1r107SqcQo9UcAjx4/OgQZb0BZb0t/+ohZAWDjrfv/IeWiB8aCLfd0V+kkLBHMQtt4cbNWtuENmvhZGTXK+0fIMhd2kPSCfXpdhEU/ASIzZoarGt9Ht8bvJBQ9ArK4trDSpZ24JDOauu5mIQUdhScvdmrnjvsMcVAbCuEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737946; c=relaxed/simple;
	bh=j6StlbELVd+u5n9960aM4JQPLwkfN+RZ0v0r+qM9jfA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=A33tD12XT+T2ZQN8s/4OSSmTHnWlVM13A2WpQ+fm3ISvpo6OwIF9lEMZbvsZ8L8ukiLjV/8rRVOfHlFnF8KulT/Z1+lZZsBQ0SvUX+8Bg5B8FFJ6SKgab5T61w0abgyM266AZzCZ5hffEd0nRSoURzEUt6FqdmTleew9ooKXvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWDcZM6V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWDcZM6V"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21145812538so34834625ad.0
        for <mptcp@lists.linux.dev>; Mon, 09 Dec 2024 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733737944; x=1734342744; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxE/0yTcivxJB7eb93gTSfufGDfSfOrc+JWTS2omUWg=;
        b=RWDcZM6V89ngyIAFIAFeivL4AQPKRSl6Ul6c6cWzjXvZIJpfcNoRunak6CtPgVUUoa
         jVZW6WIentPgJTqwRym+Q/j5S8euQlsOqGRdyD46i18jNQVIuxgU+sLIIHZSuQ4NFRzF
         V68D/B/k4ZwWFzzzeTCe9BNB8HCiN1uvTmxGC2wCf2q+MdZVxlbq50CZydzTJs4u5rHv
         1k53ZesxyCuJwCrtXp5Mqj4qwsFY1f4SySOenY5f+sm48XhxVLwROJ9AllmXEWq5/P+q
         33lkv7bjKfbCsnDizTSApVf3pRjCYHzEjErBo2vA2G/XixNCsI3jBN2cUcd8/G3gM3e4
         oaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737944; x=1734342744;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dxE/0yTcivxJB7eb93gTSfufGDfSfOrc+JWTS2omUWg=;
        b=XluAlpQirJgmpPgEi4Cp0oFhU2v9WpT/+HVPVPdIkvRa0ZjoODUr5kLWS1mDoQbfN+
         bGkbgzabKQiJuT2P8v63A2lww1p0xHTUQu5KNLUAw3To+L+wIHzM/roXKknkbjaWOPIC
         6eAkYu/vATXuEdt9gWAI4ixEqDrCJLdgMiTZ4i6kUV/tgDU/cD4B+/fTSZ2bnZ1QcZR7
         BpH0b92R19y9DNF4D1LjkdU3JjsAV4JJwudOzbRBHHh4umEmWnkPl3ghUgbtANlWhLE1
         nQdJ6KSZL6150lN8Qi0H7wYTOXCfnnbvPQ+oLwjQvofKbQmMjT+IV0yXHyD6jLxWGbJy
         ZQeA==
X-Gm-Message-State: AOJu0YyfIedHqQp5H8pObBuzXwdmeo178vXkgq12ix3zzEhUhcseGpjZ
	fRZgTgi0rKGDriqQRkX+LqETuwapwXHWhy1IWcr3WoLbu6N8+jz03wkd
X-Gm-Gg: ASbGnctmmkhAxHqugCBmyvkPCZ4Q3FJDzDaJmTRahksya/KU9PivYIkWE5kJLmKHrsL
	Xdn7FnZi52s5+Nn31V7vo7Ucvx9aSOHut7LKQsunrT8O5XHdPLNticI8NFMXyMXkG4RK3RWiMPv
	1MXm+f+A7MTPhjdECYbiU5B3fpFkXaDMJc+BXtLyvBz/q/U5a1IwFtI7g/tUuSspuvBYeRSRVsp
	jyL23tSnFUR+JCdCA6x1yBvmFHuLnD+omtSVTK3XGeHnbn8uZmouz7p4ljpUqc=
X-Google-Smtp-Source: AGHT+IFQ6O2BCtLyLKGfLLUU97bxt04LR2ULBhp9AeRYpFV28VD7wWzMMOWYzTKKt3WeMooqUMgdeg==
X-Received: by 2002:a17:902:d4cf:b0:215:9649:635a with SMTP id d9443c01a7336-21614d6998fmr138565385ad.17.1733737944197;
        Mon, 09 Dec 2024 01:52:24 -0800 (PST)
Received: from [127.0.0.1] ([52.238.27.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216634dd69esm6224955ad.40.2024.12.09.01.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:52:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733733573.git.tanggeliang@kylinos.cn>
References: <cover.1733733573.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v4_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <09ba2bf6-434d-41a0-c2ad-7882b97425c9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Dec 2024 09:52:23 +0000
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
Unstable: 1 failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/122322=
72946

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d9e0118c5b4b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D915828


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

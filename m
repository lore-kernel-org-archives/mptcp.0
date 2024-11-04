Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2E1DFD8
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724284; cv=none; b=rv9pmPvbordYAb7N1wik0pIhqGx+SZOVm2DZOKE+NcLR8PrRjXfo/NdUsS3NnWkSyXOGORAzX46iBhzfih89V2HO242+vQwzuikXbqsKaMgL6xkCrtW4TW0rZ+QZv/0XHYtUFIZkARSlU5/5lkE5+o944mbZVOtRNoznXZSRAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724284; c=relaxed/simple;
	bh=OsJsnNj3B+McvIa3vMq8W3BGbYaDsPTqfWpONqQS5+o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HSZFSx2Q+l3+JHXtwdbh2X5QAKp8mkzbf9rgIWP+xnXR7DMa7ILe7XEIMCJKHt1OjKA21rxFksYekzlbAFKcKSK0L8tAQtT3yB6r2RfeKmzdnmJ7P3MqK846lPa1AU9CZY1nYu0RImODTlVYiBaPjxxLOVKdviCLLiRGeajxE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmLarQfr; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmLarQfr"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d4213c5f6so1511715e0c.3
        for <mptcp@lists.linux.dev>; Mon, 04 Nov 2024 04:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730724282; x=1731329082; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiBrzt917e40zj4ytvweEPSX74FLlGLwxTtUiht9NFg=;
        b=PmLarQfrEMRXNAP5G31VWJjgCJ05GJZneEHz0uUp8Sybh1HmGO6SJy8uxr1+a0pUl9
         3uPeut7qv0f7Yer3fD5QmfKmnGgcYHxawso/TnNNeBXmBVl4r1MKkq3NoRgqqW7Fb8aP
         dm3Kavi3OS+etM9fNZqs6hcvfwZzOxs8V1LapBsP89D0090IfKsdXRdGNgx7GYdYwL/b
         3/efZv9dpb+ZpKRtFp+iQrwTzOaoOQS5GPzZi0pjzdMhM5+g1MyV09g2oy2HSR9Z38PK
         ySeVSrtB41+DK4QElPT1WbklRO6+QVpY0sTp0cWyqQLsffDrIoR9CrbGnQXj0nppaudQ
         NdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724282; x=1731329082;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wiBrzt917e40zj4ytvweEPSX74FLlGLwxTtUiht9NFg=;
        b=Y+3xtALQcg8sxY2kAJW6hDAbS1JXVA8dVkjmiIJPkbWC0vJIjBlm5D7VYnqn3nwfcU
         xGOnBXC39s8+1x87xf9OGRLZkOquTptwtVSoKnB6VQFloDg7IVlT5dIPWkpXdQ613T95
         N1WEho4W6P7AcgyHd/yTpi04eITu5F++vDAEyTvCJ5AzjFhB5yC3yXL2WARaEX/1rA64
         iBTXaZ8XA4AJZsw0657P7uSq3sC28JKkjxv+4n06XM2CRaK/hx0UQdAm7l62Bi10tYhQ
         wbiXLcXI+8d/DUcPRe0RBw0jGdhry3tfPraGlU7VHOQYKMLYIVF6coEVXxgEJFPg1BVT
         0mVg==
X-Gm-Message-State: AOJu0YyZvaEXKWHyIDNNrvUkJGgtmPOA72A83eCgR6XpWu6xRhKSKumB
	MzXsuqbCd+8s1MvTNOGDfQmK0NGfTM3f5z65WnoYhYMkn/unRT4=
X-Google-Smtp-Source: AGHT+IGaup5bX6TWT07u0f/sDWrWFWw84kkf+6zvdG3x+D7J4+aXM/whOLqKS4BFhaZ5QH/qLF6iLg==
X-Received: by 2002:a05:6122:893:b0:50d:2317:5b61 with SMTP id 71dfb90a1353d-5106b15d8edmr13984835e0c.6.1730724281971;
        Mon, 04 Nov 2024 04:44:41 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a9bb41sm410307585a.134.2024.11.04.04.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:44:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20241104-net-next-selftests-lib-sh-deps-v1-1-7c9f7d939fc2@kernel.org>
References:
 <20241104-net-next-selftests-lib-sh-deps-v1-1-7c9f7d939fc2@kernel.org>
Subject: Re: [PATCH net-next] selftests: net: include lib/sh/*.sh with
 lib.sh
Message-ID: <55fafcac-1854-9cad-02bd-832cf8208a86@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Nov 2024 12:44:40 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11663626947

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a7323a43b549
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D906013


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

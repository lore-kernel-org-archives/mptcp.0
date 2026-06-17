Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A13F1670
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703137; cv=none; b=gQ3sMThyevEctlooPj9jv40I1YfNlonqcP0t//ooBJYBVk2MDArxzdS1HobBzBa5I+EJLSl1g6qj4o8FAupRQGaZSeWH9jjVP+4k5A7PZehlLJAioMuOh8A6McJB/pPpfwkv5VRaCPVQV3CAAXXhonH+UwN0DpL4SUndD3XgVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703137; c=relaxed/simple;
	bh=cBs2RJOn4/u1D6MDJv7+FzTurvstt8MXfc0qcxAc4bQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=I2Y57JNAzNEOBtpJXWPNQTmiTsItZPV61BICCwh0XiZAdQ1Tu9KWchap55ilGR1v39mCzbV9sHYUB6iMRfnDd53Hh6dOqGbQofo8oNtS0g832Pa9jHb7Mch/y3E30za5dzKbOmfwBH44IE/XFzVGxgH1pNsu+78xhYpY+dgeejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbDX3+N6; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbDX3+N6"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-138501f8c04so3157162c88.1
        for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781703135; x=1782307935; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/KVbGDEcfnSZStMnvbW6h06dpmP9XkkoQzDnaJVHkQ=;
        b=dbDX3+N69XsOpaOwqpz5s4tU6I4t54PlJa4Wn8KbN+tckec1R9gLxKY5bub+umhMw0
         vX9oxYPDU5Moh4GpRiOn9cQ3Ilv7Ed2p7DJuxfsmWX5tx+CyeOp2f3+LcKfGsdikOH8x
         /ewfNigusui+bIwv3IeGRxQwdVmaOzw6gCkUhM67YnzT4H3Da+E2r8TS8b43DrFQQGAO
         sZa+ysFk5Gp6/HJoJgYPmY1vMuSUKmWI8t6R63+GfG2pJ6qcv8RrN3TPpZErQzAbxuqH
         H3uhUbaqvleIcJDrWtOWPY/lnXKYPA+hxtPD3izDn5jBnteOKip8+kzhyH7iO5O2k12E
         Ygeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781703135; x=1782307935;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/KVbGDEcfnSZStMnvbW6h06dpmP9XkkoQzDnaJVHkQ=;
        b=L7ajFh72Hvc0H6r67E+hwKEO8G0QWX7uUYcaj6NIvnygw5Jh6+dXivihm4BGQEaKsf
         MoWFlTtoB3T29C+jyWpwzLMjv9+KnYSJxBfw72WNyDosu1NkrCyVxuSAx92o+r8Nts8Q
         U7R6L0SMY1cE/ceDKzMX/p+GFeOmrang08Q6bWfO5dph09SMVD0llHRC7+QSFYuwGUPJ
         Gjh0jJJfJoiFSdEndhLAxcJD0SYkXKfWgWf4pDdOCKrW3P8TdF3bSPrHmyi7ZAyl7vv+
         6GG0hIbceS71lBNAyKesxp64vNO22iQn/C09LlD6RMixNuECVVus+sanYtZzuBLkDjpg
         0b8Q==
X-Gm-Message-State: AOJu0YyZGHBJDowuNZph3xde8gIBnHREIlPb/2/ecEWVgvNNBEbgMigD
	Y0352SXDc5QWHh0B+xax/NzEBWi1O0xYfSQtIpbndYXmoXNy2RfImugE522Z
X-Gm-Gg: Acq92OEQi/RAcqu7+k3Y6FbRQ/h5QvwJYiEZ/0SW6N+Hp/EU4VxbEi1/mJUByxuOiXC
	UIrhNsbRqC06+t7tnR+qMYqeaD1ncEoeaLy/GzJ496PEeVo3+RreBCwdtF/RblijkVU9pAIW7Lp
	kSnG7Y00Th9qDVZlbEErllYlUK/KqI2Z4Ala1/LgPftV0SWBbarqtQB63af8WrIa9q8DzqVGHBz
	/1yyjBIuxabmX+u8AJ4O+HSeiYxwtwkV0gR8QH8jMzKxgeYp1LXdrdyenSUTYW2jqKNeiXF/I8r
	89NW1FpPsM5/6gdKcoxyDsbI8JfnqeMtFyd1G1KT2N3UjrT5ltCVlwGB3OWJFsHlgVWWTPfI5go
	brldX92c0mFcPV/ntj7xyDcEsJNrPzicivK9DTrIhpFBa+hbyCH2G5ySG0piYDWrEA0b1fJxS0u
	xp9y41yaELKw3bI0OP7ugQl6B29mc+
X-Received: by 2002:a05:7022:672c:b0:136:e639:9c05 with SMTP id a92af1059eb24-1398f6de9efmr1798692c88.31.1781703135065;
        Wed, 17 Jun 2026 06:32:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.194.217])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b964862sm16797118c88.10.2026.06.17.06.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:32:14 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <10a30ed6484cc4d48009625f1ed8e12802e78e94.1781699193.git.tanggeliang@kylinos.cn>
References:
 <10a30ed6484cc4d48009625f1ed8e12802e78e94.1781699193.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22bpf=3A_Export_mptcp_packet_scheduler_?=
 =?UTF-8?Q?helpers=22?=
Message-ID: <c1a9dee6-059c-fcba-1284-056de6d6c397@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 13:32:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/276899=
66207

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/50d9d6a3a2cf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1112923


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

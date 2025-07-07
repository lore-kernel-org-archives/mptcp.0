Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812A279DC4
	for <mptcp@lists.linux.dev>; Mon,  7 Jul 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878080; cv=none; b=HlxBLVXzgnWQOdEOWCdFI686zdM7KswDWEZkMEOmdXQb2iBASM7gNQuXIOINAnXDUMaDwGqxp3EGxipRKXkjhsKPOpeh8d9tmRVLvtmLlZZDwqQFOs21V2lPVeeEdc0v9BIvpQJmxaxME4doQfiRfGl/jR9M83tSu/CDOvO1MXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878080; c=relaxed/simple;
	bh=3ZyrKowzjsCBqEu50ZPFN7DtiYOf0IqC2MCKjv8H1y4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=MOML+KjLzILC5FNIZTU6p/Q2ADS/MxC8y139InvogIXGMRe8G+j8Y03FCfS9wXOU6X5BmUft3cEuCGWQy24bZao7W+hT7uhplVaKjK83r4s75GQxWv/8l8yfenKXKd6swa+ys+1iPRHAjphz3gotQ28c+hKpW9oAzDn4KfvinWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6zFXehk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6zFXehk"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d7f2600c17so140004485a.0
        for <mptcp@lists.linux.dev>; Mon, 07 Jul 2025 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751878078; x=1752482878; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU/WnS/A7LgLOSD4ruxmkvi3xpfcJAWvJ8tPhZXoqjc=;
        b=L6zFXehkysaQO2BsIYM6b5dqjyltR4FhY3bv2/44TEX/RokEzH5W+mStpreUVMz+Ri
         ptKVIAwoVjAMYKhEV7gcd0fdQBLecFtWN5i5U7A2YHlS2IeGQWQWqYbwkRtczUpreHt2
         D6hDXWwp4Pfslps3armpgSkeP8N9cjtr987pkZz8P/w9AzWfCHT7L+wmwGoVAtjU6Zvf
         CEx0lKpvD9WtDBgcWbioBe8EBSKnT40ch5S5H3IrUSrpLdSFF1idIwoWQyCQobWyPlHL
         8l5DCXDYP3hu6weMFLOETRsKVIoCXMKlPtuC3cvRcLCiuLmd+E9qAxnlDJpgXFFSq8KC
         t6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751878078; x=1752482878;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cU/WnS/A7LgLOSD4ruxmkvi3xpfcJAWvJ8tPhZXoqjc=;
        b=U7JHDSqwyBArRG0pR9NehWpXSn4QjQ+3pxs4erXachG/BdpICZNCB1//yp4rCOzMF6
         ZUhLmWfcdpvJN2HaH4TKhcqDaragDd8aBgdotE/4LrUdMfUcH4jfcGTyCXLUZMRL+5TF
         i/kQljkYFT6uUUfS7oLIFEUmcvRXaBmPCfdOrZn8G9IwWgDR0mYn3jWYC7EFzF9Rme3K
         UqoQRTxmF0YYGc3LiCDZQXL/OMSN2Enr6codNWJ3bBD249UNZxmp7HoycPXw/c3W9Nb+
         a8r0DiqkOUREc/9MTqNDj8skNO15gzgXVeO/C1jFd5HwyJqum4KbkJr1mJQQpZ6KK/aD
         50CA==
X-Gm-Message-State: AOJu0YxovUeiwdkVZ34PVrkXMRUOjmlB+fn5zGHRBTo6+08YMToqph/Z
	dli8QMFbzvZOJON30H6WwQLv5k3lYrLyuNYZr/3LOQkx6Is+3ot4qQ88t3Hj
X-Gm-Gg: ASbGnctFrfucy9Gdh42FvvmXyPHoRjw5yyTuaQnApVNBf0wx1trP855QKDHw+Jk3vq7
	b6Ixhnpq2rqoYQ5bMjhXJnl85rV4zvkUO9TngUvh5ruaVjAortDa3GCcFMzvtXLQqWaFLullK97
	VGiAcs+hVkM3hAxeOSXZb+cWhAoT8gjgGYQRhMAuWn5HltsioxbgrbctZ20RYAyxd9wxfSMlsby
	U4TlpSyjIBchlqf/XE9xLjZ4DTuWBpv++b6gYMSkrc+61oaHyB8HCym/IYjNSucOsWdvxFIGhKa
	a9IZ4S7uG5IgAWzr4rf69cnnIMI/jrsX50+6zjsxPdjfvAoVUnMXejOWphUjzC/wTSH0XHyPE7t
	M
X-Google-Smtp-Source: AGHT+IHbdXR+q1Y3PW3xK1Fq6Z4B8WhfZQZWZlnZUOrYzfcabjyZqVNuFEe6yUIS3t7BVKuf4noMtg==
X-Received: by 2002:a05:620a:2495:b0:7d4:295c:884c with SMTP id af79cd13be357-7d5ef3ea5b9mr1075808185a.7.1751878077718;
        Mon, 07 Jul 2025 01:47:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.252.179.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe7bc9csm560963585a.63.2025.07.07.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:47:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1751699999.git.pabeni@redhat.com>
References: <cover.1751699999.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 0/5] mptcp: fix fallback-related races
Message-ID: <9df51ae7-33ec-3c54-7b35-87d475f85667@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jul 2025 08:47:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

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
uns/16110745406

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/54ab1b69acaf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D979295


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

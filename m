Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA027E049
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767530983; cv=none; b=JP/OUkmRb2HHg/1Pz3REpKwcvVQoiBPRTT/7if5rsVu2/f8LOjkO7lYJVhUqP+7fKpz8TDGeyo4pIeTgsn6HOaP5lP+z3oCQs1rCxeadW4uhL+79k8U3WW9Je+byN4RC/NDJWRN01zL+HHvwgo6OIQz700n9RHELlN3Hy5nsvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767530983; c=relaxed/simple;
	bh=z9xbgzTmdVqrh9Pe7cM9IUmW/mWD41elEJ0SlfvO/Y8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ac/HZYekwiYXNdd3oYJNy+9ewf6j7zwtxiy/pxezSxToVKNbFBo6oAYg9745PcmRz+vxbOrbnapH/cum0DPQhUtkrOqudcj8ztR4woyn20DHkn005u5XL5tM1x1Dbts2iVsYAKrNvDQk4gPvFsk8CvnxIa8mzn/d/2DoAWbUU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoSF5vul; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoSF5vul"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a35a00506so152852366d6.2
        for <mptcp@lists.linux.dev>; Sun, 04 Jan 2026 04:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767530981; x=1768135781; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBPpJ48TdEHRTC2VKNcjGjDPDKdkHljoPtJIykk68+8=;
        b=QoSF5vuln1xKoT/qfF20HppCaFavPzrIyeNMrxsRuS2W2NAHuxaKVmzWEuPD+75iE/
         QcyDvVMbjSy1scYNt82YyDMpsaCNQy7ET4pSLXZinKOAIkkoeS3SNDCMhcwdsZl36zn4
         af0F/MDMEVDWG1Wk36XaI7ioeDb52/TG9RFWlKr5IJbNNB8tEtqhBLzgCONjJN+yml3f
         cHkARXQRZAOQebWMvGvi4OaxfV7LmEZXUhIG6HtHCH+ywYYNNCLMPOeddG08oes8V2qz
         hQNjmfY6hXAzVKQ9RWuRA/AS8Tnr1CZ0lIUPTYmccQ/eCvc7lBMQmzSKHe/keujeAPkP
         cUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767530981; x=1768135781;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBPpJ48TdEHRTC2VKNcjGjDPDKdkHljoPtJIykk68+8=;
        b=xC+J04ByG/XIx/gzw9NVn7kFN6X7w6wWPKuCJ2RpI30u+QHBLDSE2XDljK5Vr1BJvb
         dTFfFWnNx3QZIbmA8v7b7/yFoPex0qn1t6CC7cc6Imm/J87N5soKtZggI5mCP3VDNqLj
         pJO9hrnadTOWYSSkd/32trEg3z93pZ0LHkvEHw1QqM0zPviTA4Kx9SWh1YcaKUzSjZFG
         Rt+fAmhpWc2imiAriHbb19Yrax7WRM/g+jLYErvMCJl9kRmrAnwuKY1K+yFwTI8bl2ee
         ynMdx3bqs7J+73TVPxgYGkmLOdQyE+lTSUYsDUV4fouz9OiUnOq6udWiqzpsbeCriWQQ
         JjNQ==
X-Gm-Message-State: AOJu0YxsViyfrCKY/fWVqT1aREQgsNa4KgksXHXmTLRlFrF9LotTNEgh
	MuuHFporNZxv4xpWSct0MBSAgZa/Ea0QsZChYWpWUUC0yPw9T1AGBH5UnApeGQ4MVg==
X-Gm-Gg: AY/fxX6l0JYYFeXEvW1o2G5Hu/l3gaODBdiMgSUT51YjHZfRgdSme2ri6GqvgwErxEQ
	84I18hRSO+dmtLGOKt6PRWLv9GCVuZP6mWY99dn0AbxBIsp6vUqNPW2yX5aJQxY6QxCFgIFPJqT
	i2rkQnJ888er63yYe43ww7GnemSJTc0ufpzZ8uBuY3oktAyQokQ0hx1RhKa3QFXunB4FdWEmdou
	TDvmaTcSYAlswE1OLvNZuOGZC6tqTMIvHeY4maJzxUDfJpbc9HJUfMfUX9zSW3cYIg108SBLq6f
	I+iqr215VZwL7QASFi29u4Rp0YRv33zUHS1llE4USSjb3gvp/yWxF0HrD3Ok8a/hVnnSmuR/ROE
	KWpEtG3CK5373zXU9s4AMQk9yZR8nWdOQbmcdBX6fZerJhMgefgEMQVwxRHMX8b6e5vEND+o6An
	irJi/uvMfJMg7UFAFP5w3eCWQ=
X-Google-Smtp-Source: AGHT+IEn4n3moR6r9wHanCcNrmfS3hq51gLrLx4E6OVacbUkgH1WujS5LdGaJdHQE3BCzmLL6CA0Ww==
X-Received: by 2002:a05:6214:328e:b0:889:7c5b:8134 with SMTP id 6a1803df08f44-88d82138446mr751864966d6.27.1767530981127;
        Sun, 04 Jan 2026 04:49:41 -0800 (PST)
Received: from [127.0.0.1] ([20.55.126.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a44c880sm331674666d6.46.2026.01.04.04.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:49:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v6 00/10] MPTCP KTLS support
Message-ID: <8c529444-15b4-b9c1-b20a-46367d0d09b8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Jan 2026 12:49:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_userspace_pm =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: debug (except selftest_mptcp_join): Success!=
 =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 =
failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/20691127354

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a5cdb3d625cd
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1038175


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)

Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1E1366
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715825794; cv=none; b=kw7VlkfimfM5vTKkvETKRXoZrX9G0SbSUgXrxKknSOcoX9hd7sNrh0J0VKrYxExuHijmyz9iMMncwHMihkLdlQ1w+TjP2w/qswEJELsA3rVv+QnX4waweXPzNmSrULohAMkoy6mZDqYG4hw0uyOzvCSQjAt8EzQ9q3CqututtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715825794; c=relaxed/simple;
	bh=sq4ALzZVUq3EGYIIv9uG3TFH1pMNxcaJbGfk/93w7nU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=N62wz4qk3vODTpZQ8cBGNoXcRi2aN5Il9FAd4DrCNV6lg+XC5uRv8Ma9POzUsbZfk8xCkCYei2zqfA3qx2+j1PhB2CYDF4vg17yVIr1oM8krVPvVUb0IXxGvtHL0lw4Hz+8IA57jh5UlcsT8PS5h8Nh08AviswnZljOqc3sIN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0IBJtxC; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0IBJtxC"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b8d98a56so691784885a.2
        for <mptcp@lists.linux.dev>; Wed, 15 May 2024 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715825791; x=1716430591; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTaAMq5QUt6BII+CzWiotTNM1x2rOq0fMHL+G9c/xAY=;
        b=b0IBJtxCE7AnaKL6MbRyCyMPzR8YzmIX87a4z8eWUiPXHeU85TpXUzvLjzpDzPwvKN
         2Yd/YokaIBvVwCvt8JBpngsUf5eiNGwlgG4sCcs/G+hqQtbnbqRJbJMDypf7E3Rz6zYU
         QVU0S5lOBL+hy+7P+xmFPZGHUtUGRUBxx90azsonr7Sbr8HEQSlEApncqsW0P0m8m/Ak
         qoQvfvaO8MFhNsVaYVu66XqS+LTUr4rYJVa2PRP0A29YjgDqoSvtGa1FsbFa6QmviJdE
         RgcC3kbFd/dXwSrA33R4IZeiexdwBjxSXVClCVNfPVsqQg+BwycBiNDaqFoHRtQpHFme
         GRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715825791; x=1716430591;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTaAMq5QUt6BII+CzWiotTNM1x2rOq0fMHL+G9c/xAY=;
        b=PAcvGNPCVoRjcCqE6O5XfYHPp4Gl15kSLIreTpXk2GPRIPzuMBSXflLcukEhklMD2a
         C0wVHIk5ya+LvvD985n2XuAmg/E9QFhZ4I/457n8ZqGdw0zEA1ScMA9UNj464sJkXCtn
         dJRNWdCkTvMDW2+R1GkYhDtQekNo/S6gQj7CdUYtYzvpVHTapcNC9BKdTf6I/ZxTatyS
         rs6OAqIRrl8NEqU0zuUJuZi7BW+XiKMQMvRku2sGgu5QA0OPUSzi7KLa5YzjO2tPOH/4
         VY0nYZ/l5gs+8LMBbIi95O3pvGOCAj3SwDo2R7dVkY8mOXnZtTH9GBi8WvNDFlGSgTfG
         4FnA==
X-Gm-Message-State: AOJu0Yx/HrtsAhvmm728x17R9ahpgvIpVZ/6HXdAQ+RYpCNms/ZboVUn
	UE1HioRM2OYiVSF4d5Y6enaDC/8x4zdSYApcMigCX4DIfhX6tYNBFu22
X-Google-Smtp-Source: AGHT+IFNpeHM2T2L0JM68p69jZT97DIoLiF1wf8oyNgT642ctHRNEU2zBVBdStWTEfVDJ+JkvbeMNw==
X-Received: by 2002:a05:620a:e0f:b0:78d:766a:d695 with SMTP id af79cd13be357-792c760392fmr1799627085a.77.1715825790965;
        Wed, 15 May 2024 19:16:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.155.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310713sm747434685a.109.2024.05.15.19.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 19:16:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715822527.git.tanggeliang@kylinos.cn>
References: <cover.1715822527.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] fixes for create_netns
Message-ID: <617b6be2-add8-853f-db9e-394dc7deda6c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 May 2024 02:16:29 +0000
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
uns/9105138376

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c39563ddfdd6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D853542


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

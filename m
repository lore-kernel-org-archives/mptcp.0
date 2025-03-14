Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E41F560E
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946508; cv=none; b=AIjs+l5xF9ftZ3zWDtGSO9Nuayp7eofHDC8Mz08HGLT79YQWiZGjsGDlZrdMH05+CGD5/MAl0K6ln2waCUVn0jOQbAy25bEUs3JjOP/V/gBTk777Aat5aJsfSBr412u1HudumsaLmFSogppCu2mt+sTvR3M1TvGvBrcJhZ62S3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946508; c=relaxed/simple;
	bh=VuMIIe+4aW3+bECZ9lvUppD+LdqjJ2oZZnHeHtJOefk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aQmkQSrqZc09I4QqMy9FgeKpkhUnlX/wl81H0EIDzzV8T1HfxdDYd+dkC5YgBNZEPHYVYQZE1EDNXpQZTJJ6pXAHr51ysYdatvV1JQ+mew5k5cV4B+NR2Z6pMKBh47mL38GDmoghL07o3X2WRt1fUATFipWloGdg8wFThYMucCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2L1jGZe; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2L1jGZe"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd049b5428so24663336d6.2
        for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741946505; x=1742551305; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVh0zwe2GzfOXSfBeyIr753xlVNO6fpnD7Fx/orlf7k=;
        b=Y2L1jGZeVZMn6hdXCBBiL4yGRhjwD84s6hmRpXZeu9t27WWs8sZx3YlcbfKYuQ5Anq
         D9I4WV8mJw8kyUYDIYG03ac830ATQQ0h4vdvGzbg9n8/PtOdCPvtFs8E19WEWC1ry3Fp
         BTo4+WhmrqFcbsaOO4cBnpyfymu/rFsLmm3hrr8yhfHaZwXCi5XH7kGxQhDyQdb+3hLd
         N5VfITCG4uDCM36kRfPOO6/FyX5+LfFn7Ev/GG+ulTg4xg44yrk3A2Gwb71IlGkRnAn9
         BzO7Sxz7pXYH7twHDAjoGR1nM/xUeqg0Jx2sAa0VgiSEffGpxmlliSuPusCUuZ8jAwNN
         juvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946505; x=1742551305;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gVh0zwe2GzfOXSfBeyIr753xlVNO6fpnD7Fx/orlf7k=;
        b=Q021ugjRNmbbGQkIGvjcvEMiSkLrv79g2kybSCrjWWSevuyIluv9QvTi13i153Db9A
         +1Q9GFOB7szzndHIz2NKU9qoKSDxB4deNV47ar8lP0HW9mx5/ZzdOsp8j2snSz/qA5pY
         1n5LsB9DOfdVrRoZI7gekazOjAZ02sGhMUguup2WdNWCNqGEMUwOaxxLfBb//qid4+Wr
         u30kWjy9FT2PhUdf5opjMlDmRrsjdbC1ug3f55LVU9VGFutryykIKsJDgtgYuCtLwBnf
         7BJB+dt30UEQ4ps2+zBAkHVn5+6WrszA4a1WjylLv35ahdMM+ev31TV7jo+j3sAmvavV
         SqjA==
X-Gm-Message-State: AOJu0YxEDRvG8B7AvaJxomEexlsjVaSwzmN8cLDdZeb7bKMvvZ4mkgVV
	iXfBATyJxfqGjh2JIVv7vewaqGfz4+y5WBuGuPRLbpUozUkdKxowkdid
X-Gm-Gg: ASbGncuSfjwq9jS9HIV5B3xYpI0JcpWV6FGDE/FWqAtin4WpsuZBOnO1V5idIHy+LFq
	3mHu+kD62YiycnZQkltCdDoICber9uQ4RgUaFDICkhx+Ce6bVMBml6a2a0F4jizryfyGCwnDo5l
	R7i6yv1vG1+czkkDZMiuSdIxkH7HJtK/XnnQo984Kmgxtb2f7h7uwcAC76dwA8CxzU+gwdXqv1p
	LB24nbjAzSaLocxJ4ad+s8U+6tQwq2o9gI82FNaCcDinwMOr6gzSBRDd3EQcZP0r6TWAqU/tY7x
	bJmQgChN8EeUV1cgXd1FdQSopGJQl0bdbcty76oG8dihFB9fUb3FEmEmUtE9Zb31a1os1A==
X-Google-Smtp-Source: AGHT+IFyZkrJjsQgXY2ojhkUpHt2Nr0VRGmRzc+XNbXc1/8alYhkvj8nLEItE2OsnZCuLcJy3UZhsA==
X-Received: by 2002:a05:6214:dab:b0:6d8:ab7e:e554 with SMTP id 6a1803df08f44-6eaeaabea08mr28820966d6.34.1741946505207;
        Fri, 14 Mar 2025 03:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade252220sm21465606d6.62.2025.03.14.03.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:01:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
References:
 <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: fix merge conflicts
 resolution
Message-ID: <8007562c-5f4f-c0ec-dd38-97eb647554a1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Mar 2025 10:01:43 +0000
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
uns/13853089822

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/774e60951372
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D943849


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

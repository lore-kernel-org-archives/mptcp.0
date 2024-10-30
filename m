Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592913CF82
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273383; cv=none; b=vCr8XQaHGyRDbUbo5cMBjDxLfoDZ7gygLq6IBSzWNCJELJuZkH9eUur+vkcUClwlUpDDL1TavbxDubGl3katSyXem64d4048BW9wqfT3A/VLRanheB2zUc3JpihKBkz2fbGMfXb6OwzNU5vMPU6ClfY/BhHe9xLJr2GEBjpFLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273383; c=relaxed/simple;
	bh=IgDm7Oe5F3TMyPGrG/RJfYnoySb6u2O2GGX29cUM7Po=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=S/dDhRt+d4YEZt2LUiUTH+BKMGEsRuJADWfK9QaPiAq1JO/K6fEzp8+suzkhJQKka9zLVGKMJjEhNQxjKyVV+VKC5XSeDbb6PH1xsHKzUEQ8bly8faOx7qzbDW8xsI8mxTJciUAKH7MNgnjbDUK4nA2utgeEkZNmIprfmzh1R6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZnNSzso; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZnNSzso"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b155da5b0cso420772985a.2
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730273381; x=1730878181; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tumir2Gj4FvEieMRHrcfeigsZSIcKBEZAsZQ1iULnqA=;
        b=gZnNSzsozikdMRV3lwB5rUbv/xnC2WOhvquXtrBhic+Ugjid27pBrznHrZ2C4uaQu5
         bbzfnvJCtE8VgkLQr6wrmUtSRfV5SVvtBBAhenebiaoe5ir5VU++nFCuxSytA3ibtEv3
         DDf6Qb/2krieOt5h/7K19iFFzxY8+gb4gRwAazUskZGXv9gckgsnFJYZOLROqcnuTm4z
         yJCGBwgB4LT+s9ha3pPgaajZpN2zoWdmb23aJ8E4xsjVnh8WspLITrqh+AId7WKcwpdD
         nQK+iim0jc67uNVahoV+Kv8tFhyDAfUNaQUgB2GgRvAQHgkWKqaXau2+HxxfFrI/421c
         gVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730273381; x=1730878181;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tumir2Gj4FvEieMRHrcfeigsZSIcKBEZAsZQ1iULnqA=;
        b=hYnjw1lCdfc4kGHtfHdVU4hJFw71vrKk85teM45Q/gtE6I7hbaMy910sRP9iU4hDE/
         V0Ed9NM/eGGaduQcev6TbaF5D/4vamY/GHh4f1o5UizIlDikJBAKPxOxLBYIBbVAwnn6
         GeD+YU0+m5ZSSgIUWtbv+mOPAOBwya1n534CGIaOtfa1NpivfM8YK/qKn3YN8n+hsmFB
         tG2hS9+Qsbqoig/qo/b/flBnW1q5Fsz0jgo/u2ldE+B9wTMGNcVYBH3o7abpcHjhdISi
         LibSf55f/S6NXwAT5jhEG7+Wj6uMcWIaFK0NP20nlPCxDXmH4skjpq0zMRLWy3jG/c0/
         /Tig==
X-Gm-Message-State: AOJu0YyonefQbd702nGNXYQ8CTGbgLssSmpcazWljgS0ce0pAfC557Qb
	Ut37dN7K1Mhl57GgxKRxkYBGqNdeMTnsN5wcbJvQBMiGqJKjDp+/flr5
X-Google-Smtp-Source: AGHT+IER3THZL/PIyofVJ40+aJRpC8nJ4FkLJMuWXvU3qsAWoEyXdH7eozIDMjCbOoi5wYGvjNRhAw==
X-Received: by 2002:a05:620a:25c7:b0:7a9:9a28:5480 with SMTP id af79cd13be357-7b1aee2c100mr318437785a.46.1730273380837;
        Wed, 30 Oct 2024 00:29:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.46.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d343fa2sm489296485a.110.2024.10.30.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:29:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 00/13] use bpf_iter in bpf schedulers
Message-ID: <1df17dc2-5f35-dd26-697e-fda339e97d57@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Oct 2024 07:29:39 +0000
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
uns/11588163116

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3711b7b9446a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D904507


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

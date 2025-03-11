Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9E221D93
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689996; cv=none; b=cHVyXRZ28EoFbh1N+aaLguijvgD4bcikr5tOZutJ/3OoV3N7ae2Bpm42yfY7jWWoJLobFgPbTAcYPEOF2ypw4GehV21fTMeegdLcCQ9Rl7B2/aqPjLcBqo5iER1BqsGqKx8F9fxj+7lkJChFYhbcnfamU1BfZNdWd47Y3J3tk4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689996; c=relaxed/simple;
	bh=MhuRSUvuNstyGkOTyxr9ktWW5ydwYB3nR85DG2LAeCk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=G28xOSHCY07OUXsmctf8AvnK64VmKbjkzSZVbCM/1rYnwp0S0JHEVV7FeVsoyLEuL5T1eiHAGjz3Zx1NUKUBew/DFjYepit62F5kjtuVvI/uQVDosxtCGLIGui+AmoggiHx+i6pcBXwZBl3y/G7jxJ/HJYiGuzcDXZBLbQYW5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7RLhoNZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7RLhoNZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c04df48a5bso463845785a.2
        for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741689994; x=1742294794; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWEY8PHZ7e3BcUuzBATHsBbyE81ZsQh5AxaUWt0pO8g=;
        b=L7RLhoNZ3tBBkHmHi0EF7Bho+J8PfYPC+8YsSa1rx/IJ6x6q7qDF95Ug/D0VIMLsZM
         nvNHtGuPjBaShheFPdg4sayl4qNbSF7ChouaidOMAjSKp77cPrPVfyKU9cNAnqr5ctGY
         nfiwZ1feJHi7BCau/uDCtLfe5YaF0CawfKtdxdt5h245x8vE1/MgnuKz7lDfT+k+hgx2
         b8TCVu/ouZyNMUNQ8usTota61053jGh1y17QZgS45D8tIFgyFajdAxcnc/l7Otq8ShBn
         UxFg9LUot47vrE0czIasC8CEIfuRFq8mez703RoZgrIVivAUwoEjL64xH9Vdp9QqZ9tD
         0FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689994; x=1742294794;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hWEY8PHZ7e3BcUuzBATHsBbyE81ZsQh5AxaUWt0pO8g=;
        b=YiUtBD8iByR5H7p3S8hx7+OtBkRohLIPQVi/SNjgLzuBOlFDBLZ+1U/AwzTxTAnvCz
         pBmjM/uxfDSzc+ajVxMu+s+CoDjuOUAiEjZQSV02e840KxPIiCvAJkMxpfsbhIilxgsI
         zqqrl77vo9w7sQ+w21PnqNkTYL0rCRlhUq2fp67CvmRm7BqJFNXLLFfv+1G/p6C5ZuMO
         tlOh4qrgJ1eiG71a4H9Ha7zmFY8ZhRq7wfDHpJn5W7wGSdrQaqy70R+yAXkVaP7olpvY
         LmGNAn2XXFEhV8zAWdMlAOBx7q0nKU5iZBInzHXW8gEZzkuq8ytPy2R2l16GuYk1vNMg
         OUIg==
X-Gm-Message-State: AOJu0YzJCBu8EiLVLmdrAmdoee0otRnth/qlwgiMhNZ9uR1snfdYfg9M
	iZmoEwQsW8lMq/1MZVWU5BIFOkOpPoV3PS9Nwu2N78Ocp1WK53xvzUTG
X-Gm-Gg: ASbGncsFrbs9d/q8cpUW/O3O2BTT0GBnpvwknR2LFxkcJD3SUe4hdlgNLkXiit+TiK3
	/k0rq9TGs0WIRU58L4ZgJ6bi0b0dP4m6h8Ypcz4kLMJCHa37Vz7/+oBiTpR1xnLsVCrSaBwOK8H
	BFpeccfi45iNqxL7l6Wj91pmLW7/IaemJeHXpsgVKjGYgRrBrfNjsHaGzGBVOBKWa+J0JlWUqsP
	y+YXKccyELQeqRHNZCn44MKn8xpFGxO/zLNPqyCotNLfFRKiABU6onwzQVjQgl75jPYJMG15jLM
	ff+Sxhi1smWT35ZHIKHP44jYWChlUgl3sWal5mJ4pvNAA9aoZdx6xO8x
X-Google-Smtp-Source: AGHT+IFisZZWfBYfHWDkgr7tepGgAOJsGgihRsYUEIdSlu/cLU2dpBnmNhTGBq/l7j7WmeAU0lEarA==
X-Received: by 2002:a05:620a:4381:b0:7c5:6742:764b with SMTP id af79cd13be357-7c567427b5dmr13176885a.31.1741689993983;
        Tue, 11 Mar 2025 03:46:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.204.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c53d010250sm561631685a.6.2025.03.11.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:46:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741685260.git.tanggeliang@kylinos.cn>
References: <cover.1741685260.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/6] BPF path manager, part 6
Message-ID: <0d282e99-5b17-5e38-8051-056a874d61e5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Mar 2025 10:46:32 +0000
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
uns/13785066155

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b7ce0c21df52
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D942639


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

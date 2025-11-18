Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFC245012
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450284; cv=none; b=dMsxf8TcJFcMOm/DNUwelfwDmhm3Yjtx67QBSmu31jusSzA7XbLod936W6rspLnQ/PXmJedEw0XHX+hP1A+7Q4XLlEgASxza76cibF4DJsMscjCDHwmn8WO2wUiBBQe9SS91l0aEe0AjvuWZnRQ9KNtPSoBwzGjBqjUhf//dqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450284; c=relaxed/simple;
	bh=ip9azbLbAxQyM2LnkHu84eyDdBBqhfH6jw6KKFHKzFY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=X9W8SDbbWMrIv+tuNpA+yjkduOHJ7zUFxX1s6LB6jPCKNSB1mgwgAaLB/pcc0D+Oz/a1XlPzt6S+ANnF6YROBlxSwJU7LLkf85Bix1c21D0+GLEeLZ3cSp5QhiCrZE8Ck/tSUF5UUmJs3+ZvZiQ08EMCA8nMrdsl/vurroeeJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngxheH+l; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngxheH+l"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so48475471cf.2
        for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 23:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763450282; x=1764055082; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxaxMvD9NIQp1oEqkILgnT/6SkBEgAT9T4kW/U3SiTc=;
        b=ngxheH+lE67L8Fsx3C8dZ/TfvnEom5kjTpFaY4pOQS9h+yPDOaxJMIYmazmr+bV7Hf
         +4AdksDeZ0kRKnbQ4immIi6taTeXx0rW95s9TwycbRuOtTNkkb1wIVCRRvxJx+qsNKmF
         fLQlJoEsUpeR4hEJ6y4ZcjM1Ns2fSRIQPUjy5VkmDc6aiXVXeKZppAMYU9ChE/yx5oux
         wvwhvCLPHvGLM4HGVEcxZuLELOdRBkIcn1STJo1/44zE02gurSfHO6dayxcAIalSDMJB
         XC+V2Am/PI52z5kVSlbYO23dZeFh1bpvpsWAHOElmGYM33QesRIGHAFqorR+rO8pNHG+
         7vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763450282; x=1764055082;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxaxMvD9NIQp1oEqkILgnT/6SkBEgAT9T4kW/U3SiTc=;
        b=szU/Lp68CZ2MRwnRYseg8e9XUhxh6f0EiZ4Ta/K+VDFnot/3PkYom1P2lebsxUAdEv
         HS5qicBb5bSNL0zmZY6lJEZ2MNGOLJp5V9wPqO1Wg6UIdhhOsKd0rFRhpvJvNI9+yIv4
         baKZxldqN/ADlgVXWhHTA6HwvpXC9sYL9jZCKHQhefhC4QtBjv7URRFFGwRw9jdJ9DIl
         sKVmLaM0FfzIEk1uTpJdiizsXQdbgWdf1mTMzMU4wbzi9RLzmUKzXpjpkEWotjTeGUcb
         1bP3oKy8l6QNiV4lEfz4PXMLEqVc1bdFOFuIBBzBTWWhqx9gAFIWjvCCOowo3gzZ3rwN
         h1RA==
X-Gm-Message-State: AOJu0YzTNrFLtdoD3AG7CmKKwP6LLNMMaqd6KO08imoNX4CMryeD885X
	FDbNsCOAShZkfPqY3YZKhzSnSGOA9dsv6gnX3T+h9Nz5pFQhwJbRi71Dw/fi
X-Gm-Gg: ASbGncu/Xg93WHsyVMnesHQvI9ZgmBYQn4DDrZuKCzS8K7JvRc06+v37HwDabiggw1B
	1vmHpQ1fE8KGbqSdd6nH8TWXFNiZbyETWCFC/omnyArDTM75SKfC3AnOwgY4urOMEmPGHdmWRUv
	+mwP4wKsXTrERYGapFqENrPuVBR93J0X5J3lkBA/S/wD3oODqsTKFhVI1gfwLQTQC8b5ekQ6FiB
	BbWuzxQOsfZZTyq3z3TB6Vbw9xBkSDWAfOLRrm/lx1sec9GsoKrQ0HA2W4TuZCtW49bq2oSRT2U
	FRzg2mC8ru+BARSNUB2fYfK3wKEth4fc2i5zX9c8irU1PnMH78AY8HQlNlLXZJpMK8U8l7MAdKO
	QWTKOexRotvY8E1EbTqJuacGvUJOWeq5kLjoJAU6NjBlfMwmumDG6b4CK29XJjOo0v6J7MpneCg
	X8TSNDrdPeoC+CcZsm2Yp6VbHVSh6kBtoQYA==
X-Google-Smtp-Source: AGHT+IHufSsCWUiHuqQjfKxkNEA6U2MP0P5fZbK2lufpD1ZJw9YN45iB/PlDa4dw7glOmVzEEHRLPw==
X-Received: by 2002:ac8:5e10:0:b0:4dd:ca89:8d7d with SMTP id d75a77b69052e-4edf210df0amr178376171cf.56.1763450281791;
        Mon, 17 Nov 2025 23:18:01 -0800 (PST)
Received: from [127.0.0.1] ([48.214.54.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86f2accsm103337641cf.12.2025.11.17.23.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:18:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next 00/10] MPTCP KTLS support
Message-ID: <68d0bf3c-d4ec-71c3-9d2c-da55289a53af@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Nov 2025 07:18:00 +0000
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
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19453856409

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b37b703d4e0a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1024635


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

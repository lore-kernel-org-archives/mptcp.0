Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291F2EC097
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277921; cv=none; b=qJaoeP4uh/Xe8ueMCM37mFXag7Jmag+MLwTvO5XaLQxsC+EQ3Ue/iZoprMsFHc13thWGLfBZ/DN2+kl6c7vieSFb60vNZy8zISW9/PJ+hjBFs29Sy2lFMP+toit7ISQbmdaX93g89T0p6ME/LoGDho2+o79F98EjpL/4nl7eVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277921; c=relaxed/simple;
	bh=gcGipeSTHpfQOyPWsIAjQS6C6k/edvhKP4Bu5JfI/5I=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=L2lo8t0jSy87mhMBEoEmyth78Ko5f/SkxNnt1rnEwvfpgLnNMttawYX2BsFgQnt6Y7e82g9UtU6DDr+Qa5o+Rkg4e4gN+XD2RNjVnhJhvpScbG40vUyn+hjLrfRd/z5O0v/lXktpTaWZwkYMkxqqNVNk92kew16bQ63QJ0i2Q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEACRax7; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEACRax7"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso38988095ab.0
        for <mptcp@lists.linux.dev>; Tue, 04 Nov 2025 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277919; x=1762882719; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=522HjPcXbatAxWPfV9wcdsMvhvyKSKICpDWZ7qnP94A=;
        b=hEACRax72rW+lfNboC6s3y4bSu/3G7CQyllV27S1YDPBpe885hq32ArzxkpIkTL290
         DW0btdhpFePmSmKg9XHWejClh2yE2gOi0jZFrP8WOrCaHhpaNU5Gl17g4ehI6FeHLmjJ
         LEfncBTMGibi3Ig0fWC4NOm6yIeoH9DxA+CEQZFd2GeWEIME0JIPw6qo7ofA+ZCY3DVE
         zUkNtqlPJ4PHroLpON9tjtn3Nuzpcxz5RFSmGAxyqDp+8XBof8Xh2SElg17O+Vm3WrBX
         yFXfRcAwP9zOukgHc3E1BYMFV19BWWQq25wU5E3Zh7oJ9uTGJSy0qBVLSizV7lBHRLCi
         RM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277919; x=1762882719;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=522HjPcXbatAxWPfV9wcdsMvhvyKSKICpDWZ7qnP94A=;
        b=b4GPznyI4fyjcEM79holafuPHHZrt4US4p7aE5Tcz6c4zvhPefg0wOMIoVNKJzTKWd
         8pG0HBEuKXJVAIAeb0mr/8Gz/dvgS2lia2zTsm6/g0CLBbQ/ZQCvS6+A9pwnv8UGYa8x
         o55WY3ftl8absm91f0nw154NMxG9xy0MtZa+dUfoDQ8y8zwRJyFf/cZyncnx2Ut/m10Z
         HUYWghnVmnjIyfkqnWB8tp/Mh0q15OQ7ResAsxEhdyoMCPDG2ETV1X7n+I6GPeOQOMaC
         QnV2Zki8y30KBC0V5odA09sjr3Y86rcgWqm3L9qdNP2XFwLCIfggdDKWheK8aNNaHMD4
         KLzg==
X-Gm-Message-State: AOJu0YxRvvaPQN8fpoR47zMXyPEyXQwm9yVxfFYbOl6xVLqEoZVxe5C8
	5rj6XTNy3kZE5hE0dyactYtFuaJtD5BZF/JPtGS4kDZ9SJIK1sj6T7M=
X-Gm-Gg: ASbGncuOcCmdYv68Ihmq6J0UNbzeePALzKAuSfxJmkXGzmZjTTVnkJMPZ2y1YrhtKuV
	xHOzTMG2yXbbOo04tBjAaUnUwmM5bFp5Q238qhJPOny8RxzSeJjTerO/mpmu4gv/yuC7vGy1pcr
	xbcVg+lwUNG3foa2b8HXXYjFLuctqWCqRMKEQ3dhEmcB997PwZQM/SlDbNvcD6CZFFXOpaXaheW
	kAptpLMT8VxIKJza+G9doAN5hvOCqrvAaab7qjsBLkoLgcR3VCKEv/x+z1kFCJxIaUZRi5P+ABb
	PyVWwsmuRethGyylmdaGiihRg2foQCRcsXrvacBHnvHnKViEKzS3Nj3lc/NAUdLNLYj6AVFjIlS
	ckw2aOEqIIAU+TQbHDAIbJzuWXBXHwIvb6AZinHv7TBDeeezVvKGqBlILw89+ZtUTB0OuGLeGwO
	BWwfWLWqL5oQGn
X-Google-Smtp-Source: AGHT+IEA3iz/miG5pQU80wvXdIn50XOsT0i4BcuwtUT2CVHVXyfBp/otgxZJQ4UbodXcg1KtcsN8cQ==
X-Received: by 2002:a05:6e02:1c23:b0:433:29c3:c512 with SMTP id e9e14a558f8ab-433407bca22mr1462385ab.21.1762277918788;
        Tue, 04 Nov 2025 09:38:38 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.97])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b61495sm15692375ab.33.2025.11.04.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:38:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762271864.git.pabeni@redhat.com>
References: <cover.1762271864.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v8 0/4] mptcp: introduce backlog processing
Message-ID: <ed2a2726-308b-5521-5fe6-03af7ce8da45@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Nov 2025 17:38:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_connect_mm=
ap =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success=
! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19075373936

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/249ad87551cc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1019535


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

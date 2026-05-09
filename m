Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D6208D0
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317162; cv=none; b=XOgt3NVKy0uC2rtu4Qpjl1MhkMZt5R5gk4oquKR3Q5IjIZq9auJVLKWuClMOqsaygThKhczeCbPJP7MpezLZYmjMqW4/zUApK/PmSvaiDqHZEGKpVRBpPYIrOm2ACa50ng9RooLDW8+PmwPS7cs/L2BDP8X89G5UHq6nMkacp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317162; c=relaxed/simple;
	bh=xI3sN7FMPmOB7qRibByBovHO819ztgIDZrO2uweUN7I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Kqj/zc1lh1GSMaNdV/A5c/IaOXdhsT1mamfyOEBzvNhjCGS4yu0MeJeqWrVzH4RdOXhpc0mvDpQfQDmjQ+nNHlj4Gc8tjdfKnNHurHoiXGfoOdPcE9VGCmL28CpPggfwpO34fcBdOf6Qf6W8ABlQXWaiElLsrN/EBHrSp3nWtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMBjvJeX; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMBjvJeX"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f30a4601bbso2994240eec.1
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317161; x=1778921961; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vemcwkPWvVkbtlhov+elhAAw0QkoGXJ2VQrD5OUUPMc=;
        b=dMBjvJeXC6HnBmhE5kdeotytWXfj3zvlMFDUAiGK2rPnYGQy6JDVZW2auUzNuDGLIW
         +Ovw3znfrJd/H9A2OUwfdhUOxKuqx4Ao7NZiw3sUc7lPcWaD/fdrVghseWrtqbS8IZXY
         b8R9IczPUKZQOxVXKBWnjGO0Q8UQZddWLi6yRANLs/zw9eGMHB8dbBUZvy3l1BQYbLub
         /4f2wWk9qcDR6oe9CCaBoBCOKSLHrJ0NTzsBEK91ntXXx450zPKwP80WfwflKYAUG26D
         GHuNtOtg6GOqU2MTzFXC2CKrp/DlVN2z/itJHFAq+1LYnB4Eq7KVaFNmtXG5BqYETQUl
         hScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317161; x=1778921961;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vemcwkPWvVkbtlhov+elhAAw0QkoGXJ2VQrD5OUUPMc=;
        b=PtG1w5eRsEi5rQdpZL9PtiTML7csDtrJoSeteDnLkgTxSWIpggMSEheV1JReK+Pxew
         G+bmNglUCGv5rw2SPEdpYrO/DNOzLnaV8E1gr6a8uv1kLARTmWYk3hA338tczILQXDAl
         39T+rjJ5sjH7LO84gu++K+HOgUb65x7HOQFPcDzfFEasKBEaU38/v0C8s/ezj9mORWcu
         /kmCCmK7iynpp9kwhgs3cigN+ArkEfKP6+Z7TrE8x/QgBD0WQg0M2WNdjs3C9T2MYL9o
         e4YTOK7l9+2JQSstDR1cTYwuZG+LSxW8KAELEfyIickyRIZmKXdwkc/t7NIA9WvRjn6+
         cYEg==
X-Gm-Message-State: AOJu0Yyg3VA2nTQbuFEJxpDgj6YtyH0dltt5fO7Nv6DrwWb3xPat3wDp
	QDbJ9ZRhwsrmdMFDTY1M+GcJABE3PkqGxA3T3UI3j2iuMLiyioetjTc=
X-Gm-Gg: Acq92OFAz3EojVLGa3fmZXX+4xRRoHie6YX0zkxhHOfXBX7+vVcIRdspnFqRHw25Thq
	sAssy+C8s4D2C1lxaPGBt1ieEepMSZDPevAqR1DsS5Z5F3tfORxpJA9sAVFqApW818CPtP8LA/q
	8+BE29YfVA+b5UumfDt8PZNVLIksa6I4CMhlYM5dPoe9gVZhoF3HjDMpxqXJPr3uBlAT/YV8bfC
	kNpQQATIC9EJUoQH4q/NqJG4e3AoqFWBKM36YHwMZ9hbIg2oYeQlAnbqevmR0GbEusiZvfT+rIz
	9snbidTYgGXrgGy01T5zdQMn3KVP6Rv95AuFLWGyFKLvvbXeQdNU66CHIWzzKsAfQCe+q/RdZjI
	qsRdf+ni1fackcN6WYHgAg0DN/my3RO8EbOyopmO7uxfjC2S/rAo+dCiMttIy9h7zwTsfxLkRVY
	g6PnsWjPVph/Vx0HxWJESeqkrfzasZm8r4MOvy
X-Received: by 2002:a05:7300:d70d:b0:2f5:3f62:37b4 with SMTP id 5a478bee46e88-2f54c080b64mr7836333eec.8.1778317160611;
        Sat, 09 May 2026 01:59:20 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847504dsm5757479eec.15.2026.05.09.01.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:59:20 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1778312843.git.pabeni@redhat.com>
References: <cover.1778312843.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 00/12] mptcp: address stall under memory
 pressure
Message-ID: <a1dc0078-d81a-a752-cf72-70abd627524b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 08:59:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_fastopen =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/255961=
00148

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ea90bda1176b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1091952


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

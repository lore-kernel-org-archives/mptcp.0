Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0783A9638
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191038; cv=none; b=mTVcs8Ksk0RJr6IIbDU4G0T10MQNTnG5OtfTHemtkzbM3jTDsD+SzrMUTbFO4K/HV17MTuTSB91ZE60vEQ1MozBGDhsjO/zu4eyxFZ4pu5HRIqfhVk4m6YA9UK9shNs2aV+Vj/LgoGutIpguhrA0fnqqLtls87ntvgeHSTiHIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191038; c=relaxed/simple;
	bh=Szf6ga576mqNYrRDCPWCNhguCOK4Zkp5shdCqCcgTxs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Fj2ye9Jbaef4l98+DbTIHCWUxAUT/A0NqHQJhpIZvow4HFed7R8otXtGT7hIhsbDBg//7Uq+oqPRcBWPoJd/CzU+ecK3+5LtVsaWeNu4rcCzw0/7FQSk8//GfYCzBX7RtdySkYF0FzVbWrh2vk1woshdXQFgev73x+8E/+EQUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGnLw7MH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGnLw7MH"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9118b952e2bso585934585a.0
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191036; x=1779795836; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX1fZEf3uLVLHFkW36AKQYy9pEIIe0RlcVkDq66R38c=;
        b=lGnLw7MHSbr9pqgvJhOhbh4ilir3+WBBlbttqp2+63SLnX8pRBHLSC5yDuroKyNJ3f
         Q5Djl24PKvM8g+ecaVqR76EP5yVgopPwN9TCiHJaKe26cm8NOlSpwMzwGQv5WiacRv8Q
         K5oDCTs477EuytkNhmi98LBU2hsy+yX+hxWCLIaSfnYAAUoVCEpfy+uG8dgojHJ/FKlC
         iB7QPS2qZYMxEF43ucQisOs6dm/QBBFADl55JdXNezeggaDeg+VEZU4QsE/QOzDkM04i
         tbACyy1OtCvl1XkdSd9F4YZIOI68zYV5mVbEawWTfXeZxBB/NKBH/ikl+GuPWPUtdn+3
         Jrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191036; x=1779795836;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AX1fZEf3uLVLHFkW36AKQYy9pEIIe0RlcVkDq66R38c=;
        b=GU6wk/FksG/JqDAz6/zBbbTeO0P6ROXRuYpD8re9jcnvmSdHqEHG3Um1IsIaOJdqt/
         FwAF7no3rOANrDIiR4G9MGF/3ewceKeC49eYlXbYKDNIq66/RZX5Bu4nR+G7He6lDcUA
         8F3Kp2y/pT+4T7lFJECihEJLqSZ5X3WLbimALc/DIdsFkZvyww2WjEGweSiq9PJOTQL6
         OawH7xmEJ/5Jyrh3NPX7wLYIsGx77v5la8tWcqsTJVnGuhxE01NhSwuTKe/iIgRrLpK5
         9sZYbeBasj3RkJKKt2/08egdmJT+PNbQDXlIw2r4mTgHD4Uk2Lra7LTz3H0qRQXbEsWP
         oR2A==
X-Gm-Message-State: AOJu0Yw5PakMlDlcMWperhoXv7eVPOEdMgFwdcxvPvrPOvM5o/eLCo1S
	o0GMIEei0gmzSzNkShsMPNAQEgIvVJu9XZuQAos3lnYjEPrOYIdE+e4DZUyn
X-Gm-Gg: Acq92OHUndCQK+VV56DNqPq9KKzOrLWzSF9z80IvKyp1XNQ/LePIOr9AJiMrGzmgwuk
	CWZdK3whz+VJeUzWs5F8szUUpxuj7EWoGFQL3ihpDir5PQ/liySG9LkyFe7u7Vm9ngxtkbmZVZl
	lvcWImKhERM097pL0OnCzExc+vr2ryigVak/fbQKMhAAib0Fs3at9cOF8+P+BQHSGptEuuHhQzX
	AXAZDlJf8wrmNQJ6DbK1hRHFmpfOgMZz2oyynIPJalpeBIUrWbWFN+ZSbQDGYgknS/N6YtQPmSd
	th3f3estzPoa0sKlCZSI1jrKuHW480+Cwk6pzW5KgCP5izI+jxz41pEujNQOGpMKbEL5jaLQ+iU
	0yODNi+obYFUXyS9wsRz1EjRStduzftvK+hZhKo2iIM4LqMbxtDkFOjzzJVusW8WxHbtKUoBvkx
	ZL6bH+KfEgC8ljYIE2SppSTwQcQrLR0+14NeAh0g==
X-Received: by 2002:a05:620a:1a16:b0:910:4023:4fc5 with SMTP id af79cd13be357-911cb727fedmr2855603685a.13.1779191035834;
        Tue, 19 May 2026 04:43:55 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.142.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf35843sm1790716785a.38.2026.05.19.04.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:43:55 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b681d1061e68faeb0d4fd68c23c09852d90385da.1779185611.git.tanggeliang@kylinos.cn>
References:
 <b681d1061e68faeb0d4fd68c23c09852d90385da.1779185611.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: set EXIT trap
 earlier
Message-ID: <7ea42c4f-467e-1008-f6ba-5192b10250d0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 11:43:54 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_mp_join selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/260919=
35747

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f318e5e5c467
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1097240


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

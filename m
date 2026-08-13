Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD9440A0B
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629183; cv=none; b=GF/eCBQuaQulonZhMoq1Qk0D6rRW66vBLduYFWXK1Szi8GZ+A/KsV6BztmJZUXgZAYWjo2D0QUkaYny03fx3Yi1eppiXfWlgXbnqltHCvMsSYldqhRhYgHEAmMoiB1aynL6rDMHoMFRAy+dBP7GeS4FAXC5kVCB2+opB+nC4uHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629183; c=relaxed/simple;
	bh=b+Z+r4EbIi9a84Sykh3VzFyqEZ9MGdHiRSkinQRtvQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=HFrGt4rZCukKr0LeC6iqZ1TFGlNSlAm+AuXTBJSWcCywwFRjrZ5kaoG/3+sN0nC2nsrenv04HeeAcHPMlIwl4jCUJx495lDpfuJGqLlsWZ7c/dbiQt/RVNQHUfxL/8vzaZeg0gDb4Em6qSK68KV/KkJnvAimYeQ2gIfainow364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuAe44in; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuAe44in"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e7c6ec9dbso91599385a.0
        for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786629181; x=1787233981; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ujkON8n4ksK4erN5u75qnQxKwnR0wbeX0QAj9QP/ecw=;
        b=nuAe44incLsEIHa2vrwfRxa7MDHr6Hv8PDzXyxm1SZtuxrv1DiHCzHd0ibMNVQcrf5
         rhsTNGuv+276RoqL0PxhLhFj+gLVqBV7DzqztKdiNVpJthWX+HdRjvmemFHg4hbShcNG
         TS2DCV9J4qVhqmsNKbv/0CWFfbX7NDnPicYWEDPW1hQZyXzz1CpSgPkLeoaLVTjBmnXQ
         Ea5QMPqVFQELcV3l1h/y+NowLXPHUDQ3U4LEU0Ai0s0WoOT2RTKleVOTHm/5qz0xmfvw
         Hb18du1CrqxiFhlvvTMAYUf9WNzeAAJVcAEY+NWjKVcOoLzluXDJW0ZiDcVpeLHSpZAf
         RP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786629181; x=1787233981;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujkON8n4ksK4erN5u75qnQxKwnR0wbeX0QAj9QP/ecw=;
        b=M1AxQ/GVDNSde0faACEUW2rpz9kBWA5OjwugpNhIGMYTSDp0mqTDXpYXw49kHmQ9b7
         8wTKy1jdRGwuLd+UrYFwzKZMqQpKoFd3omPjVtM4SXn3Lr7CVWtHNffzFqc/HV1ZE6Mu
         s4BVjcyWjEj+Eb76wcH0CvQ/gVLR600M+JAVDIIfcdNYxWB0LmaTtnZ/No7gDHoj7CVi
         tEvRqfeltoQXz7vYyyOVr8assU2NrhDbErW5lC9kUliLgsIz4Gn2ZbU2IrNe4duMIsiO
         2Um1XRtaWGC/QHHpsMvAqt3bPFMn32WXbAwvdUgqt9VjWxn7mjxNldAuve+rocMWpig6
         xhRw==
X-Gm-Message-State: AOJu0YxIYOQrzIvHSXh+NiCtkTmna0DxJBURH9Zm3B/eUZpvmHKEgfT+
	oJq3a33VCb5rZmOZCWBdhpuAKy/1G3J8yKr0iBaoTr8MrewjPnRUdmpiE0gv
X-Gm-Gg: AR+sD11COKoW2QHQgKGri68HIcoLsZuPCLBFwvLAhwV5sDGQ56J5y3xl81CRS8iayax
	VtlGth8bnsm0XMiURCm6Gk8ffKj/irHC6k6eUaVrKJPXcIUD32Ks8P5mu9w3o5zhXl6PmMhX1Lf
	5muFo/nST7RGUZjlCYM0Tk2yP8F8zKaLyBuWzkeOK1HsM4QZRwXAD/hELdyaBRf58FE2as2JYKx
	DjBc6xOEQod1mazA64H+S1QwdAqfuDNdz1kcs/DfZP7+ey64okCEnA3jDL4NF/6BzG/h+Ex72+j
	/d+HPY0OcHmvFQgCqTIjc4wtHvkesa4vRrxwmACYSL9rHJeZdi6nvVdYgO370tyLA9zDSrwwsVS
	9++roKGCyHX9ebj3E0dGppMW5Cqv4b9UNMYBXbKsr6vr8lLfBPYPKG/pt4QJekOF3Kk1pkVCffT
	EGUcD8ZCNDQHlwAehYlHU85to0tf/V18Efau6Qg0ln+mAq+9TFpOJDp+bAHmD9GrGG01oPEP3cY
	g==
X-Received: by 2002:a05:620a:900b:b0:92e:f3ca:2ec9 with SMTP id af79cd13be357-936bfad3be0mr383872285a.40.1786629181255;
        Thu, 13 Aug 2026 06:53:01 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b1290fsm149015185a.31.2026.08.13.06.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:53:00 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Akshit Patadiya <akshit@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260813123754.4095492-1-akshit@mpiricsoftware.com>
References: <20260813123754.4095492-1-akshit@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting on
 subflow close
Message-ID: <64517ba3-2c94-2f36-d8f8-1d5bdb9f3ee5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:52:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Akshit,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/317032=
46069

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a42cb09aedcb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1145437


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

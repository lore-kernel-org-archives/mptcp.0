Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318097;
	b=vfWpsqjD86JkazOHrhNvRww/KvwByHSOR+0oE6YJ17MYuBPu1Bvm17xrSA17dZmTuTO6
	 y62TD6BvHAQmGfdks/pdSUEs5sbzuG/Qd37mHJuRuRFmpA9MwEbMsBXJIDDnLwFb+HAIw
	 G791ol9N8swCA9LarUQR4ixnjPz9AAHECCj3zT5G3giQzsxl6rRHoSL6LCRYjASgOS2X5
	 n6gk5QjXLBDRIEVYQwzYfQaecWpN/1FlbUACjQj9a9j6YoGwCXhkqXc5pGNvJYtlCeLCJ
	 pjJJgamhXeloHJ0zkAy2UIT2AsDHxi/2ZUrzObx7FjXueb0Yld/KgWSA/vUcPHu7PVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=Ct2kQoFMps2XLpTPTneHJwT9c9MD2HLNWcJbetNH+ds=;
	b=M5ZCxtVV/ERzB5a6sAmyrg5B2JOXu6qnppFsAAY9j5Pb7BXXf2Z7gDH/fKzHPg0UTK3Y
	 9CVUAHP7tU4j+VpZflLfrmlgrbZ3OY32pAceOFg5L7rBm63R5Sughh1Vg+5vk6/iZDFz8
	 SN3sIIpyHaePytpzsy+3sD/UEMsD0NNduwkgnYmYk7WF+WInLIE7iEHDOGofxCibl18Dd
	 YKduYIzslnGvSmGCyaIRxECrfF/m9ZwiJAHEkE8Du//zrdbpRwjL3OvVgQ2565LsnhbzE
	 jUO6gKDPstOhrzbnCmsTc3MDkao5M3zzWBht0z1fISziwV9kIJ526YOM9NyrD7xPQ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SGFwSB1C;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427E606A32A
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 03:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4427E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SGFwSB1C
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-84a248254f4so1418255a34.0
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 19:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795318096; x=1795922896; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ct2kQoFMps2XLpTPTneHJwT9c9MD2HLNWcJbetNH+ds=;
        b=SGFwSB1CHlf1AzxE/Gdt6mHNVv23c9+lyzAG/lDkYVqp3sYrhBn2kL2DWKH6cUkdwx
         IJdRzwWVxMlpu7P96jsW/ve3xkJh8fr3YQG3h/VmCeLc7wNP7twQNGwiP+lug6MbYmIN
         wDR3iaeKSlZ9s1q8TRy1BHgRjoOOKtdHIPMB9Zi+dNwGc40EBEDyYePpc3fbINKusstI
         9iGXdJxRtw/SEJHSv1oS4tZZULcKBb0vXO83wK6KZ83ye3xAe4e+UREBgOtui4JqgrYu
         bZrq1RVwXZaexyHy1FqrKgi//LyOmChbplQwy19fVxkaiVA6pSPO6eDTK3SfU+ZOC2Ii
         Rtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795318096; x=1795922896;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ct2kQoFMps2XLpTPTneHJwT9c9MD2HLNWcJbetNH+ds=;
        b=NUDUbwVfKLzoYusqmFv3EVCgN/H6+mn7B9NCX4wmuKSbfQkBP0/eM2tDsN9bBRWhPk
         jDA3zHqMdlchxglMsK43+LZNa8gw1UqrPVSOwreED5YiE/T6j1nmRe13lRJPVwYBUcqu
         tDBER9RljOhW+Ukln2dMrP4UtJOOPcqk1mXBb4mm3+x+JT7msIihPex0SadEaAJoY/7S
         OeZx8DTP/lTrLi+ynT0UPhaUZH4PswWDUoS2DOuCgJnMd48pOJjaJhVKzK45ivQsuL4H
         2T41Prq9tj6Z3mudJn00olkRpgkq5EkWffBiEF7BvPbe9nVxZFpdGnz2Xt5Z8xoTSRXW
         c7ZA==
X-Gm-Message-State: APuU4Z+mg55Zwjk34CS+uR488drJtNLnUy/wQIKp30MJhFx6Jhs7q8aU
	8Fy9xpwM9oDeKWXZ/edqeAZj/9HX+uP/TeF1w55PiPylT6AJXEmSq9M=
X-Gm-Gg: AZFdTZdpPo84Lxl4pHRDa3nsfTagklIU9Oc7dv1FYWsIjceTwkdh+mc6DR2taUqM3dK
	lctzYDsOL+y0yhmQ1lvIEz7V4vgPdzPyKAEPR+J5buz3WU3YcST7ra2OOrFCPuTp2j2x+xcaSzS
	esmVvBpLaOnqfIHx8QXT7lYThpPnEyALcO2LYV4ppRynLRhanhwX3erxvUmvXpGNPMxMxsz0Ida
	Ai1ezdNYIqU0aAyz9AG1G72C5fQSU9iKjmSx/ieBmzA1kzQy3QITPPt9nqkS36HluZemFYhkjFK
	h0L58VjZzgSTJclEV2bWh2wTNCgcbz+MfkpaGpRiiemEqsIqo0JOS7o46utQ6ulYBLk+2AcvvID
	JyLttQ3CUSkGYi7oORDvyPlBTNumTnEN/8D4z3BfeNOkDYQBSe5Wym/jRk8mXz1OPadEcg2p1d+
	ERKNUjK+cYfqMvEjqRIhjzRLkPxDRSe4Qy7MDZ+EcxxoIDaEfzfoDSIt5+6M9HUITFe40kKe4OF
	oOGtHQW6pnysTR+LpsvU/nwPzwvmjfKgpfsmLUqPwxOqiF3sfSuSVCRa0eCH4kbgzZoIn3l305w
	5sX3ni3mZf1GiWvA35cUq8N1Zg0qSKLRPXY/tGGykQ==
X-Received: by 2002:a05:6830:44a4:b0:843:cc20:9d07 with SMTP id 46e09a7af769-86315946f33mr8378489a34.16.1795318096029;
        Sat, 21 Nov 2026 19:28:16 -0800 (PST)
Received: from github.com ([20.84.246.225])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168bdaf7sm5790381a34.5.2026.11.21.19.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:28:15 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
References: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v16 0/7] mptcp: pm: in-kernel: retry
 subflows closed after an error
Message-ID: <fd89f8c2-1c40-2eab-794b-86bb3585969a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:28:14 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 6 failed test(s): regression:sched-bbr =
regression:sched-clientlim regression:sched-mem-pressure =
regression:sched-rmem(3) regression:sched-weak-secondary =
validation:sched-loss =E2=9A=A0=EF=B8=8F  (105 new outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/449717=
84636

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cc174cbf3118
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1218365


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

Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E97524A6
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706445; cv=none; b=VqKGsTNVbn/JlSTq0XsqF4/EW4gu4e+oTTWxABb4dkdgJuXVWiMuV5C3Exx0IU4oAqToV19N4ni9RfwPl52Zg4sZm6bqPERCtpNiTZdpPaZLT9q0c5XRrIWeWiVbqnFUMIRMdj5vWhmGa78ywuQ25QkpoCTQD2ctchtRX4QiusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706445; c=relaxed/simple;
	bh=6lTSdxlQhQ3g6qR9dfzz+Q99INCjC9IM2gSaheqeDEQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NtIZPV2MYChVGIhWBqZr8wzj2GfYm49lTtHKah5Sutr9dODaSf1mmQD15fdidBx6mOoAGVb1NqwmXMwMMW99E4yYAPDY+nR1E59HFEGcPthw3N9gaJHvKZtdC3EkyoNisxipmkQqe/UoxHU1jKkSPmNyg20QckViB81uCCm34NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjpsR+aZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjpsR+aZ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-695df25699fso14300666d6.2
        for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711706443; x=1712311243; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2RE0RocOvqkpSzIdHuOcHdJBJWPPXq3H1yDEmSZ1+Y=;
        b=bjpsR+aZXZOA2ZrsX79x2x5G8A2pqle2LR+lOLw1XjHhYHvncP7+ZSwpGEaHW2QYVE
         8h3HGJs4cmfCaFd7q3jM7qyTozpy0jNTz6nnbCmTKxsmW+0Gy3q2I143h49VkAAJsOAH
         mleAJf4wbUlpLYGkjR5gZ+BYMCvdNZP24WfzPVxsRb1LB2ZaveTLT3HM+paNPi87/Fpb
         gHAtfy5P9/6CN1TPWCK4YW3liS5+WSw/gNkdlsGtcJctfVSoSW+rq2MkcpdtzNCcA5bi
         mebto0DmXpgbqRES70U1V4iit65V4YLouYTRviUkePVE73Ib6yWbHM7+r6T4m1jIPDrf
         Sd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711706443; x=1712311243;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b2RE0RocOvqkpSzIdHuOcHdJBJWPPXq3H1yDEmSZ1+Y=;
        b=SYt8JnETNPY46cKHfUBIvOqi4/EJUPGm+9yqUwxxHdsQtdheZzWuA141PzfCW/XJLn
         joIQn1iWLeR90vLBDuNrwDotFMK9DR/645ZWiCEsTy1VrcGGPaDJndnQdjJxYs5q3M9H
         /+TFAXHUX0XHLTZ7crT349+wMe+UWOiFoE8PCAjLCH82LB+dcg+kyr9XRU/WjAO5h4sk
         HhEsGjjKZYjkG1tqaqRP5T39OAh7VYHW80Rou7u8Y5pXlk4Q2N/+L+29rNKr1BlDk3CY
         IwegfmQczdnDDfjV+6OswSKZnGtZ54//R+ft6uxmKDraqiRC9NK6c8dlDUCnjuve5DO3
         Po6Q==
X-Gm-Message-State: AOJu0YxsRrqvW2Kg+Kdm8FXEX/EU/AePCEsq12NoEZW6erxnXtQmE4dZ
	SwQF6iHhT8LgjnRtSbwWKFS0BA9vyzSgy4Z2Qlkn/z+Ujc8WC5EJIhsKQio=
X-Google-Smtp-Source: AGHT+IHPI87/8nPVoNeEZWl7eY7LVMvc6WA9yX2mNQ6gZAT5cHAciS6wDN/RGcfRao9DHK0wuuIWhA==
X-Received: by 2002:a05:6214:170e:b0:696:990b:dfeb with SMTP id db14-20020a056214170e00b00696990bdfebmr1724339qvb.16.1711706442918;
        Fri, 29 Mar 2024 03:00:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.206.240])
        by smtp.gmail.com with ESMTPSA id nw6-20020a0562143a0600b0069680936f00sm1499752qvb.10.2024.03.29.03.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 03:00:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1711702915.git.tanggeliang@kylinos.cn>
References: <cover.1711702915.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/3=5D_disp?=
 =?UTF-8?Q?lay_=22last_time=22_actions_info?=
Message-ID: <ff3c7a7f-3161-1b60-cd20-32f585429ee6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Mar 2024 10:00:42 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8479431546

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bf2927563d79
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D839714


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

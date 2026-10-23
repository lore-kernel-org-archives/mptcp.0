Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792751517;
	b=NAFqYNe9v7KPpkP8CWP+XNxP/zv3v1xlLwblm8hV4VRVJxBtuYE4Z73xR8OUvySpI2bc
	 BJQJh01JdcTCtmLd0jaVAi/X+REFb0GqnPaydtQznTvvkfYSSP5Kh0YHH6stJNJKu9/7q
	 4Z9YSL9PZzfXCCGFPom2JKBlCFHSGSt9m1i5QhdFRl+0CrrAZTmR+Qx5MJdry5FibG9bi
	 Z86vq6KpaGZX4sI3kWRluwWzKQ7e2TgDyJwzfhfSZx4O+k1pzpi4oBlggNhU5hnOh03cS
	 dygUsPKzLUlgJcToFePVdt4ZiVYicQzJvzOVS2yRnggRqK/IkBp/uKn3CUIAicQsCiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792751517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=9rQ6JtbpEYlPbwrRtFoS5R+vmb6svETseJ9p/OrLr+Y=;
	b=wsQRhoOMHoagPgeq//Nx5lBkEdstV/DD2K5h+vUkaARfWAUlq0pBKkgSrAP9crHbH5pd
	 wcCCA2U+cmMro/kTJFp0VT7mkHmrepL0IJzyvdeoYRz+dxC1r7lnUnNqnUZfvu1/+RC2V
	 X9MsMNgKnCwQBa2IQ5S1yOW9Ihx+kXqotbfoLNxY0tRIK0pnWUoYBx8PNo5p9Vx84Iuk2
	 VmrTymiKQlFacQfBA/g8yJ6c7TmbYy5tLm6P4eYgPuC0qF9iO1VZz1qbvPj+YtUlYuheJ
	 ej+pa0tuFPpXDgkJyVlmTb9wPOCrzZr0jPmLx9yQUVyguLXS7xsDaQe/B+UkyZyYVLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g2O9JFWA;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1281606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 10:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1281606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g2O9JFWA
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-82380b0f55dso260924a34.1
        for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792751515; x=1793356315; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9rQ6JtbpEYlPbwrRtFoS5R+vmb6svETseJ9p/OrLr+Y=;
        b=g2O9JFWAxj1UFjyN268LgQ9iVUPkffMqK2ovIjvtcktP3x/ue5oTDdsKlTUUNIJbF+
         dlrvQ1qcY2iDCNA+ktGUQGmRxy/c4HHqKbx8HGVDEKTjaO7UCuOXCJhresrfe0FE0nYz
         V96rN75H5jLUUqActVnrhTyA1uNeKVA62qsXS3MaUFAfFxWihiEcwtLzCUIkuBvguH6F
         tUMeoCX8y4LtEAMu+OTYLT4zPaoKpTFuCJPxVhlTbNkw3GZ9iZqyMeVVJVoQnF16Nx46
         Gj3zjgeKStpf74liWfI7n49XeJfcNwsI+v2JkhdVs8X8evMj3cxo9RoWqwg6xFp1kfTZ
         1GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792751515; x=1793356315;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9rQ6JtbpEYlPbwrRtFoS5R+vmb6svETseJ9p/OrLr+Y=;
        b=PpIwJc7B78P1arklIeKSakAqCMKl9QPgRnUA+U/+lqQQnIIpFBfC300VPEWbXZF3b6
         x33u+lZlTLg8Ts7dWmdqmnZYq4nTxfHWQaj2yz6gaYX7wTE65+XgKXWwKh0vUo92WNNB
         WbpTBAN2HsQDYutkR1cM6QQJNY2lv95mTuR9GurYl4/GFf5yN0DtDRtomNSuyfZC008c
         +78K1g14rFuiaFYKEYNPvoZtc/2SdPN/UtN8ndXTTgRn/Fm+3ZRoE0h4a+8rPTQgUUel
         lRQdvFLXdsEaHqKVIGXlLDN4KeJUWRRDysOo+EtufnysBPcp7GxwN79QjwRYgV0BSYWX
         le2A==
X-Gm-Message-State: AFq9FYLZ4UqtFJEDxR/X4DKjfu8MuRO7Bp20EvQNlEFhqNk1wrxYN1ye
	BzHSlDhW+j6MSnFRpYf8vANEhJBesCTZyBPl1DWMIzM547Z4XlKmbagxvOiO
X-Gm-Gg: AYBFou0wAFOAFfGkUh65912Oe4SxVEcq7TrmtT6gb6Cp0QsNm33LgZYFvbLCDq2oIyf
	7rOCv2iJDyKT7TdZ3pfOtDuMdH8ii8O6QTarZWO8omP7X1PkMGbayK3owwx1eIcnqEuLg4y4jYY
	27BDJlX4BI33LL8UezXi+bCZje7Tj0UFu/ukoq/xjBuISaJfWo4XCrciQIHFVgXyhG4vqPKzgaF
	MBUfGrOgh+iYSwX5jjSDzHr0XAu2Q3M/kYLSFPSAdpQXhYPIedQgEnWvkzyDXA00i6gCUXsrGEl
	NCKl4ZN4WIf7s0HAjR86JI+hB18YOkLKW0gskgKfvGot2f7oiv9VQojj9s81WwRpPMQ0lkSvktq
	WLpeSPUB3N26l2JF10RLpafESiqM2JTj5jmj8Db91GBYo4iYCx8OA3yJpsWK+kNadG26Vnrvtg5
	/mv52KOyvv5QCvptT5F4peeZ1N0/zq/L+Db+7SsOrIhXvgNdeJ7GTgx4G8GoP2khGV7X0WVcqVC
	pn7HCZDgyNcxJUrBGkaO+coTbqiRMLoao8cb/kHAa9mG1b2c5B498yC4pjqpLNap6K7hlo=
X-Received: by 2002:a05:6830:b14:b0:7fa:ab72:9e04 with SMTP id 46e09a7af769-84fb20298c5mr1091764a34.28.1792751513991;
        Fri, 23 Oct 2026 03:31:53 -0700 (PDT)
Received: from github.com ([135.232.208.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbd362a19sm1709897a34.7.2026.10.23.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:31:52 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1792746800.git.tanggeliang@kylinos.cn>
References: <cover.1792746800.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] Add MPTCP support for NBD
Message-ID: <c5be76ca-ade1-c5a0-7460-e9dbd6476fbe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 10:31:51 +0000
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

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): selftest_mptcp_nbd selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_nbd =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/399337=
48069

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/04bb6f5fada2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1191964


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

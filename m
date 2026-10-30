Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334303;
	b=PSeHnV849a9601CG8fTJIjX11Y9+1wbk48T29g2pI4l6csr4iPWcAzXdTcNJoM30nM8M
	 HmNvVvHIOxYFdW5AXPEnwhaZVHZzXguE6YAKTSN++fUVuiOIjT3662/0447n9N6+DXbEG
	 jZj2PcC4UeTLoiqqV91c4dyDKWU/Rrzn0tcp5vYc9vK9xik1vXh2PDJCJeHMR4xwzNLvw
	 3XzUEsrk183pL1YibN/GVRVBTY1JGFeOpLeOJCnnqaJXBlWYteGvvqLz+oCyWHFXy1K+h
	 VKpWaBkKJZ8hp72oxiwhyx3Lk8BACEDjFSioTXj8ktTMfMDAMHau4r+/yBZDToxdz8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=QKv6GYktdwsLp3YNFqFUFdetsu8ILMbPOeRdWhODgOA=;
	b=MfvVMi8so77YzWUjjSfVe7ZnGKgskl3qdISQJOC97gCHD2TksbW0Zb9wwylwRt24FOoJ
	 UkDIViRoEsynKd5DtWHK9JexeUwXm0f9QG3Bnx2oIj3tULYNlEkprX8NS5fDF7QKu/Uiz
	 Pas39/BfEOUFdO2LxuPxKL44pEvEk/nvw/6s4vavHqyLMZI3GkKmsFu+C/DmL3iB8+52Q
	 M9FmilLo2bsge9o4LvJFZcKvogRGE7P//lNoVKLI+4KSjF6blNjO6AIW9DLjogxZcoOki
	 cpzriFmbA2Xyw6PfMlMZpTx4OH59ECiRtQrZCoKbkuLs2pv7b/zqt1lM6WuWMY0qKPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqxwD8er;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F27606A31D
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 04:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49F27606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqxwD8er
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-188406bb948so235236c88.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793334301; x=1793939101; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QKv6GYktdwsLp3YNFqFUFdetsu8ILMbPOeRdWhODgOA=;
        b=LqxwD8erKeauDKZhQv9Z21VoqiaVbFCepr8RzZ0JL/tq9fzdZh3b5FyzbT9OVtHYen
         c8Bqvm27LEMNrReIEXWQd/jscuno9nAEQmdCI2sIt/Y/Szwxo0Q/1flhtppvyqzyHxzE
         djokswP6QMYhT5LGj7Ocu8e4dotPG8OVSC1BZC07pPyu99+pVKdkqOIcQ3l/iX6w6MIN
         SoQZ1FbHZhw+W8Q3g/pNTr6ATUnAHaeZ5xpdAqLLItZfGbHZfyJeRGUn6IgERK+l0vcp
         IfVyM+z/WPYEkVhRzyqwrJtFVZdkNys02DPLd5owkMIXtuPFU4ikOpSKEZGACuaXpyhw
         PiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334301; x=1793939101;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKv6GYktdwsLp3YNFqFUFdetsu8ILMbPOeRdWhODgOA=;
        b=aNVnkz7vd2TUZNp0Zellp1iM6vWjZecHlLIFWxHUb3Oa1MqLO6rYG9Q2JrH3XkvH3O
         HkcRntq1JdY0M2xoTeB8bplV/b4Zv237hxt0JIyCuB5qqeMeAxBWU4aDnf8w91jhqagb
         2bIqInRdKjqPy9/ueR1qUvv1BdGCjKob/QMd+p1fSJEKiHXwvTzedd0l3yJi2Ua86ZcJ
         ZQ/9RgjGV44wyjpDkWHkwir3MxF5D7fTLDH+xMv3GO2ds8RFpWvjJ49bWuH33MeflRyp
         12Jy1JJqcSQDzCzP5b4RPCFNkzNLL17Ugk1w6EVdba1m2QtOsyjA8Lkj5LaXZgPQb4Nl
         dxCQ==
X-Gm-Message-State: AFq9FYKNBCfg+gpGiGRgTNT0uC4SSDtvpe7RTzeXQCGRtqzlhz48ElNc
	X1U3/tjPPbfCp0Bz1Ih1QDAWnCcf6eymnGbCdzPNIDPjm39ZeuVcF5c=
X-Gm-Gg: AYBFou34hFtGDSu7HEFuPupbO1eipT8TGZom77zMo09o/N97hcw2vIkHL5CfCdr/9M2
	77LcsJoM70/1USEj0ZJPaNU5pZqAKAi/0G4O1628L/gVyQxGPfGGRG9Z22q3sP8d2zduzHWPbm/
	0E/4oYxrWnkS/InMCA6gAKAcdDe36v4agxZlysp5ZAMZZDM9sC5AcQGChpIkOD/+TXaqbStgOOU
	LY4TBAyaUZI6VBKI1iG7/JLlUoBL6J9XJ8aS/LAplz+XoFv2Y68GUERN6bMwnpWHxwDb2j+uimo
	SB3JwdcA51UzksCmcdJO3hX4osswCynlHL14GB/fc9zbv5PTuFrNyQe7BXsts9Bw+/sJy0RsKN4
	U0Ax7DtlPtCW9mYLZ1VcQfSTu1BuwJ+OdFzPnauasp7+m/0vmgLl7bssJN8jR8I4yHY3FSjsxEv
	fINHpZEunZnbVw92qFm92UtG/flFMd0s357B2M8RYqUDTOJg/yhrPx53AerOiClsqWi75/eLINz
	nFoloNBmE1pkkekLlSWabuqRu8FIg2xyrAQ2dhysj60d6pTQ7UjJEi0WGbatQIvReuIDdPbB5WD
	Fl3C4NNOpLu1ljl1OEI6Qo8sW9htv/IcKPHSbrs=
X-Received: by 2002:a05:7022:1506:b0:168:3243:c907 with SMTP id a92af1059eb24-1ac5bda80a6mr1761440c88.24.1793334301229;
        Thu, 29 Oct 2026 21:25:01 -0700 (PDT)
Received: from github.com ([20.168.94.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b0a628bsm3075942c88.22.2026.10.29.21.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:24:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793326853.git.tanggeliang@kylinos.cn>
References: <cover.1793326853.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v17 0/4] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <ebfbc7b2-f6a8-a370-ac26-6952af384a3b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:24:58 +0000
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

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_syscalls =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 2 failed test(s): error:sched-bbr =
validation:sched-weak-secondary =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/409933=
18561

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1f6607073d0f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196753


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

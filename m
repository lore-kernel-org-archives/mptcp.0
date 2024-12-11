Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5B238E2C
	for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918520; cv=none; b=rhKMR4i4d/oEDXUAggW7IqAq5foNFB9jpL9UBW1F+XrXEi0wx/cFiJhDBpPcBDveWAujZpn79APic7Ue9Vv/fSap23/XmZ02dqmODDlCqA+PwOxXbRamJNkX6dNOnMByZHv5Toihxpdr2UOgc78a2wAVcFRrTdKt6/pEHQVFFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918520; c=relaxed/simple;
	bh=73wcfsW5B/TtiYDJZN0a7ryOP9iebtI/7Tj8j4TRAC8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=uQ+T3ynV448dNQ/qdcZ84BO9ZGCJzzOl5Gm/8HmXKG/N2UO73X9HHq8B8MukoVHNwKE3BYqLZmObZmLwRTzZth1s/lWRClT5rQZwlgTpsT7W1XZ9D/9tLJQ3iJ1M8yZt+/ShLp4KSCtiFN7euQzBZvfaxyt/WPiz4wEhZPgL4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMlMBRkV; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMlMBRkV"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8fa32d3d6so52911226d6.2
        for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 04:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733918518; x=1734523318; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQoawCMw9sjLfDi2RG3GRbnzbMRfrgOZklD5cWLFL/o=;
        b=gMlMBRkVnhf08BYsfMcX8+ZX4MUcIe6v1jTso+LJC6iQppLrQWGHEQBAiuaLx0wLjl
         t+saInJh/EBr6qC+b6mGFo/u4HPZTY2Yaxe3HWGjJJB9GRJvVmAE8eED0YK0biskLApY
         3x1gy8dK8r07bgmqIIihUbrn4PhJ39V7p2o0Nn5MsMj3B6ZPeQvs6JD4b+TlV8UTjED0
         BEZJKw0Be/UAvRRifkz5XX/biH7XwmWjGaEIO6pApL7s9QJU2tSomWnOKKsFSMTd3HFG
         6P7uTTWMe3g0HPXpPVY+ZDxfRTLIr19aV81YTql2nUHL2ZM1Zr/4LJJN4kDOYQkQT9Bg
         gjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733918518; x=1734523318;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gQoawCMw9sjLfDi2RG3GRbnzbMRfrgOZklD5cWLFL/o=;
        b=MpC3hWsXgoQvCooAHBh4GzRnj9bWWc85JCtOXYoIs4RvU7VpEiWs5UAci3Uyx/2zPv
         aEhzgmXsSvN4MXtDcFEhPebU918rfPLL0kxTbQC9UdNPKsmesh8MtGuHDALNPR73CFMZ
         8JBz/k5LUL4ZulcMycQm5/M5uNZ6Qc/4ZaPtdCRybjSjL25gtwK3anYJFOYlH7SWyvPy
         aWKpE//PQdgvldd5Soz39zcR+EvdcAUIrULEGE7OGZVmA+tSxJn9JUXJ10ZOrGslXZLR
         szFOOFsU2HBxs0EMBYneEYwrrCwzrDQ/AjkN93LBesf1Vaz3uE3FEtbT3AQP//CsLCWw
         3Vlw==
X-Gm-Message-State: AOJu0YwtWj2XyRIO2NAhKt4UgpZg1v0xLOvGxfdt4UjB1FMxq6SMWSE/
	gA/zG/AXbTvQOrvh8RX9Yh7pcdyRFHCy8Dpx0LFoo69xT1aUPi65CXqU
X-Gm-Gg: ASbGncsB23iaL4LZLqZkRskhPln1eFZBe6jyylyktjEEQQAyGhD4mP5EY7m4ZQjAIik
	LDcvA85831VcRZHweWYVVjMyIJFrSoqkPyB/CYlSo6rDOvghQeNyvi55TXu/cvYkcE0PKEyJTf5
	tLfBKi3TdpLWDLRYHP6tbA7ngVmOp4ET+l4nnAcpOxmPFy61537/5CUsEcA3k6tOTV9jZr+mAPp
	3dun8C8ymB2gJ+9XiQhiFnjDBEY0Ja/QIhR9v5bCzw9zirO+HM+Phy39bYJc3QsZh8YUg==
X-Google-Smtp-Source: AGHT+IGKID+Bkohb0HH7x2B0YgteHHTtk7ytFF/EP8evIc9o5hwjEoDPIc8KxjjVen1hYvz/LYeQ9Q==
X-Received: by 2002:a05:6214:e47:b0:6d1:7433:3670 with SMTP id 6a1803df08f44-6d934ad2d36mr51158016d6.4.1733918518167;
        Wed, 11 Dec 2024 04:01:58 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dabff3e7sm69635706d6.108.2024.12.11.04.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 04:01:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_0FE3ED0442E69C9D86C0AEEE338A49F90305@qq.com>
References: <tencent_0FE3ED0442E69C9D86C0AEEE338A49F90305@qq.com>
Subject: Re: [mptcp-next] mptcp: fix invalid addr occupy
 'add_addr_accepted'
Message-ID: <3b0fc60e-4439-d281-9dc5-a3ab133b5d40@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Dec 2024 12:01:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

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
uns/12275226711

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5ad61844af3a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D916728


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

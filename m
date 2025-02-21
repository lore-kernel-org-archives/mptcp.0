Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63491AF0B8
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155009; cv=none; b=uSOu89vQUfUeVN2AoFVS+1ARUayffGPkQiDdE7munGwM0Ec81rY/FXQ/igdPmVkYtnml2bmAxyCjwjJRjQJjrJTIw0OuVNaHiKYq+QR8mEmB99G+WupJPXyd12zqmuk0YEVs0swdEkRI4NcYHNnEOs4Q01j+3Ixbz4H6PxPsCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155009; c=relaxed/simple;
	bh=VY9FX9aJH/KzYsWPlZkAmqId7a3BiEo1t2xbD1FkD9E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ToRaZPd5xwmJXNi8BGyGkD+hJwoj7hltKOL7AR3p/p3D6v5PiUpbQ0tlQLypfvs7MBkP94IEXWMo2d98looaAPpoMZ6g0wOCe7Mk08+jXIZoMryj7F2qJWaXpnTXFtv8DkZsAN8e8SzwZkyGU3Qy8kOJcYvbrngycLvgdqpoYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeymLJwf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeymLJwf"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0818add57so234301885a.3
        for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 08:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740155006; x=1740759806; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu8svhmAJdJNZ+riBMeaxO3mpxI07KTy8JYrGuA3vz4=;
        b=KeymLJwfn3PeWuHN9ioTgrdY3MvQMmwNE3HmIDrX8GnM9upDKgpgJBiBtVqFRk+YSA
         l2uiehb/mf6IAEUvmc9DYIEuw4MXLNNOChdagOBWO/dRG1eoXQaiMoZeCE7HdlDwg+z2
         L4IolVGVhVpFjRcVds2jFUWL9mrrHMyFJf8mv1jpGNDVmuf+LQnLaoS8HSFGrCf1eHQw
         6nHAWcw4//0D3PGxCyhHjHKIlXfmdQHhCn+I5g0J9T0MtKbv9HIrufPiyWgaRe3i59nR
         W3TLtSl1yoBvmrwz+lrR4xx/s/x0odyBwAqjpaDoIDrYVjclBRO8Us/V1YtNlQ2bFhk/
         34KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155006; x=1740759806;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lu8svhmAJdJNZ+riBMeaxO3mpxI07KTy8JYrGuA3vz4=;
        b=Wp2Bf8srQBfPFil6Z0/P/3e9HOZFW/BMjBMichsjz5OOTqdMvmwUMV+i0+TYDPDnBU
         CRiNOeQTVyBgOGBoD1kfKSTKHiw1LCIANjkt/4qjDdgQKW1WJEGgSZZizLk2qNHiJsNV
         S36dAwtE8Zd0qABEXsviBDCh3313uTj4OPMRwvl9gxU1n3ZpKgK5NdbAFRC1hYfrdj6x
         88Vs2fk0zy76SpSMWk1q62vmeoulIoC7XcHS0TiY3j1igPnyPxXxJzdie3GE3aVc+K1s
         WQxL8P8FuQPuTph0p0GeoqxrLTfdLEJOZDRtdN9ZR7nDyqu3PORC7qic0YynUyLMaju7
         IrFQ==
X-Gm-Message-State: AOJu0Yy7DZyfU/IiEeKtnaOTjj1JOTwx2F3/TdP8gDAavs5oA0bVs3e4
	pRnihG2iyxeuSl5Gsl2YdPNoThbq6rN2nfmOuaQ6eRcVwAYvR/4=
X-Gm-Gg: ASbGnctdEn8WGvNdKQWiz1u4QhIVg7yibSiIhF/nWFgmQQtd5syTjNLOzU4nFN4kx2u
	LMC1fu1lCXL9NzpBi8YitCCjJUXnEJUyhCXMwQk4cRXxYyMOZMY4r/y3Tzjfqqx7deJWByMKFlR
	cycgGKg1XYDHa07vdP45AmUKIvUKMCzzmM+FOdj3d25CjMrkD4cgAPHLxAZgawVqjlcbFvK/68d
	THmC1S5FK8SrNwQ1ABsuS8M4pSsRxEaFuOvocn9HrKFhKIbmJ3zZlen/JsNdFXIqP+0y4ax5gVD
	cqihuDutrdLjN1HzqeJByKz3OpnXGcry1zFTU7Y=
X-Google-Smtp-Source: AGHT+IEwiDTk6HFEAq9u1aydgKLRDvNFMU6U6gBOyooTLm9+x0+JjzpjmtMth9l66gXOIB2UqpNoIA==
X-Received: by 2002:a05:620a:26a7:b0:7c0:b690:8468 with SMTP id af79cd13be357-7c0cf8ea524mr454018785a.33.1740155006513;
        Fri, 21 Feb 2025 08:23:26 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ab7eecb2sm494311885a.36.2025.02.21.08.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:23:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250221-mptcp-sched-data-ptr-v1-0-dbaec476fa6b@kernel.org>
References: <20250221-mptcp-sched-data-ptr-v1-0-dbaec476fa6b@kernel.org>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: sched: reduce size for unused
 data
Message-ID: <05cb08ff-0ea2-6d09-a320-de31499ff66c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Feb 2025 16:23:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/13459912721

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4f91f5c000d9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D936464


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

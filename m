Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10426225408
	for <mptcp@lists.linux.dev>; Mon, 15 Dec 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824627; cv=none; b=cGNJiNb6akmIp3v43PM4c3ERyf2CGUgSBe0nLQ07/Qr3pJ2hYBN9TCr965ul4JSfgFoK8u9Vdbbeq3Xz7EhXzOAhUTZpe34TGTz+20B0R+9AtCJyaJIMRPR+Lsts0zhyLhnWrinpZD524gd3YxDs314kYnoffBdp73xJBhEH3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824627; c=relaxed/simple;
	bh=kYDTy8Ii9FyHCEUYEAZg+ydWLksDZ/laAoarAcvgL7w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WKreBAsUTvHlzdgjGuWijgrt7fVm5BwE6UZb87gMtJHthdstGQExDtoykz+gB1xI2KhowcLyYROrwkqAcRq3WA2+rYFiYuIyxcyh5Rha9DzDjdS0HfmJV6TsB8PBOWdyN2Als3indU/OMbgazIqXi7hLl8rRYaxiSCpPQEodxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFs9gkJ9; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFs9gkJ9"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4f1b212ba25so32184341cf.2
        for <mptcp@lists.linux.dev>; Mon, 15 Dec 2025 10:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765824625; x=1766429425; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIzYRxZy+BydE0DdRLuyC/O5YAnTEsevEuBE92BWGWw=;
        b=IFs9gkJ9IW8pZWvTB3bO25WpILq2iRaPbRkoqiblWwypxlSyuzksnHkV1BV30ox2Lt
         5Aw/V8je6OJE34Uh15sgFw6KKKT7HokWUWnQDodefQ56AklGbdkTlFjV/J6qfdWOW6Yw
         zNMFiixvNum7tABmwbgrF6WYh/dvZ5VMYSYQZ1BtS3P7ep+Gd4bxAzatSbjmXyY8eWmU
         uEw0vbFU/z+BLWfQDDIJPh/JG8THRZk5P9jkkFWEMNXXogmj3WGWjlNzjrlEy5NCC3sG
         Q5Cn/j3KWGu6ZiTnX/8gS/PnnVn+3RCd8Ul1YyuRin7nj+fooX5f6u4N7yNBUz/DShlh
         xm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765824625; x=1766429425;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIzYRxZy+BydE0DdRLuyC/O5YAnTEsevEuBE92BWGWw=;
        b=XIZK82VtP3IeJugTDDahMDmvQNoHOVtJGDiWIOwXQ2bOXhEx506M46BN2MWcSO51S7
         FZAA0ax2FX4OQe7U/cgRXx5fOq9jZOKPTjkoTJi0ysDVapn2RY9KxFLBKqJ3XIuKtqhD
         IYOu0ymsQD0lsEDphvFHPAXvjvuVFe99dtIFAJfDn4qmYTq5A69CFOj9srRoOaD5jCbF
         K0T6QB/pnFHNnaPsOIJMcH8kMAX+5E7LzsiHlv8wN4tIzIAhFeGsl3/YWK9O/06dHSi6
         bNPa4shQdLTwk9uFWv20pu7Gz3HYIHKm55RN5/6+LzdEthBHHtIIwOmww7j++K0x32Cq
         wmmw==
X-Gm-Message-State: AOJu0YyJvMlFwiEwZATRxrc2xmyBF07XfU07hpr/H06Vih2HZlJ85XG6
	2bkAnIkuKeAaeyTGe1NQI2Sbeik+qqq9e2SH3G8RAiEn1HJYTblb3Ncd6ioUq/k=
X-Gm-Gg: AY/fxX7TnmGF94DW/jpJbpNqJqSjyuvTwTi7dpyL3WCGD3xvBu6RMkMNsiutdMDJ8Mo
	s02zvgrzciMrs/f6tfRKVMf8/h9/evZR3hCJdMniJrPKXy9iFeb5SJcneNQ9QsW5yagbtmyE1V9
	GVnBqutSI76vB96ynNyMu1kg4hR57iyI6cyQ2b1jmg+7XYY6glCyjB3oActItbVtmJd6/V0xwfK
	5IPdZpudkZr+u7kSovoQVaefFPsLRurjI92dPy6uYPFD7ic4LdUYJITikgaSmWCsSxsngDYv+Ah
	iPB4fGgX76EUHNJZrhl1MmxPfG+Rr36BeAI4mHxtS2Fz/rJ87KgzAVV5LF+V9LzRxYh8h4/4DHP
	ePjTn95HOMlxhj/DL87LSnmY1bkOG3XSvZaxaA2NhDLgZRLFiu3EyzMLdCpVPTS9IHxnbOhz+KS
	bnfLg9b7ORC8MnG1m5uSK7y+U=
X-Google-Smtp-Source: AGHT+IF80SH5ngGWveaDcKmnbc2W+nZE0h4SCpqpyJTd4cAzYik7LAYCVTQw1+aspecYPxiTj8pAxQ==
X-Received: by 2002:a05:622a:11d1:b0:4ee:28d1:4b91 with SMTP id d75a77b69052e-4f1d059d49dmr153006961cf.54.1765824624894;
        Mon, 15 Dec 2025 10:50:24 -0800 (PST)
Received: from [127.0.0.1] ([20.109.38.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c7e99dsm752511cf.34.2025.12.15.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 10:50:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org>
References:
 <20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: pm: in-kernel: fix issue 606
Message-ID: <e2de94d0-ab40-0cdb-ead9-1a32cf114fbd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Dec 2025 18:50:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/20242032173

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4856b70dcf11
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1033402


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)

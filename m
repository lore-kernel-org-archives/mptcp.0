Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87186170A3D
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949853; cv=none; b=jqtKa8lm1bNTKEn3e9sGLulTHCxQdElPiIhG3iZiohD3UD9vTy0/0zQK0BIIq13qOx3QXjDHbFu/24OSYgZrHOnLf6rU0oO/WbLID4tX7XJ2krRmr7d2UnW43mxhueEo3cIzn+yEy0guxKzB/E3iEsImLH4ltfxwoi1vkuJQOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949853; c=relaxed/simple;
	bh=Mwnm22/Laj1Epg0sIcCIx7hq+p19qtf0FKiaxhzIhF0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nnEj4gcslVDVTSIPsG3elWP4/gEwqWL8zOQbWMJUZeetG8x2hELO/xF/L07lcy2nThUAznI0qqF5G2DBTa49HhFdXA8GbfLJWgS4v5wPrX0TtRA0Ycn3Zs4JMcpDYmtaMj3uadcB+bv1ig4cskImQAyXnFDzFV69WQQictNk1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPO9QzMt; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPO9QzMt"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c34fb4f65eso28345856d6.0
        for <mptcp@lists.linux.dev>; Mon, 09 Sep 2024 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725949851; x=1726554651; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe318hbHqyL54SIM9/c09E/L/WenIhOrVmPl4XS45dQ=;
        b=BPO9QzMt4VHms0hIIA8LB3kI1MsPI6KypXduXysdHWvXkvfeSTe1UNtbQZFjDWagqZ
         s6AiwEEDPvprzBmh2LRcQE6eGy2xXvbOz+0n3kSctVl1cN4r+oY2fL7WdzUlaMoCZZ6A
         CkQ1P/l6+IaBEyvZQEgJ+gFOSP4zqmgIgVlrTfNzSUaiG8yTKjT0gXEytaPzbR5CkgfY
         IJ48M9hVqh4sSg7XJfF0yEDTNiD4dJMCl/5wBVSaWeaaZnUI39KlzUjHVW+XgN1meSv8
         uy9KOT+MkMawK8hLDZ7Nx3POswtWeluewPsgjYkwWtXRI8MWjODm9gLB4kQ1tP+8+h2v
         CUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949851; x=1726554651;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oe318hbHqyL54SIM9/c09E/L/WenIhOrVmPl4XS45dQ=;
        b=p7NBnbTIgkzQqwdQ4th/W6VDTfKU2Ctzcn/6GoWvTrq3WEin2HDHVGyQadu7+f8EYc
         V1IRGAl5R/mxH3t/tbDfZCNSwtAxsT3Uk/3rS3+9dPljTDvp6HZ2X2dCqWnQ8q4eeJKu
         wRDhkQwMhdDH4pBkRoghY2Mf3T6p4kErb0YCA1JP4ANT+oAs16vGEpJTVgfwT85o85Qo
         xfAfY9gsg4GXwdKEnXjB4WCnn+zyruK8zNox0R0XGNQWHS/RaCb8Tf9LEOlITdj7kJ/v
         sp1cxCV6ASQWBbl3dbJC4rSwQz+uLpM5xyDFGf7NXCNLhoEuOj2F4hew+RZxWnGjGQjF
         WX0w==
X-Gm-Message-State: AOJu0YzvglUkK55RxhcSaBm+BmgU0rPMteOBPi1IarRv1XzRPMY2fdT4
	Z69HalHEk5+xnAXe5w31uCIeMKAWaC8IhUsAR+QMyjxhekkU5E0ykIui
X-Google-Smtp-Source: AGHT+IFeznYtpQ4y1IdOasq4vsH+G0ilYLFaG6lUId5jM+AEcENBJpksKTEiU8jEN5LYTL2Qz+Knwg==
X-Received: by 2002:a05:6214:3282:b0:6c5:e6c:d5fb with SMTP id 6a1803df08f44-6c5283fd10cmr191281566d6.25.1725949851279;
        Mon, 09 Sep 2024 23:30:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.191.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343397f7sm27308596d6.49.2024.09.09.23.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:30:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725946276.git.tanggeliang@kylinos.cn>
References: <cover.1725946276.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/5] add mptcp_subflow bpf_iter
Message-ID: <9c607dc6-979f-f6b4-3473-ec717f1df763@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2024 06:30:50 +0000
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
uns/10786552827

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ed6d012aaff4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888713


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

Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5124C668
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190215; cv=none; b=B9EaNY6QonC94BKC13yPyf5WAH9lDAPybaQBq99zmu99cvUToI0jgr+87W+RP45rQf45GKXeGo0i0iJ68VyT3mS0TDkHpiP9jOF+HQX7Ig1qGxgdN8R1mauGYhhhpSuPASiTbzjX9aGnlH6qpNG3SrWjNswBBCZZqrBikyjj+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190215; c=relaxed/simple;
	bh=rhN+koqEB/OxNjaB2SdKMBamd+y6zG5LTVha9KHyJ1c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XGoTReVUTMmoLbt6GN/42fXA8q7V+P/fc4UhuyI+XsptHsbiwf6GCiIjyTDBbt+BFCUyPvMrBZ6v9MfmZQljjgmwcTN4HbM+FmwZ+n0E2CNJztZYU0a5kxM5enhdIqTXJk6RjLUy8+rczGapmog83/o2GQMZeTn9KKKrlBvtYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLhsiAxs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLhsiAxs"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c3b44dabe0so382775885a.1
        for <mptcp@lists.linux.dev>; Wed, 05 Mar 2025 07:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190213; x=1741795013; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT4rp0g4K/gOfPNIZf9sm8PWNlYIFDMSomWmgeDWv+A=;
        b=SLhsiAxsIqbldh9Z7kfd+iY/aBsI1IJ+g8p9nsuSj/7lxUkEbY8HplLAUGP8kNY3r6
         fEAfYK5HUd1HmO1sanzmk7VmgDWEBFfM70JclVn18SLaDxoc7481t9CWJyUSNCi3x+P+
         fk8mgtIy3d5B5IPhUk0U0STW9EwOmzBRxkQjLZiGQ9XfGob/2hqQOHwzrXcSoU9nDHCK
         uFuSGYRdDs4Jft14WxlDkLpd/MR7Gois8yximRZ6JLWRf/Wy7GyocW4sgF8GDRKN18fX
         v1j5dsvlCqg2goZM0vOlS99yskcfwbNSBorQJp57dm5Aputx1bdZNoYdDOHjsPla5Bvu
         2Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190213; x=1741795013;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sT4rp0g4K/gOfPNIZf9sm8PWNlYIFDMSomWmgeDWv+A=;
        b=ViTNg9yI9oJs73oHJIbWAcyBDTYC5btthfwEaSelF9MyO4PnwgvToJGo9J+p0tcr91
         p4abiusHdXVzUACLgc+Anjazjl8Vy26TmPpz1AlG5OR5zAAWdXNC7MGhLX68W64CLst4
         zUNzU2jx+1/K/vkkbAGXklIJjRAZDaaLyKGOYWerlUFIWRBuINssik9Fh/jPjXfJ6FIn
         3DfXby5Xa48S1leY/xdI6R4ns1yN9RFMVHlrToCNJtT2mEVgoj9AWFILbRR4lZ0lVoaU
         MpISZd0uoLFWTzwwKeljEQ3/+OTHWZaymi7WlZIGDbWb45old7kLpYyOiGwsvGpoCJ38
         du9w==
X-Gm-Message-State: AOJu0YzwwJYef+d/2f2iMhdNBhk6DZuL2hgX6M29EtzJT4Wr7qKrzXUR
	JUfM6u3zMluLaf+0nJ/56itH2kc7uACAtGPWKwWKEMDrcZudv+Y=
X-Gm-Gg: ASbGnctUXXHxRm184rpfiiwKhpfEp2Lx1VmErxdtdQYS0yiSGVVbNtGNlPkBlf4W9QH
	xnEq9GKl5BSxQ0ixXEaT2jRmqy34L69VdUrrxcyHwVA58GkXpM85UdmvgyK3Yragn/u8F5SKJDm
	+OuMUbQHJxLQs7RCr5+h3yvLfdqHVmrGBU2I6lPAlvB53G33qfVaPuBc9+0nSQiGIgWtbUwWR1U
	GabBSWOfkpYhBqruG6W6dpuyX7WRGK07knFSX4U/mI9y4LDcO3KehOhwmBqLejH1z0t5Mcf5LDZ
	rFhVEYqGBCUbtiDTBR9YZW7TtNG1/+fve9XmzlS8viC2GJ4STnT1ly85Kg==
X-Google-Smtp-Source: AGHT+IH8Qfyw+owgZc3tM34curStcPr34f93eLzj0QBKwyGaXdq4Kd3kKUFgAtwIq5x41JEouEimXA==
X-Received: by 2002:a05:620a:2696:b0:7c3:d64b:a434 with SMTP id af79cd13be357-7c3d8ee1be2mr537291085a.41.1741190213228;
        Wed, 05 Mar 2025 07:56:53 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378dadf9dsm895246385a.111.2025.03.05.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:56:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
References:
 <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
Message-ID: <340be8dc-c1ce-019b-76b2-011300eec008@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Mar 2025 15:56:52 +0000
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
uns/13678956999

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aa0a7828116d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D940602


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

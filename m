Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986B32BF3D
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444309; cv=none; b=dImpevwtsKNs3+LQjte1htK3/VmBM/8j4vVdHHv0eeEFLjkIXTRAwiY8GwWeUWEJ/4Y9klWgIDcwnhhUb+atmVdzCUgasZorLdDUwdGUGtANk7A/c7Nbr9IY11I9f+M5kSkJGiLAg3hV0c++mbNldw/LO14vcIjigFjaqEtemKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444309; c=relaxed/simple;
	bh=yVtzgzzsNI5QjXu3odzpfAJ4JPKo5YAweG69s7pOiSI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aNIVQLwA8Q8LYjIMGMOlkI4D83LR/it4sEKHyw0pG7NyGyWqKSZ52cQxtyVb/TTzZ9PqZ9aN5udtb0XXCXDne6SFdjELf5BcprXyxLl4/C1Ef8KKwsoMyzTG28SvXpukGOzrKqAQMOu6T2q0bU2lOTdoEdJ5bCMR8BPXTfC/Sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQEmef3v; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQEmef3v"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-406630d3b17so25752665ab.0
        for <mptcp@lists.linux.dev>; Tue, 09 Sep 2025 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757444306; x=1758049106; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05/JMkWxN1Ld07mmSJtv2NAvPqO2IqKQDK2Q0tlaDdo=;
        b=MQEmef3vqBw/csoMShQ+i8i9Eia1dU3G6bEAFPTBbg/jlXUV6cdmAwfldHCN2Knwyq
         23RZyTp1OUf6kdK+2FrE2hImUkY3DZJJqeN3+b/u8M069sPiiKvzptKSlEYL9MNK8TDF
         U7BQQARDCN00C8T7+CpFXuO/z3eJlmkMm0YFMhZDOdmBwp+NbUt8iK5HmWh2VNtmtU9Q
         cperdWxiSzvJCgUMQ9TpAFzx9AUbuJUyIXJKEGh6WMVBE/fB8mKhPI3xX0RNh1ET6EKc
         7oUXBnY3loxuRg5R4CZiP9fSZ3Tw0r/XAWMiP39PRnAbZaYqcegD/tmNpHqRudPLZrLe
         PEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757444306; x=1758049106;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05/JMkWxN1Ld07mmSJtv2NAvPqO2IqKQDK2Q0tlaDdo=;
        b=j7d21QS+IGaI7ORWTjkiennstEq0p9wSrtqMmM0h+c2FeTJO6Uz6b0jXuOzM6JsTYu
         JzV+m4GbvApMzJnk+YENfeqH+FBHmMe3A2LvFh3BTu2jddPDxIlzbnQ6viAYhToPieOQ
         unnw7FqXvSDc4s2ZPW5fgUVPDaKw1oyhHzleJPQfrh0bXIKEPn0BNmMRzRolUHTtxatm
         Vy0H3uTThk6YBtcmiIZlwO+VqmZNOXNov0H1523Pxr2qLahjDbY8e3bilftio7N2v+8R
         HUMJFzfR7nhxVBiI46hwfav1rzz0ANoGmgL/lp5v7lgQ8xlrudPLuz5klmxST9Mir0du
         fV4Q==
X-Gm-Message-State: AOJu0Yy9fU+kjdWS33CmyiXCFoytBb42rqrPdXSP+NV4OVqAvqkYfON9
	FnassVu7C6lAl18E4Gp6RyV/M5Yf95B2j1is8akkUkz6fMwOlksCn2Q=
X-Gm-Gg: ASbGncsScfXX672/f5cTQnxvgiXQZ77QLqzss6f7cO60/BK4f6hYnx0UcVY+lWltj3q
	60uJVwuqPYSUCzS9Q9P0iPo3Sy8Ojl4q0aue7f57lpvbVy3LzwjHWjXvXH5jcOwLPXliXvHDykX
	2BX0QkmKs87VppNw2xMy/wm96WGJnSuS6hNTKxeT36O1PThzsYDNGrDsLeLyyswe5BDQ/SKVCUc
	DAEUJhL4o7O9Zhfg5S2dmAzsLuSAzpjcZU6ahGZQLasHS0+DNuLy355HHia4GLy1vgFWnNa98U9
	Xm77QvcW5hfNJA2TJrnhQWb1qJC0WoBjZ7ZEql097VFNPbupPhkbGXUOPXRF/bTo4IomJsc+jeM
	mwds+Ef1aVmjGW+0ZCz7Xsc61hT95ZFpyP6r3fGoB7iLjrO8=
X-Google-Smtp-Source: AGHT+IEmoVjWA2cRjNQleWINdSpsdv1wG19iR6Gxu73a62aa3rY7bYWhb0hVikO65/6tFX4iy9n6ug==
X-Received: by 2002:a05:6e02:1607:b0:3f3:dd9a:63d6 with SMTP id e9e14a558f8ab-3fd961f424amr197116745ab.22.1757444306261;
        Tue, 09 Sep 2025 11:58:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.124.230])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-415645b8dbbsm2427935ab.30.2025.09.09.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:58:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
References:
 <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: pm: netlink: announce
 server-side flag
Message-ID: <52f9aec8-289b-a284-10ff-5236804a3315@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Sep 2025 18:58:24 +0000
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
Unstable: 2 failed test(s): packetdrill_dss selftest_mptcp_connect_checksum=
 =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17590195633

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/058da6352a3c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1000598


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

Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF36FC3
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231605; cv=none; b=OaCvQL3sW8UdVKldZT4KuQUWdlxIjzexs0mZ/oTrvkl5sLknVQviyTSv3POVDg0HdfR66zujXS9kvquCt68vh1wX0uH1+bR1wnWlwfV20ObEYUu0rz9hKPDXnLWR9DI6RzTCsQ9eErdCYGAous/oQaHYytOGAhNy9CYw14HNOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231605; c=relaxed/simple;
	bh=KK8hMU4OT0X9FUpCPvVGNVv5B+BH5d87nqk51k4V9iY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pOAkp0ltmr5JgxHv+Aiiww9fh/hGjAG2A1pqJZeaS+GLJRZxx7/2tJbak+r0r+8U0bXVbyOS5O32uoVrZXHSAjeTPob70adQoALvxDcPlA95DWZeR6V3UhlU+bxdZaQ4Srk8Zy8VJkS6zR23Kz3DZ3QHoQERg3VtceUY5QMFgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioCdHqNS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioCdHqNS"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3db4a6110so115333385a.0
        for <mptcp@lists.linux.dev>; Wed, 05 Mar 2025 19:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741231602; x=1741836402; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4zOsD+g8QqGXiQpMdoCq/wRxHG7KiXxbM19hP7/ZBc=;
        b=ioCdHqNSOqXtuvBcz9j0MD/ujfaSDUtIp+pBWU9kpcU9K7UeW+SUfdn6G5qsibnDH/
         sBKNas5KxT6tdIQMmYpLwmcHXURgYcdy01LOQgtaj3BUfHJtlQAO1O9fcVGalvR3Xp5J
         E8/HhZT1h6lQaIF9jFdamqRyQNGemClHBIyrBokx84LEYW3ghbX3IGO5ss8f6KU73rwr
         FU7ZQMjyl9pxd3obJwUYE6VN/JVHI928fH8SI2NIPg5A244ma5Q/U8Cva36Zh3BENkwn
         af4eygJiiT3/fsEIQnja36zS7gERfCJ0URZF8Us7kPrE8Md0XFzgf8w2F0liq9QRCHAR
         AIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741231602; x=1741836402;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4zOsD+g8QqGXiQpMdoCq/wRxHG7KiXxbM19hP7/ZBc=;
        b=A+LMhn/OO6k2XKQZuoPQmfUcbIK4VabLvCrId6bWOpQX0/u+etN13P/dMaMo2xNwjO
         6RLNt6Hhj2WrNKwrefoidIuyYrN1kMflQI/cLwWNnujEcPOMJf3oKYDYNQ7OGqXN8EF2
         KuyGhPea1qVjyZDMhDVSoZsezJOLjaTq+EFuJ0pMzSqF9M2Qz15ibXrWBnVABy5BIwpY
         qk+A1b8W18YUd9VHefnybUYoYivg8o6a03DCZF+VO7llHwx38YtScnnkUev1zMDS2PK5
         mMzO581RClXup3uzOmltQFEZ0TRn/urqO2ZwEeZtCow1SOeHft8OibUt64DZjxxV/YG/
         fz/Q==
X-Gm-Message-State: AOJu0YzOrMxnEKeT7iNd6s7k2is+JbwsArFuTv42VJhNvaIneYrjkIWb
	ktKWadd0ejA13V3+KfbyFsn1vtoWUTSwLwj91NpVibWJH+SOtsR5DRuFe1E=
X-Gm-Gg: ASbGncuw17A5UNL0daukqE49bG9UU3x0S8VUroDUgvul1R1RLzu8I5V1fv9oBP6Et9W
	ffd7boi0EgwIFXpp7eo63AbXFABfNJQ4gdKN9imvQ8KU7tqxFXcZ1mbl6/M7Zn5AHjoGRpLcw6x
	MAJTd3oz+vyEF6fdK4yoy5FpIjU07PPNLZ8HaZVgl39b1T/EKjnlUQMb0RxY+yPWWjACWHHOiLw
	h9rlek3HXzzbscSSYauBOk/0u3MBjzy4NtcHlTUuC+R59kdXZ5UlY0qYyhDv5DISmjG3cMIACSU
	BbPov1gszQwGOZpmo4b0FnGVAF8/tEZuGnTjSoGRqoWWKoBxmw2U1Fy+MHcB
X-Google-Smtp-Source: AGHT+IFjhWIqN8uilkWX8/qbybrpBRsQwQajg0l7eZQO3I5wEHtod8XYUo+nz4jJIV+9FgyuXifsPQ==
X-Received: by 2002:a05:620a:4389:b0:7b6:d7be:2e4 with SMTP id af79cd13be357-7c3e3a3375bmr262607285a.26.1741231602603;
        Wed, 05 Mar 2025 19:26:42 -0800 (PST)
Received: from [127.0.0.1] ([172.183.246.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5385d12sm32295585a.55.2025.03.05.19.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:26:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/8] cleanups for bpf schedulers
Message-ID: <acce9077-a81e-507d-86cd-8e89dd612c0b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Mar 2025 03:26:40 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13689905745

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4b6403c184b4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D940810


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

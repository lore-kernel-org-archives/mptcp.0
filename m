Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D22066F4
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498116; cv=none; b=Sph24ttKorGfoa+n/+1+m0+JFy8GCshtDB8HNJBqVNWGVVn93GTUz5pBT7fbh5/kNcZO5uJRmNGuTbt1Ox5fj+YyOq1IqXQJ5O/B1fVLl2lb1WKbFT7mEXn649pIHEekB/WjJrJTH9+blWY7XVzInBvmdYgiYTcFYYeRcgz6VDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498116; c=relaxed/simple;
	bh=k7w/Y8yWFhZb2qGwx9jnAn8/l3RSGJVC6Y6sxhtK6G0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VImowjTrbJAhvgROXGFu+tPpWh15qOlkSzCAGYEXduZocXM3dTYcF+I9dJd3nFC/NntIseZx281T2XPW788XvYJAFkcJtzCSVhMDxp2mhOn3+oQPXzrnlaHeTugjITsQBuwHToAfmhci3jlRniKh+JOQtIea0jUDaEQhWflrEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTWFQdgr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTWFQdgr"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso15168966d6.0
        for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 00:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736498114; x=1737102914; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgdgCzagEJP0694Uj0t80/dN91TtG7fwTkN2UD4vGpo=;
        b=WTWFQdgrwt89n5v2gaKRZRJxltZ9mfyHXF+9PS8llk9GW9Jo18aSAkkE05/lwkiyXo
         DMoIz47QDdRwHH7ZzXKsAo1Bcz3HZU5Pr3c8Pr7mlXpElmAEj0ZTemv//41jHSflltt8
         mp5jtO/0ol2keNMPW2isKPwBw8J7+wknkvst5IUsRYEH8xlMs7+2yEZu574qA5wQcM30
         N/pIDkzwO78pQ2kMG04Nz4dIAQ8T4YAB4zim1H/ZPHhyPjrwYM6d97vHToUnqwRK0M0q
         zLP/rdM4Vd/gNewfMB2fgnGqv2YyZYKRMNwoe+POeEI8XHV4EkDNtM4lloUBGwx9arki
         I18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498114; x=1737102914;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgdgCzagEJP0694Uj0t80/dN91TtG7fwTkN2UD4vGpo=;
        b=W/Hi4TteZbemQYTeh1hdd5X5vd0wfUobO9dtFwAm2OrVMHJ8NUjAbxtALW+I50X9iE
         2ki99axCiS+tUOH1I3w90AZUvOsdmsrhvMbTW+P+umsUh/JVQzt66gvmePZ/PnZwxxgm
         WpAG3AwGFvYKgMIWvjDthxG2nIAlRA9NlKtgvg+hn5qmjw9TO1ZMe+T+CjCBHBVn9evt
         siLjm1lJH0SQmSFTALLUNXGSTwnlU5/4ivuqxDWI2E6t1tOkrIQl+A7S1RtsZJmVXSws
         trmiL+dbNDF7ynMACIXutVBklGUAwd2SF/vK/nFD/c2POHAWvJIDvdSMP1piIC0Voxp/
         2TUA==
X-Gm-Message-State: AOJu0YwiJIw3SjfjuM5/OvSmVwN3v1JcQ6J+p1eiOvUH8l2KXVYPS+3a
	/s4eb3GPHeZkDK0jMw07vXu0iLhwhGZ0ufTiuEZqNmX+YM7faLg=
X-Gm-Gg: ASbGncuIYsGIjl+vpPHcWOhfWohQhOmP1J+yY+s+G3RDIwICsspraQVlkTALotzymdG
	voHH6QBtDUmtQkcWYiWSWF8Hakfxwgl4SuQ23x+kXAw5/ufVMg45KCYFvukihyepSV6yta0Rrn4
	vNs66DD5ArxHX+oMgfFzELKh87goxJHA/mJpF6zcDkyUQB5/TVeCW3MjBAaoI73xggS5U827ij6
	orbaulPfC4VqIjeops737m69ipm/7f+hUwGm+STqrHHVx7x4fXtuYyDdEWHywHD+OVNMaM=
X-Google-Smtp-Source: AGHT+IEIJXNXjM8/nGVHUDqaNfaG6/7n2L21ommoU7tq4wyFsfR3Xy7XOMX1a7rn7cwZbgigB7L9Xw==
X-Received: by 2002:a05:6214:4282:b0:6d8:7ccf:b692 with SMTP id 6a1803df08f44-6df9b1dfc20mr147790926d6.11.1736498111881;
        Fri, 10 Jan 2025 00:35:11 -0800 (PST)
Received: from [127.0.0.1] ([172.183.50.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce32483bcsm151165885a.33.2025.01.10.00.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:35:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736493803.git.tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/8] use GENL_REQ_ATTR_CHECK in userspace
 pm
Message-ID: <6af67b78-1880-76b0-12e3-24781953b064@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 08:35:09 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/127053=
50996

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d5de4a4eab65
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D924037


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

Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695517D6
	for <mptcp@lists.linux.dev>; Mon, 16 Feb 2026 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771281117; cv=none; b=EyiRXseQmLqsn3ABno9bRaSsECxfYOFqQkp4lH1vMndmWcFWWKfIbEbRj44vLU0WOfUWlzsm1LWqHRNLFo7gPm1nDXIEhM36kcsQGOEEn3SmR9cmQSHZgU3Si9GsAg7Av2kbym3946VxoZm+bicV00cw6v2hPRe1auJ+3hDMH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771281117; c=relaxed/simple;
	bh=Q9unQsMZdS7PM6Q+gUXUqBdDz5s6LyYuazElQ53pKAs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=N9EQaUtFNF/bOO5v2nvwSa+S8i1qNJbpMXL3OXYRse1CfIh7TwPFk2APeR+2qXJBpPoUc7zpBk/4OQwNExPclIVq8lS5y6OkJfZk0nHNVmc05QchTwjooAlcvq3t5+e9awIhq13LyuYhtsEJy0ixVZEx+SlMUS/t2VEluu8VCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7Qh1Zs9; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7Qh1Zs9"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d4c65d772cso3037826a34.1
        for <mptcp@lists.linux.dev>; Mon, 16 Feb 2026 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771281115; x=1771885915; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7NStvoCe8y/z1MxPW7dnWo7yMvosQjrkjBfwaZkKZc=;
        b=b7Qh1Zs9hYi9VBEyqwv1tlAuALJ2ajbaNSgBdmjWaYRTWZf+s4eeM6z54yGXaLVmjj
         jjdm6bcYlqhH3OwBunL9i3gVDgQgRLqJKCEoqaDJRsnz7MaDMBnc0OsxUxjKqI1H8krG
         DIe++B85oYQWDVfYQZ0aW0R6dMslKS9MwKVcC2PR968IIc9X5/mYawXPxqZl5XZF1geT
         DykfclvTrGYbwzgMM63UVqe+7rn/HxsXJpkapXFFspb7/kvUo+6+mj7BMTptNfUok48i
         tYuH40TTHnhUPr2lNWV8eNOF7oKOLF2hL/SFAhh+E3hiKOXMS87NkSAS59BPOhdqIyEB
         JoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771281115; x=1771885915;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7NStvoCe8y/z1MxPW7dnWo7yMvosQjrkjBfwaZkKZc=;
        b=uKL9mCN/DriId362GZzALF5u0YbCRIf+0J6CSsWUSQuDRnFhGhrr5f2kq0oPIdf+lS
         NQmzoPR2Hv3AkCYxZN5LJw3C/yR581aNjZmqDcQR4y21v2FPmu0IucoXqlS5Cc9vhjIi
         r3yARleGpeEjcwiycnu9aOou4EzFasA7NQlSiwqXBOa8Jk3BlHGUC8xpCQDGj7binkgN
         iD0WE++w2k6TL4Jimn860mmkQjVCAjHn2izbxO19OHEFVHo0cXF3SnUEVnwQJZX0ccDe
         KpzNcafzBfntJBP+q9eYZu5/vhatTQfedX18+FHccsNiOXCjcm22R5Yp5sHd48z46cK4
         ljbQ==
X-Gm-Message-State: AOJu0YwZUkd1sLQlaCSJG3kbcOHbUpT/j2WNfVt9CV5Ai7aeN6S+qdcR
	kNuL1haS8IvPRU1oycPVj11lPGqCxH1WCCQbS0mgtEETgGnipUFXBGw=
X-Gm-Gg: AZuq6aJ/Mr9mk9Ei/NU9zYHq007ZYi1QZdAdWOjVjU8cgkti0E/tzDvrw+k50wnGcXA
	pevaah08s1TRvYhg0kGtvuxpjCCCQRc34Xpc+L7FYIDAS/i/mTZoHUgBS6Qvn/q6EXCPhA9VOaI
	X5ik3nrJqi72yXs14WSC/RI1gJdBZ9opHvldTOQOC7vS9bSy+A5kOVpe0vdw8PZuDhTuK+TQbVx
	K4WvvNqSWesyOFZErPSUjAKe8IC7h5FyoYZJaxsdwDq27tuhmS+pooBBn2dg8Kf2DX8EuPzJAWX
	wkNhMmm5/q4Gu/Np8caU9JQhbCdZWPBe/15FMOMX5/CVrreL79qQU9qKKHHCkMYUuyOoutuxztq
	b+h8i3ttNt9lQ2N6ZD+ZySZ3YlTDD1bZRERuEdvWj1TXNiPzsArxA8lJeNdYAVslIkAGRgVYS81
	Nq8aS/o4NWF22kN04qI7oqy6K+qHREZbuq3N1Z
X-Received: by 2002:a05:6830:3882:b0:7cf:e4a1:8a9d with SMTP id 46e09a7af769-7d4c4a63bb2mr7932996a34.14.1771281115459;
        Mon, 16 Feb 2026 14:31:55 -0800 (PST)
Received: from [127.0.0.1] ([172.212.163.23])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a754b162sm13559266a34.12.2026.02.16.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 14:31:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
References:
 <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: more stable simult_flows
 tests
Message-ID: <604e9832-4fac-b3b2-dfa2-e40e481cf94b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Feb 2026 22:31:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Critical: Global =
Timeout =E2=9D=8C
- KVM Validation: debug (except selftest_mptcp_join): =
Unstable: 2 failed test(s): packetdrill_dss packetdrill_sockopts =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Notice: =
Call Traces at boot time, rebooted and continued =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/220781=
99700

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/92395bd88118
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1054688


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

Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854142AA2
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053807; cv=none; b=rm7iUcKumy4GMH5DhUWgg/0A8JZZJa5Tk17U/A63zbTfolNRd8RcDOm0jK2v6Md0RFxh46D8+GvYkEiWczpuUoOMg3lJFUs9aMskf9OBoj9ultGPLTeVoHDJ+SKpysyT/3a/0hg8FScVxk7dHxPKAI+kKdM/yee27cFgCyXmH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053807; c=relaxed/simple;
	bh=J+qW+oOGdN0WfzkAj4ZJdFO92UZzMwQ24Ylnv/FMcqY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kjoaXwKRNVk+Pq10sQSq4R8LgccTdEvRChTQayzgBATSSxYcaoBMlXoKGLxMWpQ4cH6AwDqs4mU711atYsdD7cyU8aCS5XeUHg4kexUwD5ydXVENPDTtWdx67AGtcirvFeOsQv+txuC9YdotDPDSLzV5Ifv4pSRP1+kJTOe/rGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWhY61FJ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWhY61FJ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430a25ed4e7so33891761cf.0
        for <mptcp@lists.linux.dev>; Tue, 02 Apr 2024 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712053805; x=1712658605; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYxYtHOovOGxycgEZDns+0Fzw0ytimxzDmGNo9M1ZqA=;
        b=dWhY61FJ/bbx7HQVdMKIFYn9O+pxlFVGsgknHujygEFKKe48ULk9a6UAlzhW+I1T6f
         OptvwC3tZpKOp4T7Asms78zV9/PGKXb0JOhq/OfPs/JlYD47mDxSeoCLkekLZ1poCsoS
         Jc0XSpz5Jtoko5kkqD+7/oQ1UBLGTShjwgD2lnuOzruNBfRXrc/1OKuEJFQnqk4HWuTW
         wLwZeA7bktxWm9tWIe0dJUUBVFdUhWsptUOySolihmZGcxitI8dzfTtPxUMsW/XjALr5
         s9JynaWg5S3mQuYZXVWJ1IofooWOzOtlNXg8xMfQCsYg0X9KINNVINQ6pKRkeqgkRA3v
         kTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712053805; x=1712658605;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYxYtHOovOGxycgEZDns+0Fzw0ytimxzDmGNo9M1ZqA=;
        b=d2M7qUVJpxnk5uhoBl8HchvgoJ/uGxsZqP2NYE6jggv/O31NBibLrf86KAs6gg27DV
         D6LXkEJdViB4soogIq/qR3ZSO58X8EjnKHtYHqkom3ZhBCklv45h/RH5oOjxZMPkUp/T
         6j4a186ykjHAZ0P7cey59tK1QX9asjr1jOjGT+nKlL4fkCosPFunEhtqlsZC51jjpqlf
         C3iN9girpRQ0pfKg5gki+zlvpCK2DF0D5QF64E4e+XMk8v4HmUh6x2+GbJ3ZKiyUrMjx
         Jh1VESpXDzHHKJxW0ZxDy+8Ne8YDx0hT4eDQjUoG0rrQtLxdrWIcY+LJRnkmx4YYNpMk
         k1+w==
X-Gm-Message-State: AOJu0Yw+vdeb62iqzIi7guDMIGTGhVdGIiH/shFq5Ge5ccLVonkC13+N
	Rq1zwgZAQTH5mH4+eYdKcS4c6hSpXnRFyavQxVhhUHgsLwcEE1Z1Hpf4u3M=
X-Google-Smtp-Source: AGHT+IHgpjsOpqolm4R3KTBQcp/KPWy/lc/Ig4PRNKMy/GO6BG6i7/5EHcNBuetDJMEacA4/cgs78g==
X-Received: by 2002:ac8:7e83:0:b0:431:824e:8e48 with SMTP id w3-20020ac87e83000000b00431824e8e48mr14919357qtj.9.1712053804642;
        Tue, 02 Apr 2024 03:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.95.210])
        by smtp.gmail.com with ESMTPSA id gb7-20020a05622a598700b00434386bf75asm342755qtb.34.2024.04.02.03.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:30:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712049966.git.tanggeliang@kylinos.cn>
References: <cover.1712049966.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v4_0/2=5D_disp?=
 =?UTF-8?Q?lay_=22last_time=22_actions_info?=
Message-ID: <084fc95f-d5de-4f61-2ac3-a817b7d3bc3b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2024 10:30:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
selftest_diag =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): =
Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/=
actions/runs/8520704616

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6b5cb3bcda=
d5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D840534


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

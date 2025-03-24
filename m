Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFB25D554
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808509; cv=none; b=mVAhFRKgcmI7NYmQrM63wpGRX09v4vyuASgJonCOTPsj8q/LAl3Na1bWvxZKzxJsUKt/rdKJrlfl4QR6D3amOOegUZhlgDcsEC/lPqcASr0GN0I/wjfAZSt2yNMIGJ8KYvMNhf8WhKvyX+RiWz8mq+QtUc/UaGcp2lfW1EYbr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808509; c=relaxed/simple;
	bh=XcCz5eWlBnFDoecIFLzkUauBBSTbfwRLnw4+HZfc0ok=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AVZdVCInxgyLEeF4/F8yh2ij9g9eVw6YZ0uG4X6eUMreNBfGqeMWg2qJK6E3rwLrFNcdOmrva3xF+wzqXqQa9xm9axnM0ZA5ELwu33xfPxkT7XqOIzBS9SUtIuFJ5adXThWBKefWyD1WJDX6u7U4OG9jPOkJIxByiglVw9D79CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INstR61L; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INstR61L"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5a88b34a6so407938385a.3
        for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742808507; x=1743413307; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqybVtkyUSj2nrZu76+/iluM2CL1VgnKuOZHHcsRsIE=;
        b=INstR61LQ+levAWuko7ck/toI0eNYFndwBacXqUiPhGH6M7AT2nO0z+c3xPPsgSSTz
         IFF4AuNAgYiA+d+dAaZPR6KvR9NzzA3c3Sn8y1gwBrjQeagykFUOhbOWw79+0EfZbMWx
         Znw5IlbpAevVjrp9qZyrM7pUvB7OuTjJKQ60u0TIoT0qJMRoRgwNtAehk8wPEQjPJ9j0
         m+CGaNdRoQxbSEZLnMyXODsWnk/X86QYjCrM35RFVt1h6mVMGP1SQ/9SwBraBFy/8QF/
         OMhBs+IK6RP9UMfV7SFf4yF+fd2Xgkn6DjTX+zuwgO8qGc4fLVfbFkOnQkGzbZsDpNNW
         NYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742808507; x=1743413307;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqybVtkyUSj2nrZu76+/iluM2CL1VgnKuOZHHcsRsIE=;
        b=PirChwAfBAcC4Z/T2fQGhxVhYp4rg84LIgiZm1F+b6qCYrOi1mdoul/Pj8ums/lqPq
         5YJdoawN3jXc6C3IjQlY8NZ50xeU0JvCpRQaM3tNryXK8rR8ZN5dV7iGp8wk1C2JNoPR
         a8SsdzaQITWuqCv++dbSfIiTzhq2m1kEjBf8SC3quVg/pzCJxygdkqVYIx+1oOEN+J76
         ZdOrTICCMtafsVXE9fMLlJSRmNNdyCmIrqGCkP3gCSZzsXR6nUQaE755fXphsqhpWuoj
         L3BQSkdW48AhUfTJAE+BP6FMutJF++p0opqB9+fjgELXbqmkDlYaGvZJj3yMpKJnKcjh
         +QIA==
X-Gm-Message-State: AOJu0YycZ8VIUn8oV9ACMCGwyOJG4kf6GvQldMtWsnFxB2zwJaja0I4X
	lsi+2zi0RrfTRX6DVYuM7kgz273igMmmz/METBUJeTJgLga8iWBikHV70OY=
X-Gm-Gg: ASbGnctAUZxuOeeOFpPFINCP9FlqyqywGNAAYnBqqQ7tMAEPoPZotzY6gJyUASLDVJN
	owsjKk5bZ3DvZiWOvoSEcj4CHmXalDMXC1PEiSLFDxtxfJfAkj6bf7j69voLjMNQY8Ezf3OYpon
	FOdYGW4tJWDbM1CQ4QJJBbqlEy7SOSo2Wdu0W7owkfzmoRPKfQBDPwIB6+U+hkYVntsdjVKUtv6
	aeVvVJ67L//kCMP9sGso66Xv7S7XfxsBDzU6RMUcFryLuE7/XQ5kni9FFkIfLFHA4C01xM/aSZf
	AsOYJEpj7NNSUBUMaZIOorlRYxEJEec3RWKq6zO58qT9uX0eDWWdBFpE
X-Google-Smtp-Source: AGHT+IFQeRn61yStf9r3Hx4i2VjIttLVtJzKZe0IW8oBksjiqgA37gXNcvdL5ISgrnZXMVnJ3t7lyA==
X-Received: by 2002:a05:620a:26a0:b0:7c5:4949:23f3 with SMTP id af79cd13be357-7c5ba19046amr1574151385a.27.1742808507007;
        Mon, 24 Mar 2025 02:28:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.62.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93576dbsm486820685a.90.2025.03.24.02.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 02:28:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1742804266.git.tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/9] BPF path manager, part 6
Message-ID: <3ab84600-1bc2-7371-c6be-fbf2970acff0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Mar 2025 09:28:25 +0000
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
uns/14030669230

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2ff193385091
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D946713


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
